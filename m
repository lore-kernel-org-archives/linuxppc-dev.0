Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AFF51A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:45:09 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 22:45:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 47D1D2BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:45:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KCNVjk7143870
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:23:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KCj5hm014477
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:45:05 +1000
Date: Tue, 20 May 2014 22:45:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
Message-ID: <20140520124504.GB28441@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <537B4740.6090806@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537B4740.6090806@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 02:14:56PM +0200, Alexander Graf wrote:
>
>On 20.05.14 13:56, Gavin Shan wrote:
>>On Tue, May 20, 2014 at 01:25:11PM +0200, Alexander Graf wrote:
>>>On 20.05.14 10:30, Gavin Shan wrote:
>>>>If we detects frozen state on PE that has been passed to guest, we
>>>>needn't handle it. Instead, we rely on the guest to detect and recover
>>>>it. The patch avoid EEH event on the frozen passed PE so that the guest
>>>>can have chance to handle that.
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>How does the guest learn about this failure? We'd need to inject an
>>>error into it, no?
>>>
>>When error is existing in HW level, 0xFF's will be turned on reading
>>PCI config space or memory BARs. Guest retrieves the failure state,
>>which is captured by HW automatically, via RTAS call
>>"ibm,read-slot-reset-state2" when seeing 0xFF's on reading PCI config
>>space or memory BARs. If "ibm,read-slot-reset-state2" reports errors in HW,
>>the guest kernel starts to recovery.
>>
>>It can be called as "passive" reporting. There possible has one case that
>>the error can't be reported for ever: No device driver binding to the VFIO
>>PCI device and no access to device's config space and memory BARs. However,
>>it doesn't matter. As we don't use the device, we needn't detect and recover
>>the error at all.
>
>So if the guest is waiting for an interrupt to happen it will wait
>forever? Not really nice.
>

Nope, the error reporting in guest isn't interrupt-driven. It's always
"polling" :-)

>>>I think what you want is an irqfd that the in-kernel eeh code
>>>notifies when it sees a failure. When such an fd exists, the kernel
>>>skips its own error handling.
>>>
>>Yeah, it's a good idea and something for me to improve in phase II. We
>>can discuss for more later.
>
>I think it makes sense to at least walk into that direction
>immediately. The reason I brought it up in the context of this patch
>is that with an irqfd you wouldn't need the passed flag at all.
>

I don't see how it can avoid the "passed" flag. Without the flag, any
PCI config and memory BAR access on host side could trigger EEH recovery
for those PCI devices passed to guest. That's unexpected behaviour. 

For host, we have 2 ways to report errors: interrupt driven and polling.
For the guest, we only have "polling" :-)

>>  For now, what I have in my head is something
>>like this:
>>
>>       [ Host ] -> Error detected -> irqfd (or eventfd) -> QEMU
>>                                                            |
>>                                    -------------(A)---------
>>                                    |
>>                         Send one EEH event to guest kernel
>>                                    |
>>                         Guest kernel starts the recovery
>>
>>(A): I didn't figure out one convienent way to do the EEH event injection yet.
>
>How does the guest learn about errors in pHyp?
>

It relies on "polling".

Thanks,
Gavin

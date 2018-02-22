Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTKM2ns5zF1j8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:19:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <38f27cd0-7f1a-b3ca-d8f3-615bd97637be@linux.vnet.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
 <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
 <87mv6f56vl.fsf@concordia.ellerman.id.au> <87y3pvgyko.fsf@linux.vnet.ibm.com>
 <38f27cd0-7f1a-b3ca-d8f3-615bd97637be@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 09:19:02 +1100
Message-ID: <87y3jkpt0p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian King <brking@linux.vnet.ibm.com> writes:
> On 09/03/2017 06:19 PM, Stewart Smith wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>>>>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>>>>    init on the kernel being kexec booted from skiboot should be extremely fast. 
>>>
>>> OK, I didn't know that was an option, so that might help.
>>>
>>>> ...
>>>> If you've got cases where ipr init is taking a long time, I'd be
>>>> interested to know what scenarios are the most annoying to see if there
>>>> is any opportunity to improve.
>>>
>>> Yeah booting bare metal is where I see it (not using ipr.fast_reboot).
>> 
>> Hrm... We should probably enable that by default for petitboot then.
>> 
>> It'd at least cut some time off booting straight through to OS.
>
> Agreed. I'd be interested to hear if that helps address the issue
> Michael is seeing.
>
> You can easily test this by exiting to a petitboot shell:
>
> echo 1 > /sys/module/ipr/parameters/fast_reboot
>
> Then go back to petitboot and boot the OS.

Just following up on this (!).

This does work, and I've now been running it in my CI for about a month
(~1000 boots) with no problems.

You can also make it persistent by doing:

  $ nvram -p ibm,skiboot --update-config bootargs="ipr.fast_reboot=1"

cheers

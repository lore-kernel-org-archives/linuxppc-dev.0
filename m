Return-Path: <srs0=q55z=fr=linux.vnet.ibm.com=bryantly@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znv495kkKzF1cw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 01:39:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znv494mDrz8vnb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 01:39:05 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znv491TS5z9sBR
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2018 01:39:05 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NEcQSV098299
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 09:39:03 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gak44m8ck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 09:39:03 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Fri, 23 Feb 2018 07:39:01 -0700
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 torvalds@linux-foundation.org, ruscur@russell.cc,
 jjalvare@linux.vnet.ibm.com
References: <20180208122035.9305-1-mpe@ellerman.id.au>
 <dcfc6411-20cf-5b3f-20c5-14167de54700@linux.vnet.ibm.com>
 <20180222231236.GB14632@bhelgaas-glaptop.roam.corp.google.com>
 <87h8q8pcr9.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 08:38:57 -0600
MIME-Version: 1.0
In-Reply-To: <87h8q8pcr9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <0217a4a8-015b-f4d8-9859-a41967038500@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2/22/18 10:10 PM, Michael Ellerman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> On Thu, Feb 08, 2018 at 09:05:45AM -0600, Bryant G. Ly wrote:
>>> On 2/8/18 6:20 AM, Michael Ellerman wrote:
>>>
>>>> There's no reason pci_uevent_ers() needs to be inline in pci.h, so
>>>> move it out to a C file.
>>>>
>>>> Given it's used by AER the obvious location would be somewhere in
>>>> drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
>>>> unfortunately that doesn't work in the case where EEH is enabled but
>>>> PCIEPORTBUS is not.
>>>>
>>>> So for now put it in pci-driver.c, next to pci_uevent(), with an
>>>> appropriate #ifdef so it's not built if AER and EEH are both disabled.
>>>>
>>>> While we're moving it also fix up the kernel doc comment for @pdev to
>>>> be accurate.
>>>>
>>>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>  drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  include/linux/pci.h      | 38 +++-----------------------------------
>>>>  2 files changed, 39 insertions(+), 35 deletions(-)
>>> Looks good, thanks for fixing it!
>>>
>>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> This would normally be a "Reviewed-by" unless you actually
>> participated in developing the patch, and in that case, your
>> "Signed-off-by" would normally be included in the original posting.
>>
>> What do you intend?  I'll be glad to add either.
> I wrote the patch, so Bryant meant Reviewed-by or maybe Acked-by.
>
> cheers
>
Yes, I mean't, 

Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>

Thanks, 

Bryant

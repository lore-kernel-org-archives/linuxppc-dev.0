Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F26E1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 10:12:45 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6987014029C
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 10:12:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Sep 2015 10:12:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AB8302CE8050
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 10:12:40 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8O0CWfm35979302
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 10:12:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8O0C75S002091
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 10:12:07 +1000
Message-ID: <56033FD3.7040000@au1.ibm.com>
Date: Thu, 24 Sep 2015 10:12:03 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au1.ibm.com, Manoj Kumar <kumarmn@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Panic on unhandled Machine Check
References: <1442990508-10199-1-git-send-email-dja@axtens.net>
In-Reply-To: <1442990508-10199-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/09/15 16:41, Daniel Axtens wrote:
> All unrecovered machine check errors on PowerNV should cause an
> immediate panic. There are 2 reasons that this is the right policy:
> it's not safe to continue, and we're already trying to reboot.
>
> Firstly, if we go through the recovery process and do not successfully
> recover, we can't be sure about the state of the machine, and it is
> not safe to recover and proceed.
>
> Linux knows about the following sources of Machine Check Errors:
> - Uncorrectable Errors (UE)
> - Effective - Real Address Translation (ERAT)
> - Segment Lookaside Buffer (SLB)
> - Translation Lookaside Buffer (TLB)
> - Unknown/Unrecognised
>
> In the SLB, TLB and ERAT cases, we can further categorise these as
> parity errors, multihit errors or unknown/unrecognised.
>
> We can handle SLB errors by flushing and reloading the SLB. We can
> handle TLB and ERAT multihit errors by flushing the TLB. (It appears
> we may not handle TLB and ERAT parity errors: I will investigate
> further and send a followup patch if appropriate.)
>
> This leaves us with uncorrectable errors. Uncorrectable errors are
> usually the result of ECC memory detecting an error that it cannot
> correct, but they also crop up in the context of PCI cards failing
> during DMA writes, and during CAPI error events.
>
> There are several types of UE, and there are 3 places a UE can occur:
> Skiboot, the kernel, and userspace. For Skiboot errors, we have the
> facility to make some recoverable. For userspace, we can simply kill
> (SIGBUS) the affected process. We have no meaningful way to deal with
> UEs in kernel space or in unrecoverable sections of Skiboot.
>
> Currently, these unrecovered UEs fall through to
> machine_check_expection() in traps.c, which calls die(), which OOPSes
> and sends SIGBUS to the process. This sometimes allows us to stumble
> onwards. For example we've seen UEs kill the kernel eehd and
> khugepaged. However, the process killed could have held a lock, or it
> could have been a more important process, etc: we can no longer make
> any assertions about the state of the machine. Similarly if we see a
> UE in skiboot (and again we've seen this happen), we're not in a
> position where we can make any assertions about the state of the
> machine.
>
> Likewise, for unknown or unrecognised errors, we're not able to say
> anything about the state of the machine.
>
> Therefore, if we have an unrecovered MCE, the most appropriate thing
> to do is to panic.
>
> The second reason is that since e784b6499d9c ("powerpc/powernv: Invoke
> opal_cec_reboot2() on unrecoverable machine check errors."), we
> attempt a special OPAL reboot on an unhandled MCE. This is so the
> hardware can record error data for later debugging.
>
> The comments in that commit assert that we are heading down the panic
> path anyway. At the moment this is not always true. With UEs in kernel
> space, for instance, they are marked as recoverable by the hardware,
> so if the attempt to reboot failed (e.g. old Skiboot), we wouldn't
> panic() but would simply die() and OOPS. It doesn't make sense to be
> staggering on if we've just tried to reboot: we should panic().
>
> Explicitly panic() on unrecovered MCEs on PowerNV.
> Update the comments appropriately.
>
> This fixes some hangs following EEH events on cxlflash setups.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1273D1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 16:45:41 +1000 (AEST)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F02D31401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2015 16:45:39 +1000 (AEST)
Received: by pacgz1 with SMTP id gz1so3724435pac.2
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2015 23:45:38 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc/powernv: Panic on unhandled Machine Check
Date: Wed, 23 Sep 2015 16:41:48 +1000
Message-Id: <1442990508-10199-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All unrecovered machine check errors on PowerNV should cause an
immediate panic. There are 2 reasons that this is the right policy:
it's not safe to continue, and we're already trying to reboot.

Firstly, if we go through the recovery process and do not successfully
recover, we can't be sure about the state of the machine, and it is
not safe to recover and proceed.

Linux knows about the following sources of Machine Check Errors:
- Uncorrectable Errors (UE)
- Effective - Real Address Translation (ERAT)
- Segment Lookaside Buffer (SLB)
- Translation Lookaside Buffer (TLB)
- Unknown/Unrecognised

In the SLB, TLB and ERAT cases, we can further categorise these as
parity errors, multihit errors or unknown/unrecognised.

We can handle SLB errors by flushing and reloading the SLB. We can
handle TLB and ERAT multihit errors by flushing the TLB. (It appears
we may not handle TLB and ERAT parity errors: I will investigate
further and send a followup patch if appropriate.)

This leaves us with uncorrectable errors. Uncorrectable errors are
usually the result of ECC memory detecting an error that it cannot
correct, but they also crop up in the context of PCI cards failing
during DMA writes, and during CAPI error events.

There are several types of UE, and there are 3 places a UE can occur:
Skiboot, the kernel, and userspace. For Skiboot errors, we have the
facility to make some recoverable. For userspace, we can simply kill
(SIGBUS) the affected process. We have no meaningful way to deal with
UEs in kernel space or in unrecoverable sections of Skiboot.

Currently, these unrecovered UEs fall through to
machine_check_expection() in traps.c, which calls die(), which OOPSes
and sends SIGBUS to the process. This sometimes allows us to stumble
onwards. For example we've seen UEs kill the kernel eehd and
khugepaged. However, the process killed could have held a lock, or it
could have been a more important process, etc: we can no longer make
any assertions about the state of the machine. Similarly if we see a
UE in skiboot (and again we've seen this happen), we're not in a
position where we can make any assertions about the state of the
machine.

Likewise, for unknown or unrecognised errors, we're not able to say
anything about the state of the machine.

Therefore, if we have an unrecovered MCE, the most appropriate thing
to do is to panic.

The second reason is that since e784b6499d9c ("powerpc/powernv: Invoke
opal_cec_reboot2() on unrecoverable machine check errors."), we
attempt a special OPAL reboot on an unhandled MCE. This is so the
hardware can record error data for later debugging.

The comments in that commit assert that we are heading down the panic
path anyway. At the moment this is not always true. With UEs in kernel
space, for instance, they are marked as recoverable by the hardware,
so if the attempt to reboot failed (e.g. old Skiboot), we wouldn't
panic() but would simply die() and OOPS. It doesn't make sense to be
staggering on if we've just tried to reboot: we should panic().

Explicitly panic() on unrecovered MCEs on PowerNV.
Update the comments appropriately.

This fixes some hangs following EEH events on cxlflash setups.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/opal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 230f3a7cdea4..4296d55e88f3 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -487,9 +487,12 @@ int opal_machine_check(struct pt_regs *regs)
 	 *    PRD component would have already got notified about this
 	 *    error through other channels.
 	 *
-	 * In any case, let us just fall through. We anyway heading
-	 * down to panic path.
+	 * If hardware marked this as an unrecoverable MCE, we are
+	 * going to panic anyway. Even if it didn't, it's not safe to
+	 * continue at this point, so we should explicitly panic.
 	 */
+
+	panic("PowerNV Unrecovered Machine Check");
 	return 0;
 }
 
-- 
2.5.0

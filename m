Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (ixro-out-rtc.ixiacom.com [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id 92274DDFD6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 23:03:09 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: oprofile: enable support for ppc750
	processors
Date: Wed, 4 Mar 2009 14:02:42 +0200
References: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
	<1231246535-13151-3-git-send-email-opurdila@ixiacom.com>
	<1236142078.6696.11.camel@pasglop>
In-Reply-To: <1236142078.6696.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903041402.43130.opurdila@ixiacom.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Tue, 2009-01-06 at 14:55 +0200, Octavian Purdila wrote:
> > Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>
>
> So I'm going to merge 1/2 but this one should really be changed to
> advertise ppc/750 in oprofile_cpu_type (ie. to userspace).
>

Sure. Here is the new patch which uses ppc/750. It enables oprofile for all 3 FX variants and GX as well.

Thanks!
tavi


commit 70f4865a614e9b0ff4594ebd52b95f78e998b79f
Author: Octavian Purdila <opurdila@ixiacom.com>
Date:   Tue Jan 6 12:51:43 2009 +0200

    powerpc: oprofile: enable support for ppc750 processors
    
    Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 923f87a..c3ea72b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -726,6 +726,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750FX rev 2.0 must disable HID0[DPM] */
 		.pvr_mask		= 0xffffffff,
@@ -741,6 +743,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750FX (All revs except 2.0) */
 		.pvr_mask		= 0xffff0000,
@@ -756,6 +760,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750fx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750GX */
 		.pvr_mask		= 0xffff0000,
@@ -771,6 +777,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750fx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 740/750 (L2CR bit need fixup for 740) */
 		.pvr_mask		= 0xffff0000,

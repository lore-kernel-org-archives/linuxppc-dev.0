Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id DC3D3B715A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 09:18:08 +1000 (EST)
Received: from mail38-db3 (localhost.localdomain [127.0.0.1])	by
	mail38-db3-R.bigfish.com (Postfix) with ESMTP id 6352116400B7	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 23:18:01 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.250])	by
	mail38-db3.bigfish.com (Postfix) with ESMTP id ADAF03E004B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 23:18:00 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7VNHmjt004490	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 16:17:58 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/fsl_booke: Add support to boot from core other
	than 0
Date: Tue, 31 Aug 2010 18:24:45 -0500
Message-ID: <1283297085-3455-2-git-send-email-msm@freescale.com>
In-Reply-To: <1283297085-3455-1-git-send-email-msm@freescale.com>
References: <1283297085-3455-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First we check to see if we are the first core booting up. This
is accomplished by comparing the boot_cpuid with -1, if it is we
assume this is the first core coming up.

Secondly, we need to update the initial thread info structure
to reflect the actual cpu we are running on otherwise
smp_processor_id() and related functions will return the default
initialization value of the struct or 0.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/head_fsl_booke.S |   10 ++++++++--
 arch/powerpc/kernel/setup_32.c       |    2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 258315a..5bbf593 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -152,8 +152,11 @@ _ENTRY(__early_start)
 	/* Check to see if we're the second processor, and jump
 	 * to the secondary_start code if so
 	 */
-	mfspr	r24,SPRN_PIR
-	cmpwi	r24,0
+	lis	r24, boot_cpuid@h
+	ori	r24, r24, boot_cpuid@l
+	lwz	r24, 0(r24)
+	cmpwi	r24, -1
+	mfspr   r24,SPRN_PIR
 	bne	__secondary_start
 #endif
 
@@ -175,6 +178,9 @@ _ENTRY(__early_start)
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+	rlwinm  r22,r1,0,0,31-THREAD_SHIFT      /* current thread_info */
+	stw	r24, TI_CPU(r22)
+
 	bl	early_init
 
 #ifdef CONFIG_RELOCATABLE
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 8f58986..4be3ef4 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -46,7 +46,7 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-int boot_cpuid;
+int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 int boot_cpuid_phys;
 
-- 
1.6.6.1

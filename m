Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id AB23BB7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Aug 2010 07:52:15 +1000 (EST)
Received: from mail9-tx2 (localhost.localdomain [127.0.0.1])	by
	mail9-tx2-R.bigfish.com (Postfix) with ESMTP id 7CF007503ED	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2010 21:51:58 +0000 (UTC)
Received: from TX2EHSMHS044.bigfish.com (unknown [10.9.14.251])	by
	mail9-tx2.bigfish.com (Postfix) with ESMTP id 471541AB0046	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2010 21:51:58 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7RLpvZa003355	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Aug 2010 14:51:57 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kernel: Adds correct calling convention for kexec
	purgatory
Date: Fri, 27 Aug 2010 16:58:21 -0500
Message-ID: <1282946301-28207-1-git-send-email-msm@freescale.com>
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

Call kexec purgatory code correctly. We were getting lucky before.
If you examine the powerpc 32bit kexec "purgatory" code you will
see it expects the following:

>From kexec-tools: purgatory/arch/ppc/v2wrap_32.S
-> calling convention:
->   r3 = physical number of this cpu (all cpus)
->   r4 = address of this chunk (master only)

As such, we need to set r3 to the current core, r4 happens to be
unused by purgatory at the moment but we go ahead and set it
here as well

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/misc_32.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 99bc652..6d1151f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -807,6 +807,9 @@ relocate_new_kernel:
 	isync
 	sync
 
+	mfspr	r3, SPRN_PIR /* current core we are running on */
+	mr	r4, r5 /* load physical address of chunk called */
+
 	/* jump to the entry point, usually the setup routine */
 	mtlr	r5
 	blrl
-- 
1.6.6.1

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD120B71A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 06:21:29 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4KK4BGJ011182
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2011 14:04:11 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4KKLIol113602
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2011 14:21:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4KKLHRT003853
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2011 14:21:17 -0600
Date: Fri, 20 May 2011 16:22:25 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix 32-bit SMP build
Message-ID: <20110520202225.GI25179@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
however it uses a 64-bit instruction which is not valid on 32-bit
platforms.  Use 'stw' instead.

Reported-by: Richard Cochran <richardcochran@gmail.com>
Tested-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 402560e..998a100 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -700,7 +700,7 @@ _GLOBAL(start_secondary_resume)
	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
	li      r3,0
-	std     r3,0(r1)                /* Zero the stack frame pointer */
+	stw     r3,0(r1)                /* Zero the stack frame pointer */
	bl      start_secondary
	b       .
 #endif /* CONFIG_SMP */

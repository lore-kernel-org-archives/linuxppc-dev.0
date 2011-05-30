Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1D5CB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 22:25:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4UCJGLG015415
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2011 06:19:16 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4UCQWml091508
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2011 06:26:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4U6OaF1007675
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2011 00:24:37 -0600
Date: Mon, 30 May 2011 08:26:21 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] 2.6.39 powerpc: Fix 32-bit SMP build
Message-ID: <20110530122621.GD2557@zod.rchland.ibm.com>
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

Backport upstream commit 6de06f313a65d0ec
    
Commit fa3f82c8bb7acb ("powerpc/smp: soft-replugged CPUs must go back to
start_secondary") introduced start_secondary_resume to head_32.S, however
it uses a 64-bit instruction which is not valid on 32-bit platforms.  Use
'stw' instead.
    
CC: stable@kernel.org
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c5c24be..727f40a 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -896,7 +896,7 @@ _GLOBAL(start_secondary_resume)
 	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
 	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li      r3,0
-	std     r3,0(r1)                /* Zero the stack frame pointer */
+	stw     r3,0(r1)                /* Zero the stack frame pointer */
 	bl      start_secondary
 	b       .
 #endif /* CONFIG_SMP */

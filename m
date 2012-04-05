Return-Path: <anton@samba.org>
Date: Thu, 5 Apr 2012 23:44:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/4 v2] powerpc: Better scheduling of CR save code in system
 call path
Message-ID: <20120405234448.4d879808@kryten>
In-Reply-To: <20120405142557.398f14d2@kryten>
References: <20120405142327.6038bbb4@kryten> <20120405142557.398f14d2@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


At the moment system call entry looks like:

crclr	so
...
mfcr	r9
...
std	r9,_CCR(r1)

commit bd19c8994a82 ([POWERPC] system call micro optimisation) put
some space between the crclr and mfcr in order to avoid a stall.

There is still a stall seen between the mfcr and std. We can avoid
the crclr by doing it in a GPR with rlwinm which gives us more room
to better schedule the sequence.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2:

Milton pointed out that rlwinm copies the low 32bits into the top
32bits and this might confuse ptracers. We tossed around a few ideas
but his suggestion of using rldimi sounds good to me.

Index: linux-build/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/entry_64.S	2012-04-05 14:03:05.123678148 +1000
+++ linux-build/arch/powerpc/kernel/entry_64.S	2012-04-05 23:38:09.182681076 +1000
@@ -63,15 +63,9 @@ system_call_common:
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
-	/*
-	 * This "crclr so" clears CR0.SO, which is the error indication on
-	 * return from this system call.  There must be no cmp instruction
-	 * between it and the "mfcr r9" below, otherwise if XER.SO is set,
-	 * CR0.SO will get set, causing all system calls to appear to fail.
-	 */
-	crclr	so
 	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
+	mfcr	r2
 	std	r4,GPR4(r1)
 	std	r5,GPR5(r1)
 	std	r6,GPR6(r1)
@@ -84,15 +78,19 @@ system_call_common:
 	std	r11,GPR12(r1)
 	std	r11,_XER(r1)
 	std	r9,GPR13(r1)
-	mfcr	r9
 	mflr	r10
+	/*
+	 * This clears CR0.SO (bit 28), which is the error indication on
+	 * return from this system call.
+	 */
+	rldimi	r2,r11,28,(63-28)
 	li	r11,0xc01
-	std	r9,_CCR(r1)
 	std	r10,_LINK(r1)
 	std	r11,_TRAP(r1)
 	mfctr	r10
 	std	r10,_CTR(r1)
 	std	r3,ORIG_GPR3(r1)
+	std	r2,_CCR(r1)
 	ld	r2,PACATOC(r13)
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)

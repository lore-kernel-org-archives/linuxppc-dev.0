Return-Path: <anton@samba.org>
Date: Thu, 5 Apr 2012 14:26:39 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/4] powerpc: No need to preserve count register across
 system call
Message-ID: <20120405142639.237dde63@kryten>
In-Reply-To: <20120405142327.6038bbb4@kryten>
References: <20120405142327.6038bbb4@kryten>
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


The count register is volatile so we don't need to preserve it.
Store zero to the entry in the exception frame.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/entry_64.S	2012-03-22 22:47:15.023504471 +1100
+++ linux-build/arch/powerpc/kernel/entry_64.S	2012-03-22 22:47:17.899556262 +1100
@@ -77,6 +77,7 @@ system_call_common:
 	std	r11,GPR11(r1)
 	std	r11,GPR12(r1)
 	std	r11,_XER(r1)
+	std	r11,_CTR(r1)
 	std	r9,GPR13(r1)
 	mflr	r10
 	li	r11,0xc01
@@ -87,8 +88,6 @@ system_call_common:
 	rlwinm	r2,r2,0,4,2
 	std	r10,_LINK(r1)
 	std	r11,_TRAP(r1)
-	mfctr	r10
-	std	r10,_CTR(r1)
 	std	r3,ORIG_GPR3(r1)
 	std	r2,_CCR(r1)
 	ld	r2,PACATOC(r13)

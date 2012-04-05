Return-Path: <anton@samba.org>
Date: Thu, 5 Apr 2012 14:24:29 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/4] powerpc: No need to save XER in a system call
Message-ID: <20120405142429.7bb7785c@kryten>
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


The XER is a volatile register so there is no need to save and restore
it over a system call - zero it out in the exception stack frame
instead.

This should fix a 5 cycle stall of the mfxer/std seen on POWER7.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/entry_64.S	2012-03-22 22:47:04.479314599 +1100
+++ linux-build/arch/powerpc/kernel/entry_64.S	2012-03-22 22:47:08.379384827 +1100
@@ -82,6 +82,7 @@ system_call_common:
 	std	r11,GPR10(r1)
 	std	r11,GPR11(r1)
 	std	r11,GPR12(r1)
+	std	r11,_XER(r1)
 	std	r9,GPR13(r1)
 	mfcr	r9
 	mflr	r10
@@ -89,9 +90,7 @@ system_call_common:
 	std	r9,_CCR(r1)
 	std	r10,_LINK(r1)
 	std	r11,_TRAP(r1)
-	mfxer	r9
 	mfctr	r10
-	std	r9,_XER(r1)
 	std	r10,_CTR(r1)
 	std	r3,ORIG_GPR3(r1)
 	ld	r2,PACATOC(r13)

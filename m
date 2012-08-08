Return-Path: <anton@samba.org>
Date: Wed, 8 Aug 2012 13:51:41 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc: Fix VMX in interrupt check in POWER7 copy loops
Message-ID: <20120808135141.5d17d20e@kryten>
In-Reply-To: <20120808135046.06056d11@kryten>
References: <20120808135046.06056d11@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The enhanced prefetch hint patches corrupt the condition register
that was used to check if we are in interrupt. Fix this by using cr1.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -288,7 +288,7 @@ err1;	stb	r0,0(r3)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	bl	.enter_vmx_usercopy
-	cmpwi	r3,0
+	cmpwi	cr1,r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STACKFRAMESIZE+48(r1)
 	ld	r4,STACKFRAMESIZE+56(r1)
@@ -326,7 +326,7 @@ err1;	stb	r0,0(r3)
 	dcbt	r0,r8,0b01010	/* GO */
 .machine pop
 
-	beq	.Lunwind_stack_nonvmx_copy
+	beq	cr1,.Lunwind_stack_nonvmx_copy
 
 	/*
 	 * If source and destination are not relatively aligned we use a
Index: b/arch/powerpc/lib/memcpy_power7.S
===================================================================
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -222,7 +222,7 @@ _GLOBAL(memcpy_power7)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	bl	.enter_vmx_copy
-	cmpwi	r3,0
+	cmpwi	cr1,r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STACKFRAMESIZE+48(r1)
 	ld	r4,STACKFRAMESIZE+56(r1)
@@ -260,7 +260,7 @@ _GLOBAL(memcpy_power7)
 	dcbt	r0,r8,0b01010	/* GO */
 .machine pop
 
-	beq	.Lunwind_stack_nonvmx_copy
+	beq	cr1,.Lunwind_stack_nonvmx_copy
 
 	/*
 	 * If source and destination are not relatively aligned we use a

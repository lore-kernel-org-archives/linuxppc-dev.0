Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: module: fix stubs for BE
Date: Mon, 12 May 2014 17:15:02 +0930
Message-ID: <87fvkfmoe9.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alistair Popple <alistair@popple.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A simple patch which was supposed to swap r12 and r11 also
inexplicably changed the offset by two bytes.  This instruction
(to load r2) isn't used in LE, so it wasn't noticed.

Fixes: b1ce369e82 ("powerpc: modules: use r12 for stub jump address.)
Reported-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Tested-by: Alistair Popple <alistair@popple.id.au>

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index ef349d0..077d2ce 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -134,7 +134,7 @@ static u32 ppc64_stub_insns[] = {
 	0xe98b0020,			/* ld      r12,32(r11) */
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Set up new r2 from function descriptor */
-	0xe84b0026,			/* ld      r2,40(r11) */
+	0xe84b0028,			/* ld      r2,40(r11) */
 #endif
 	0x7d8903a6,			/* mtctr   r12 */
 	0x4e800420			/* bctr */

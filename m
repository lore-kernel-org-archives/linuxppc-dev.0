Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 30/33] powerpc: modules: use r12 for stub jump address.
Date: Tue, 25 Mar 2014 22:44:36 +1100
Message-Id: <1395747879-5948-31-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

In ELFv2, r12 is supposed to equal to PC on entry to a function.
Our stubs use r11, so change swap that with r12.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8bfcf1b..f8b6d28 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -67,13 +67,13 @@ struct ppc64_stub_entry
    r2) into the stub. */
 static struct ppc64_stub_entry ppc64_stub =
 { .jump = {
-	0x3d820000,			/* addis   r12,r2, <high> */
-	0x398c0000,			/* addi    r12,r12, <low> */
+	0x3d620000,			/* addis   r11,r2, <high> */
+	0x396b0000,			/* addi    r11,r11, <low> */
 	/* Save current r2 value in magic place on the stack. */
 	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
-	0xe96c0020,			/* ld      r11,32(r12) */
-	0xe84c0028,			/* ld      r2,40(r12) */
-	0x7d6903a6,			/* mtctr   r11 */
+	0xe98b0020,			/* ld      r12,32(r11) */
+	0xe84b0026,			/* ld      r2,40(r11) */
+	0x7d8903a6,			/* mtctr   r12 */
 	0x4e800420			/* bctr */
 } };
 
-- 
1.8.3.2

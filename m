Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 22/33] powerpc: make module stub code endian independent
Date: Tue, 25 Mar 2014 22:44:28 +1100
Message-Id: <1395747879-5948-23-git-send-email-anton@samba.org>
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

By representing them as words, rather than chars, we can avoid
endian ifdefs.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 42 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 12664c1..7c16b2e 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -47,8 +47,8 @@
 struct ppc64_stub_entry
 {
 	/* 28 byte jump instruction sequence (7 instructions) */
-	unsigned char jump[28];
-	unsigned char unused[4];
+	u32 jump[7];
+	u32 unused;
 	/* Data for the above code */
 	struct ppc64_opd_entry opd;
 };
@@ -61,25 +61,14 @@ struct ppc64_stub_entry
    r2) into the stub. */
 static struct ppc64_stub_entry ppc64_stub =
 { .jump = {
-#ifdef __LITTLE_ENDIAN__
-	0x00, 0x00, 0x82, 0x3d, /* addis   r12,r2, <high> */
-	0x00, 0x00, 0x8c, 0x39, /* addi    r12,r12, <low> */
+	0x3d820000, /* addis   r12,r2, <high> */
+	0x398c0000, /* addi    r12,r12, <low> */
 	/* Save current r2 value in magic place on the stack. */
-	0x28, 0x00, 0x41, 0xf8, /* std     r2,40(r1) */
-	0x20, 0x00, 0x6c, 0xe9, /* ld      r11,32(r12) */
-	0x28, 0x00, 0x4c, 0xe8, /* ld      r2,40(r12) */
-	0xa6, 0x03, 0x69, 0x7d, /* mtctr   r11 */
-	0x20, 0x04, 0x80, 0x4e  /* bctr */
-#else
-	0x3d, 0x82, 0x00, 0x00, /* addis   r12,r2, <high> */
-	0x39, 0x8c, 0x00, 0x00, /* addi    r12,r12, <low> */
-	/* Save current r2 value in magic place on the stack. */
-	0xf8, 0x41, 0x00, 0x28, /* std     r2,40(r1) */
-	0xe9, 0x6c, 0x00, 0x20, /* ld      r11,32(r12) */
-	0xe8, 0x4c, 0x00, 0x28, /* ld      r2,40(r12) */
-	0x7d, 0x69, 0x03, 0xa6, /* mtctr   r11 */
-	0x4e, 0x80, 0x04, 0x20  /* bctr */
-#endif
+	0xf8410028, /* std     r2,40(r1) */
+	0xe96c0020, /* ld      r11,32(r12) */
+	0xe84c0028, /* ld      r2,40(r12) */
+	0x7d6903a6, /* mtctr   r11 */
+	0x4e800420  /* bctr */
 } };
 
 /* Count how many different 24-bit relocations (different symbol,
@@ -274,19 +263,10 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 			      struct ppc64_opd_entry *opd,
 			      struct module *me)
 {
-	Elf64_Half *loc1, *loc2;
 	long reladdr;
 
 	*entry = ppc64_stub;
 
-#ifdef __LITTLE_ENDIAN__
-	loc1 = (Elf64_Half *)&entry->jump[0];
-	loc2 = (Elf64_Half *)&entry->jump[4];
-#else
-	loc1 = (Elf64_Half *)&entry->jump[2];
-	loc2 = (Elf64_Half *)&entry->jump[6];
-#endif
-
 	/* Stub uses address relative to r2. */
 	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
@@ -296,8 +276,8 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 	}
 	DEBUGP("Stub %p get data from reladdr %li\n", entry, reladdr);
 
-	*loc1 = PPC_HA(reladdr);
-	*loc2 = PPC_LO(reladdr);
+	entry->jump[0] |= PPC_HA(reladdr);
+	entry->jump[1] |= PPC_LO(reladdr);
 	entry->opd.funcaddr = opd->funcaddr;
 	entry->opd.r2 = opd->r2;
 	return 1;
-- 
1.8.3.2

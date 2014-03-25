Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 27/33] powerpc: Handle new ELFv2 module relocations
Date: Tue, 25 Mar 2014 22:44:33 +1100
Message-Id: <1395747879-5948-28-git-send-email-anton@samba.org>
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

The new ELF ABI tends to use R_PPC64_REL16_LO and R_PPC64_REL16_HA
relocations (PC-relative), so implement them.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/include/uapi/asm/elf.h |  7 ++++++-
 arch/powerpc/kernel/module_64.c     | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 0341109..59dad11 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -295,8 +295,13 @@ do {									\
 #define R_PPC64_TLSLD		108
 #define R_PPC64_TOCSAVE		109
 
+#define R_PPC64_REL16		249
+#define R_PPC64_REL16_LO	250
+#define R_PPC64_REL16_HI	251
+#define R_PPC64_REL16_HA	252
+
 /* Keep this the last entry.  */
-#define R_PPC64_NUM		110
+#define R_PPC64_NUM		253
 
 /* There's actually a third entry here, but it's unused */
 struct ppc64_opd_entry
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f6544d7..34ba326 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -491,6 +491,23 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			 */
 			break;
 
+		case R_PPC64_REL16_HA:
+			/* Subtract location pointer */
+			value -= (unsigned long)location;
+			value = ((value + 0x8000) >> 16);
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
+		case R_PPC64_REL16_LO:
+			/* Subtract location pointer */
+			value -= (unsigned long)location;
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+			break;
+
 		default:
 			printk("%s: Unknown ADD relocation: %lu\n",
 			       me->name,
-- 
1.8.3.2

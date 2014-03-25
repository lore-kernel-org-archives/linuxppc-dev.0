Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 23/33] powerpc: modules implement R_PPC64_TOCSAVE relocation.
Date: Tue, 25 Mar 2014 22:44:29 +1100
Message-Id: <1395747879-5948-24-git-send-email-anton@samba.org>
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

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/include/uapi/asm/elf.h | 5 ++++-
 arch/powerpc/kernel/module_64.c     | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 7e39c91..0341109 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -291,9 +291,12 @@ do {									\
 #define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
 #define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
 #define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
+#define R_PPC64_TLSGD		107
+#define R_PPC64_TLSLD		108
+#define R_PPC64_TOCSAVE		109
 
 /* Keep this the last entry.  */
-#define R_PPC64_NUM		107
+#define R_PPC64_NUM		110
 
 /* There's actually a third entry here, but it's unused */
 struct ppc64_opd_entry
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 7c16b2e..a8694d4 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -454,6 +454,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			*location = value - (unsigned long)location;
 			break;
 
+		case R_PPC64_TOCSAVE:
+			/*
+			 * Marker reloc indicates we don't have to save r2.
+			 * That would only save us one instruction, so ignore
+			 * it.
+			 */
+			break;
+
 		default:
 			printk("%s: Unknown ADD relocation: %lu\n",
 			       me->name,
-- 
1.8.3.2

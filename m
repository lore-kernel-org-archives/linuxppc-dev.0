Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 3/7] powerpc/kprobes: Fix ABIv2 issues with kprobe_lookup_name
Date: Fri,  4 Apr 2014 17:09:06 +1100
Message-Id: <1396591750-8203-4-git-send-email-anton@samba.org>
In-Reply-To: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use ppc_function_entry in places where we previously assumed
function descriptors exist.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/kprobes.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 7b6feab..af15d4d 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -30,6 +30,7 @@
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 #include <asm/probes.h>
+#include <asm/code-patching.h>
 
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
 
@@ -56,9 +57,9 @@ typedef ppc_opcode_t kprobe_opcode_t;
 		if ((colon = strchr(name, ':')) != NULL) {		\
 			colon++;					\
 			if (*colon != '\0' && *colon != '.')		\
-				addr = *(kprobe_opcode_t **)addr;	\
+				addr = (kprobe_opcode_t *)ppc_function_entry(addr); \
 		} else if (name[0] != '.')				\
-			addr = *(kprobe_opcode_t **)addr;		\
+			addr = (kprobe_opcode_t *)ppc_function_entry(addr); \
 	} else {							\
 		char dot_name[KSYM_NAME_LEN];				\
 		dot_name[0] = '.';					\
-- 
1.8.3.2

Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 25/33] powerpc: module: handle MODVERSION for .TOC.
Date: Tue, 25 Mar 2014 22:44:31 +1100
Message-Id: <1395747879-5948-26-git-send-email-anton@samba.org>
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

For the ELFv2 ABI, powerpc introduces a magic symbol ".TOC.".  If we
don't create a CRC for it (minus the leading ".", since we strip that)
we get a modpost warning about missing CRC and the CRC array seems to
be displaced by 1 so other CRCs mismatch too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/misc_64.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index b80fafb..4e314b9 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -637,6 +637,15 @@ _GLOBAL(kexec_sequence)
 
 #ifdef CONFIG_MODULES
 #if defined(_CALL_ELF) && _CALL_ELF == 2
+
+#ifdef CONFIG_MODVERSIONS
+.weak __crc_TOC.
+.section "___kcrctab+TOC.","a"
+.globl __kcrctab_TOC.
+__kcrctab_TOC.:
+	.llong	__crc_TOC.
+#endif
+
 /*
  * Export a fake .TOC. since both modpost and depmod will complain otherwise.
  * Both modpost and depmod strip the leading . so we do the same here.
-- 
1.8.3.2

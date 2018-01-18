Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMlLD4mS3zF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 00:34:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: greg@kroah.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v4.14 backport 08/10] powerpc/64s: Support disabling RFI flush
 with no_rfi_flush and nopti
Date: Fri, 19 Jan 2018 00:34:08 +1100
Message-Id: <20180118133410.18716-8-mpe@ellerman.id.au>
In-Reply-To: <20180118133410.18716-1-mpe@ellerman.id.au>
References: <20180118133410.18716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit bc9c9304a45480797e13a8e1df96ffcf44fb62fe upstream.

Because there may be some performance overhead of the RFI flush, add
kernel command line options to disable it.

We add a sensibly named 'no_rfi_flush' option, but we also hijack the
x86 option 'nopti'. The RFI flush is not the same as KPTI, but if we
see 'nopti' we can guess that the user is trying to avoid any overhead
of Meltdown mitigations, and it means we don't have to educate every
one about a different command line option.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 79e81a783547..935059cb9e40 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -788,8 +788,29 @@ early_initcall(disable_hardlockup_detector);
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
 static void *l1d_flush_fallback_area;
+static bool no_rfi_flush;
 bool rfi_flush;
 
+static int __init handle_no_rfi_flush(char *p)
+{
+	pr_info("rfi-flush: disabled on command line.");
+	no_rfi_flush = true;
+	return 0;
+}
+early_param("no_rfi_flush", handle_no_rfi_flush);
+
+/*
+ * The RFI flush is not KPTI, but because users will see doco that says to use
+ * nopti we hijack that option here to also disable the RFI flush.
+ */
+static int __init handle_no_pti(char *p)
+{
+	pr_info("rfi-flush: disabling due to 'nopti' on command line.\n");
+	handle_no_rfi_flush(NULL);
+	return 0;
+}
+early_param("nopti", handle_no_pti);
+
 static void do_nothing(void *unused)
 {
 	/*
@@ -860,6 +881,7 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	enabled_flush_types = types;
 
-	rfi_flush_enable(enable);
+	if (!no_rfi_flush)
+		rfi_flush_enable(enable);
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.14.3

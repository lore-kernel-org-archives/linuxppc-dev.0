Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts49-srv.bellnexxia.net (tomts49.bellnexxia.net
	[209.226.175.193]) by ozlabs.org (Postfix) with ESMTP id 378BFDDEBE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 11:59:13 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.205.181])
	by tomts22-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20061221000142.OAVH8030.tomts22-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 19:01:42 -0500
Date: Wed, 20 Dec 2006 19:01:40 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 4/4] Linux Kernel Markers : powerpc optimisation
Message-ID: <20061221000140.GE28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061220235216.GA28643@Krystal>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the powerpc Linux Kernel Markers optimised version.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- /dev/null
+++ b/include/asm-powerpc/marker.h
@@ -0,0 +1,58 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. PowerPC architecture
+ * optimisations.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm/asm-compat.h>
+
+struct __mark_marker_c {
+	const char *name;
+	marker_probe_func **call;
+	const char *format;
+} __attribute__((packed));
+
+struct __mark_marker {
+	struct __mark_marker_c *cmark;
+	volatile short *enable;
+} __attribute__((packed));
+
+#ifdef CONFIG_MARKERS
+
+#define MARK(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		static const struct __mark_marker_c __mark_c_##name \
+			__attribute__((section(".markers.c"))) = \
+			{ #name, &__mark_call_##name, format } ; \
+		char condition; \
+		asm volatile(	".section .markers, \"a\";\n\t" \
+					PPC_LONG "%1, 0f;\n\t" \
+					".previous;\n\t" \
+					".align 4\n\t" \
+					"0:\n\t" \
+					"li %0,0;\n\t" \
+				: "=r" (condition) \
+				: "i" (&__mark_c_##name)); \
+		__mark_check_format(format, ## args); \
+		if (unlikely(condition)) { \
+			preempt_disable(); \
+			(*__mark_call_##name)(format, ## args); \
+			preempt_enable_no_resched(); \
+		} \
+	} while (0)
+
+
+/* Offset of the immediate value from the start of the addi instruction (result
+ * of the li mnemonic), in bytes. */
+#define MARK_ENABLE_IMMEDIATE_OFFSET 2
+#define MARK_POLYMORPHIC
+
+#endif

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6BB7DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 06:15:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7BKFpje010051
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:15:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7BKFo43170700
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:15:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7BKFoEP024336
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 14:15:50 -0600
Date: Tue, 12 Aug 2008 01:45:47 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] Apply relocation
Message-ID: <20080811201547.GC26566@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201120.GA25283@in.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apply relocation

This code is a wrapper around regular kernel. This checks whether the
kernel is loaded at 32MB, if its not loaded at 32MB, its treated as a
regular kernel and the control is given to the kernel immediately. If
the kernel is loaded at 32MB, it applies relocation delta to each offset
in the list which was generated and appended by patch 1 and 2. After
updating all offsets, control is given to the relocatable kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/boot/vmlinux.lds.S     |   28 ++++++++++++++++++++++++++++
 arch/powerpc/boot/vmlinux.reloc.scr |    8 ++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/vmlinux.lds.S
 create mode 100644 arch/powerpc/boot/vmlinux.reloc.scr

diff --git a/arch/powerpc/boot/vmlinux.lds.S b/arch/powerpc/boot/vmlinux.lds.S
new file mode 100644
index 0000000..245c667
--- /dev/null
+++ b/arch/powerpc/boot/vmlinux.lds.S
@@ -0,0 +1,28 @@
+#include <asm/page.h>
+#include <asm-generic/vmlinux.lds.h>
+
+ENTRY(start_wrap)
+
+OUTPUT_ARCH(powerpc:common64)
+SECTIONS
+{
+	. = KERNELBASE;
+
+/*
+ * Text, read only data and other permanent read-only sections
+ */
+	/* Text and gots */
+	.text : {
+		_head = .;
+		*(.text.head)
+		_ehead = .;
+
+		_text = .;
+		*(.vmlinux)
+		_etext = .;
+
+		_reloc = .;
+		*(.text.reloc)
+		_ereloc = .;
+	}
+}
diff --git a/arch/powerpc/boot/vmlinux.reloc.scr b/arch/powerpc/boot/vmlinux.reloc.scr
new file mode 100644
index 0000000..7240b6b
--- /dev/null
+++ b/arch/powerpc/boot/vmlinux.reloc.scr
@@ -0,0 +1,8 @@
+SECTIONS
+{
+  .vmlinux : {
+	input_len = .;
+	*(.data)
+	output_len = . - 8;
+	}
+}
-- 
1.5.4

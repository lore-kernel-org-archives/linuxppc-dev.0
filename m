Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392AAC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:02:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67E021773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCR8Yh0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67E021773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbVZ24StzDqLX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:02:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZCR8Yh0G"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTdJ4FVzzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:37:40 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id f6so7865406pgs.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o4nkW5qMBlJfhXU2XzdZiHmjUQAE2qfxhJ8o3/2mt0U=;
 b=ZCR8Yh0G0S9MhzPKcA0kaKJiCZNVsrjniYh3f7+M87mqND/kJ3K3EoZmRwPn0MZ5ZK
 PmWxHrvWcLryZ2VQBNbeH8+ZTyZ5tw1kwriR0leIEA8dcl+44zhDPon6srqvHpU1MRm5
 cMI6O+ut+omWKMcIi8H4MHja1/f1wbJZSPahTGJMTyJtSbuY7cU0Xpewq5YCpma5div9
 NPzvdJrv1yDWzDtPZiLeSukB7SJbfqxRic1TTD260Uh0cGc/TrLHrjRPMonjShkEBdYL
 b+mtBChn94Geop0jPrDxawLmoWjKhGu/oTm8hS56sZDZTQ7OW9bi0Cqf9uWwcGAP6J4d
 scTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o4nkW5qMBlJfhXU2XzdZiHmjUQAE2qfxhJ8o3/2mt0U=;
 b=mJb237YxvCgX4Jqq+k+sIEnK44ur+/OVADz/qhrzB6BPtYVyxXFsDtAyjIf9Z2EQV3
 eOqlovlUiKKwXpna7TtdsTizWKXVVP7otlS3OOezJ2edCRN6CJxXg2ZbyY5iCeH4mgIh
 zlGvRv1Fa3DQoLvyTEMD8oOVLjswo+wD4t8vpsYv5O/1XdcahkUFDe8b6kNqFc0eh11H
 +VlbSRzHZnxQggYi0z9Gu96V4G0tivIhFL+hE1BhZDU139sP5iD+3ewQ7ImJuxMN7z3U
 wuNIW/bz/ekzZrfW+0mAuq0xEUJiEIgQxlSAz4JvS5Bmx+k7XhSaBujzbIh7o3M6QjMN
 0Lbg==
X-Gm-Message-State: APjAAAVfwzWgnT1Okju84A7oHhgry+eRKgf5eQJle9T0Vb0FFNOx8ej/
 RHhataIiRzAgX4brAXMnvyA=
X-Google-Smtp-Source: APXvYqxrFa2o/lkJ3G96PqNTaEeM7wfvhL/FoS4hwRbeY2bEIv5FoVrZWHACnsr1tudYl838heCmdw==
X-Received: by 2002:a63:4a45:: with SMTP id j5mr26042107pgl.426.1556037458867; 
 Tue, 23 Apr 2019 09:37:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:37:38 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 44/63] Documentation: x86: convert zero-page.txt to reST
Date: Wed, 24 Apr 2019 00:29:13 +0800
Message-Id: <20190423162932.21428-45-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:32 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/zero-page.rst | 47 +++++++++++++++++++++++++++++++++
 Documentation/x86/zero-page.txt | 40 ----------------------------
 3 files changed, 48 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 7b8388ebd43d..9a0b5f38ef6b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,3 +14,4 @@ Linux x86 Support
    kernel-stacks
    entry_64
    earlyprintk
+   zero-page
diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
new file mode 100644
index 000000000000..deedbc84454d
--- /dev/null
+++ b/Documentation/x86/zero-page.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+Zero Page
+=========
+
+The additional fields in struct boot_params as a part of 32-bit boot
+protocol of kernel. These should be filled by bootloader or 16-bit
+real-mode setup code of the kernel. References/settings to it mainly
+are in::
+
+  arch/x86/include/uapi/asm/bootparam.h
+
+::
+
+	Offset	Proto	Name		Meaning
+	/Size
+
+	000/040	ALL	screen_info	Text mode or frame buffer information
+					(struct screen_info)
+	040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
+	058/008	ALL	tboot_addr      Physical address of tboot shared page
+	060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
+					(struct ist_info)
+	080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
+	090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
+	0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
+					OBSOLETE!!
+	0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
+	0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
+	0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
+	0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
+	140/080	ALL	edid_info	Video mode setup (struct edid_info)
+	1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
+	1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
+	1E4/004	ALL	scratch		Scratch field for the kernel setup code
+	1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
+	1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
+	1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
+					(below)
+	1EB/001	ALL     kbd_status      Numlock is enabled
+	1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
+	1EF/001	ALL	sentinel	Used to detect broken bootloaders
+	290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
+	2D0/A00	ALL	e820_table	E820 memory map table
+					(array of struct e820_entry)
+	D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
deleted file mode 100644
index 68aed077f7b6..000000000000
--- a/Documentation/x86/zero-page.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-The additional fields in struct boot_params as a part of 32-bit boot
-protocol of kernel. These should be filled by bootloader or 16-bit
-real-mode setup code of the kernel. References/settings to it mainly
-are in:
-
-  arch/x86/include/uapi/asm/bootparam.h
-
-
-Offset	Proto	Name		Meaning
-/Size
-
-000/040	ALL	screen_info	Text mode or frame buffer information
-				(struct screen_info)
-040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
-058/008	ALL	tboot_addr      Physical address of tboot shared page
-060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
-				(struct ist_info)
-080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
-090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
-0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
-				OBSOLETE!!
-0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
-0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
-0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
-0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
-140/080	ALL	edid_info	Video mode setup (struct edid_info)
-1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
-1E4/004	ALL	scratch		Scratch field for the kernel setup code
-1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
-1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
-1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
-				(below)
-1EB/001	ALL     kbd_status      Numlock is enabled
-1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
-1EF/001	ALL	sentinel	Used to detect broken bootloaders
-290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
-2D0/A00	ALL	e820_table	E820 memory map table
-				(array of struct e820_entry)
-D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
-- 
2.20.1


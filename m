Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2FC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A047820651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQb9AJGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A047820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qj583kkBzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:17:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQb9AJGQ"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh6K33KMzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:33:29 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id w25so84248pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5a/6MPsR4urKp6yQEMyiUcAMrF2FenVOvePurxnpdZ8=;
 b=bQb9AJGQlPSOo3LXhEGmCcLePbpXt3ZDwN9IY0TD8i+MWU/1jfz8mKaZXqgEs8kxP3
 TCE4C68S2MhbovfNZlQbpwJTewaK5rayecNA3fRKvT2ECRT2ITGgSaDcwsor+iBi3HUm
 sK8hNOcFZTx57HYoHgfj97irLlieOolVxiEa7K5PhsnbADqj8AvCt3ulIdtYltd1jGA9
 UahPsFHLftmQRA0Ii0eUyjITyj2+Ck2vdwKp3SGLfvPaRxpf1k22ZwPLaIXsOspEf25E
 1Bz+OaX/eAEfuGfCDQEquq+vwsfCk9rPqz7yq8DGcmKOJWu3ZfA2k/yNC5Q/y7TpDyii
 j0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5a/6MPsR4urKp6yQEMyiUcAMrF2FenVOvePurxnpdZ8=;
 b=kpqmpbJ5HjzgKgyJzo/K94ksUgFijSZ1Q6I6P4dxJF5TUr7IA76HbDJ6rX/xdJlRTY
 sjCnF7hHGnR0ieN5ZdMctW3Xq+tXDCbqcSr+EQxw30sKJIl69fpfopA7qerubHq41KB9
 D/LtlIWXoDmoiFdgn21tYc9ikTo7PWZEkijO/JErEZ6Mh3d0Vkf0IFMKY2Bit/Hjk/1d
 06ccGnpoe0SpXctng37jSemLV32kClCAi8apILswTzh0aV9jpKdG3VfO/aikjVRKMKXU
 peX99Go1QeApCM4fhvDrel43XCvs9+/8fwclJrSoCnCRwEMkDJ6KE8a4jK9UxH1MjXfT
 mUQg==
X-Gm-Message-State: APjAAAVbokhdk3mklIXq73JlWQRHLKwYacYOQez4EfsnLDJ5UM6VBKYV
 OwTHjAa2S8nCeO0O7Ynmjs0=
X-Google-Smtp-Source: APXvYqyD82rg0mi82mhLm44kgfK1nVbiS1CcHAwNaq0u8ox19Zj+Cp7hQO6CnorxaLYLJIXtAwc90A==
X-Received: by 2002:a63:6581:: with SMTP id
 z123mr38514410pgb.243.1556206406976; 
 Thu, 25 Apr 2019 08:33:26 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:33:26 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 19/24] Documentation: ACPI: move apei/output_format.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:12 +0800
Message-Id: <20190425153117.16057-20-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/acpi/apei/output_format.txt     | 147 -----------------
 .../acpi/apei/output_format.rst               | 150 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 3 files changed, 151 insertions(+), 147 deletions(-)
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst

diff --git a/Documentation/acpi/apei/output_format.txt b/Documentation/acpi/apei/output_format.txt
deleted file mode 100644
index 0c49c197c47a..000000000000
--- a/Documentation/acpi/apei/output_format.txt
+++ /dev/null
@@ -1,147 +0,0 @@
-                     APEI output format
-                     ~~~~~~~~~~~~~~~~~~
-
-APEI uses printk as hardware error reporting interface, the output
-format is as follow.
-
-<error record> :=
-APEI generic hardware error status
-severity: <integer>, <severity string>
-section: <integer>, severity: <integer>, <severity string>
-flags: <integer>
-<section flags strings>
-fru_id: <uuid string>
-fru_text: <string>
-section_type: <section type string>
-<section data>
-
-<severity string>* := recoverable | fatal | corrected | info
-
-<section flags strings># :=
-[primary][, containment warning][, reset][, threshold exceeded]\
-[, resource not accessible][, latent error]
-
-<section type string> := generic processor error | memory error | \
-PCIe error | unknown, <uuid string>
-
-<section data> :=
-<generic processor section data> | <memory section data> | \
-<pcie section data> | <null>
-
-<generic processor section data> :=
-[processor_type: <integer>, <proc type string>]
-[processor_isa: <integer>, <proc isa string>]
-[error_type: <integer>
-<proc error type strings>]
-[operation: <integer>, <proc operation string>]
-[flags: <integer>
-<proc flags strings>]
-[level: <integer>]
-[version_info: <integer>]
-[processor_id: <integer>]
-[target_address: <integer>]
-[requestor_id: <integer>]
-[responder_id: <integer>]
-[IP: <integer>]
-
-<proc type string>* := IA32/X64 | IA64
-
-<proc isa string>* := IA32 | IA64 | X64
-
-<processor error type strings># :=
-[cache error][, TLB error][, bus error][, micro-architectural error]
-
-<proc operation string>* := unknown or generic | data read | data write | \
-instruction execution
-
-<proc flags strings># :=
-[restartable][, precise IP][, overflow][, corrected]
-
-<memory section data> :=
-[error_status: <integer>]
-[physical_address: <integer>]
-[physical_address_mask: <integer>]
-[node: <integer>]
-[card: <integer>]
-[module: <integer>]
-[bank: <integer>]
-[device: <integer>]
-[row: <integer>]
-[column: <integer>]
-[bit_position: <integer>]
-[requestor_id: <integer>]
-[responder_id: <integer>]
-[target_id: <integer>]
-[error_type: <integer>, <mem error type string>]
-
-<mem error type string>* :=
-unknown | no error | single-bit ECC | multi-bit ECC | \
-single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
-target abort | parity error | watchdog timeout | invalid address | \
-mirror Broken | memory sparing | scrub corrected error | \
-scrub uncorrected error
-
-<pcie section data> :=
-[port_type: <integer>, <pcie port type string>]
-[version: <integer>.<integer>]
-[command: <integer>, status: <integer>]
-[device_id: <integer>:<integer>:<integer>.<integer>
-slot: <integer>
-secondary_bus: <integer>
-vendor_id: <integer>, device_id: <integer>
-class_code: <integer>]
-[serial number: <integer>, <integer>]
-[bridge: secondary_status: <integer>, control: <integer>]
-[aer_status: <integer>, aer_mask: <integer>
-<aer status string>
-[aer_uncor_severity: <integer>]
-aer_layer=<aer layer string>, aer_agent=<aer agent string>
-aer_tlp_header: <integer> <integer> <integer> <integer>]
-
-<pcie port type string>* := PCIe end point | legacy PCI end point | \
-unknown | unknown | root port | upstream switch port | \
-downstream switch port | PCIe to PCI/PCI-X bridge | \
-PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
-root complex event collector
-
-if section severity is fatal or recoverable
-<aer status string># :=
-unknown | unknown | unknown | unknown | Data Link Protocol | \
-unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
-Poisoned TLP | Flow Control Protocol | Completion Timeout | \
-Completer Abort | Unexpected Completion | Receiver Overflow | \
-Malformed TLP | ECRC | Unsupported Request
-else
-<aer status string># :=
-Receiver Error | unknown | unknown | unknown | unknown | unknown | \
-Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
-Replay Timer Timeout | Advisory Non-Fatal
-fi
-
-<aer layer string> :=
-Physical Layer | Data Link Layer | Transaction Layer
-
-<aer agent string> :=
-Receiver ID | Requester ID | Completer ID | Transmitter ID
-
-Where, [] designate corresponding content is optional
-
-All <field string> description with * has the following format:
-
-field: <integer>, <field string>
-
-Where value of <integer> should be the position of "string" in <field
-string> description. Otherwise, <field string> will be "unknown".
-
-All <field strings> description with # has the following format:
-
-field: <integer>
-<field strings>
-
-Where each string in <fields strings> corresponding to one set bit of
-<integer>. The bit position is the position of "string" in <field
-strings> description.
-
-For more detailed explanation of every field, please refer to UEFI
-specification version 2.3 or later, section Appendix N: Common
-Platform Error Record.
diff --git a/Documentation/firmware-guide/acpi/apei/output_format.rst b/Documentation/firmware-guide/acpi/apei/output_format.rst
new file mode 100644
index 000000000000..c2e7ebddb529
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/apei/output_format.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+APEI output format
+==================
+
+APEI uses printk as hardware error reporting interface, the output
+format is as follow::
+
+        <error record> :=
+        APEI generic hardware error status
+        severity: <integer>, <severity string>
+        section: <integer>, severity: <integer>, <severity string>
+        flags: <integer>
+        <section flags strings>
+        fru_id: <uuid string>
+        fru_text: <string>
+        section_type: <section type string>
+        <section data>
+
+        <severity string>* := recoverable | fatal | corrected | info
+
+        <section flags strings># :=
+        [primary][, containment warning][, reset][, threshold exceeded]\
+        [, resource not accessible][, latent error]
+
+        <section type string> := generic processor error | memory error | \
+        PCIe error | unknown, <uuid string>
+
+        <section data> :=
+        <generic processor section data> | <memory section data> | \
+        <pcie section data> | <null>
+
+        <generic processor section data> :=
+        [processor_type: <integer>, <proc type string>]
+        [processor_isa: <integer>, <proc isa string>]
+        [error_type: <integer>
+        <proc error type strings>]
+        [operation: <integer>, <proc operation string>]
+        [flags: <integer>
+        <proc flags strings>]
+        [level: <integer>]
+        [version_info: <integer>]
+        [processor_id: <integer>]
+        [target_address: <integer>]
+        [requestor_id: <integer>]
+        [responder_id: <integer>]
+        [IP: <integer>]
+
+        <proc type string>* := IA32/X64 | IA64
+
+        <proc isa string>* := IA32 | IA64 | X64
+
+        <processor error type strings># :=
+        [cache error][, TLB error][, bus error][, micro-architectural error]
+
+        <proc operation string>* := unknown or generic | data read | data write | \
+        instruction execution
+
+        <proc flags strings># :=
+        [restartable][, precise IP][, overflow][, corrected]
+
+        <memory section data> :=
+        [error_status: <integer>]
+        [physical_address: <integer>]
+        [physical_address_mask: <integer>]
+        [node: <integer>]
+        [card: <integer>]
+        [module: <integer>]
+        [bank: <integer>]
+        [device: <integer>]
+        [row: <integer>]
+        [column: <integer>]
+        [bit_position: <integer>]
+        [requestor_id: <integer>]
+        [responder_id: <integer>]
+        [target_id: <integer>]
+        [error_type: <integer>, <mem error type string>]
+
+        <mem error type string>* :=
+        unknown | no error | single-bit ECC | multi-bit ECC | \
+        single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
+        target abort | parity error | watchdog timeout | invalid address | \
+        mirror Broken | memory sparing | scrub corrected error | \
+        scrub uncorrected error
+
+        <pcie section data> :=
+        [port_type: <integer>, <pcie port type string>]
+        [version: <integer>.<integer>]
+        [command: <integer>, status: <integer>]
+        [device_id: <integer>:<integer>:<integer>.<integer>
+        slot: <integer>
+        secondary_bus: <integer>
+        vendor_id: <integer>, device_id: <integer>
+        class_code: <integer>]
+        [serial number: <integer>, <integer>]
+        [bridge: secondary_status: <integer>, control: <integer>]
+        [aer_status: <integer>, aer_mask: <integer>
+        <aer status string>
+        [aer_uncor_severity: <integer>]
+        aer_layer=<aer layer string>, aer_agent=<aer agent string>
+        aer_tlp_header: <integer> <integer> <integer> <integer>]
+
+        <pcie port type string>* := PCIe end point | legacy PCI end point | \
+        unknown | unknown | root port | upstream switch port | \
+        downstream switch port | PCIe to PCI/PCI-X bridge | \
+        PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
+        root complex event collector
+
+        if section severity is fatal or recoverable
+        <aer status string># :=
+        unknown | unknown | unknown | unknown | Data Link Protocol | \
+        unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
+        Poisoned TLP | Flow Control Protocol | Completion Timeout | \
+        Completer Abort | Unexpected Completion | Receiver Overflow | \
+        Malformed TLP | ECRC | Unsupported Request
+        else
+        <aer status string># :=
+        Receiver Error | unknown | unknown | unknown | unknown | unknown | \
+        Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
+        Replay Timer Timeout | Advisory Non-Fatal
+        fi
+
+        <aer layer string> :=
+        Physical Layer | Data Link Layer | Transaction Layer
+
+        <aer agent string> :=
+        Receiver ID | Requester ID | Completer ID | Transmitter ID
+
+Where, [] designate corresponding content is optional
+
+All <field string> description with * has the following format::
+
+        field: <integer>, <field string>
+
+Where value of <integer> should be the position of "string" in <field
+string> description. Otherwise, <field string> will be "unknown".
+
+All <field strings> description with # has the following format::
+
+        field: <integer>
+        <field strings>
+
+Where each string in <fields strings> corresponding to one set bit of
+<integer>. The bit position is the position of "string" in <field
+strings> description.
+
+For more detailed explanation of every field, please refer to UEFI
+specification version 2.3 or later, section Appendix N: Common
+Platform Error Record.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index e9f253d54897..869badba6d7a 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -17,6 +17,7 @@ ACPI Support
    DSD-properties-rules
    debug
    aml-debugger
+   apei/output_format
    gpio-properties
    i2c-muxes
    acpi-lid
-- 
2.20.1


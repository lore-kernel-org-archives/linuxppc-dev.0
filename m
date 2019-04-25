Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3759DC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:37:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C091F206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ0/y/Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C091F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhCF2jL9zDqXv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uZ0/y/Ml"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh4C65hCzDqWJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:31:39 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id y3so12424pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=38uz3qJNPvtDRMAt1xDrXWeaVF5xlbamdqed+OfZn+E=;
 b=uZ0/y/Mls3TIS2W94diWWMLbkQi4vN3XpTJrZPsHzlrU3dQVgRAgBxiRX20Ynd2pOV
 Kedu24tJ9bD/n4LWcVDT+4XXepndPCeosMaDvjjByhsUgBqo9fsaPLNZ7A5cJs3BdpVr
 6XtGsYeDGWqrVEAWO3SmSKFVLHTRDDJcBWVYKOTgmhoDB9ZuB+humMRDlaJlXP4YFX4B
 h0bJktvWFhjU0aToCZNJRuGUB+TWBVOEI9JV5lXskoFstVym5kEeoAkjYFiFeLRVZ3Nj
 uP1YpATEuVZaWN+EjnNQzd+de4ekJCFUkWEqbj+rqtv87aX/Q6MUwnalMElgfEgR/jf5
 MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=38uz3qJNPvtDRMAt1xDrXWeaVF5xlbamdqed+OfZn+E=;
 b=gOJtvaXUt9AEkGjvH8Y4ZJhT9MNiSnpZRgO2oLQFk8Dm3NG466cWZ1O9UWEOFqgw/b
 XSDzswZT++FLRYtTeIDa+Cx6ESkFxIeDooqBEG08Ci3WGgPg8XTxLdP2zb137K7CfVLt
 9tstd5zAEfgMmaQ2j6EI57hPXds+hYV5vyKfBih4PqQgg9ptT/jT75TCf8SBQiY8z1XV
 0VOjAWD/VZNEFHPiDbGiVP9ot3T3QkxX14XRFsdhT9TRT24FDTqzsGvItDBWNJInhzBe
 yDif8jCmhLDTnQkhxOP2IRbjvn2dM2js63tdCthGEMGat00xjuSztzmI6ZjWcEQ7+WMG
 eR1g==
X-Gm-Message-State: APjAAAVPXn+1Kt+jLCrFYddEDKi8XIlUATnduVpHSnbA6DhZSdv7Jmy7
 lFHtbjafkQZ5sZsy1dMUOS8=
X-Google-Smtp-Source: APXvYqz4vstQOb+DmzkKaxVX1jZv48TV1t+eOGfn+77NOzK+ntFfMZpuZbEP4+D+DuaxqbiN8B/eiA==
X-Received: by 2002:aa7:884b:: with SMTP id k11mr21257474pfo.49.1556206294356; 
 Thu, 25 Apr 2019 08:31:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.31.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:31:33 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Thu, 25 Apr 2019 23:30:53 +0800
Message-Id: <20190425153117.16057-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
reST format in this serias.

The hieararchy of ACPI docs are based on Corbet's suggestion:
https://lkml.org/lkml/2019/4/3/1047
I did some adjustment according to the content and finally they are placed as:
Documentation/firmware-guide/acpi/
├── acpi-lid.rst
├── aml-debugger.rst
├── apei
│   ├── einj.rst
│   └── output_format.rst
├── debug.rst
├── dsd
│   ├── data-node-references.rst
│   └── graph.rst
├── DSD-properties-rules.rst
├── enumeration.rst
├── gpio-properties.rst
├── i2c-muxes.rst
├── lpit.rst
├── method-customizing.rst
├── method-tracing.rst
├── namespace.rst
├── osi.rst
└── video_extension.rst
Documentation/driver-api/acpi/
├── linuxized-acpica.rst
└── scan_handlers.rst
ocumentation/admin-guide/acpi/
├── cppc_sysfs.rst
├── dsdt-override.rst
├── initrd_table_override.rst
└── ssdt-overlays.rst

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Many thanks for all the comments!

v6: add a missed patch.
v5: Fix all comments from Mauro. Thanks for your careful review!

Changbin Du (24):
  Documentation: add Linux ACPI to Sphinx TOC tree
  Documentation: ACPI: move namespace.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and
    convert to  reST
  Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and
    convert to reST
  Documentation: ACPI: move DSD-properties-rules.txt to
    firmware-guide/acpi and covert to reST
  Documentation: ACPI: move gpio-properties.txt to firmware-guide/acpi
    and convert to reST
  Documentation: ACPI: move method-customizing.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move initrd_table_override.txt to
    admin-guide/acpi and convert to reST
  Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/data-node-references.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move method-tracing.txt to firmware-guide/acpi
    and convert to rsST
  Documentation: ACPI: move aml-debugger.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move apei/output_format.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move ssdt-overlays.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move video_extension.txt to firmware-guide/acpi
    and convert to reST

 Documentation/acpi/aml-debugger.txt           |  66 ----
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.txt         | 192 ------------
 Documentation/acpi/ssdt-overlays.txt          | 172 ----------
 .../acpi/cppc_sysfs.rst}                      |  71 +++--
 .../acpi/dsdt-override.rst}                   |   8 +-
 Documentation/admin-guide/acpi/index.rst      |  14 +
 .../acpi/initrd_table_override.rst            | 115 +++++++
 .../admin-guide/acpi/ssdt-overlays.rst        | 180 +++++++++++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/driver-api/acpi/index.rst       |   9 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++---
 .../acpi/scan_handlers.rst}                   |  24 +-
 Documentation/driver-api/index.rst            |   1 +
 .../acpi/DSD-properties-rules.rst}            |  21 +-
 .../acpi/acpi-lid.rst}                        |  40 ++-
 .../firmware-guide/acpi/aml-debugger.rst      |  75 +++++
 .../acpi/apei/einj.rst}                       |  94 +++---
 .../acpi/apei/output_format.rst               | 150 +++++++++
 .../acpi/debug.rst}                           |  31 +-
 .../acpi/dsd/data-node-references.rst}        |  36 ++-
 .../acpi/dsd/graph.rst}                       | 157 +++++-----
 .../acpi/enumeration.rst}                     | 135 ++++----
 .../acpi/gpio-properties.rst}                 |  78 +++--
 .../firmware-guide/acpi/i2c-muxes.rst         |  61 ++++
 Documentation/firmware-guide/acpi/index.rst   |  26 ++
 .../lpit.txt => firmware-guide/acpi/lpit.rst} |  18 +-
 .../acpi/method-customizing.rst               |  89 ++++++
 .../firmware-guide/acpi/method-tracing.rst    | 238 ++++++++++++++
 .../acpi/namespace.rst}                       | 294 +++++++++---------
 .../osi.txt => firmware-guide/acpi/osi.rst}   |  15 +-
 .../acpi/video_extension.rst}                 |  85 +++--
 Documentation/firmware-guide/index.rst        |  13 +
 Documentation/index.rst                       |  10 +
 MAINTAINERS                                   |   2 +-
 38 files changed, 1659 insertions(+), 1360 deletions(-)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 delete mode 100644 Documentation/acpi/method-customizing.txt
 delete mode 100644 Documentation/acpi/method-tracing.txt
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (80%)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)
 create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)
 rename Documentation/{acpi/enumeration.txt => firmware-guide/acpi/enumeration.rst} (87%)
 rename Documentation/{acpi/gpio-properties.txt => firmware-guide/acpi/gpio-properties.rst} (81%)
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (56%)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (68%)
 create mode 100644 Documentation/firmware-guide/index.rst

-- 
2.20.1


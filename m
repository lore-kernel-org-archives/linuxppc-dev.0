Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33974C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:05:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F6E206B2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F6E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RbjW4WqFzF3T9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:05:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.44; helo=mail-ot1-f44.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZ52nMBzF3Td
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:58:52 +1000 (AEST)
Received: by mail-ot1-f44.google.com with SMTP id q50so9202709otd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2H5TWm/H0mjutjCIY7LBeMKuqNZFs88YFnIbfjaa4Us=;
 b=Kfm5+WxVH29V7eA7WZ/AN7HlwfQGKQr4c27BjGsrGEVDyTx4hDaLEisbcLSToTKaCC
 NcpMZiyQ5UX2HaE0Xh6P507j/xkCZWoiSEEyDi15AXEjL143L1hArGzBACabuq0D96SX
 GdxmFuJZhYpu7262Rfm0FFuBgkeDUhsOkA3RK5GQf/QsxaVmrSftANX+9FBasthvd2E/
 DV93kW0faB2+iNFQXURJONItndnGNVmdfnQIP7CzowR4xtVkwfr/rwwJiVTwLBHA16gN
 OKnCPSdHfsoRi1ohc/CoTLpFX5ATW+v2d8OD1H3pPbNA0eLgU/BHLtnTyLWuVShtsEOx
 Ikkw==
X-Gm-Message-State: ABuFfoiG/s0IATpAH9TOrPHoseIUDHzwIci18udEI7adWNcE9Hor3O7a
 kUIFv734RWC+nAJr4dZpfA==
X-Google-Smtp-Source: ACcGV60WUWdaXiwzhdMITdQ9ubAhOA3zBfrGJTp2HugmJjP1enuNMMsN8DTPobelUqkXaCwDuaTDkA==
X-Received: by 2002:a9d:3cd0:: with SMTP id t16mr7183164otf.158.1538758730142; 
 Fri, 05 Oct 2018 09:58:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:49 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/36] Devicetree schema
Date: Fri,  5 Oct 2018 11:58:12 -0500
Message-Id: <20181005165848.3474-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The current DT binding documentation is not ideal as it is just free form
text with at most only a loose structure. This makes reviewing bindings a
manual process. The bindings are often duplicating information that's
already defined elsewhere and missing information one would need to
validate a DTS file. The examples in binding documents are not built and
a source of lots of typos sometimes found in review and sometimes not.
Secondly, there's no verification that DTS files match what the
documentation says. While dtc does do some checking (and has gained more
recently), it can't do per binding checks as it would have to understand
thousands of compatible strings to match on.

There's been a number of proposals over the years to address validation.
They've all suffered from inventing their own validation language and the
effort it would take to fully define and flush out a validation language.
Enter json-schema. The language has a defined specification, maps well to
DT data, and there are numerous existing tools which can be leveraged.
The actual DT schema doc files are stored as YAML using only a JSON
compatible subset. YAML is considered more human readable allowing
comments for example.

This series adds the build support, some documentation, and converts
some bindings (mostly ARM board/soc bindings). The tools, core schema,
and meta-schema are in a separate repository[1]. This might eventually
be integrated with dtc or added to the kernel, but for now I plan to
keep it separate.

Future plans/ideas:
- Validate examples against the schema. Currently, they are just built
  with dtc.
- Support single targets in addition to validating all enabled dtb
  targets.
- Better control of which schemas to use for validation such as core
  only or specific lists of schemas. This will make for more easily
  testing new schema and filtering warnings.
- Printing out nodes without any specific schema (i.e. missing schema).

This series is dependent on the dt/next branch and is available here[2].
The branch also has a doc2yaml script which can help convert binding
files. It's not perfect, but works pretty well considering the input is
free form text.

Rob


[1] https://github.com/robherring/yaml-bindings
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git yaml-bindings

Rob Herring (36):
  dt-bindings: arm: alpine: Move CPU control related binding to
    cpu-enable-method/al,alpine-smp
  dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding
    to its own file
  dt-bindings: arm: atmel: Move various sys registers out of SoC binding
    doc
  dt-bindings: arm: fsl: Move DCFG and SCFG bindings to their own docs
  dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc
  dt-bindings: arm: zte: Move sysctrl bindings to their own doc
  kbuild: Add support for DT binding schema checks
  dt-bindings: Add a writing DT schemas how-to and annotated example
  dt-bindings: Convert trivial-devices.txt to json-schema
  dt-bindings: altera: Convert clkmgr binding to json-schema
  dt-bindings: timer: Convert ARM timer bindings to json-schema
  dt-bindings: arm: Convert cpu binding to json-schema
  dt-bindings: arm: Convert PMU binding to json-schema
  dt-bindings: arm: Convert primecell binding to json-schema
  dt-bindings: arm: Convert Actions Semi bindings to jsonschema
  dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
  dt-bindings: arm: Convert Altera board/soc bindings to json-schema
  dt-bindings: arm: Convert Amlogic board/soc bindings to json-schema
  dt-bindings: arm: Convert Atmel board/soc bindings to json-schema
  dt-bindings: arm: Convert Calxeda board/soc bindings to json-schema
  dt-bindings: arm: Convert TI davinci board/soc bindings to json-schema
  dt-bindings: arm: Convert FSL board/soc bindings to json-schema
  dt-bindings: arm: Convert MediaTek board/soc bindings to json-schema
  dt-bindings: arm: Convert TI nspire board/soc bindings to json-schema
  dt-bindings: arm: Convert Oxford Semi board/soc bindings to
    json-schema
  dt-bindings: arm: Convert QCom board/soc bindings to json-schema
  dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
  dt-bindings: arm: Convert Rockchip board/soc bindings to json-schema
  dt-bindings: arm: Convert Renesas board/soc bindings to json-schema
  dt-bindings: arm: Convert CSR SiRF board/soc bindings to json-schema
  dt-bindings: arm: Convert SPEAr board/soc bindings to json-schema
  dt-bindings: arm: Convert ST STi board/soc bindings to json-schema
  dt-bindings: arm: Convert Tegra board/soc bindings to json-schema
  dt-bindings: arm: Convert VIA board/soc bindings to json-schema
  dt-bindings: arm: Convert Xilinx board/soc bindings to json-schema
  dt-bindings: arm: Convert ZTE board/soc bindings to json-schema

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   2 +-
 Documentation/devicetree/bindings/.gitignore  |   2 +
 Documentation/devicetree/bindings/Makefile    |  30 ++
 .../devicetree/bindings/arm/actions.txt       |  56 --
 .../devicetree/bindings/arm/actions.yaml      |  34 ++
 .../devicetree/bindings/arm/al,alpine.txt     |  88 ---
 .../devicetree/bindings/arm/al,alpine.yaml    |  21 +
 .../devicetree/bindings/arm/altera.txt        |  14 -
 .../devicetree/bindings/arm/altera.yaml       |  20 +
 .../arm/altera/socfpga-clk-manager.txt        |  11 -
 .../arm/altera/socfpga-clk-manager.yaml       |  30 ++
 .../devicetree/bindings/arm/amlogic.txt       | 131 -----
 .../devicetree/bindings/arm/amlogic.yaml      | 104 ++++
 .../amlogic/amlogic,meson-gx-ao-secure.txt    |  28 +
 .../devicetree/bindings/arm/armadeus.txt      |   6 -
 .../devicetree/bindings/arm/atmel-at91.yaml   | 132 +++++
 .../arm/{atmel-at91.txt => atmel-sysregs.txt} |  73 +--
 Documentation/devicetree/bindings/arm/bhf.txt |   6 -
 .../devicetree/bindings/arm/calxeda.txt       |  15 -
 .../devicetree/bindings/arm/calxeda.yaml      |  22 +
 .../bindings/arm/compulab-boards.txt          |  25 -
 .../arm/cpu-enable-method/al,alpine-smp       |  34 +-
 .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
 .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
 .../devicetree/bindings/arm/davinci.txt       |  25 -
 .../arm/freescale/fsl,layerscape-dcfg.txt     |  19 +
 .../arm/freescale/fsl,layerscape-scfg.txt     |  19 +
 Documentation/devicetree/bindings/arm/fsl.txt | 224 --------
 .../devicetree/bindings/arm/fsl.yaml          | 166 ++++++
 .../devicetree/bindings/arm/i2se.txt          |  22 -
 .../devicetree/bindings/arm/mediatek.txt      |  79 ---
 .../devicetree/bindings/arm/mediatek.yaml     |  85 +++
 .../devicetree/bindings/arm/nspire.txt        |  14 -
 .../devicetree/bindings/arm/olimex.txt        |  10 -
 .../devicetree/bindings/arm/oxnas.txt         |  14 -
 .../devicetree/bindings/arm/oxnas.yaml        |  25 +
 Documentation/devicetree/bindings/arm/pmu.txt |  70 ---
 .../devicetree/bindings/arm/pmu.yaml          |  96 ++++
 .../devicetree/bindings/arm/primecell.txt     |  46 --
 .../devicetree/bindings/arm/primecell.yaml    |  35 ++
 .../devicetree/bindings/arm/qcom.txt          |  57 --
 .../devicetree/bindings/arm/qcom.yaml         | 125 +++++
 .../devicetree/bindings/arm/realtek.txt       |  22 -
 .../devicetree/bindings/arm/realtek.yaml      |  25 +
 .../devicetree/bindings/arm/renesas,prr.txt   |  18 +
 .../devicetree/bindings/arm/rockchip.txt      | 220 --------
 .../devicetree/bindings/arm/rockchip.yaml     | 242 +++++++++
 .../devicetree/bindings/arm/shmobile.txt      | 161 ------
 .../devicetree/bindings/arm/shmobile.yaml     | 205 +++++++
 .../devicetree/bindings/arm/sirf.txt          |  11 -
 .../devicetree/bindings/arm/sirf.yaml         |  27 +
 .../devicetree/bindings/arm/spear.txt         |  26 -
 .../devicetree/bindings/arm/spear.yaml        |  25 +
 Documentation/devicetree/bindings/arm/sti.txt |  23 -
 .../devicetree/bindings/arm/sti.yaml          |  23 +
 .../devicetree/bindings/arm/technologic.txt   |  23 -
 .../devicetree/bindings/arm/tegra.txt         |  60 ---
 .../devicetree/bindings/arm/tegra.yaml        |  88 +++
 .../devicetree/bindings/arm/ti/nspire.yaml    |  24 +
 .../bindings/arm/ti/ti,davinci.yaml           |  26 +
 .../devicetree/bindings/arm/vt8500.txt        |  22 -
 .../devicetree/bindings/arm/vt8500.yaml       |  23 +
 .../devicetree/bindings/arm/xilinx.txt        |  83 ---
 .../devicetree/bindings/arm/xilinx.yaml       |  81 +++
 .../bindings/arm/{zte.txt => zte-sysctrl.txt} |  15 +-
 .../devicetree/bindings/arm/zte.yaml          |  26 +
 .../devicetree/bindings/example-schema.yaml   | 155 ++++++
 .../bindings/timer/arm,arch_timer.txt         | 112 ----
 .../bindings/timer/arm,arch_timer.yaml        | 103 ++++
 .../bindings/timer/arm,arch_timer_mmio.yaml   | 120 +++++
 .../bindings/timer/arm,global_timer.txt       |  27 -
 .../bindings/timer/arm,global_timer.yaml      |  46 ++
 .../devicetree/bindings/trivial-devices.txt   | 201 -------
 .../devicetree/bindings/trivial-devices.yaml  | 414 ++++++++++++++
 Documentation/devicetree/writing-schema.md    | 111 ++++
 Makefile                                      |   8 +-
 scripts/Makefile.lib                          |  24 +-
 78 files changed, 3344 insertions(+), 2485 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.gitignore
 create mode 100644 Documentation/devicetree/bindings/Makefile
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/armadeus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
 rename Documentation/devicetree/bindings/arm/{atmel-at91.txt => atmel-sysregs.txt} (67%)
 delete mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/nspire.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
 create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ti/nspire.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml
 rename Documentation/devicetree/bindings/arm/{zte.txt => zte-sysctrl.txt} (62%)
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml
 create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/trivial-devices.txt
 create mode 100644 Documentation/devicetree/bindings/trivial-devices.yaml
 create mode 100644 Documentation/devicetree/writing-schema.md

--
2.17.1

Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E35C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:36:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9908120851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9908120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437ywl2NzpzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:36:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrX2DGYzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:28 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id w13so12345572oiw.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kPJl8Pm7ZcOKwW846HHdQooRTxxkgNCV5FyHgwbALNM=;
 b=OtnPVsjRrAyX3gYu7xT1Zs2Eomw/4p4emusPYBigkyRB4lmapES0sJScNMXil9Ow1r
 026GhpzuPMFd45izw8L4g14tDpgXVC+jZHGvyK52eWwK7rAl3d1uW0r8bILnNxZpQpMa
 gSuGcilMYBldQv36Oxgk9qWcutzdKVlxUfOcbY+ASS9YvTO90+xymjYawhoButh/IT0e
 y5mqEzDsqQ+ATHu25XJCjws2bWbsqD7aOsqxBJxZXSP1n0ZAehYx2M1VW6t6fvIKQMtP
 rE4J4TXIbY1LkNTjQCq0mC/teq7RCjzD+xMltW/wYsPUpxkc9rbYgtNppLdvcAyPd+oD
 27yQ==
X-Gm-Message-State: AA+aEWbu+uDe29y9dwePiT0zzBeuycgt+JjXduCD8MtMaVeq8hLzIJSR
 qbCfxOAPMTQdV8+VpdNSzA==
X-Google-Smtp-Source: AFSGD/WVj0pF9gZSFmJhEvEDv85aXRYTL9y7ZOW11KnyGcPAe1VwL6yGo7ypFqLTfUpB40kDZzQkbA==
X-Received: by 2002:aca:db41:: with SMTP id s62mr10385288oig.349.1543872745950; 
 Mon, 03 Dec 2018 13:32:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:25 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/34] Devicetree schema
Date: Mon,  3 Dec 2018 15:31:49 -0600
Message-Id: <20181203213223.16986-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko Stuebner <heiko@sntech.de>, Sean Hudson <darknighte@darknighte.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Sekhar Nori <nsekhar@ti.com>,
 Patrice Chotard <patrice.chotard@st.com>, David Brown <david.brown@linaro.org>,
 Grant Likely <grant.likely@arm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Kevin Hilman <khilman@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, arm@kernel.org,
 Andy Gross <andy.gross@linaro.org>,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>, linux-tegra@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Simon Horman <horms@verge.net.au>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-amlogic@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Tony Prisk <linux@prisktech.co.nz>, Dinh Nguyen <dinguyen@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>,
 Jun Nie <jun.nie@linaro.org>, linux-oxnas@groups.io,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
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

This series is available here[2]. The branch also has a doc2yaml script
which can help convert binding files. It's not perfect, but works pretty
well considering the input is free form text.

My plan is to merge this initial support for v4.21. There's not yet any
requirement that new bindings be submitted using the schema. I think that
should wait a bit until after this gets a bit more exposure. I do have
some tooling in place to test submitted patches and update DT patchwork
with the result.


SoC maintainers,
The board/soc bindings can go thru your trees if there are conflicts (if
any SoC or board is added). It shouldn't matter if they go in separately
from the build support. shmobile, rockchip, fsl and amlogic already have
conflicts with next. Otherwise, I can take them via the DT tree.

Rob


v2:
 - Rebase to v4.20-rc2
 - Add some missing Xilinx boards (from Michal Simek)
 - Add ability to validate with a single specified schema using
   the DT_SCHEMA_FILES variable.
 - Add back some dropped comments for board names
 - Various maintainer fixes
 - Rework ARM PMU interrupts schema.
 - Updates to ARM CPU vendor specific properties.
 - Add i2c-gpio conversion to json-schema. Serves as example of including
   another schema (i2c-controller.yaml)
 - Set license on schema files to GPL-2.0
 - Improvements to writing-schema.md and annotated example.


[1] https://github.com/robherring/yaml-bindings
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git yaml-bindings-v2

Michal Simek (1):
  dt-bindings: arm: Add missing Xilinx boards

Rob Herring (33):
  kbuild: Add support for DT binding schema checks
  dt-bindings: Add a writing DT schemas how-to and annotated example
  dt-bindings: Convert trivial-devices.txt to json-schema
  dt-bindings: altera: Convert clkmgr binding to json-schema
  dt-bindings: i2c: Convert i2c-gpio binding to json-schema
  dt-bindings: timer: Convert ARM timer bindings to json-schema
  dt-bindings: arm: Convert cpu binding to json-schema
  dt-bindings: arm: Convert PMU binding to json-schema
  dt-bindings: arm: Convert primecell binding to json-schema
  dt-bindings: arm: Convert Actions Semi bindings to jsonschema
  dt-bindings: arm: Convert Alpine board/soc bindings to json-schema
  dt-bindings: arm: Convert Altera board/soc bindings to json-schema
  dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding
    to its own file
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
  dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc
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
 Documentation/devicetree/bindings/.gitignore  |   1 +
 Documentation/devicetree/bindings/Makefile    |  33 ++
 .../devicetree/bindings/arm/actions.txt       |  56 --
 .../devicetree/bindings/arm/actions.yaml      |  38 ++
 .../devicetree/bindings/arm/al,alpine.txt     |  16 -
 .../devicetree/bindings/arm/al,alpine.yaml    |  21 +
 .../devicetree/bindings/arm/altera.txt        |  14 -
 .../devicetree/bindings/arm/altera.yaml       |  20 +
 .../arm/altera/socfpga-clk-manager.txt        |  11 -
 .../arm/altera/socfpga-clk-manager.yaml       |  31 ++
 .../devicetree/bindings/arm/amlogic.txt       | 138 -----
 .../devicetree/bindings/arm/amlogic.yaml      | 109 ++++
 .../amlogic/amlogic,meson-gx-ao-secure.txt    |  28 +
 .../devicetree/bindings/arm/armadeus.txt      |   6 -
 .../devicetree/bindings/arm/atmel-at91.txt    |  72 ---
 .../devicetree/bindings/arm/atmel-at91.yaml   | 133 +++++
 Documentation/devicetree/bindings/arm/bhf.txt |   6 -
 .../devicetree/bindings/arm/calxeda.txt       |  15 -
 .../devicetree/bindings/arm/calxeda.yaml      |  22 +
 .../bindings/arm/compulab-boards.txt          |  25 -
 .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
 .../devicetree/bindings/arm/cpus.yaml         | 507 ++++++++++++++++++
 .../devicetree/bindings/arm/davinci.txt       |  25 -
 Documentation/devicetree/bindings/arm/fsl.txt | 229 --------
 .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++
 .../devicetree/bindings/arm/i2se.txt          |  22 -
 .../devicetree/bindings/arm/mediatek.txt      |  79 ---
 .../devicetree/bindings/arm/mediatek.yaml     |  85 +++
 .../devicetree/bindings/arm/nspire.txt        |  14 -
 .../devicetree/bindings/arm/olimex.txt        |  10 -
 .../devicetree/bindings/arm/oxnas.txt         |  14 -
 .../devicetree/bindings/arm/oxnas.yaml        |  25 +
 Documentation/devicetree/bindings/arm/pmu.txt |  70 ---
 .../devicetree/bindings/arm/pmu.yaml          |  91 ++++
 .../devicetree/bindings/arm/primecell.txt     |  46 --
 .../devicetree/bindings/arm/primecell.yaml    |  36 ++
 .../devicetree/bindings/arm/qcom.txt          |  57 --
 .../devicetree/bindings/arm/qcom.yaml         | 125 +++++
 .../devicetree/bindings/arm/realtek.txt       |  22 -
 .../devicetree/bindings/arm/realtek.yaml      |  23 +
 .../devicetree/bindings/arm/renesas,prr.txt   |  20 +
 .../devicetree/bindings/arm/rockchip.txt      | 240 ---------
 .../devicetree/bindings/arm/rockchip.yaml     | 251 +++++++++
 .../devicetree/bindings/arm/shmobile.txt      | 169 ------
 .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++
 .../devicetree/bindings/arm/sirf.txt          |  11 -
 .../devicetree/bindings/arm/sirf.yaml         |  27 +
 .../devicetree/bindings/arm/spear.txt         |  26 -
 .../devicetree/bindings/arm/spear.yaml        |  25 +
 Documentation/devicetree/bindings/arm/sti.txt |  23 -
 .../devicetree/bindings/arm/sti.yaml          |  23 +
 .../devicetree/bindings/arm/technologic.txt   |  23 -
 .../devicetree/bindings/arm/tegra.txt         |  65 ---
 .../devicetree/bindings/arm/tegra.yaml        | 101 ++++
 .../devicetree/bindings/arm/ti/nspire.yaml    |  24 +
 .../bindings/arm/ti/ti,davinci.yaml           |  26 +
 .../devicetree/bindings/arm/vt8500.txt        |  22 -
 .../devicetree/bindings/arm/vt8500.yaml       |  23 +
 .../devicetree/bindings/arm/xilinx.txt        |  83 ---
 .../devicetree/bindings/arm/xilinx.yaml       | 114 ++++
 Documentation/devicetree/bindings/arm/zte.txt |  14 -
 .../devicetree/bindings/arm/zte.yaml          |  26 +
 .../devicetree/bindings/example-schema.yaml   | 170 ++++++
 .../devicetree/bindings/i2c/i2c-gpio.txt      |  46 --
 .../devicetree/bindings/i2c/i2c-gpio.yaml     |  73 +++
 .../bindings/timer/arm,arch_timer.txt         | 112 ----
 .../bindings/timer/arm,arch_timer.yaml        | 103 ++++
 .../bindings/timer/arm,arch_timer_mmio.yaml   | 120 +++++
 .../bindings/timer/arm,global_timer.txt       |  27 -
 .../bindings/timer/arm,global_timer.yaml      |  46 ++
 .../devicetree/bindings/trivial-devices.txt   | 190 -------
 .../devicetree/bindings/trivial-devices.yaml  | 392 ++++++++++++++
 Documentation/devicetree/writing-schema.md    | 130 +++++
 Makefile                                      |  11 +-
 scripts/Makefile.lib                          |  24 +-
 77 files changed, 3487 insertions(+), 2493 deletions(-)
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
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
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
 delete mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml
 create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/trivial-devices.txt
 create mode 100644 Documentation/devicetree/bindings/trivial-devices.yaml
 create mode 100644 Documentation/devicetree/writing-schema.md

--
2.19.1

Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0fjl0PV8zDvdB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 19:58:50 +1100 (AEDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 3t0fY63Zh9zMqlKH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 10:51:22 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>, Chanho Min <chanho.min@lge.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/6] DT: Fix spelling of standard properties
Date: Fri, 21 Oct 2016 10:51:11 +0200
Message-Id: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and error messages.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v2:
  - Dropped patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Split off "[PATCH v2 4/6] ASoC: davinci-mcbsp: DT fix
    s/interrupts-names/interrupt-names/" from the unrelated "[PATCH 06/14]
    dmaengine: bcm2835: DT spelling s/interrupts-names/interrupt-names/",
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Please apply where appropriate.

Thanks!

P.S. I used the following to detect misspellings:

    words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"

    git grep -Ew "${words}s-names"
    git grep -E "[^-]\<${words}-name\>[^-]"
    git grep -Ew "#${words}s-cells"             # false positive phys-cells
    git grep -E "#${words}-cell\>[^-]"

    git grep -w adress-cells
    git grep -Ew "interrupts-(map|parent)"

Geert Uytterhoeven (6):
  ARM: dts: STiH407: DT fix s/interrupts-names/interrupt-names/
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/
  dt: booting-without-of: DT fix s/#interrupt-cell/#interrupt-cells/
  powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/

 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 Documentation/devicetree/booting-without-of.txt           | 2 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi                    | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                        | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                        | 2 +-
 arch/powerpc/boot/dts/acadia.dts                          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

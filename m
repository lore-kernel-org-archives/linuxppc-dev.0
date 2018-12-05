Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCFAC04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D71320892
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="hExiDw+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D71320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398Pq106VzDqyh
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="hExiDw+d";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=verge.net.au
 (client-ip=202.4.237.240; helo=kirsty.vergenet.net;
 envelope-from=horms@verge.net.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="hExiDw+d";
 dkim-atps=neutral
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 4398Lt6xG5zDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:44:22 +1100 (AEDT)
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E870C25B7E1;
 Thu,  6 Dec 2018 06:44:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544039061; bh=TKgJ/B1m9hc37jwDkuVlvbypFYp99QVJvNT1/WVzoD4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hExiDw+dZd98p5OkWoSeKQLrmnMiUTlnUXeDWT8pfbHSqOC3VjddEqXJ8OFgYIXfv
 b9K/b4tA1e106sQZa3xhrED/lHP+355IhhWmPuBtPLxxxloHS1HbfmYPX4oDiO4UNw
 rBwZSYTmqYXI+Oye3MPsCH4uCm+3k0FgErQkdi78=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 64A1DE22094; Wed,  5 Dec 2018 11:44:19 -0800 (PST)
Date: Wed, 5 Dec 2018 11:44:19 -0800
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181205194419.p6u56h57yk63xshj@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > >
> > > > Cc: Simon Horman <horms@verge.net.au>
> > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > >
> > > Hi Rob,
> > >
> > > what is this based on? I get a conflict when applying the .txt change
> > > and if I knew the base for this patch it would be rather easy to work
> > > out what has changed.
> 
> 4.20-rc2
> 
> > >
> > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> 
> Yes. Though it was pointed out that get_maintainers.pl can pull emails
> out of this file. We'd need to get that to work by default though.
> 
> > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> 
> Sure, if that's what you all want.

How about this?

From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2.1] dt-bindings: arm: Convert Renesas board/soc bindings to
 json-schema

Convert Renesas SoC bindings to DT schema format using json-schema.

v2.1 [Simon Horman]
- rebased on renesas-devel-20181204-v4.20-rc5
  + Added r8a7744 development platform and SoM
  + Correct RZ/G2E part number
- Update MAINTAINERS

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 228 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
 MAINTAINERS                                        |   4 +-
 3 files changed, 230 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
new file mode 100644
index 000000000000..5e9d4864a600
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/shmobile.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Emma Mobile EV2
+        items:
+          - enum:
+              - renesas,kzm9d # Kyoto Microcomputer Co. KZM-A9-Dual
+          - const: renesas,emev2
+
+      - description: RZ/A1H (R7S72100)
+        items:
+          - enum:
+              - renesas,genmai # Genmai (RTK772100BC00000BR)
+              - renesas,gr-peach # GR-Peach (X28A-M01-E/F)
+              - renesas,rskrza1 # RSKRZA1 (YR0K77210C000BE)
+          - const: renesas,r7s72100
+
+      - description: RZ/A2 (R7S9210)
+        items:
+          - const: renesas,r7s9210
+
+      - description: SH-Mobile AG5 (R8A73A00/SH73A0)
+        items:
+          - enum:
+              - renesas,kzm9g # Kyoto Microcomputer Co. KZM-A9-GT
+          - const: renesas,sh73a0
+
+      - description: R-Mobile APE6 (R8A73A40)
+        items:
+          - enum:
+              - renesas,ape6evm
+          - const: renesas,r8a73a4
+
+      - description: R-Mobile A1 (R8A77400)
+        items:
+          - enum:
+              - renesas,armadillo800eva # Atmark Techno Armadillo-800 EVA
+          - const: renesas,r8a7740
+
+      - description: RZ/G1H (R8A77420)
+        items:
+          - const: renesas,r8a7742
+
+      - description: RZ/G1M (R8A77430)
+        items:
+          - enum:
+              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
+              - iwave,g20d
+          - const: iwave,g20m
+          - const: renesas,r8a7743
+
+      - items:
+          - enum:
+              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
+              - iwave,g20m
+              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)
+          - const: renesas,r8a7743
+
+      - description: RZ/G1N (R8A77440)
+        items:
+          - enum:
+              # iWave Systems RZ/G1N Qseven Development Platform (iW-RainboW-G20D-Qseven)
+              - iwave,g20d
+          - const: iwave,g20m
+          - const: renesas,r8a7744
+
+      - items:
+          - enum:
+              # iWave Systems RZ/G1N Qseven System On Module (iW-RainboW-G20M-Qseven)
+              - iwave,g20m
+          - const: renesas,r8a7744
+
+      - description: RZ/G1E (R8A77450)
+        items:
+          - enum:
+              - iwave,g22m # iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
+              - renesas,sk-rzg1e # SK-RZG1E (YR8A77450S000BE)
+          - const: renesas,r8a7745
+
+      - description: iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
+        items:
+          - const: iwave,g22d
+          - const: iwave,g22m
+          - const: renesas,r8a7745
+
+      - description: RZ/G1C (R8A77470)
+        items:
+          - enum:
+              - iwave,g23s #iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
+          - const: renesas,r8a77470
+
+      - description: RZ/G2M (R8A774A1)
+        items:
+          - const: renesas,r8a774a1
+
+      - description: RZ/G2E (R8A774C0)
+        items:
+          - const: renesas,r8a774c0
+
+      - description: R-Car M1A (R8A77781)
+        items:
+          - enum:
+              - renesas,bockw
+          - const: renesas,r8a7778
+
+      - description: R-Car H1 (R8A77790)
+        items:
+          - enum:
+              - renesas,marzen # Marzen (R0P7779A00010S)
+              - renesas,stout # Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
+          - const: renesas,r8a7779
+
+      - description: R-Car H2 (R8A77900)
+        items:
+          - enum:
+              - renesas,lager # Lager (RTP0RC7790SEB00010S)
+          - const: renesas,r8a7790
+
+      - description: R-Car M2-W (R8A77910)
+        items:
+          - enum:
+              - renesas,henninger
+              - renesas,koelsch # Koelsch (RTP0RC7791SEB00010S)
+              - renesas,porter # Porter (M2-LCDP)
+          - const: renesas,r8a7791
+
+      - description: R-Car V2H (R8A77920)
+        items:
+          - enum:
+              - renesas,blanche # Blanche (RTP0RC7792SEB00010S)
+              - renesas,wheat # Wheat (RTP0RC7792ASKB0000JE)
+          - const: renesas,r8a7792
+
+      - description: R-Car M2-N (R8A77930)
+        items:
+          - enum:
+              - renesas,gose # Gose (RTP0RC7793SEB00010S)
+          - const: renesas,r8a7793
+
+      - description: R-Car E2 (R8A77940)
+        items:
+          - enum:
+              - renesas,alt # Alt (RTP0RC7794SEB00010S)
+              - renesas,silk # SILK (RTP0RC7794LCB00011S)
+          - const: renesas,r8a7794
+
+      - description: R-Car H3 (R8A77950)
+        items:
+          - enum:
+                # H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
+                # H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
+              - renesas,h3ulcb
+              - renesas,salvator-x # Salvator-X (RTP0RC7795SIPB0010S)
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
+          - const: renesas,r8a7795
+
+      - description: R-Car M3-W (R8A77960)
+        items:
+          - enum:
+              - renesas,m3ulcb # M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
+              - renesas,salvator-x # Salvator-X (RTP0RC7796SIPB0011S)
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
+          - const: renesas,r8a7796
+
+      - description: Kingfisher (SBEV-RCAR-KF-M03)
+        items:
+          - const: shimafuji,kingfisher
+          - enum:
+              - renesas,h3ulcb
+              - renesas,m3ulcb
+          - enum:
+              - renesas,r8a7795
+              - renesas,r8a7796
+
+      - description: R-Car M3-N (R8A77965)
+        items:
+          - enum:
+              - renesas,m3nulcb # M3NULCB (R-Car Starter Kit Pro, RTP0RC77965SKBX010SA00 (M3-N ES1.1))
+              - renesas,salvator-x # Salvator-X (RTP0RC7796SIPB0011S (M3-N))
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
+          - const: renesas,r8a77965
+
+      - description: R-Car V3M (R8A77970)
+        items:
+          - enum:
+              - renesas,eagle # Eagle (RTP0RC77970SEB0010S)
+              - renesas,v3msk # V3MSK (Y-ASK-RCAR-V3M-WS10)
+          - const: renesas,r8a77970
+
+      - description: R-Car V3H (R8A77980)
+        items:
+          - enum:
+              - renesas,condor # Condor (RTP0RC77980SEB0010SS/RTP0RC77980SEB0010SA01)
+              - renesas,v3hsk # V3HSK (Y-ASK-RCAR-V3H-WS10)
+          - const: renesas,r8a77980
+
+      - description: R-Car E3 (R8A77990)
+        items:
+          - enum:
+              - renesas,ebisu # Ebisu (RTP0RC77990SEB0010S)
+          - const: renesas,r8a77990
+
+      - description: R-Car D3 (R8A77995)
+        items:
+          - enum:
+              - renesas,draak # Draak (RTP0RC77995SEB0010S)
+          - const: renesas,r8a77995
+
+      - description: RZ/N1D (R9A06G032)
+        items:
+          - enum:
+              - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
+          - const: renesas,r9a06g032
+
+...
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
deleted file mode 100644
index 7f91c2a8b54e..000000000000
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ /dev/null
@@ -1,155 +0,0 @@
-Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
---------------------------------------------------------------------
-
-SoCs:
-
-  - Emma Mobile EV2
-    compatible = "renesas,emev2"
-  - RZ/A1H (R7S72100)
-    compatible = "renesas,r7s72100"
-  - RZ/A2 (R7S9210)
-    compatible = "renesas,r7s9210"
-  - SH-Mobile AG5 (R8A73A00/SH73A0)
-    compatible = "renesas,sh73a0"
-  - R-Mobile APE6 (R8A73A40)
-    compatible = "renesas,r8a73a4"
-  - R-Mobile A1 (R8A77400)
-    compatible = "renesas,r8a7740"
-  - RZ/G1H (R8A77420)
-    compatible = "renesas,r8a7742"
-  - RZ/G1M (R8A77430)
-    compatible = "renesas,r8a7743"
-  - RZ/G1N (R8A77440)
-    compatible = "renesas,r8a7744"
-  - RZ/G1E (R8A77450)
-    compatible = "renesas,r8a7745"
-  - RZ/G1C (R8A77470)
-    compatible = "renesas,r8a77470"
-  - RZ/G2M (R8A774A1)
-    compatible = "renesas,r8a774a1"
-  - RZ/G2E (R8A774C0)
-    compatible = "renesas,r8a774c0"
-  - R-Car M1A (R8A77781)
-    compatible = "renesas,r8a7778"
-  - R-Car H1 (R8A77790)
-    compatible = "renesas,r8a7779"
-  - R-Car H2 (R8A77900)
-    compatible = "renesas,r8a7790"
-  - R-Car M2-W (R8A77910)
-    compatible = "renesas,r8a7791"
-  - R-Car V2H (R8A77920)
-    compatible = "renesas,r8a7792"
-  - R-Car M2-N (R8A77930)
-    compatible = "renesas,r8a7793"
-  - R-Car E2 (R8A77940)
-    compatible = "renesas,r8a7794"
-  - R-Car H3 (R8A77950)
-    compatible = "renesas,r8a7795"
-  - R-Car M3-W (R8A77960)
-    compatible = "renesas,r8a7796"
-  - R-Car M3-N (R8A77965)
-    compatible = "renesas,r8a77965"
-  - R-Car V3M (R8A77970)
-    compatible = "renesas,r8a77970"
-  - R-Car V3H (R8A77980)
-    compatible = "renesas,r8a77980"
-  - R-Car E3 (R8A77990)
-    compatible = "renesas,r8a77990"
-  - R-Car D3 (R8A77995)
-    compatible = "renesas,r8a77995"
-  - RZ/N1D (R9A06G032)
-    compatible = "renesas,r9a06g032"
-
-Boards:
-
-  - Alt (RTP0RC7794SEB00010S)
-    compatible = "renesas,alt", "renesas,r8a7794"
-  - APE6-EVM
-    compatible = "renesas,ape6evm", "renesas,r8a73a4"
-  - Atmark Techno Armadillo-800 EVA
-    compatible = "renesas,armadillo800eva", "renesas,r8a7740"
-  - Blanche (RTP0RC7792SEB00010S)
-    compatible = "renesas,blanche", "renesas,r8a7792"
-  - BOCK-W
-    compatible = "renesas,bockw", "renesas,r8a7778"
-  - Condor (RTP0RC77980SEB0010SS/RTP0RC77980SEB0010SA01)
-    compatible = "renesas,condor", "renesas,r8a77980"
-  - Draak (RTP0RC77995SEB0010S)
-    compatible = "renesas,draak", "renesas,r8a77995"
-  - Eagle (RTP0RC77970SEB0010S)
-    compatible = "renesas,eagle", "renesas,r8a77970"
-  - Ebisu (RTP0RC77990SEB0010S)
-    compatible = "renesas,ebisu", "renesas,r8a77990"
-  - Genmai (RTK772100BC00000BR)
-    compatible = "renesas,genmai", "renesas,r7s72100"
-  - GR-Peach (X28A-M01-E/F)
-    compatible = "renesas,gr-peach", "renesas,r7s72100"
-  - Gose (RTP0RC7793SEB00010S)
-    compatible = "renesas,gose", "renesas,r8a7793"
-  - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
-    H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
-    compatible = "renesas,h3ulcb", "renesas,r8a7795"
-  - Henninger
-    compatible = "renesas,henninger", "renesas,r8a7791"
-  - iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
-    compatible = "iwave,g23s", "renesas,r8a77470"
-  - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
-    compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
-  - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
-    compatible = "iwave,g22m", "renesas,r8a7745"
-  - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
-    compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
-  - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
-    compatible = "iwave,g20m", "renesas,r8a7743"
-  - iWave Systems RZ/G1N Qseven Development Platform (iW-RainboW-G20D-Qseven)
-    compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7744"
-  - iWave Systems RZ/G1N Qseven System On Module (iW-RainboW-G20M-Qseven)
-    compatible = "iwave,g20m", "renesas,r8a7744"
-  - Kingfisher (SBEV-RCAR-KF-M03)
-    compatible = "shimafuji,kingfisher"
-  - Koelsch (RTP0RC7791SEB00010S)
-    compatible = "renesas,koelsch", "renesas,r8a7791"
-  - Kyoto Microcomputer Co. KZM-A9-Dual
-    compatible = "renesas,kzm9d", "renesas,emev2"
-  - Kyoto Microcomputer Co. KZM-A9-GT
-    compatible = "renesas,kzm9g", "renesas,sh73a0"
-  - Lager (RTP0RC7790SEB00010S)
-    compatible = "renesas,lager", "renesas,r8a7790"
-  - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
-    compatible = "renesas,m3ulcb", "renesas,r8a7796"
-  - M3NULCB (R-Car Starter Kit Pro, RTP0RC77965SKBX010SA00 (M3-N ES1.1))
-    compatible = "renesas,m3nulcb", "renesas,r8a77965"
-  - Marzen (R0P7779A00010S)
-    compatible = "renesas,marzen", "renesas,r8a7779"
-  - Porter (M2-LCDP)
-    compatible = "renesas,porter", "renesas,r8a7791"
-  - RSKRZA1 (YR0K77210C000BE)
-    compatible = "renesas,rskrza1", "renesas,r7s72100"
-  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
-    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032"
-  - Salvator-X (RTP0RC7795SIPB0010S)
-    compatible = "renesas,salvator-x", "renesas,r8a7795"
-  - Salvator-X (RTP0RC7796SIPB0011S)
-    compatible = "renesas,salvator-x", "renesas,r8a7796"
-  - Salvator-X (RTP0RC7796SIPB0011S (M3-N))
-    compatible = "renesas,salvator-x", "renesas,r8a77965"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a7795"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a7796"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a77965"
-  - SILK (RTP0RC7794LCB00011S)
-    compatible = "renesas,silk", "renesas,r8a7794"
-  - SK-RZG1E (YR8A77450S000BE)
-    compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
-  - SK-RZG1M (YR8A77430S000BE)
-    compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
-  - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
-    compatible = "renesas,stout", "renesas,r8a7790"
-  - V3HSK (Y-ASK-RCAR-V3H-WS10)
-    compatible = "renesas,v3hsk", "renesas,r8a77980"
-  - V3MSK (Y-ASK-RCAR-V3M-WS10)
-    compatible = "renesas,v3msk", "renesas,r8a77970"
-  - Wheat (RTP0RC7792ASKB0000JE)
-    compatible = "renesas,wheat", "renesas,r8a7792"
diff --git a/MAINTAINERS b/MAINTAINERS
index 5254f41ec788..dadab9f25e9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1961,7 +1961,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
 F:	arch/arm64/configs/renesas_defconfig
-F:	Documentation/devicetree/bindings/arm/shmobile.txt
+F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
@@ -2081,7 +2081,7 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
-F:	Documentation/devicetree/bindings/arm/shmobile.txt
+F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.11.0


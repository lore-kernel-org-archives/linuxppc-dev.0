Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB3FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 01:27:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10AB20865
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 01:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10AB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4338Rg1BQ7zDqPD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:27:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4338PW2Sf1zDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 12:25:51 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gR5YF-0000Bq-AS; Sun, 25 Nov 2018 19:19:04 -0600
Message-ID: <09ee2f91765add47e628e0ab03776d468cec0914.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yuantian Tang <andy.tang@nxp.com>
Date: Sun, 25 Nov 2018 19:19:00 -0600
In-Reply-To: <20181031065736.32719-1-andy.tang@nxp.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: andy.tang@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 mturquette@baylibre.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-31 at 14:57 +0800, Yuantian Tang wrote:
> From: Scott Wood <oss@buserror.net>
> 
> The driver retains compatibility with old device trees, but we don't
> want the old nodes lying around to be copied, or used as a reference
> (some of the mux options are incorrect), or even just being clutter.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
> v3:
>   - update the commit message
>   - split the dts and driver to different patchset
> 
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi     |    4 +-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi       |   15 -----
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi    |   18 ------
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi    |   18 ------
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi    |   70 -------------------
> -----
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi     |   16 +++---
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi     |    4 +-
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi    |   18 ------
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi |   55 +++----------------
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |   38 +++----------
>  arch/powerpc/boot/dts/fsl/t1023si-post.dtsi    |   16 ------
>  arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi     |    4 +-
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi    |   44 ---------------
>  arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi    |   22 --------
>  arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi     |    8 ++--
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi    |   61 ---------------------
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi     |   24 ++++----
>  22 files changed, 66 insertions(+), 409 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> index 88d8423..bb7b9b9 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> @@ -70,14 +70,14 @@
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> index f3f968c..388ba1b 100644
> --- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> @@ -75,28 +75,28 @@
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
>  		cpu2: PowerPC,e6500@4 {
>  			device_type = "cpu";
>  			reg = <4 5>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
>  		cpu3: PowerPC,e6500@6 {
>  			device_type = "cpu";
>  			reg = <6 7>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
>  		};
> diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> index 1b33f51..4f044b4 100644
> --- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> @@ -398,21 +398,6 @@
>  	};
>  
>  /include/ "qoriq-clockgen2.dtsi"
> -	clockgen: global-utilities@e1000 {
> -		compatible = "fsl,b4-clockgen", "fsl,qoriq-clockgen-2.0";
> -		reg = <0xe1000 0x1000>;
> -
> -		mux0: mux0@0 {
> -			#clock-cells = <0>;
> -			reg = <0x0 0x4>;
> -			compatible = "fsl,qoriq-core-mux-2.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> -				<&pll1 0>, <&pll1 1>, <&pll1 2>;
> -			clock-names = "pll0", "pll0-div2", "pll0-div4",
> -				"pll1", "pll1-div2", "pll1-div4";
> -			clock-output-names = "cmux0";
> -		};
> -	};
>  
>  	rcpm: global-utilities@e2000 {
>  		compatible = "fsl,b4-rcpm", "fsl,qoriq-rcpm-2.0";
> diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> index 51e975d..872e448 100644
> --- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> @@ -327,24 +327,6 @@
>  /include/ "qoriq-clockgen1.dtsi"
>  	global-utilities@e1000 {
>  		compatible = "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
> -
> -		mux2: mux2@40 {
> -			#clock-cells = <0>;
> -			reg = <0x40 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux2";
> -		};
> -
> -		mux3: mux3@60 {
> -			#clock-cells = <0>;
> -			reg = <0x60 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux3";
> -		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> index 941274c..6318962 100644
> --- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> @@ -89,7 +89,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_0>;
>  			fsl,portid-mapping = <0x80000000>;
>  			L2_0: l2-cache {
> @@ -99,7 +99,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> -			clocks = <&mux1>;
> +			clocks = <&clockgen 1 1>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x40000000>;
>  			L2_1: l2-cache {
> @@ -109,7 +109,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> -			clocks = <&mux2>;
> +			clocks = <&clockgen 1 2>;
>  			next-level-cache = <&L2_2>;
>  			fsl,portid-mapping = <0x20000000>;
>  			L2_2: l2-cache {
> @@ -119,7 +119,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> -			clocks = <&mux3>;
> +			clocks = <&clockgen 1 3>;
>  			next-level-cache = <&L2_3>;
>  			fsl,portid-mapping = <0x10000000>;
>  			L2_3: l2-cache {
> diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> index 187676f..81bc75a 100644
> --- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> @@ -354,24 +354,6 @@
>  /include/ "qoriq-clockgen1.dtsi"
>  	global-utilities@e1000 {
>  		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
> -
> -		mux2: mux2@40 {
> -			#clock-cells = <0>;
> -			reg = <0x40 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux2";
> -		};
> -
> -		mux3: mux3@60 {
> -			#clock-cells = <0>;
> -			reg = <0x60 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux3";
> -		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> index 50b73e8..db92f11 100644
> --- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> @@ -90,7 +90,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_0>;
>  			fsl,portid-mapping = <0x80000000>;
>  			L2_0: l2-cache {
> @@ -100,7 +100,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> -			clocks = <&mux1>;
> +			clocks = <&clockgen 1 1>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x40000000>;
>  			L2_1: l2-cache {
> @@ -110,7 +110,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> -			clocks = <&mux2>;
> +			clocks = <&clockgen 1 2>;
>  			next-level-cache = <&L2_2>;
>  			fsl,portid-mapping = <0x20000000>;
>  			L2_2: l2-cache {
> @@ -120,7 +120,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> -			clocks = <&mux3>;
> +			clocks = <&clockgen 1 3>;
>  			next-level-cache = <&L2_3>;
>  			fsl,portid-mapping = <0x10000000>;
>  			L2_3: l2-cache {
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> index a025208..4da49b6 100644
> --- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> @@ -374,76 +374,6 @@
>  /include/ "qoriq-clockgen1.dtsi"
>  	global-utilities@e1000 {
>  		compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
> -
> -		pll2: pll2@840 {
> -			#clock-cells = <1>;
> -			reg = <0x840 0x4>;
> -			compatible = "fsl,qoriq-core-pll-1.0";
> -			clocks = <&sysclk>;
> -			clock-output-names = "pll2", "pll2-div2";
> -		};
> -
> -		pll3: pll3@860 {
> -			#clock-cells = <1>;
> -			reg = <0x860 0x4>;
> -			compatible = "fsl,qoriq-core-pll-1.0";
> -			clocks = <&sysclk>;
> -			clock-output-names = "pll3", "pll3-div2";
> -		};
> -
> -		mux2: mux2@40 {
> -			#clock-cells = <0>;
> -			reg = <0x40 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux2";
> -		};
> -
> -		mux3: mux3@60 {
> -			#clock-cells = <0>;
> -			reg = <0x60 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux3";
> -		};
> -
> -		mux4: mux4@80 {
> -			#clock-cells = <0>;
> -			reg = <0x80 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> -			clock-names = "pll2", "pll2-div2", "pll3", "pll3-
> div2";
> -			clock-output-names = "cmux4";
> -		};
> -
> -		mux5: mux5@a0 {
> -			#clock-cells = <0>;
> -			reg = <0xa0 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> -			clock-names = "pll2", "pll2-div2", "pll3", "pll3-
> div2";
> -			clock-output-names = "cmux5";
> -		};
> -
> -		mux6: mux6@c0 {
> -			#clock-cells = <0>;
> -			reg = <0xc0 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> -			clock-names = "pll2", "pll2-div2", "pll3", "pll3-
> div2";
> -			clock-output-names = "cmux6";
> -		};
> -
> -		mux7: mux7@e0 {
> -			#clock-cells = <0>;
> -			reg = <0xe0 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> -			clock-names = "pll2", "pll2-div2", "pll3", "pll3-
> div2";
> -			clock-output-names = "cmux7";
> -		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> index d56a546..0a7c65a 100644
> --- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> @@ -94,7 +94,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_0>;
>  			fsl,portid-mapping = <0x80000000>;
>  			L2_0: l2-cache {
> @@ -104,7 +104,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> -			clocks = <&mux1>;
> +			clocks = <&clockgen 1 1>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x40000000>;
>  			L2_1: l2-cache {
> @@ -114,7 +114,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> -			clocks = <&mux2>;
> +			clocks = <&clockgen 1 2>;
>  			next-level-cache = <&L2_2>;
>  			fsl,portid-mapping = <0x20000000>;
>  			L2_2: l2-cache {
> @@ -124,7 +124,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> -			clocks = <&mux3>;
> +			clocks = <&clockgen 1 3>;
>  			next-level-cache = <&L2_3>;
>  			fsl,portid-mapping = <0x10000000>;
>  			L2_3: l2-cache {
> @@ -134,7 +134,7 @@
>  		cpu4: PowerPC,e500mc@4 {
>  			device_type = "cpu";
>  			reg = <4>;
> -			clocks = <&mux4>;
> +			clocks = <&clockgen 1 4>;
>  			next-level-cache = <&L2_4>;
>  			fsl,portid-mapping = <0x08000000>;
>  			L2_4: l2-cache {
> @@ -144,7 +144,7 @@
>  		cpu5: PowerPC,e500mc@5 {
>  			device_type = "cpu";
>  			reg = <5>;
> -			clocks = <&mux5>;
> +			clocks = <&clockgen 1 5>;
>  			next-level-cache = <&L2_5>;
>  			fsl,portid-mapping = <0x04000000>;
>  			L2_5: l2-cache {
> @@ -154,7 +154,7 @@
>  		cpu6: PowerPC,e500mc@6 {
>  			device_type = "cpu";
>  			reg = <6>;
> -			clocks = <&mux6>;
> +			clocks = <&clockgen 1 6>;
>  			next-level-cache = <&L2_6>;
>  			fsl,portid-mapping = <0x02000000>;
>  			L2_6: l2-cache {
> @@ -164,7 +164,7 @@
>  		cpu7: PowerPC,e500mc@7 {
>  			device_type = "cpu";
>  			reg = <7>;
> -			clocks = <&mux7>;
> +			clocks = <&clockgen 1 7>;
>  			next-level-cache = <&L2_7>;
>  			fsl,portid-mapping = <0x01000000>;
>  			L2_7: l2-cache {
> diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> index bfba0b4..2d74ea8 100644
> --- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> @@ -96,7 +96,7 @@
>  		cpu0: PowerPC,e5500@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_0>;
>  			fsl,portid-mapping = <0x80000000>;
>  			L2_0: l2-cache {
> @@ -106,7 +106,7 @@
>  		cpu1: PowerPC,e5500@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> -			clocks = <&mux1>;
> +			clocks = <&clockgen 1 1>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x40000000>;
>  			L2_1: l2-cache {
> diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> index e2bd931..16b454b 100644
> --- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> @@ -319,24 +319,6 @@
>  /include/ "qoriq-clockgen1.dtsi"
>  	global-utilities@e1000 {
>  		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
> -
> -		mux2: mux2@40 {
> -			#clock-cells = <0>;
> -			reg = <0x40 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux2";
> -		};
> -
> -		mux3: mux3@60 {
> -			#clock-cells = <0>;
> -			reg = <0x60 0x4>;
> -			compatible = "fsl,qoriq-core-mux-1.0";
> -			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> -			clock-names = "pll0", "pll0-div2", "pll1", "pll1-
> div2";
> -			clock-output-names = "cmux3";
> -		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> index dbd5775..ed89dbb 100644
> --- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> @@ -102,7 +102,7 @@
>  		cpu0: PowerPC,e5500@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&mux0>;
> +			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_0>;
>  			fsl,portid-mapping = <0x80000000>;
>  			L2_0: l2-cache {
> @@ -112,7 +112,7 @@
>  		cpu1: PowerPC,e5500@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> -			clocks = <&mux1>;
> +			clocks = <&clockgen 1 1>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x40000000>;
>  			L2_1: l2-cache {
> @@ -122,7 +122,7 @@
>  		cpu2: PowerPC,e5500@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> -			clocks = <&mux2>;
> +			clocks = <&clockgen 1 2>;
>  			next-level-cache = <&L2_2>;
>  			fsl,portid-mapping = <0x20000000>;
>  			L2_2: l2-cache {
> @@ -132,7 +132,7 @@
>  		cpu3: PowerPC,e5500@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> -			clocks = <&mux3>;
> +			clocks = <&clockgen 1 3>;
>  			next-level-cache = <&L2_3>;
>  			fsl,portid-mapping = <0x10000000>;
>  			L2_3: l2-cache {
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> index 88cd70d..5c89cfa 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> @@ -32,55 +32,16 @@
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> +sysclk: sysclk {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <100000000>;
> +	clock-output-names = "sysclk";
> +};
> +
>  clockgen: global-utilities@e1000 {

The U-Boot fixup won't work with this.  U-Boot patches the frequency directly
into the clockgen node (BTW, this is another reason to preserve the generic
1.0/2.0 compatible string).  The new binding does not require an input clock
node when it is provided as clock-frequency directly in the clockgen node --
and the sysclk node was not in my original patch (nor did you note that you
made changes from that original).  Why did you add it?

I would just remove it when applying, but I'm concerned that this indicates a
lack of testing (and I don't have the hardware access to test it myself,
except on t4240) -- unless the 100 MHz sysclk just happened to be correct on
the machines you tested (which would also be a test coverage problem)?

-Scott



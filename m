Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 365092C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Mar 2014 20:22:37 +1100 (EST)
Date: Mon, 3 Mar 2014 10:22:31 +0100
From: Gerhard Sittig <gsi@denx.de>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dts: mpc512x: adjust clock specs for FEC nodes
Message-ID: <20140303092231.GS3327@book.gsilab.sittig.org>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
 <1393237557-31406-2-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393237557-31406-2-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawn.guo@linaro.org>,
 Mike Turquette <mturquette@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 24, 2014 at 11:25 +0100, Gerhard Sittig wrote:
> 
> a recent FEC binding document update that was motivated by i.MX
> development revealed that ARM and PowerPC implementations in Linux
> did not agree on the clock names to use for the FEC nodes
> 
> change clock names from "per" to "ipg" in the FEC nodes of the
> mpc5121.dtsi include file such that the .dts specs comply with
> the common FEC binding
> 
> this "incompatible" change does not break operation, because
> - COMMON_CLK support for MPC5121/23/25 and adjusted .dts files
>   were only introduced in Linux v3.14-rc1, no mainline release
>   provided these specs before
> - if this change won't make it for v3.14, the MPC512x CCF support
>   provides full backwards compability, and keeps operating with
>   device trees which lack clock specs or don't match in the names
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

ping

Are there opinions about making PowerPC users of FEC use the same
clock names as ARM users do, to re-use (actually: keep sharing)
the FEC binding?  The alternative would be to fragment the FEC
binding into several bindings for ARM and PowerPC, which I feel
would be undesirable, and is not necessary.

It would be nice to ship v3.14 (the first release with proper CCF
support for MPC512x) in a shape that is consistent with other FEC
users (ARM i.MX).  We are lucky to have noticed the difference
before the release, and need not introduce the incompatibility,
and need not document and support obsolete conditions but can fix
them instead.

> ---
>  arch/powerpc/boot/dts/mpc5121.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
> index 2c0e1552d20b..a5a375598ed8 100644
> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
> @@ -281,7 +281,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			clocks = <&clks MPC512x_CLK_FEC>;
> -			clock-names = "per";
> +			clock-names = "ipg";
>  		};
>  
>  		eth0: ethernet@2800 {
> @@ -291,7 +291,7 @@
>  			local-mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <4 0x8>;
>  			clocks = <&clks MPC512x_CLK_FEC>;
> -			clock-names = "per";
> +			clock-names = "ipg";
>  		};
>  
>  		/* USB1 using external ULPI PHY */
> -- 
> 1.7.10.4


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

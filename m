Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 77616DDF0C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 01:20:47 +1100 (EST)
Date: Tue, 24 Mar 2009 17:20:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Update ranges in gianfar node to match
	other dts
Message-ID: <20090324142045.GA17184@oksana.dev.rtsoft.ru>
References: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 08:35:45AM -0500, Kumar Gala wrote:
> The gianfar node @ 25000 was missing its ranges prop for the mdio bus
> and provided an explicit ranges property on gianfar@24000 to match
> all other .dts
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

I think this part is missing:

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 3ebf7ec..98de8bf 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -195,11 +195,11 @@
 			fixed-link = <1 1 1000 0 0>;
 			fsl,magic-packet;
 
-			mdio@24520 {
+			mdio@520 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,gianfar-mdio";
-				reg = <0x24520 0x20>;
+				reg = <0x520 0x20>;
 				phy4: ethernet-phy@4 {
 					interrupt-parent = <&ipic>;
 					interrupts = <20 0x8>;
@@ -229,11 +229,11 @@
 			sleep = <&pmc 0x10000000>;
 			fsl,magic-packet;
 
-			mdio@25520 {
+			mdio@520 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,gianfar-tbi";
-				reg = <0x25520 0x20>;
+				reg = <0x520 0x20>;
 
 				tbi1: tbi-phy@11 {
 					reg = <0x11>;


>  arch/powerpc/boot/dts/mpc8313erdb.dts |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 3ebf7ec..20a0fa8 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -180,7 +180,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			sleep = <&pmc 0x20000000>;
> -			ranges;
> +			ranges = <0x0 0x24000 0x1000>;
>  
>  			cell-index = <0>;
>  			device_type = "network";
> @@ -221,6 +221,7 @@
>  			model = "eTSEC";
>  			compatible = "gianfar";
>  			reg = <0x25000 0x1000>;
> +			ranges = <0x0 0x25000 0x1000>;
>  			local-mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <34 0x8 33 0x8 32 0x8>;
>  			interrupt-parent = <&ipic>;
> -- 
> 1.5.6.6

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

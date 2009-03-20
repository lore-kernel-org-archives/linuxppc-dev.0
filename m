Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B3ECDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 15:26:48 +1100 (EST)
Message-Id: <734DA8C3-EADB-4426-BD18-AC190918CD7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49C26434.30302@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
Date: Thu, 19 Mar 2009 23:26:41 -0500
References: <49C26434.30302@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2009, at 10:26 AM, Wolfgang Grandegger wrote:

> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,gianfar-mdio";
> +			reg = <0x24520 0x20>;
> +
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0 1>;
> +				reg = <0>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy1: ethernet-phy@1 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0 1>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			tbi0: tbi-phy@11 {
> +				reg = <0x11>;
> +				device_type = "tbi-phy";
> +			};
> +		};
> +
> +		mdio@26520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,gianfar-tbi";
> +			reg = <0x26520 0x20>;
> +
> +			tbi1: tbi-phy@11 {
> +				reg = <0x11>;
> +				device_type = "tbi-phy";
> +			};
> +		};
> +
> +		enet0: ethernet@24000 {
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <29 2 30 2 34 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
> +			tbi-handle = <&tbi0>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +

See Anton's recent post in moving the mdio node under the ethernet.   
Please match.

- k

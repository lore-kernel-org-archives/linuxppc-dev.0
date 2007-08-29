Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Aug 2007 15:39:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Introduce new CPM device bindings.
Message-ID: <20070829053941.GC3206@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201619.GB24210@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201619.GB24210@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 03:16:19PM -0500, Scott Wood wrote:
> This introduces a new device binding for the CPM and other devices on
> these boards.  Some of the changes include:
> 
> 1. Proper namespace scoping for Freescale compatibles and properties.
> 
> 2. Use compatible rather than things like device_type and model
> to determine which particular variant of a device is present.
> 
> 3. Give the drivers the relevant CPM command word directly, rather than
> requiring it to have a lookup table based on device-id, SCC v. SMC, and
> CPM version.
> 
> 4. Specify the CPCR and the usable DPRAM region in the CPM's reg property.
> 
> Boards that do not require the legacy bindings should select
> CONFIG_PPC_CPM_NEW_BINDING to enable the of_platform CPM devices. Once
> all existing boards are converted and tested, the config option can
> become default y to prevent new boards from using the old model.  Once
> arch/ppc is gone, the config option can be removed altogether.

I think it would be better to change the name and reverse the sense of
this config option, since what it actually does is disable the old
binding, not enable the new one.

[snip]
> @@ -1824,6 +1827,170 @@ platforms are moved over to use the flattened-device-tree model.
>  		fsl,has-rstcr;
>  	};
>  
> +   l) Freescale Communications Processor Module
> +
> +   NOTE: This is an interim binding, and will likely change slightly,
> +   as more devices are supported.  The QE bindings especially are
> +   incomplete.
> +
> +   i) Root CPM node
> +
> +   Properties:
> +   - compatible : "fsl,cpm1", "fsl,cpm2", or "fsl,qe".
> +   - reg : The first resource is a 48-byte region beginning with
> +           CPCR.  The second is the available general-purpose
> +           DPRAM.
> +   - fsl,brg-frequency : the internal clock source frequency for baud-rate
> +     generators in Hz.
> +
> +   Example:
> +	cpm@119c0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
> +		reg = <119c0 30 0 2000>;
> +		bus-frequency = <d#25000000>;
> +	}

Your example has bus-frequency, but lacks fsl,brg-frequency, in
contrast to the description above.

Since you have a separate brg node defined below, maybe
fsl,brg-frequency should just be replaced with a 'clock-frequency'
property in that subnode.

> +   ii) Properties common to mulitple CPM/QE devices
> +
> +   - fsl,cpm-command : This value is ORed with the opcode and command flag
> +                       to specify the device on which a CPM command operates.
> +
> +   - fsl,cpm-brg : Indicates which baud rate generator the device
> +                   is associated with.  If absent, an unused BRG
> +                   should be dynamically allocated.

Maybe a property with the brg node's phandle could be included as
well, to avoid having to hop up to the CPM node, then back down to the
brg-compatible node to find it?

Or maybe even have a separate subnode for each brg, and just have a
phandle to reference it from the other devices, rather than using this
index.

> +
> +   - reg : Unless otherwise specified, the first resource represents the
> +           scc/fcc/ucc registers, and the second represents the device's
> +           parameter RAM region (if it has one).
> +
> +   iii) Serial
> +
> +   Currently defined compatibles:
> +   - fsl,cpm1-smc-uart
> +   - fsl,cpm2-smc-uart
> +   - fsl,cpm1-scc-uart
> +   - fsl,cpm2-scc-uart
> +   - fsl,qe-uart
> +
> +   Example:
> +
> +	serial@11a00 {
> +		device_type = "serial";
> +		compatible = "fsl,mpc8272-scc-uart",
> +		             "fsl,cpm2-scc-uart";
> +		reg = <11a00 20 8000 100>;
> +		interrupts = <28 8>;
> +		interrupt-parent = <&PIC>;
> +		fsl,cpm-brg = <1>;
> +		fsl,cpm-command = <00800000>;
> +	};
> +
> +   iii) Network
> +
> +   Currently defined compatibles:
> +   - fsl,cpm1-scc-enet
> +   - fsl,cpm2-scc-enet
> +   - fsl,cpm1-fec-enet
> +   - fsl,cpm2-fcc-enet (third resource is GFEMR)
> +   - fsl,qe-enet
> +
> +   Example:
> +
> +	ethernet@11300 {
> +		device_type = "network";
> +		compatible = "fsl,mpc8272-fcc-enet",
> +		             "fsl,cpm2-fcc-enet";
> +		reg = <11300 20 8400 100 11390 1>;
> +		local-mac-address = [ 00 00 00 00 00 00 ];
> +		interrupts = <20 8>;
> +		interrupt-parent = <&PIC>;
> +		phy-handle = <&PHY0>;
> +		linux,network-index = <0>;
> +		fsl,cpm-command = <12000300>;
> +	};

Should this also have a phandle pointer to the mdio node?

> +   iv) MDIO
> +
> +   Currently defined compatibles:
> +   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
> +   fsl,cpm2-mdio-bitbang (reg is port C registers)
> +
> +   Properties for fsl,cpm2-mdio-bitbang:
> +   fsl,mdio-pin : pin of port C controlling mdio data
> +   fsl,mdc-pin : pin of port C controlling mdio clock
> +
> +   Example:
> +
> +	mdio@10d40 {
> +		device_type = "mdio";
> +		compatible = "fsl,mpc8272ads-mdio-bitbang",
> +		             "fsl,mpc8272-mdio-bitbang",
> +		             "fsl,cpm2-mdio-bitbang";
> +		reg = <10d40 14>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		fsl,mdio-pin = <12>;
> +		fsl,mdc-pin = <13>;
> +	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

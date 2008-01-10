Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE902DE041
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:01:26 +1100 (EST)
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Thu, 10 Jan 2008 16:01:01 +1100
Message-Id: <1199941261.6734.224.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, sven@genesi-usa.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-09 at 09:32 -0700, Grant Likely wrote:
> From: Olaf Hering <olaf@aepfle.de>
> 
> The new network driver fec_mpc52xx will not work on efika because the
> firmware does not provide all required properties.
> http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
> create more properties. But only the phy stuff is required to get a
> working network.
> 
> This should go into the kernel because its appearently
> impossible to boot the script via tftp and then load the real boot
> binary (yaboot or zimage).
> 
> (Olaf's s-o-b line needs to go here)
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

As much as I despise having to work around firmware bugs, it looks
indeed like this one has been broken for way too long to the point where
users are being hurt, distros are being hurt, and telling people to
whack things in nvramrc is just plain gross, so let's merge it.
> ---
> 
> Here's my respin of Olaf's patch to move it to fixup_device_tree_efika()
> and to make it check if the nodes exist before blindly creating them.
> 
> Cheers,
> g.
> 
>  arch/powerpc/kernel/prom_init.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 1add6ef..5d89a21 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2216,6 +2216,45 @@ static void __init fixup_device_tree_efika(void)
>  			prom_printf("fixup_device_tree_efika: ",
>  				"skipped entry %x - setprop error\n", i);
>  	}
> +
> +	/* Make sure ethernet mdio bus node exists */
> +	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio"));
> +	if (!PHANDLE_VALID(node)) {
> +		prom_printf("Adding Ethernet MDIO node\n");
> +		call_prom("interpret", 1, 1,
> +			" s\" /builtin\" find-device"
> +			" new-device"
> +				" 1 encode-int s\" #address-cells\" property"
> +				" 0 encode-int s\" #size-cells\" property"
> +				" s\" mdio\" 2dup device-name device-type"
> +				" s\" mpc5200b-fec-phy\" encode-string"
> +				" s\" compatible\" property"
> +				" 0xf0003000 0x400 reg"
> +				" 0x2 encode-int"
> +				" 0x5 encode-int encode+"
> +				" 0x3 encode-int encode+"
> +				" s\" interrupts\" property"
> +			" finish-device");
> +	};
> +
> +	/* Make sure ethernet phy device node exist */
> +	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio/ethernet-phy"));
> +	if (!PHANDLE_VALID(node)) {
> +		prom_printf("Adding Ethernet PHY node\n");
> +		call_prom("interpret", 1, 1,
> +			" s\" /builtin/mdio\" find-device"
> +			" new-device"
> +				" s\" ethernet-phy\" device-name"
> +				" 0x10 encode-int s\" reg\" property"
> +				" my-self"
> +				" ihandle>phandle"
> +			" finish-device"
> +			" s\" /builtin/ethernet\" find-device"
> +				" encode-int"
> +				" s\" phy-handle\" property"
> +			" device-end");
> +	}
> +
>  }
>  #else
>  #define fixup_device_tree_efika()
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

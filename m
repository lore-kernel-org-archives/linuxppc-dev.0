Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 14A6EDE207
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:53:04 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so113142uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:53:03 -0800 (PST)
Message-ID: <4784FCB1.3010509@genesi-usa.com>
Date: Wed, 09 Jan 2008 16:56:17 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
In-Reply-To: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Okay I have a better suggestion.

Apply all the prom_init fixes you like. But, instead of swizzling on the
individual nodes, do it blanket for the firmware version.

For instance, wrap the entire efika fixups stuff with a check for the
openprom property "built-on" - this is the date the firmware was built.
efika.forth will change this!

Just make sure it's less than.. let's say, a certain version of efika.forth,
and I will roll a version which has a higher version and some extra features
like CAN/I2C exposure.

If you run efika.forth it will not touch the device tree. If you don't, it
will add the small amount of patches. Add a huge comment that this hunk of
code should be scheduled for deletion at some later date. Put a Kconfig
around it so it can be taken out, even, at distro option.

Does that sound better? Right now I'm a little too busy to write and
compile test code for it so I will not venture to submit a patch..
do we want to work on a comprehensive, required efika.forth release
that fixes these things together, or is it just my job for now?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Grant Likely wrote:
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

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB7FDB7D53
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 10:27:41 +1000 (EST)
Subject: Re: ppc4xx emac support of phy-less devices patch + dts example
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Staale.Aakermann@kongsberg.com
In-Reply-To: <DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13@ukgw-exmb-p06.kda.kongsberg.com>
References: <DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13@ukgw-exmb-p06.kda.kongsberg.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 10:27:28 +1000
Message-ID: <1270600048.13812.98.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-19 at 13:32 +0100, Staale.Aakermann@kongsberg.com wrote:
> Hi,

 Hi !

Sorry for the delay, I've been busy with other things and your message
slipped a bit through the cracks.

> I'm currently working on a custom embedded card with ppc405ex
> installed. 
> 
> On this card, EMAC1 is "phy-less", and connected directly to a MAC on
> a micrel switch (ks8995ma).
>
> I've tried the default phy-less mode currently supported by the core
> driver for ibm_newmac, but found
> 
> this insufficient. I've made a patch for the core driver so it
> supports some more scenarios. 

 .../...
 

So first thing first, your patch is completely whitespace damaged :-)

Now, as for your aproach:

> +    if (emac_read_uint_prop(np, "phy-duplex", &dev->phy.duplex, 0))
> 
> +        dev->phy.duplex = 1;
> 
> +
> 
> +    if (emac_read_uint_prop(np, "phy-speed", &dev->phy.speed, 0))
> 
> +        dev->phy.speed = 100;
> 
> +
> 
> +    if (emac_read_uint_prop(np, "phy-autoneg", &dev->phy.autoneg, 0))
> 
> +        dev->phy.autoneg = 0;
> 
> +

No objection on the method above. It might be nicer to call those
fixed-phy-duplex, fixed-phy-speed, etc... and have a "fixed-phy" empty
property as a cleaner way to represent the phyless mode but that's not a
very big deal.

>             dev->phy.address = -1;
> 
>             dev->phy.features = SUPPORTED_MII;
> 
> -           if (emac_phy_supports_gige(dev->phy_mode))
> 
> -                 dev->phy.features |= SUPPORTED_1000baseT_Full;
> 
> -           else
> 
> -                 dev->phy.features |= SUPPORTED_100baseT_Full;
> 

So you remove the above which sets the 1000bT support...

> +
> 
> +        if (dev->phy.autoneg == 1 )
> 
> +            dev->phy.features |= SUPPORTED_Autoneg;
> 
> +

> +        switch (dev->phy.duplex)
> 
> +        {
> 
> +            case 0:
> 
> +
> 
> +                if (dev->phy.speed == 10 )
> 
> +                    dev->phy.features |= SUPPORTED_10baseT_Half;
> 
> +
> 
> +                if (dev->phy.speed == 100 )
> 
> +                    dev->phy.features |= SUPPORTED_100baseT_Half;
> 
> +
> 
> +                if (dev->phy.speed == 100 )
> 
> +                    dev->phy.features |= SUPPORTED_100baseT_Half;
> 
> +
> 
> +            default:
> 

Ditto...

> 
> +                if (dev->phy.speed == 10 )
> 
> +                    dev->phy.features |= SUPPORTED_10baseT_Full;
> 
> +
> 
> +                if (dev->phy.speed == 100 )
> 
> +                    dev->phy.features |= SUPPORTED_100baseT_Full;
> 
> +
> 
> +                if (dev->phy.speed == 100 )
> 
> +                    dev->phy.features |= SUPPORTED_100baseT_Full;
> 
> +        }
> 
> +

And never add back any option for 1000bT ... Not nice :-)

You should add the case back for 1000bT (btw, turn the above into a
switch/case statement please). And if phy.speed is none of the above
(default, ie, the property is not present in the device-tree), then
revert to the old method, or something like that. Or you may break
existing stuff.

>             dev->phy.pause = 1;
> 
>  
> 
> +        #if defined (CONFIG_PPC_DCR_NATIVE) && defined (CONFIG_405EX)
> 
> +        if (of_get_property(np, "phy-clock-internal", NULL))
> 
> +            dcri_clrset(SDR0, SDR0_MFR, ( dev->rgmii_port ?
> SDR0_MFR_ECS >> 1 : SDR0_MFR_ECS ),0 );
> 
> +        #endif
> 
> +

Ok.

Cheers,
Ben.

>             return 0;
> 
>       }
> 
>  
> 
>  
> 
> DTS example:
> 
>  
> 
> EMAC1: ethernet@ef600a00 {
> 
>       linux,network-index = <0x1>;
> 
>       device_type = "network";
> 
>       compatible = "ibm,emac-405ex", "ibm,emac4sync";
> 
>       interrupt-parent = <&EMAC1>;
> 
>       interrupts = <0x0 0x1>;
> 
>       #interrupt-cells = <1>;
> 
>       #address-cells = <0>;
> 
>       #size-cells = <0>;
> 
>       interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
> 
>                    /*Wake*/  0x1  &UIC1 0x1f 0x4>;
> 
>       reg = <0xef600a00 0x000000c4>;
> 
>       local-mac-address = [0000000000]; 
> 
>       mal-device = <&MAL0>;
> 
>       mal-tx-channel = <1>;
> 
>       mal-rx-channel = <1>;
> 
>       cell-index = <1>;
> 
>       max-frame-size = <9000>;
> 
>       rx-fifo-size = <4096>;
> 
>       tx-fifo-size = <2048>;
> 
>       phy-mode = "rgmii";
> 
>       phy-map = <0xffffffff>;      // Be sure that the emac use
> phy-less configuration
> 
>       phy-address = <0xffffffff>;  // Be sure that the emac use
> phy-less configuration
> 
>       phy-speed = <100>;
> 
>       phy-duplex = <1>;
> 
>       phy-autoneg = <0>;
> 
>       phy-clock-internal;          
> 
>       rgmii-device = <&RGMII0>;
> 
>       rgmii-channel = <1>;
> 
>       has-inverted-stacr-oc;
> 
>       has-new-stacr-staopc;
> 
> };
> 
>  
> 
>  
> 
>  
> 
> Best regards 
> 
> Staale Aakermann, Systems Engineer
> 
> Kongsberg Defence Systems / Defence Communication
> 
> Olav Brunborgsv 6, P.O.Box 87, 1375 Billingstad, Norway
> 
> Phone: +47 66 84 24 00, Direct Phone: +47 66 74 48 51,
> 
> Fax: +47 66 84 82 30, Mobile: +47 928 29 879
> 
> Mail: staale.aakermann@kongsberg.com
> 
> Url: www.kongsberg.com
> 
>  
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

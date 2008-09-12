Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Sep 2008 10:36:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: TQM8349 and ARCH = powerpc
Message-ID: <20080912003640.GA22288@yookeroo.seuss>
References: <48C68763.6030606@sympatec.com>
	<20080909112253.c9c9617f.kim.phillips@freescale.com>
	<48C7D5C6.1070507@sympatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48C7D5C6.1070507@sympatec.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 10, 2008 at 04:12:22PM +0200, Oliver Rutsch wrote:
> Hi again,
>
>>
>> u-boot assigns the IMMR to 0xff400000 in TQM834x.h, whereas the device
>> tree you picked has it at 0xe0000000 (it's defined in the soc node).
>> Don't forget to match up the PCI addresses too.  patches welcome, of
>> course (we don't have tqm boards).
>>
> So I modified the dts to match the IMMRMBAR and the pci section at  
> 0xff400000. In U-Boot I disabled the PCI_CONFIG because I don't need the  
> PCI bus. But the result is always the same. It looks like the kernel  
> stops booting at an earlier stage.
>
> I hope it's OK to post my current tqm8349.dts here:
> Any suggestions are welcome.
>
> Thanks and bye,
>
> /dts-v1/;

[snip]
>     wdt@200 {
>       device_type = "watchdog";

Drop this device_type.

>       compatible = "mpc83xx_wdt";
>       reg = <0x200 0x100>;
>     };

[snip]
>     usb@22000 {
>       compatible = "fsl-usb2-mph";
>       reg = <0x22000 0x1000>;
>       #address-cells = <1>;
>       #size-cells = <0>;
>       interrupt-parent = <&ipic>;
>       interrupts = <39 0x8>;
>       phy_type = "ulpi";
>       port1;

Yuck.. is this 'port1' thing in the binding?  It's a terrible property
name...

>     };

[snip]
>     enet0: ethernet@24000 {
>       cell-index = <0>;
>       device_type = "network";
>       model = "TSEC";
>       compatible = "gianfar";

Didn't someone finally get around to rewriting the gianfar binding
with a better compatible string?

>       reg = <0x24000 0x1000>;
>       local-mac-address = [ 00 00 00 00 00 00 ];
>       interrupts = <32 0x8 33 0x8 34 0x8>;
>       interrupt-parent = <&ipic>;
>       phy-handle = <&phy0>;
>       linux,network-index = <0>;

linux,network-index shouldn't be necessary any more.

>     };

[snip]
>   pci0: pci@ff408500 {
>     cell-index = <1>;

I don't think cell-index belongs here.

>     interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>     interrupt-map = <
>         /* IDSEL 0x10 - SATA */
>         0x8000 0x0 0x0 0x1 &ipic 22 0x8 /* SATA_INTA */
>         >;
>     interrupt-parent = <&ipic>;
>     interrupts = <66 0x8>;
>     bus-range = <0x0 0x0>;
>     ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
>         0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
>         0x01000000 0x0 0x00000000 0xe2000000 0x0 0x01000000>;
>     clock-frequency = <66666666>;
>     #interrupt-cells = <1>;
>     #size-cells = <2>;
>     #address-cells = <3>;
>     reg = <0xff408500 0x100>;
>     compatible = "fsl,mpc8349-pci";
>     device_type = "pci";
>   };
>
>   localbus@ff405000 {
>     #address-cells = <2>;
>     #size-cells = <1>;
>     compatible = "fsl,mpc8349e-localbus",
>            "fsl,pq2pro-localbus";
>     reg = <0xff405000 0xd8>;
>     ranges = <0x3 0x0 0xf0000000 0x210>;
>
>
>   };
> };
>
>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

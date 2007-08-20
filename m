Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id E12B5DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 18:31:42 +1000 (EST)
Date: Mon, 20 Aug 2007 10:31:37 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20070820083137.GJ13994@moe.telargo.com>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070818100643.GA31233@nd47.coderock.org>
	<46C8643B.7010104@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46C8643B.7010104@genesi-usa.com>
Cc: Domen Puncer <domen@coderock.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 19/08/07 16:39 +0100, Matt Sealey wrote:
> Domen,
> 
> Do it in a Forth script, or in nvramrc (after probe-all). Don't clutter
> Linux with more fixups. The Efika PHY isn't going to change to something
> else and it's a bog standard no-frills MII PHY anyway.

Fine with me, but I'm worried people won't update nvramrc.

Currently I have this:
--- start ---

s" /builtin" find-device

new-device
        1 encode-int s" #address-cells" property
        0 encode-int s" #size-cells" property
        s" mdio" 2dup device-name device-type
        s" mpc5200b-fec-phy" s" compatible" property
        0xf0003000 0x400 reg

        0x2 encode-int
        0x5 encode-int
        0x3 encode-int
        encode+ encode+
        s" interupts" property

        new-device
                s" ethernet-phy@0" device-name
                s" ethernet-phy" device-type
                0 encode-int s" reg" property

                my-self \ save our phandle to stack
                ihandle>phandle
        finish-device
finish-device

s" /builtin/ethernet" find-device
        encode-int      \ phy's phandle
        s" phy-handle" property
device-end

---  end  ---

But I have a problem with it, possibly due to my not-knowledge of Forth.
Compatible keep getting set to:
	compatible            "/builtin/etherne"



<spin>
> If you insist on using prom_init and fixups, yaboot has the best
> examples of call-method and interpret, both readable and fairly
> easily available.

Thanks.


	Domen

> > On 10/08/07 11:51 +0200, Domen Puncer wrote:
> >> Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> >> ===================================================================
> >> --- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> >> +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> >> +		mdio@3000 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +			device_type = "mdio";
> >> +			compatible = "mpc5200b-fec-phy";
> >> +			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
> >> +			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
> >> +			interrupt-parent = <&mpc5200_pic>;
> >> +
> >> +			phy0:ethernet-phy@0 {
> >> +				device_type = "ethernet-phy";
> >> +				reg = <0>;
> >> +			};
> >>  		};
> > 
> > I am struggling with this part on Efika.
> > I would like to add this to the device tree from
> > fixup_device_tree_efika() (arch/powerpc/kernel/prom_init.c).
> > 
> > AFAICS client-services doesn't offer anything like new-device,
> > so I guess "interpret" or "call-method" will have to be used.
> > 
> > I have read some docs, but I'm still wandering in the dark.
> > Can I please get an example?
> > Pretty please with a cherry on top?
> > 
> > 
> > 	Domen
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

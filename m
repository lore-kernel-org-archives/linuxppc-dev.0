Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 2CBB3DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 01:31:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc/4xx: Add GPIO, SPI and MMC suport to the Arches
Date: Fri, 31 Oct 2008 15:31:05 +0100
References: <1225451506-24727-1-git-send-email-sr@denx.de>
	<20081031122121.GA21741@oksana.dev.rtsoft.ru>
In-Reply-To: <20081031122121.GA21741@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810311531.05357.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

thanks for your comments.

On Friday 31 October 2008, Anton Vorontsov wrote:
> > diff --git a/arch/powerpc/boot/dts/arches.dts
> > b/arch/powerpc/boot/dts/arches.dts index d9113b1..c568095 100644
> > --- a/arch/powerpc/boot/dts/arches.dts
> > +++ b/arch/powerpc/boot/dts/arches.dts
> > @@ -195,6 +195,38 @@
> >  				interrupts = <0x3 0x4>;
> >  			};
> >
> > +			SPI0: spi@ef600900 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				device_type = "spi";
>
> device_type isn't needed.

OK, will remove.

> > +				compatible = "ibm,spi-460gt", "ibm,ppc4xx-spi";
> > +				reg = <0xef600900 7>;
> > +				interrupt-parent = <&UIC1>;
> > +				interrupts = <2 4>;
> > +
> > +				/* gpio(s) representing chip select(s) */
> > +				gpios = <&GPIO1 11 0>;
> > +
> > +				mmc-slot@0 {
> > +					compatible = "linux,mmc-spi", "mmc-spi";
>
> According to new (though still not approved) bindings, this should
> be "<board-specific>-mmc-slot", "mmc-spi-slot".

So I will wait a while with re-sending until this is "approved".

> > +					reg = <0>;
> > +					spi-max-frequency = <10000000>;
> > +					voltage-range = <3300 3300>;
>
> For new bindings I changed this to "voltage-ranges", so that we
> could specify discontinuous range.

OK, will change in next version.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================

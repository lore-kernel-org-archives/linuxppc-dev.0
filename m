Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB56C1A0BB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 03:30:41 +1100 (EST)
Message-ID: <1412785827.13320.532.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Wed, 8 Oct 2014 11:30:27 -0500
In-Reply-To: <5435649F.5070908@c-s.fr>
References: <20141003164916.DBD631AAFA2@localhost.localdomain>
 <1412368198.13320.434.camel@snotra.buserror.net> <542FE1C4.7000403@c-s.fr>
 <1412640953.13320.502.camel@snotra.buserror.net> <5435649F.5070908@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-08 at 18:21 +0200, leroy christophe wrote:
> Le 07/10/2014 02:15, Scott Wood a écrit :
> > On Sat, 2014-10-04 at 14:02 +0200, christophe leroy wrote:
> >> What should it look like if that offset had to be in the device tree ?
> > If the offset is not relocatable or discoverable, it should stay in the
> > device tree.  If you have an old chip you wouldn't have
> > fsl,cpm1-spi-reloc and thus you'd still have "0x3d80 0x30" in reg.
> This index is from the start of the dual port RAM. It is 0x2000 above 
> the start of the CPM area.
> In the DTS, we have:
> 
>      soc@ff000000 {
>          compatible = "fsl,mpc885", "fsl,pq1-soc";
>          #address-cells = <1>;
>          #size-cells = <1>;
>          device_type = "soc";
>          ranges = <0x0 0xff000000 0x28000>;
>          bus-frequency = <0>;
>          clock-frequency = <0>;
> 
>          cpm@9c0 {
>              #address-cells = <1>;
>              #size-cells = <1>;
>              compatible = "fsl,mpc885-cpm", "fsl,cpm1";
>              ranges;
>              reg = <0x9c0 0x40>;
>              brg-frequency = <0>;
>              interrupts = <0>;    // cpm error interrupt
>              interrupt-parent = <&CPM_PIC>;
> 
>              muram@2000 {
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges = <0x0 0x2000 0x2000>;
> 
>                  data@0 {
>                      compatible = "fsl,cpm-muram-data";
>                      reg = <0x0 0x1c00>;
>                  };
>              };
> 
>              spi: spi@a80 {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  cell-index = <0>;
>                  compatible = "fsl,spi", "fsl,cpm1-spi";
>                  reg = <0xa80 0x30 0x3d80 0x30>;
>                  interrupts = <5>;
>                  interrupt-parent = <&CPM_PIC>;
>                  mode = "cpu";
> 
> 
> The binding allows me to do an of_iomap() on the parameter RAM, hence to 
> get access to the relocation index which is inside it.
> But if the relocation index is 0, I have to calculate it by myself 
> because the calling function expects it in return.
> The binding is also supposed to tell that the muram is at 0xff002000. 
> But I don't know how I can get this info and use it to calculate the 
> index of my param RAM ? I need to calculate the index which is 1d80 
> (0x3d80 - 0x2000)

What binding are you talking about?  There is no published binding for
this yet.

As for what the driver should do, it should do an of_iomap(), but what
it does with the resulting memory depends on the compatible.  For
fsl,cpm1-spi, the result would be the parameter RAM for the device.  For
fsl,cpm1-spi-reloc and fsl,cpm2-spi, it would be the relocation
register.  The driver would either read the contents of the register, or
write a different offset.

My understanding is that the relocation register would only be zero on
the chips where we'd use fsl,cpm1-spi, not fsl,cpm1-spi-reloc.

-Scott

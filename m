Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 546EDB7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 00:08:19 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 7E5A0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 00:08:18 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ma8hr-0001nf-4T
	for linuxppc-dev@ozlabs.org; Sun, 09 Aug 2009 13:45:03 +0000
Received: from p5dd16c09.dip.t-dialin.net ([93.209.108.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Aug 2009 13:45:03 +0000
Received: from lorenz.kolb.newsgroups.nospam by p5dd16c09.dip.t-dialin.net
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Aug 2009 13:45:03 +0000
To: linuxppc-dev@ozlabs.org
From: Lorenz Kolb <lorenz.kolb.newsgroups.nospam@lkmail.de>
Subject: Re: need help getting SPI controller working on 405EX
Date: Sun, 09 Aug 2009 15:38:08 +0200
Message-ID: <h5mjg0$rqs$1@ger.gmane.org>
References: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan French wrote:
> Hi, I am trying to add support for the 405EX's SPI controller on a Kilauea board.  I've added the below to the device tree (under plb/opb/):
> 
> [nfrench@nfrench-laptop linux-2.6-denx]$ diff -C2 arch/powerpc/boot/dts/kilauea.dts spi.dts
> *** arch/powerpc/boot/dts/kilauea.dts	2009-05-05 15:56:16.000000000 -0700
> --- spi.dts	2009-08-06 08:42:19.000000000 -0700
> ***************
> *** 207,210 ****
> --- 207,221 ----
>   				#size-cells = <0>;
>   			};
> +             
> +             SPI0: spi@ef600600 {
> +                 cell-index = <0>;
> +                 compatible = "ibm,spi-405ex", "ibm,spi";
> +                 reg = <ef600600 6>;
> +                 interrupts = <8 4>;
> +                 interrupt-parent = <&UIC0>;
> +                 mode = "cpu";
> +             };
>   
>   			RGMII0: emac-rgmii@ef600b00 {
> 

That entry within the device tree will generally make the spi-"bus" 
known to Linux, that's ok so far.

> I've also compiled my kernel with the following enabled:
> 
>         CONFIG_SPI=y
>         CONFIG_SPI_MASTER=y
>         CONFIG_SPI_SPIDEV=y
> 
> I see this make it into the device tree after boot:
> 
>         [root@10.2.3.28 /]$ find /proc/device-tree/ | grep spi
>         /proc/device-tree/plb/opb/spi@ef600600
>         /proc/device-tree/plb/opb/spi@ef600600/name
>         /proc/device-tree/plb/opb/spi@ef600600/mode
>         /proc/device-tree/plb/opb/spi@ef600600/interrupt-parent
>         /proc/device-tree/plb/opb/spi@ef600600/interrupts
>         /proc/device-tree/plb/opb/spi@ef600600/reg
>         /proc/device-tree/plb/opb/spi@ef600600/compatible
>         /proc/device-tree/plb/opb/spi@ef600600/cell-index
> 
> But I don't see any /dev/spidev* devices created or any mention of SPI
> at boot time.  I'm starting to suspect that I don't have the kernel
> configured right, otherwise I would see at least the SPI driver
> complaining about something, right?

For getting spidev devices you have to add entries for an spidev device 
to your newly created spi-"bus". So what you are currently missing are 
the spidev child-nodes in the device tree.
As I'm currently cut off from some device to test, no guaranty that it 
will work, but your dts entry should look something like:

              SPI0: spi@ef600600 {
                  cell-index = <0>;
                  compatible = "ibm,spi-405ex", "ibm,spi";
                  reg = <ef600600 6>;
                  interrupts = <8 4>;
                  interrupt-parent = <&UIC0>;
                  mode = "cpu";

                  yourdevice@0 {
                      compatible = "spidev";
                      spi-max-frequency = <1000000>; /* what ever your 
max-freq. is */
                      reg = <0>; /* Chipselect-address */
                  };
              };

> 
> Thanks,
> 
> Nathan French

At least something similar worked for me some months ago (before we 
switched to a "real" driver for some custom peripheral).

Regards,

Lorenz

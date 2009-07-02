Return-Path: <joakim.tjernlund@transmode.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DC9D7B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 16:18:58 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D03BDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 16:18:56 +1000 (EST)
In-Reply-To: <20090701211212.GA26231@oksana.dev.rtsoft.ru>
References: <1246475772-10645-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20090701211212.GA26231@oksana.dev.rtsoft.ru>
Subject: Re: [PATCH] [spi_mpc83xx] Always enable legacy support.
To: avorontsov@ru.mvista.com
Message-ID: <OFCF8CC091.F2420839-ONC12575E7.00216E4F-C12575E7.0022AF37@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 2 Jul 2009 08:18:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 01/07/2009 23:12:12:
>
> On Wed, Jul 01, 2009 at 09:16:12PM +0200, Joakim Tjernlund wrote:
> > There are out of tree boards that need this legacy support too.
>
> Heh.
>
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> > I hope this is OK. I just discovered that spi didn't work for
> > me in 2.6.30 and I have no time to work on coverting my boards.
>
> I'd convert them for you if they were in-tree. :-) But I don't
> think that moving the kernel backwards because of out-of-tree
> boards is a good thing.

:), but allowing out-of-tree boards one or two kernel releases to catch up
with a legacy printout would have been nice.

>
> > I don't have a clue either on how to do that, any pointers
> > how to add a few spidev devices via OF?
>
> Something like this will work:
>
>       spi@4c0 {
>          #address-cells = <1>;
>          #size-cells = <0>;
>          cell-index = <0>;
>          compatible = "fsl,spi";
>          reg = <0x4c0 0x40>;
>          interrupts = <2>;
>          interrupt-parent = <&qeic>;
>          /* provide chip-selects here */
>          gpios = <&qe_pio_d 13 0   /* CS0 */
>              &qe_pio_d 14 0>; /* CS1 */
>          mode = "cpu-qe";
>
>          device@0 {
>             compatible = "spidev";
>             reg = <0>; /* CS0*/
>             spi-max-frequency = <50000000>;
>          };
>
>          device@0 {
>             compatible = "spidev";
>             reg = <1>; /* CS1 */
>             spi-max-frequency = <50000000>;
>          };
>       };
>
> You can look at arch/powerpc/boot/dts/mpc832x_rdb.dts as an
> example.
>
> Note that "spidev" isn't correct compatible entry to use,
> but it's quick and dirty solution. A proper solution is to
> add a proper compatible entry into the device-tree, and
> add "spidev" alias into drivers/of/base.c:of_modalias_table.

Thanks

  Jocke

Return-Path: <joakim.tjernlund@transmode.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BD0E3B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 00:59:19 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B4EDDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 00:59:19 +1000 (EST)
In-Reply-To: <20090804142250.GA17398@oksana.dev.rtsoft.ru>
References: <20090713222005.GA19859@oksana.dev.rtsoft.ru>
	<20090713151911.GA28114@oksana.dev.rtsoft.ru>
	<OFF188389D.68E638A2-ONC12575F2.00568C5B-C12575F2.0057FC95@transmode.se>
	<20090713173455.GA9866@oksana.dev.rtsoft.ru>
	<OF9378E65D.FBBCCFD5-ONC12575F2.006B28D5-C12575F2.006DDAE5@transmode.se>
	<OF613F53BF.1FD77EDB-ONC12575F3.00753535-C12575F3.00753537@transmode.se>
	<20090714220931.GA11378@oksana.dev.rtsoft.ru>
	<OF9A2BDEDE.DC0DE0D4-ONC1257608.004A7A59-C1257608.004AF3BF@transmode.se>
	<20090804142250.GA17398@oksana.dev.rtsoft.ru>
Subject: Re: Ang: Re: [PATCH 0/2] Setting GPIOs simultaneously
To: avorontsov@ru.mvista.com
Message-ID: <OFC7025845.8BE60C98-ONC1257608.0051D318-C1257608.00525388@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 4 Aug 2009 16:59:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 04/08/2009 16:22:50:
>
> On Tue, Aug 04, 2009 at 03:38:40PM +0200, Joakim Tjernlund wrote:
> > Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 15/07/2009 00:09:31:
> > >
> > > On Tue, Jul 14, 2009 at 11:20:13PM +0200, Joakim Tjernlund wrote:
> > > [...]
> > > > >But any users of the legacy bindings should be in-tree.
> > > >
> > > > ehh, it was working until you made it OF only. Why do call the native
> > > > way legacy?  It is the method all non OF arch uses.
> > >
> > > It's legacy because there are no in-tree users anymore. Nowadays
> > > we're trying to pass all needed information via OF, and we're
> > > trying to avoid ugly platform-dependant hacks. Your SPI scheme
> > > can be easily described via OF, but sure, it's hard to implement
> > > it with the current SPI/OF subsystem.
> >
> > Sorry for the long delay, I have been on vaction and been busy with other stuff.
> >
> > Tell me, how does this new OF SPI device scheme work out if you want
> > to use the bitbanged SPI driver?
>
> spi-controller {
>    ...
>    compatible = "generic-bitbang-spi";
>    gpios = <GPIO_CLK GPIO_MOSI GPIO_MISO>;
>    spi,chip-select-machines = <&gpio_csm &board_csm>;
>
>    gpio_csm: chip-select-machine {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       compatible = "generic-gpio-csm";
>       gpios = <GPIO_CS1 GPIO_CS2>;
>
>       touchscreen@0 {
>          reg = <0>; /* using GPIO CS1 */
>       };
>
>       eeprom@1 {
>          reg = <1>; /* using GPIO CS2 */
>       };
>    };
> };
>
> localbus {
>    ...
>    board_csm: chip-select-machine {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       compatibe = "board-specific-csm";
>
>       light-sensor@0 {
>          reg = <0>; /* using board-specific "CS3" */
>       };
>
>       battery@1 {
>          reg = <1>; /* using board-specific "CS4" */
>       };
>    };
> };

hmm, this looks promising. Can I write my own board-specific-csm
and attach it to the SPI CS engine? I don't quite
se how, the 8xxx SPI driver only looks for gpio functions.
Perhaps this is something that you are working on?

       Jocke

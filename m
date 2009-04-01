Return-Path: <avorontsov@ru.mvista.com>
Date: Wed, 1 Apr 2009 16:30:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Subject: Re: [PATCH 6/8] --- arch/powerpc/boot/dts/socrates.dts | 9
	+++++++-- 1 file changed, 7 insertions(+), 2 deletions(-)
Message-ID: <20090401123029.GA31909@oksana.dev.rtsoft.ru>
References: <20090331123727.853787299@denx.de>
	<20090331124036.057237866@denx.de>
	<20090331230451.GA23304@yookeroo.seuss>
	<49D31856.9060808@grandegger.com>
	<20090401110955.GA7507@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090401110955.GA7507@yookeroo.seuss>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 10:09:55PM +1100, David Gibson wrote:
> On Wed, Apr 01, 2009 at 09:31:34AM +0200, Wolfgang Grandegger wrote:
> > Hi David,
> > 
> > this patch went out by mistake, sorry.
> > 
> > David Gibson wrote:
> > > On Tue, Mar 31, 2009 at 02:37:33PM +0200, Wolfgang Grandegger wrote:
> > >> Index: linux-2.6/arch/powerpc/boot/dts/socrates.dts
> > >> ===================================================================
> > >> --- linux-2.6.orig/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:24:38.078719288 +0200
> > >> +++ linux-2.6/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:47:56.986720719 +0200
> > >> @@ -52,6 +52,7 @@
> > >>  	soc8544@e0000000 {
> > >>  		#address-cells = <1>;
> > >>  		#size-cells = <1>;
> > >> +		device_type = "soc";
> > > 
> > > You should not be adding device_type to a new board's dts.  You
> > > *especially* shouldn't be doing that with no patch comment explaining
> > > why.
> > 
> > In the final patch I have removed the device_type = "soc", but it makes
> > trouble as some mpc85xx rely on it.
> 
> Um.. what?  Some mpc85xx?  This is the dts for *one specific board*, I
> don't see how something that affects "some mpc85xx" is relevant.

Not some, but *all* mpc85xx. The thing is that U-Boot is searching
for device_type = "soc" to fixup some properties (for example,
bus-frequency) for all mpc85xx parts, so you can't easily remove
the device_type w/o breaking boot for firmwares that customers have
pre-programmed in their products.

Note that upgrading firmware without JTAG is dangerous, so it's not
an option to "force" everybody to upgrade their firmware just
because we want to remove some cruft from the device tree.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

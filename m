Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 24 Oct 2008 21:01:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024170128.GA20577@oksana.dev.rtsoft.ru>
References: <4900ED81.3040202@genesi-usa.com>
	<20081024164120.GA14350@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081024164120.GA14350@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 08:41:20PM +0400, Anton Vorontsov wrote:
[...]
> > So, how do we define in a bank of GPIOs, which ones are free for use, 
> > without them being attached to a device and given as a "gpios" property?
> >
> > Would we suggest a node;
> >
> > gpio-header {
> > 	compatible = "bplan,efika-gpio";
> > 	gpios = <&gpio-standard 16 0 17 0>;
> > };
> >
> > gpio-header2 {
> > 	compatible = "bplan,efika-gpio-wkup";
> > 	gpios = <&gpio-wkup 18 0>;
> > };
>
> IMO this looks very reasonable. You properly describe the hardware:
> physical device (header) and its resources.

If there are actually two headers, that is. If you use two nodes
just to specify which gpio is wkup, that is's a bit ugly... Why not

gpio-header {
	compatible = "bplan,<board>-gpio-header";
	gpios = <&standard 16 0
		 &standard 17 0
		 &wakeup 18 0>;
}

And the driver whould know that on this particular <board>
third gpio is the wakeup one?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

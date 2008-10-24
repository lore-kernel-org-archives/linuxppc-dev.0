Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 24 Oct 2008 20:41:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024164120.GA14350@oksana.dev.rtsoft.ru>
References: <4900ED81.3040202@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <4900ED81.3040202@genesi-usa.com>
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

On Thu, Oct 23, 2008 at 04:32:49PM -0500, Matt Sealey wrote:
> Hi guys,
>
> I'm a little perplexed as to how I would define a GPIO controller in a 
> device tree but mark off pins as available or not, so users can geek 
> around in their own drivers without defining in a device tree exactly 
> what they intend to use it for (especially if it's something really 
> weird).
>
> Easiest example - the Efika runs an MPC5200B has 3 GPIO pins on the 
> board. It's not much, but they're there for use. All the other GPIOs are 
> absolutely out of bounds, off limits and probably dangerous to touch, but 
> since each GPIO block has a 32-bit register to handle them, you can 
> twiddle any bit you like with impunity and cause all the damage you want. 
> A simple thought comes to mind in that the gpiolib should not allow a  
> request for one of these "bad" GPIO pins to succeed.

Well, the same applies to the IRQ controllers. I bet you can request a
reserved IRQ on some particular board/CPU, but results would be
unpredictable (the driver would touch reserved bits etc). The device
tree should be sane for this particular platform and not specify bogus
gpios/irqs/regs/sizes/etc.

> So, how do we define in a bank of GPIOs, which ones are free for use, 
> without them being attached to a device and given as a "gpios" property?
>
> Would we suggest a node;
>
> gpio-header {
> 	compatible = "bplan,efika-gpio";
> 	gpios = <&gpio-standard 16 0 17 0>;
> };
>
> gpio-header2 {
> 	compatible = "bplan,efika-gpio-wkup";
> 	gpios = <&gpio-wkup 18 0>;
> };

IMO this looks very reasonable. You properly describe the hardware:
physical device (header) and its resources.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

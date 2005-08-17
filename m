Return-Path: <trini@kernel.crashing.org>
Date: Wed, 17 Aug 2005 08:05:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20050817150536.GN8214@smtp.west.cox.net>
References: <1124209292.3869.5.camel@localhost.localdomain>
	<11F30454-6808-44A3-8F5B-F36ED0028EF4@freescale.com>
	<1124263872.3869.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124263872.3869.48.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Use platform device for 8250 registration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 08:31:11AM +0100, David Woodhouse wrote:
> On Wed, 2005-08-17 at 01:30 -0500, Kumar Gala wrote:
> > > We could probably remove all the rest of the crap from asm/serial.h and
> > > let platforms register their own serial8250 platform devices...
> 
> > Hmm, I wondering if we can provide some standard way of handling this  
> > for the embedded platforms as well.  It would be nice to drop the old  
> > style of initialization completely and move to using a platform  
> > device always.
> 
> Yes, that's precisely what I meant. Just remove it from the list in
> serial.h and as Ben says, instantiating a platform device is easy.
> 
> static struct plat_serial8250_port my_serial_ports[] = {
> 	{
> 		.uartclk = 115200*16,
> 		.iobase = 0x2f8,
> 		.irq = 3,
> 		.flags = ASYNC_BOOT_AUTOCONF;
> 	},
> };

So long as you convert arch/ppc/boot/ to this as well, why not (or at
least being able to grab the infos from these structs somehow).

Once everyone is on a flat tree, I don't object to killing all of the
old-style uart definitions steaming out of <asm-ppc/serial.h>.

-- 
Tom Rini
http://gate.crashing.org/~trini/

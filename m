Return-Path: <david-b@pacbell.net>
Received: from smtp113.sbc.mail.mud.yahoo.com (smtp113.sbc.mail.mud.yahoo.com
	[68.142.198.212]) by ozlabs.org (Postfix) with SMTP id 02782DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 02:19:19 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Sylvain Munaut <tnt@246tnt.com>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
Date: Wed, 16 May 2007 09:11:55 -0700
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
In-Reply-To: <464ABE97.7090603@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705160911.55867.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
	Dragos Carp <dragos.carp@toptica.com>,
	Domen Puncer <domen@coderock.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 16 May 2007, Sylvain Munaut wrote:
> 
> Well, this comment is not about the patch but about the driver it self,
> I didn't see it before today.

It merged earlier in the 2.6.22 cycle.  If you don't have criticisms
about the patch itself, I'll forward it for merging after I get at
least an ack from Dragos.


> So here's a few things I see from a quick glance at the code :
> 
>  - Chaning port_config in the driver is just wrong ... you should _not_
> do that. That should have been setup by the bootloader or at worse in
> the platform setup code.

And that's where the worst of the magic numerology lives too.
If that's pinmux style setup, agreed -- it doesn't belong there.

As a rule, I tell folk that Linux shouldn't rely on the boot
loader to have done much more than get Linux loaded.  The way
board development works, bootloaders usually freeze well before
all the setup nuances Linux cares about have been resolved.


>  - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
> resource of the platform_device. This macro is just there for early
> console stuff.

That PPC_MERGE stuff does look messy.


>  - You do read/write/modify operation on CDM shared register
> (clk_enables) from a driver, you should have added something in common
> 52xx code to do theses with proper locking.
>  - You can get f_system from the device tree instead of just assuming
> it's 512 MHz. It probably need to be done the same way it's done to find
> ipb_freq.
>  - Would have been nice to be able to somehow configure MCLK rather than
> #define it

Best to use <linux/clk.h> for all of those, but it seems powerpc/ppc
don't support those interfaces yet ... is there maybe a plan for
resolving that issue?


>  - I hope to remove all arch/ppc stuff by 2.6.23 if I can make the
> cuimage stuff work in arch/powerpc so just including the platform code
> stuff for 1 kernel version ...

This originally started out as ppc then moved to powerpc ... agreed,
it would be nicer to need only one kind of bus glue.

- Dave

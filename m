Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 88CF1B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 08:33:16 +1000 (EST)
Date: Tue, 5 Apr 2011 00:26:37 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Pegasos i8042 broken again
Message-ID: <20110404222637.GA4633@iram.es>
References: <20101010013755.1697.qmail@kosh.dhis.org>
	<1286696147.2463.499.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286696147.2463.499.camel@pasglop>
Cc: pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 10, 2010 at 06:35:47PM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2010-10-09 at 20:37 -0500, pacman@kosh.dhis.org wrote:
> > Pegasos has no keyboard again. I blame commit
> > 540c6c392f01887dcc96bef0a41e63e6c1334f01, which tries to find i8042 IRQs in
> > the device-tree but doesn't fall back to the old hardcoded 1 and 12 in all
> > failure cases.
> > 
> > Specifically, the case where the device-tree contains nothing matching
> > pnpPNP,303 or pnpPNP,f03 doesn't seem to be handled well. It sort of falls
> > through to the old code, but leaves the IRQs set to 0.
> > 
> > The last time something like this happened, I submitted a patch:
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2007-July/039988.html
> > which got committed, but afterward I was scolded for working around a bug
> > instead of fixing it in nvramrc.
> > 
> > This time I just won't send my workaround patch, at least until it's decided
> > that the kernel should be made to understand the device-tree as is.
> > 
> > If it's decided instead that the firmware should be patched... well I just
> > don't feel comfortable inventing my own patch for nvramrc, since it's written
> > in a language I don't know and presumably could brick the machine if I get it
> > wrong. Also I'm not even sure what the kernel is expecting to find there. 
> 
> Those things really suck. They absolutely refuse to fix their FW for
> reasons I never quite managed to figure out.
> 
> At this stage, I'd say the best is to add yet another pegasos workaround
> in prom_init that adds the missing compatible property.

Ok, I got fed up about it. The patch referred above is obviously wrong since
it leaves interrupts at 0 when a device_type or name of 8042 is found,
so what about the following? 

I can ship it with a signed-off-by and proper comments a bit later if people agree.

Compiled and tested, otherwise I couldn't even type this message :-)

	Regards,
	Gabriel

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9d4882a..06865ac 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -599,6 +599,10 @@ int check_legacy_ioport(unsigned long base_port)
 		 * name instead */
 		if (!np)
 			np = of_find_node_by_name(NULL, "8042");
+		if (np) {
+			of_i8042_kbd_irq = 1;
+			of_i8042_aux_irq = 12;
+		}
 		break;
 	case FDC_BASE: /* FDC1 */
 		np = of_find_node_by_type(NULL, "fdc");

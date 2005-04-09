Return-Path: <leigh@solinno.co.uk>
Received: from queue02-winn.mailhost.ntl.com (mailhost.ntl.com [212.250.162.8])
	by ozlabs.org (Postfix) with ESMTP id 693AF67A2E
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 02:24:51 +1000 (EST)
To: "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
From: "Leigh Brown" <leigh@solinno.co.uk>
In-Reply-To: <20050408145431.GY3396@smtp.west.cox.net>
	<20050408155717.GB3396@smtp.west.cox.net>
References: <20050408155717.GB3396@smtp.west.cox.net>
	<20050408145431.GY3396@smtp.west.cox.net>
	<20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
	<42533FA1.1070001@gmx.net>
	<20050406185049.GF3396@smtp.west.cox.net>
	<33467.82.10.231.190.1112960162.squirrel@82.10.231.190>
Message-Id: <20050409113317.25ECF157F18@jar.solinno.co.uk>
Date: Sat,  9 Apr 2005 12:33:17 +0100 (BST)
Cc: linuxppc-dev@ozlabs.org, Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH 2.6.11+] ppc32: Make the Powerstack II Pro4000 boot again
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 8 Apr 2005 07:54:31 -0700 Tom Rini wrote:
> On Fri, Apr 08, 2005 at 12:36:02PM +0100, Leigh Brown wrote:
> > Tom Rini said:
> > > On Wed, Apr 06, 2005 at 03:47:13AM +0200, Christian wrote:
> > >> Tom Rini wrote:
> > >> > Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
> > >> > command-line works?  Thanks.
> > >>
> > >> i booted vanilla 2.6.11.6 with noresidual (and "nopresidual" too, as
> > >> Sven sugggested), but the scsi errors did not went away :(
> > >>
> > >> on a side note, and perhaps totally unrelated: i always have
> > >> PROC_PREPRESIDUAL=y in my .config, but i never had /proc/residual as
> > >> promised from the help text.
> > >
> > > Odd.  I thought that only happened if you had no residual data at all
> > > (which can happen on Powerstacks, esp if netbooting the kernel).  But
> > > in that case the new code shouldn't be hit at all.  Leigh?
> > 
> > Hi, I'm back from my holidays, and have had a look at this.  As I spent
> > lots of time understanding the horrendous mess that was
> > prep_pcibios_fixup(), I'd be loath to back out the changes I made
> > (especially as they work so well for me ;-) ).
> > 
> > It turns out that prep_pib_init() is the culprit.  Although it would
> > appear to be coded for the non-openpic case, it obviously doesn't work.
> > The old version of prep_pcibios_fixup() only called it if there is an
> > openpic on the machine.  We can restore that behaviour with the
> > following patch:
> > 
> > --- prep_pci.c.orig	2005-04-08 11:49:25.743718088 +0000
> > +++ prep_pci.c	2005-04-08 12:23:00.541422280 +0000
> > @@ -1245,8 +1245,13 @@
> >  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> >  	}
> > 
> > -	/* Setup the Winbond or Via PIB */
> > -	prep_pib_init();
> > +	/* Setup the Winbond or Via PIB - prep_pib_init() is coded for
> > +	 * the non-openpic case, but it breaks (at least) the Utah
> > +	 * (Powerstack II Pro4000), so only call it if we have an
> > +	 * openpic.
> > +	 */
> > +	if (have_openpic)
> > +		prep_pib_init();
> >  }
> > 
> >  static void __init
> > 
> > I've no idea even what machines would be affected by this, but it
> > fixes Sven's problem and restores the old behaviour, so that
> > can't be bad.
> > 
> > I guess fixing prep_pib_init() would be the better solution but
> > I wouldn't know where to start.  If this band-aid is good enough
> > I can submit a proper patch, if you like.
> 
> If this works, I'd like to see this get into 2.6.12.  Please re-send to
> akpm / this list.  Assuming it's just the above:
> Acked-by: Tom Rini <trini@kernel.crashing.org>

On Fri, 8 Apr 2005 08:57:17 -0700, Tom Rini wrote:
> On Fri, Apr 08, 2005 at 05:51:40PM +0200, Christian wrote:
> > Tom Rini wrote:
> > > 
> > > If this works, I'd like to see this get into 2.6.12.  Please re-send to
> > > akpm / this list.  Assuming it's just the above:
> > > Acked-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > yes! i just applied Leigh's patch (thanks!) to a pristine 2.6.11.6 and my
> > PReP here booted fine:
> >   http://www.nerdbynature.de/bits/hal/2.6.11.6/leigh/
> 
> Great.  Leigh, can you also submit to gregkh for 2.6.11.7?  Thanks.

This patch restores the original behaviour of prep_pcibios_fixup() to
only call prep_pib_init() on machines with an openpic.  This allows
the Powerstack II Pro4000 to boot again.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>

--- linux-2.6/arch/ppc/platforms/prep_pci.c.orig	2005-04-08 16:55:53.336800298 +0200
+++ linux-2.6/arch/ppc/platforms/prep_pci.c	2005-04-08 16:56:01.818070165 +0200
@@ -1245,8 +1245,13 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
-	/* Setup the Winbond or Via PIB */
-	prep_pib_init();
+	/* Setup the Winbond or Via PIB - prep_pib_init() is coded for
+	 * the non-openpic case, but it breaks (at least) the Utah
+	 * (Powerstack II Pro4000), so only call it if we have an
+	 * openpic.
+	 */
+	if (have_openpic)
+		prep_pib_init();
 }
 
 static void __init

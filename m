Date: Sun, 15 Feb 2004 12:30:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc64: Add the Kconfig & Makefile changes related to the PowerMac
 G5 merge
In-Reply-To: <1076843399.6958.52.camel@gaston>
Message-ID: <Pine.GSO.4.58.0402151230050.22078@waterleaf.sonytel.be>
References: <200402120609.i1C69SwG020565@hera.kernel.org>
 <Pine.GSO.4.58.0402151201470.22078@waterleaf.sonytel.be> <1076843399.6958.52.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 15 Feb 2004, Benjamin Herrenschmidt wrote:
> On Sun, 2004-02-15 at 22:04, Geert Uytterhoeven wrote:
> > On Thu, 12 Feb 2004, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1622.2.3, 2004/02/12 14:53:14+11:00, benh@kernel.crashing.org
> > >
> > > 	ppc64: Add the Kconfig & Makefile changes related to the PowerMac G5 merge
> > >
> > > @@ -93,7 +93,7 @@
> > >
> > >  config ADB_MACIO
> > >  	bool "Include MacIO (CHRP) ADB driver"
> > > -	depends on ADB && !POWER4
> > > +	depends on ADB && PPC_PMAC && !PPC_PMAC64
> >                           ^^^^^^^^
> > Is that correct? Shouldn't that be PPC_CHRP?
>
> Hrm... right, feel free to provide a patch, I'm too tired right now :)

--- linux-2.6.3-rc3/drivers/macintosh/Kconfig.orig	2004-02-15 11:10:28.000000000 +0100
+++ linux-2.6.3-rc3/drivers/macintosh/Kconfig	2004-02-15 12:29:23.000000000 +0100
@@ -93,7 +93,7 @@

 config ADB_MACIO
 	bool "Include MacIO (CHRP) ADB driver"
-	depends on ADB && PPC_PMAC && !PPC_PMAC64
+	depends on ADB && PPC_CHRP && !PPC_PMAC64
 	help
 	  Say Y here to include direct support for the ADB controller in the
 	  Hydra chip used on PowerPC Macintoshes of the CHRP type.  (The Hydra

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

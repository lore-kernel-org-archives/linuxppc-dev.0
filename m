Date: Sat, 11 Aug 2001 11:52:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA console endian bug
In-Reply-To: <20010811110554.E13486@suse.de>
Message-ID: <Pine.LNX.4.05.10108111145260.8907-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Aug 2001, Olaf Hering wrote:
> On Sat, Aug 11, Olaf Hering wrote:
> > On Sat, Aug 11, Geert Uytterhoeven wrote:
> > > Note that I've been having a fight with Olaf Hering about this as well :-)
> >
> > And the battle goes on :)
> >
> > It really fixes my VGA problems so far, but I guess the bug is somewhere
> > else.
> > We use a patch to display the kernel version above the framebuffer logo.
> > It works on intel and on sparc, but it gives the usual garbage for the
> > version chars on ppc.
> >
> > It uses the fbcon_putcs() function. I will see how it works without that
> > vga patch.
>
> sigh,
>
> I removed the vga patch and the version string appears still as garbage.
> We have the clgen driver in the kernel and it prints its messages also
> as garbage, this was always the case, also in 2.2. That does not happen
> with the vga patch.
>
> The bootlogo-version patch can be found here:
> /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/patches/50_bootlogo-ver-2.4.5.gz

+       /* G.S.: Display a line above the Boot Logo to state what
+       * version of the kernel we are booting.
+       */
+       char welcometext[] = "Linux " UTS_RELEASE;
+       unsigned short welcomestring[ sizeof(welcometext) ];
+       int i;
+       for(i = 0; i < sizeof(welcometext); i++)
+           welcomestring[i] = 0x0700 | welcometext[i];
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+       fbcon_putcs( conp, welcomestring, sizeof(welcometext), 0, 0 );

That's not correct, you _must_ use scr_{read,write}w() to access screen
buffers. fbcon_putcs() expects a pointer to a shadow screen buffer.

Please try

    scr_writew(0x0700 | welcometext[i], &welcomestring[i]);

instead.

Your code works on ia32 because ia32 and VGA are both little endian.
It works on SPARC because SPARC and fbdev on SPARC are both big endian.
I guess it fails on a real VGA textconsole on SPARC too (iff SPARC would
support VGA text mode).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 28 Nov 2001 10:14:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
	ajoshi@unixbox.com, lethal@chaoticdreams.org, dan@debian.org,
	Martin Costabel <costabel@wanadoo.fr>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
In-Reply-To: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0111281012090.15842-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Nov 2001, Tom Rini wrote:
> Hello all.  The following patches make slight changes to the vmode/cmode
> logic on a few fb drivers.  Now everone consistantly only tries to get
> these modes from nvram if CONFIG_NVRAM is defined (otherwise a
> compile-time error on everyone but atyfb).  On imsttfb I made the logic
> only executed on CONFIG_ALL_PPC, and removed USE_NV_MODES (which
> shouldn't be needed now).  However, I have none of this hardware, and I
> remember some of these drivers being very touchy.  So could people with
> this hardware apply the patch and let me know if it works still?

I _think_ the right solution is to hide the NVRAM vmode/cmode stuff in
macmodes.c, so all drivers will automagically use it for the default video
mode.

The same with MAC monitor sense information, just pass it to mac_find_mode().

So mac_find_mode() should do this:

  - if default mode specified, try that
  - if MAC monitor sense specified, try that
  - if NVRAM, try that
  - fall back to default mode database walking

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 11 Aug 2001 12:14:36 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA console endian bug
Message-ID: <20010811121436.A704@suse.de>
References: <20010811110554.E13486@suse.de> <Pine.LNX.4.05.10108111145260.8907-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10108111145260.8907-100000@callisto.of.borg>; from geert@linux-m68k.org on Sat, Aug 11, 2001 at 11:52:09AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 11, Geert Uytterhoeven wrote:

> +       for(i = 0; i < sizeof(welcometext); i++)
> +           welcomestring[i] = 0x0700 | welcometext[i];
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +       fbcon_putcs( conp, welcomestring, sizeof(welcometext), 0, 0 );
>
> That's not correct, you _must_ use scr_{read,write}w() to access screen
> buffers. fbcon_putcs() expects a pointer to a shadow screen buffer.
>
> Please try
>
>     scr_writew(0x0700 | welcometext[i], &welcomestring[i]);
>
> instead.
>
> Your code works on ia32 because ia32 and VGA are both little endian.
> It works on SPARC because SPARC and fbdev on SPARC are both big endian.
> I guess it fails on a real VGA textconsole on SPARC too (iff SPARC would
> support VGA text mode).

Well, that fixes "the last known problem".

But it still leaves the question whats really wrong with the vga console :)


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

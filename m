Date: Fri, 29 Oct 1999 10:48:36 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Cort Dougan <cort@ppc.kernel.org>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Jeff Garzik <jgarzik@pobox.com>, Martin Mares <mj@ucw.cz>
Subject: Re: PPC scr_{read,write}w() cleanup (fwd)
In-Reply-To: <19991029015806.A14709@chimaera.ppc.kernel.org>
Message-ID: <Pine.GSO.4.10.9910291047500.13603-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Oct 1999, Cort Dougan wrote:
> Maybe I'm confused.  If so, point out where I'm wrong here:
> 
> We build in VGA_CONSOLE and FB for a common build.  We end up getting the
> wrong scr_read/write if we end up using the wrong one (through
> vt_buffer.h).
> 
> Will vt_buffer.h "do the right thing" in this case?

I think so: vt_buffer.h includes asm/vga.h first if CONFIG_VGA_CONSOLE or
CONFIG_MDA_CONSOLE are set.

> } What's the problem there? If vgacon is enabled, scr_write() will be writew(),
> } i.e. little endian. But since scr_readw() == readw() is little endian as well,
> } it'll work fine.
> } 
> } Or am I missing something?
> } 
> } > I'm willing to switch PReP to fb entirely if it's reasonable that it will
> } > work on all PReP boxes.  Any suggestions?
> } 
> } I don't think it will work on all PReP boxes yet. There's no frame buffer
> } device for S3 [89]6[48] yet :-(
> } 
> } > } Does this work on your boxes? I really like to have this fixed.
> } > } 
> } > } Finally I found some time to sort out the PPC scr_{read,write}w() mess.
> } > } Now scr_{read,write}w() always swaps bytes if {vga,mda}con was compiled in,
> } > } while we did a runtime check before.
> } > } 
> } > } This patch matters specifically for people with PReP boxes, who may want to use
> } > } vgacon on one head and a real frame buffer device on either a second head or on
> } > } the first head after boot up (insmod *fb.o takes over vgacon).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

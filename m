Date: Fri, 29 Oct 1999 01:58:06 -0600
From: Cort Dougan <cort@ppc.kernel.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Jeff Garzik <jgarzik@pobox.com>, Martin Mares <mj@ucw.cz>
Subject: Re: PPC scr_{read,write}w() cleanup (fwd)
Message-ID: <19991029015806.A14709@chimaera.ppc.kernel.org>
References: <19991028215345.A13930@chimaera.ppc.kernel.org> <Pine.GSO.4.10.9910290919560.13603-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.9910290919560.13603-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Fri, Oct 29, 1999 at 09:22:40AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Maybe I'm confused.  If so, point out where I'm wrong here:

We build in VGA_CONSOLE and FB for a common build.  We end up getting the
wrong scr_read/write if we end up using the wrong one (through
vt_buffer.h).

Will vt_buffer.h "do the right thing" in this case?

} What's the problem there? If vgacon is enabled, scr_write() will be writew(),
} i.e. little endian. But since scr_readw() == readw() is little endian as well,
} it'll work fine.
} 
} Or am I missing something?
} 
} > I'm willing to switch PReP to fb entirely if it's reasonable that it will
} > work on all PReP boxes.  Any suggestions?
} 
} I don't think it will work on all PReP boxes yet. There's no frame buffer
} device for S3 [89]6[48] yet :-(
} 
} > } Does this work on your boxes? I really like to have this fixed.
} > } 
} > } Finally I found some time to sort out the PPC scr_{read,write}w() mess.
} > } Now scr_{read,write}w() always swaps bytes if {vga,mda}con was compiled in,
} > } while we did a runtime check before.
} > } 
} > } This patch matters specifically for people with PReP boxes, who may want to use
} > } vgacon on one head and a real frame buffer device on either a second head or on
} > } the first head after boot up (insmod *fb.o takes over vgacon).
} 
}     [...]
} 
} Gr{oetje,eeting}s,
} 
} 						Geert
} 
} --
} Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
} Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
} Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 27 Jan 2000 15:12:22 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Ulrik De Bie <winmute@atlantique.venturi.net>
Subject: Re: vgacon, vga16fb, clgenfb on PPC
Message-ID: <20000127151222.W14218@hq.fsmlabs.com>
References: <Pine.LNX.4.05.10001272250560.428-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10001272250560.428-100000@callisto.of.borg>; from Geert Uytterhoeven on Thu, Jan 27, 2000 at 11:00:32PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I lost all my PReP boxes and can't test anymore.  Motorola has a bunch of
guys on staff doing linux/ppc development for their systems (PReP) now so
you may want to have them test.

For now feel free to push it to the bk tree here.

} 	Hi,
}
} Finally I was able to compile a recent kernel again (2.3.41 from
} bitkeeper/PPC)!
}
} I revised my patch to make vga16fb and clgenfb compile (as modules, in my
} case). I couldn't test clgenfb, but vga16fb works fine as my second head (S3
} Trio64V+ initialized by em86, first head on ATI Rage II+ handled by atyfb).
}
} Compared to my previous version from 2 months ago, I think I found the bug that
} caused the endianness problems with vgacon on PReP: defining
} scr_memcpyw_{from,to} to be equal to memcpy() was wrong, since in that case no
} byteswapping was done when accessing video memory.
}
} The idea behind this patch is to make scr_{write,read}w() use {write,read}w()
} when {vga,mda}con is compiled in (independent of CONFIG_FB), and to use native
} byte ordering when it isn't.
}
} This patch is especially interesting for people who want to
}
}   - have a second head handled by vga16fb
}   - use clgenfb
}   - have vgacon on one head and clgenfb on the second
}   - ...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 2 Oct 2000 22:57:15 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati driver with rage II/rage pro)
Message-ID: <20001002225715.B15425@suse.de>
References: <20001001224427.A18368@suse.de> <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home>; from geert@linux-m68k.org on Mon, Oct 02, 2000 at 04:59:18PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 02, Geert Uytterhoeven wrote:

> On Sun, 1 Oct 2000, Olaf Hering wrote:
> > while we are about to improve the atyfb, is it possible to fix the color
> > depth switching?
> > When I boot without a kernel arg I end up with 8 bit at console. I can't
> > increase the color depth afterwards with fbset, and mol crashes when it
> > tries to do that. When I specify atyfb:cmode:24 everythings works fine
> > and I can switch down to 8 and back to 24 and mol starts fine.
>
> Does it also crash when you increase the color depth with fbset?

I only have access to the wallstreet right now, and I can not increase
the depth here.
But it seems to work fine on a beige G3:

pineapple:~ # fbset

mode "1024x768-90"
    # D: 99.830 MHz, H: 76.090 kHz, V: 90.048 Hz
    geometry 1024 768 1024 768 8
    timings 10017 192 0 41 21 96 15
    rgba 8/0,8/0,8/0,0/0
endmode

pineapple:~ # fbset -depth 16
pineapple:~ # fbset -depth 15
pineapple:~ # cat /proc/cmdline
root=/dev/fd0 load_ramdisk=1 ramdisk_size=64000
pineapple:~ # lspci -n
00:00.0 Class 0600: 1057:0002 (rev 40)
00:0e.0 Class 0200: 1011:0019 (rev 41)
00:10.0 Class ff00: 106b:0010 (rev 01)
00:12.0 Class 0300: 1002:4754 (rev 9a)
pineapple:~ #


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

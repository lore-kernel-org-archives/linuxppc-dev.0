Subject: Re: Radeon problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030722212344.11c895f1.pochini@shiny.it>
References: <20030722212344.11c895f1.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1058909248.535.0.camel@gaston>
Mime-Version: 1.0
Date: 22 Jul 2003 23:27:29 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-07-22 at 23:23, Giuliano Pochini wrote:
> >> Problem #1: Radeonfb sets a video mode that isn't supported by my LCD
> >> monitor. I have to blindly type "/usr/sbin/fbset -a 1280x1024-60 -depth 16"
> >> at the root console every time (*if* it boots, because I make the box
> >> crash quite often :( ). Is there a boot option to set the right video mode ?
> >
> > Can you send me a dmesg dump (with the wrong video mode) and
> > a dump of /proc/device-tree/pci@f0000000 ?
>
> Yes, these are the relevant lines:
>
> ----
> Kernel command line: ro video=radeonfb:1024x768-8@75
> Console: colour dummy device 80x25
> radeonfb: ref_clk=2700, ref_div=12, xclk=24975 from OF
> Console: switching to colour frame buffer device 80x30
> radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
> radeonfb: DVI port no monitor connected
> radeonfb: CRT port CRT monitor connected
> ----
>
> Hmm, I just noticed that it believes I connected a CRT monitor. It's wrong,
> I have an non-Apple LCD display connected to the DVI port. 80x30 means the
> resolution is still 640x480.

Tried booting with video=radeon:dfp to force flat panel detection ?

> This a dir of /proc/device-tree/pci@f0000000, but I don't see how can it be
> useful. Is there a tool to extract more info ?

Just tarball that dir, it contains some useful stuffs, beleive me :)

> [Giu@Jay pci@f0000000]$ dir
> total 0
> dr-xr-xr-x    4 root     root            0 lug 22 21:09 .
> dr-xr-xr-x   21 root     root            0 lug 22 21:09 ..
> lrwxrwxrwx    1 root     root           20 lug 22 21:13 @10 -> ATY,PheonixParent@10
> -r--r--r--    1 root     root            4 lug 22 21:13 #address-cells
> lrwxrwxrwx    1 root     root           20 lug 22 21:13 ATY,PheonixParent -> ATY,PheonixParent@10
> dr-xr-xr-x    4 root     root            0 lug 22 21:13 ATY,PheonixParent@10
> lrwxrwxrwx    1 root     root           15 lug 22 21:13 @b -> uni-north-agp@b
> -r--r--r--    1 root     root           10 lug 22 21:13 built-in-names
> -r--r--r--    1 root     root            8 lug 22 21:13 bus-range
> -r--r--r--    1 root     root            4 lug 22 21:13 clock-frequency
> -r--r--r--    1 root     root           10 lug 22 21:13 compatible
> -r--r--r--    1 root     root            4 lug 22 21:13 device_type
> -r--r--r--    1 root     root            4 lug 22 21:13 #interrupt-cells
> -r--r--r--    1 root     root           28 lug 22 21:13 interrupt-map
> -r--r--r--    1 root     root           16 lug 22 21:13 interrupt-map-mask
> -r--r--r--    1 root     root            4 lug 22 21:13 interrupt-parent
> -r--r--r--    1 root     root            8 lug 22 21:13 interrupts
> -r--r--r--    1 root     root            4 lug 22 21:13 linux,phandle
> -r--r--r--    1 root     root           14 lug 22 21:13 model
> -r--r--r--    1 root     root            4 lug 22 21:13 name
> -r--r--r--    1 root     root           72 lug 22 21:13 ranges
> -r--r--r--    1 root     root            8 lug 22 21:13 reg
> -r--r--r--    1 root     root            4 lug 22 21:13 #size-cells
> -r--r--r--    1 root     root           11 lug 22 21:13 slot-names
> lrwxrwxrwx    1 root     root           15 lug 22 21:13 uni-north-agp -> uni-north-agp@b
> dr-xr-xr-x    2 root     root            0 lug 22 21:13 uni-north-agp@b
> -r--r--r--    1 root     root            0 lug 22 21:13 write-combining
>
>
> --
> Bye.
>    Giuliano.
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

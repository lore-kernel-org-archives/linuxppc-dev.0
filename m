Message-ID: <37318C55.FD33BC88@twinpeaks.prc.com>
Date: Thu, 06 May 1999 08:34:29 -0400
From: Mike Ladwig <mike@twinpeaks.prc.com>
Reply-To: mike@twinpeaks.prc.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        tmrini@ntplx.net
Subject: Re: atyfb and 8500+ATI RagePro
References: <Pine.LNX.4.10.9905031145560.3092-100000@mercator.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote:
> > Recently, I came across a post my Hugy Caley about a "hacked" atyfb
> > driver from Abe White.  I thought I'd give it a try.  Using the
> > parameter line, "video=atyfb:vmode:19,cmode:16", I actually get a
> > somewhat reasonable display

Since writing this, I have found the single key line to the Abe White
patch
that helps me.  I noticed that in the 104 version of atyfb that
RagePro LT stuff similar to the hack was added in, so I thought I'd
focus on
what wasn't added.

If I add an immediate 'return' to aty_set_pll_ct, my
system will boot with BootX parameter "video=atyfb:vmode:19,cmode:16". 
I believe
the atyfb driver is at least somewhat working here, because I can run
Xconfigurator and get an FB_Dev X server up, so long as I pick a display
mode close to
vmode:19,cmode:16.  X doesn't work outside of Xconfigurator, but I hope
that's
a different issue.

The relevent part of dmesg:

MacOS display is /bandit/ATY,XCLAIMVRPro
atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 12M SGRAM, 230 MHz PLL,
100 Mhz
MCLK
Console: switching to colour frame buffer device 160x60
fb0: ATY Mach64 frame buffer device on /bandit/ATY,XCLAIMVRPro
Monitor sense value = 0x73f, using video mode 6 and color mode 0.
fb1: control display adapter

[root@zuul mike]# /usr/sbin/fbset -i

mode "name"
    # D: 125.644 MHz, H: 74.788 kHz, V: 74.788 Hz
    geometry 1280 960 1280 4908 16
    timings 7959 224 32 36 1 144 3
endmode

Frame buffer device information:
    Name        : ATY Mach64
    Address     : 0x81800000
    Size        : 12578816
    Type        : PACKED PIXELS
    Visual      : DIRECTCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 2560
    MMIO Address: 0x817ff800
    MMIO Size   : 2048
    Accelerator : ATI Mach64GT

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-ID: <3735F419.EDA55028@loomer.com>
Date: Sun, 09 May 1999 13:46:21 -0700
From: Hugh Caley <hcaley@loomer.com>
Reply-To: hcaley@loomer.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, tmrini@ntplx.net,
        mike@twinpeaks.prc.com
Subject: Re: atyfb and 8500+ATI RagePro
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As an FYI, 29498928 does work with my PB G3 Series 300mhz; I can boot
with video=atyfb:vmode:14,cmode:32,mclk:83.

Sometimes, though, the console speed is really slow, but if I boot and
exit X, either Xpmac or XF68_FBDev, it becomes faster.  Also, I am
getting the little vertical snow band mentioned below when running X.

I'm using a 2.2.8 kernel I built from CVS source from openprojects
yesterday.

Hugh


"Timothy A. Seufert" wrote:
>
> At 4:48 PM +0200 5/6/99, Geert Uytterhoeven wrote:
> >Hence the problem lies within the programming of the pixel and memory
clocks.
>
> Could it be the same reference clock problem I was having?  (I need to
sit
> down and write some code to parameterize the reference clock.)
>
> Mike, could you try the following change to atyfb.c? (without any
other
> patches applied):
>
> Find where ref_clk_per is defined.  I don't have the source in front
of me
> at the moment, but it will look something like:
>
> unsigned long int ref_clk_per = 1000000000000UL/14318180;
>
> This line sets atyfb's notion of the frequency of the card's reference

> clock (from which all others are derived) to 14.318180 MHz.  Please
try
> changing 14318180 to 29498928 and 28636360 to get 29.499 and 28.636
MHz
> respectively.
>
> I discovered that my Rage Pro card has a 29.498928 MHz reference
clock, and
> had some of the same symptoms as you (can't boot unless mclk is set
low).
> Once I set the reference clock to 29.499 MHz atyfb started working a
lot
> better (though I do get some snow in a thin vertical band near the
left
> side of the screen whenever video memory is being written).

I received similar advice from Geert yesterday.  Indeed it helps with my

problem,
as I too have a card with a reference clock at 29.498 Mhz.  I also get
the same small
amount of snow down the penguin centerline during video activity.

Since the initial success, I have noticed that with actual use, I have
various
problems (thin colored line at boot which goes away with the console,
blanking and of the console display, etc.) so I think more remains to be

done.

I duplicated the DEBUG dump block so that I get a before and after
picture of the
card setup on boot:

MacOS display is /bandit/ATY,XCLAIMVRPro
atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 12M SGRAM, 230 MHz PLL,
100 Mhz
MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG
DSP_ON_OFF
7b33a040 87010182 00651a7b 75130c01     03000200      0038064a
0118061f
PLL ad d5 44 64 e4 13 80 91 8e 9e 29 01 a6 1b 00 00
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG
DSP_ON_OFF
7b23a040 87010182 00751a7b 75130c01     03000200      003a0660
063500c0
PLL ad d5 41 14 dc 03 00 8a 8e 9e 29 01 a6 1b 00 00
Console: switching to colour frame buffer device 160x60
fb0: ATY Mach64 frame buffer device on /bandit/ATY,XCLAIMVRPro
Monitor sense value = 0x73f, using video mode 6 and color mode 0.
fb1: control display adapter

mike.



--
"Brain-eating mutants are bad for business..." - Battle Angel
Hugh "Batmensch" Caley


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

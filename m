Date: Mon, 15 Mar 1999 18:12:43 -0500 (EST)
From: abew <awhite@dartmouth.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: PB G3 Video (for the developers)
Message-ID: <Pine.LNX.3.96.990315175315.20173A-100000@hamish.dartmouth.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a G3 powerbook 266, 14.1", 96 RAM.  For the past many months, I've
been using a custom kernel 2.1.130 in which I hacked atyfb.c (using the
code that Rick Oikawa used to use in his powerbook 2.1.2? kernel) so that
I could boot using 'video=atyfb', etc rather than use the oh-so-slow 'no
video driver' option.  Last night, I did a complete re-install (I wanted
to wait for R5, but who knows when that will be out), and I upgraded
immediately to the 2.2.3 kernel from samba, hoping that by passing in an
'mclk' argument at boot to the kernel as has been discussed on this list
recently, I could use the atyfb accel with the standard kernel and not get
the scary (but colorful) death screen that used to plague me when I tried
to boot a standard kernel without 'no video driver' checked.

Well, I tried all sorts of different mclk values
('video=atyfb:vmode:14,cmode:32,mclk:X') but I got the crazy-colored death
screen no matter what.  Finally, I merged the hacks to atyfb.c that I had
made before into the atyfb.c of the 2.2.3 kernel and tried that... and it
worked great.  I currently am using Geert's XF68 with accel and can do fun
things like window sliding in Enlightenment with no problems -- it's
extrememly fast (faster than Xpmac_mga, I think, but not by much).

So, I'm attaching the diff of my hacked atyfb.c and the standard one in
the hopes that maybe one of the developers who actually knows what they're
doing can possibly figure out a way to modify atyfb.c to get powerbooks
like mine to work with the atyfb in the standard kernel ???  (because I
certainly have NO idea what I'm doing... again, I just used Oikawa's code
and merged it in).  First, here is the appropriate section of 'dmesg':

MacOS display is /pci/ATY,RageLTPro
atyfb: 3D RAGE LT PRO [0x4c50 rev 0xdc] 4M SGRAM, 135 MHz PLL, 100 Mhz
MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on /pci/ATY,RageLTPro

Now here's the diff on atyfb.c:

329,330c329
< #if 1
< /*#if defined(__sparc__) || defined(DEBUG) */
---
> #if defined(__sparc__) || defined(DEBUG)
694,695c693
< #if 1
< /*#if defined(__sparc__) || defined(DEBUG) */
---
> #if defined(__sparc__) || defined(DEBUG)
1478,1480d1475
< 
<     return;
< 
1622c1617
<        (Gx == VU_CHIP_ID) || (Gx == LP_CHIP_ID)) && (info->ram_type >=
SDRAM))
---
>        (Gx == VU_CHIP_ID)) && (info->ram_type >= SDRAM))
2364c2359
<                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx ==
LP_CHIP_ID)
---
>                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
2511c2506
<                      Gx == LI_CHIP_ID) {
---
>                      Gx == LI_CHIP_ID || Gx == LP_CHIP_ID) {
2515,2517d2509
<           } else if (Gx == LP_CHIP_ID) {
<               mclk = 100;
<               pll = 135;
2652,2658c2644,2646
<         if (Gx == LP_CHIP_ID) {
<           default_vmode = VMODE_1024_768_60;
<         } else {
<           default_vmode = nvram_read_byte(NV_VMODE);
<           if (default_vmode <= 0 || default_vmode > VMODE_MAX)
<               default_vmode = VMODE_CHOOSE;
<       }
---
>       default_vmode = nvram_read_byte(NV_VMODE);
>       if (default_vmode <= 0 || default_vmode > VMODE_MAX)
>           default_vmode = VMODE_CHOOSE;
2661c2649
<       if (Gx == LG_CHIP_ID || Gx == LP_CHIP_ID) {
---
>       if (Gx == LG_CHIP_ID)
2664c2652
<       } else {
---
>       else {
3387c3375
<       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx == LP_CHIP_ID)
---
>       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)


Please let me know if there is anything else I can do... 
Thanks.

--Abe White


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

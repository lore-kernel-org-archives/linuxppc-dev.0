Date: Tue, 16 Mar 1999 09:51:02 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: abew <awhite@dartmouth.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: PB G3 Video (for the developers)
In-Reply-To: <Pine.LNX.3.96.990315175315.20173A-100000@hamish.dartmouth.edu>
Message-ID: <Pine.LNX.4.03.9903160948410.31092-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 15 Mar 1999, abew wrote:
> Well, I tried all sorts of different mclk values
> ('video=atyfb:vmode:14,cmode:32,mclk:X') but I got the crazy-colored death
> screen no matter what.  Finally, I merged the hacks to atyfb.c that I had
> made before into the atyfb.c of the 2.2.3 kernel and tried that... and it
> worked great.  I currently am using Geert's XF68 with accel and can do fun
> things like window sliding in Enlightenment with no problems -- it's
> extrememly fast (faster than Xpmac_mga, I think, but not by much).

Interesting to know...

> So, I'm attaching the diff of my hacked atyfb.c and the standard one in
> the hopes that maybe one of the developers who actually knows what they're
> doing can possibly figure out a way to modify atyfb.c to get powerbooks
> like mine to work with the atyfb in the standard kernel ???  (because I
> certainly have NO idea what I'm doing... again, I just used Oikawa's code
> and merged it in).  First, here is the appropriate section of 'dmesg':
> 
> MacOS display is /pci/ATY,RageLTPro
> atyfb: 3D RAGE LT PRO [0x4c50 rev 0xdc] 4M SGRAM, 135 MHz PLL, 100 Mhz
                         ^^^^^^
I.e. LP_CHIP_ID

> MCLK
> Console: switching to colour frame buffer device 128x48
> fb0: ATY Mach64 frame buffer device on /pci/ATY,RageLTPro
> 
> Now here's the diff on atyfb.c:

Please use the `-u' option of diff next time so we can see contexts. And in
which order have you diffed the files?

> 1622c1617
> <        (Gx == VU_CHIP_ID) || (Gx == LP_CHIP_ID)) && (info->ram_type >=
> SDRAM))
> ---
> >        (Gx == VU_CHIP_ID)) && (info->ram_type >= SDRAM))
> 2364c2359
> <                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx ==
> LP_CHIP_ID)
> ---
> >                   Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
> 2511c2506
> <                      Gx == LI_CHIP_ID) {
> ---
> >                      Gx == LI_CHIP_ID || Gx == LP_CHIP_ID) {
> 2515,2517d2509
> <           } else if (Gx == LP_CHIP_ID) {
> <               mclk = 100;
> <               pll = 135;
> 2652,2658c2644,2646
> <         if (Gx == LP_CHIP_ID) {
> <           default_vmode = VMODE_1024_768_60;
> <         } else {
> <           default_vmode = nvram_read_byte(NV_VMODE);
> <           if (default_vmode <= 0 || default_vmode > VMODE_MAX)
> <               default_vmode = VMODE_CHOOSE;
> <       }
> ---
> >       default_vmode = nvram_read_byte(NV_VMODE);
> >       if (default_vmode <= 0 || default_vmode > VMODE_MAX)
> >           default_vmode = VMODE_CHOOSE;
> 2661c2649
> <       if (Gx == LG_CHIP_ID || Gx == LP_CHIP_ID) {
> ---
> >       if (Gx == LG_CHIP_ID)
> 2664c2652
> <       } else {
> ---
> >       else {
> 3387c3375
> <       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID || Gx == LP_CHIP_ID)
> ---
> >       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)

I guess it's one (or more) of these tests for LP_CHIP_ID. If I could see the
contexts, I could comment more on that (sorry, very limited time).

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

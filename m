Date: Wed, 27 Sep 2000 12:08:10 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Message-ID: <20000927120810.B4206@suse.de>
References: <20000926204606.B467@suse.de> <19340821143437.3943@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19340821143437.3943@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 26, Benjamin Herrenschmidt wrote:


> One thing: I'd be interested in figuring out what happens if you simply
> leave this nasty ATI BAR unassigned (write 0xffffffff and then 0 to it).
> Will the controller fail ?

How do I do that? Can one of you prepare a diff against Bens current
tree? He is at pre10 since last night.

> What I can do in the meantime is test that we are running _exactly_ on
> this machine model, and them remap to a region we know is safe (that's
> more or less what you patch do).

My machine has these data:
cpuinfo:
clock           : 291MHz
machine         : PowerBook
motherboard     : AAPL,PowerBook1998 MacRISC
lspci -n:
00:11.0 Class 0300: 1002:4c47 (rev 80)

This is what 18pre4-ben1 reports:

<6>MacOS display is /pci/ATY,264LT-G
<4>atyfb: alternate regbase 1 phys 0x82fff000 virt 0xd0004000
<4>atyfb: alternate regbase 2 phys 0x82fff000 virt 0xd0007000
<4>atyfb: framebuffer phys 0x82800000 virt 0xd000a000
<4>atyfb: region 2 ofbase 0x10000000 breg 24 io 0 pbase 0x82fff000 size
0x1000 overlaps VRAM  - reassigned to pbase 0x83000000 size 0x1000 !
<4>atyfb: alternate regbase 3 phys 0x83000000 virt 0xd080b000
<4>atyfb: 3D RAGE LT-G [0x4c47 rev 0x80] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 63 Mhz MCLK
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
<4>7b23a040 87010182 044215b7 a5000001     03000300      00280840 01a005fe
<4>PLL cd d3 21 44 e8 03 80 e1 8e 9e 98 14 a6 1b 00 00
<4>atyfb: using alternate regbase 1:
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
<4>7b23a040 87010182 044215b7 a5000001     03000300      00280840 01a005fe
<4>PLL cd d3 21 44 e8 03 80 e1 8e 9e 98 14 a6 1b 00 00
<4>atyfb: using alternate regbase 2:
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
<4>7b23a040 87010182 044215b7 a5000001     03000300      00280840 01a005fe
<4>PLL cd d3 21 44 e8 03 80 e1 8e 9e 98 14 a6 1b 00 00
<4>atyfb: using alternate regbase 3:
<4>BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
<4>7b23a040 87010182 044215b7 a5000001     03000300      00280840 01a005fe
<4>PLL cd d3 21 44 e8 03 80 e1 8e 9e 98 14 a6 1b 00 00
<6>atyfb: monitor sense=51e, maps to mode 7
<4>Console: switching to colour frame buffer device 128x48
<4>fb0: ATY Mach64 frame buffer device on /pci/ATY,264LT-G


I have currently no access to other PowerBooks, only the Wallstreets
need the patch. iBook works fine and Lombard should also work.
There is still that init problem, but it is less worse than a hard
crash.




Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

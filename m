To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with Radeon flat panel support
From: gtgj@pacbell.net (Gregorio Gervasio Jr.)
Date: 22 Jan 2002 00:54:37 -0800
Message-ID: <m3wuyaahpu.fsf@adsl-63-206-120-177.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


        I have a Samsung flat panel connected to the DVI port of a
Radeon Mac Edition (PCI version).  The system is a PowerWave/120 which
boots Linux using BootX.  The flat panel worked fine (only) at
1280x1024@60 using 2.4.15-pre6-ben0 but not with 2.4.18-pre3-ben0.
The difference seems to be that the new radeonfb now tries to program
the flat panel registers whereas the old one preserved most of the
registers (which presumably MacOS has initialized).  As far as I can
tell, the register values are:

                      initial   2.4.15-pre6  2.4.18-pre3
                                  (works)       (fails)
----------------------------------------------------------
fp_crtc_h_total_disp  00000032    00000032     009f00d6 *
fp_crtc_v_total_disp  00000029    00000029     03ff0429 *
fp_h_sync_strt_wid    00120008    00120008     001204fa *
fp_v_sync_strt_wid    00030000    00030000     00030400 *
fp_horz_stretch       009f0000    009f0000     009f0000
fp_vert_stretch       003ff000    003ff000     003ff000
fp_gen_ctl            040311cc    000311cd     000311cd
----------------------------------------------------------

With debug enabled, the messages from radeonfb during boot seem okay:

radeonfb_pci_register BEGIN
PCI: Enabling device 00:0d.0 (0086 -> 0087)
radeonfb: ref_clk=2700, ref_div=12, xclk=16615 from OF
radeonfb: probed DDR SGRAM 32768k videoram
radeonfb: detected DFP panel size: 1280x1024
hStart = 1280, hEnd = 1424, hTotal = 1720
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d6^I   hsync_strt_wid = 0x1204fa
v_total_disp = 0x3ff0429^I   vsync_strt_wid = 0x30400
post div = 0x2
fb_div = 0x60
ppll_div_3 = 0x10060
ron = 1792, roff = 22064
vclk_freq = 10800, per = 788
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon QD  DDR SGRAM 32 MB
radeonfb: CRT port DFP monitor connected
radeonfb_pci_register END


Any ideas on what may be going wrong?

For now, I can get the old behavior if I fool radeonfb into thinking
that the monitor is a regular CRT instead of a flat panel (thus
skipping all the FP-specific code).
--
Gregorio Gervasio, Jr.
gtgj@pacbell.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

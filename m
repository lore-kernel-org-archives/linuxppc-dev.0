To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with Radeon flat panel support
References: <Pine.BSF.4.44.0201220145180.89480-100000@shell.unixbox.com>
From: gtgj@pacbell.net (Gregorio Gervasio Jr.)
Date: 23 Jan 2002 01:22:17 -0800
In-Reply-To: <Pine.BSF.4.44.0201220145180.89480-100000@shell.unixbox.com>
Message-ID: <m3r8oh4e2e.fsf@adsl-63-196-7-85.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Tue, 22 Jan 2002 01:50:12 -0800 (PST), Ani Joshi <ajoshi@shell.unixbox.com> said:

a> Look in radeon_get_pllinfo() and see the code which calculates the
a> ref_div, and hard code that to 67.  It seems you are getting 12 for that
a> calculated value, which is wrong (I've never seen any 1st generation
a> mac radeon (AGP or PCI) with a ref_clock of that value).  Try that and
a> lemme know if that fixes anything.

        I just tried that and it still doesn't work.  For what it's
worth, the debug messages now say:

radeonfb_pci_register BEGIN
PCI: Enabling device 00:0d.0 (0086 -> 0087)
radeonfb: ref_clk=2700, ref_div=67, xclk=16615 from OF
radeonfb: probed DDR SGRAM 32768k videoram
radeonfb: detected DFP panel size: 1280x1024
hStart = 1280, hEnd = 1424, hTotal = 1720
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d6^I   hsync_strt_wid = 0x1204fa
v_total_disp = 0x3ff0429^I   vsync_strt_wid = 0x30400
post div = 0x2
fb_div = 0x218
ppll_div_3 = 0x10218
ron = 1792, roff = 22064
vclk_freq = 10800, per = 788

a> Other then that, all the other debug info seems correct.  You may want to
a> try 2.4.18-pre5 (when it comes out) or when 2.4.18 when its finished as
a> I've updated the driver recently w/ regards to flat panel.

        Okay, I will watch for it.  Thanks.


a> On 22 Jan 2002, Gregorio Gervasio Jr. wrote:

[...]

>>                        initial   2.4.15-pre6  2.4.18-pre3
>>                                   (works)       (fails)
>> ----------------------------------------------------------
>> fp_crtc_h_total_disp  00000032    00000032     009f00d6 *
>> fp_crtc_v_total_disp  00000029    00000029     03ff0429 *
>> fp_h_sync_strt_wid    00120008    00120008     001204fa *
>> fp_v_sync_strt_wid    00030000    00030000     00030400 *
>> fp_horz_stretch       009f0000    009f0000     009f0000
>> fp_vert_stretch       003ff000    003ff000     003ff000
>> fp_gen_ctl            040311cc    000311cd     000311cd
>> ----------------------------------------------------------
>>
>> With debug enabled, the messages from radeonfb during boot seem okay:
>>
>> radeonfb_pci_register BEGIN
>> PCI: Enabling device 00:0d.0 (0086 -> 0087)
>> radeonfb: ref_clk=2700, ref_div=12, xclk=16615 from OF
>> radeonfb: probed DDR SGRAM 32768k videoram
>> radeonfb: detected DFP panel size: 1280x1024
>> hStart = 1280, hEnd = 1424, hTotal = 1720
>> vStart = 1025, vEnd = 1028, vTotal = 1066
>> h_total_disp = 0x9f00d6^I   hsync_strt_wid = 0x1204fa
>> v_total_disp = 0x3ff0429^I   vsync_strt_wid = 0x30400
>> post div = 0x2
>> fb_div = 0x60
>> ppll_div_3 = 0x10060
>> ron = 1792, roff = 22064
>> vclk_freq = 10800, per = 788
>> Console: switching to colour frame buffer device 160x64
>> radeonfb: ATI Radeon QD  DDR SGRAM 32 MB
>> radeonfb: CRT port DFP monitor connected
>> radeonfb_pci_register END

[...]

--
Gregorio Gervasio, Jr.
gtgj@pacbell.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

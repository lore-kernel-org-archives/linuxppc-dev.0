Return-Path: <jfaslist@yahoo.fr>
Received: from web27502.mail.ukl.yahoo.com (web27502.mail.ukl.yahoo.com
	[217.146.177.206]) by ozlabs.org (Postfix) with SMTP id A0DDA67B66
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:43:01 +1000 (EST)
Message-ID: <20061010203620.771.qmail@web27502.mail.ukl.yahoo.com>
Date: Tue, 10 Oct 2006 22:36:19 +0200 (CEST)
From: jean-francois simon <jfaslist@yahoo.fr>
Subject: Graphic issues (emulating VGA bios on IBM Maple)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1813975178-1160512579=:99772"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1813975178-1160512579=:99772
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi,
I have ported the x86emu x86 emulator to IBM PIBS firmware on a Maple 
platform. I am now trying to emulate a PCI ATI RADEON RV100 VGA BIOS.  
It goes all the way and seems OK.  When I boot Linux , the card is 
recognized (it wasn't before), but the screen just flickers a couple of 
time.  I worry about the message:
"radeonfb: Retrieved PLL infos from BIOS" since I don't have a BIOS.  
And the radeon_base.c driver seems to be doing a bunch of them:
       /*
         * Check out if we have an X86 which gave us some PLL 
informations
         * and if yes, retrieve them
         */
        if (!force_measure_pll && rinfo->bios_seg) {
                u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 
0x30);

                rinfo->pll.sclk         = BIOS_IN16(pll_info_block + 
0x08);
                rinfo->pll.mclk         = BIOS_IN16(pll_info_block + 
0x0a);
                rinfo->pll.ref_clk      = BIOS_IN16(pll_info_block + 
0x0e);
                rinfo->pll.ref_div      = BIOS_IN16(pll_info_block + 
0x10);
                rinfo->pll.ppll_min     = BIOS_IN32(pll_info_block + 
0x12);
                rinfo->pll.ppll_max     = BIOS_IN32(pll_info_block + 
0x16);

                printk(KERN_INFO "radeonfb: Retrieved PLL infos from 
BIOS\n");
                goto found;


The PLL values may be bogus..


Thanks for any help.
-jf simon


radeonfb_pci_register BEGIN
aper_base: 80000000 MC_FB_LOC to: 83ff8000, MC_AGP_LOC to: ffff9000
radeonfb (0000:02:01.0): Found 32768k of DDR 64 bits wide videoram
radeonfb (0000:02:01.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: No ATY,RefCLK property !
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, 
System=150.00 MHz
radeonfb: PLL min 12000 max 35000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeon_probe_OF_head
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeon_probe_OF_head
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2    hsync_strt_wid = 0xe053a
v_total_disp = 0x3ff0429           vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
freq = 10800, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 21600
ref_div = 60, ref_clk = 2700, output_freq = 21600
post div = 0x1
fb_div = 0x1e0
ppll_div_3 = 0x101e0
Console: switching to colour frame buffer device 160x64
radeonfb (0000:02:01.0): ATI Radeon QY
radeonfb_pci_register END
kobject_register failed for radeonfb (-17)
Call Trace:
[C000000000BFFB60] [C00000000000E97C] .show_stack+0x68/0x1b4 
(unreliable)
[C000000000BFFC10] [C00000000017EC54] .kobject_register+0x5c/0x8c
[C000000000BFFCA0] [C0000000001FAAF0] .bus_add_driver+0x7c/0x1b4
[C000000000BFFD50] [C0000000001FBDC8] .driver_register+0xac/0xc8
[C000000000BFFDD0] [C00000000018D084] .__pci_register_driver+0x8c/0xdc
[C000000000BFFE60] [C0000000003CCC9C] .radeonfb_old_init+0x164/0x188
[C000000000BFFF00] [C00000000000929C] .init+0x258/0x3d0
[C000000000BFFF90] [C00000000001E848] .kernel_thread+0x4c/0x68
vga16fb: unable to map device
vga16fb: probe of vga16fb.0 failed with error -12

 		
---------------------------------
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! Demandez à ceux qui savent sur Yahoo! Questions/Réponses.
--0-1813975178-1160512579=:99772
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre><tt><tt>Hi,<br>I have ported the x86emu x86 emulator to IBM PIBS firmware on a Maple <br>platform. I am now trying to emulate a PCI ATI RADEON RV100 VGA BIOS.  <br>It goes all the way and seems OK.  When I boot Linux , the card is <br>recognized (it wasn't before), but the screen just flickers a couple of <br>time.  I worry about the message:<br>"radeonfb: Retrieved PLL infos from BIOS" since I don't have a BIOS.  <br>And the radeon_base.c driver seems to be doing a bunch of them:<br>       /*<br>         * Check out if we have an X86 which gave us some PLL <br>informations<br>         * and if yes, retrieve them<br>         */<br>        if (!force_measure_pll &amp;&amp; rinfo-&gt;bios_seg) {<br>                u16 pll_info_block = BIOS_IN16(rinfo-&gt;fp_bios_start + <br>0x30);<br><br>                rinfo-&gt;pll.sclk         = BIOS_IN16(pll_info_block + <br>0x08);<br>                rinfo-&gt;pll.mclk         = BIOS_IN16(pll_info_block + <br>0x0a);<br>              
  rinfo-&gt;pll.ref_clk      = BIOS_IN16(pll_info_block + <br>0x0e);<br>                rinfo-&gt;pll.ref_div      = BIOS_IN16(pll_info_block + <br>0x10);<br>                rinfo-&gt;pll.ppll_min     = BIOS_IN32(pll_info_block + <br>0x12);<br>                rinfo-&gt;pll.ppll_max     = BIOS_IN32(pll_info_block + <br>0x16);<br><br>                printk(KERN_INFO "radeonfb: Retrieved PLL infos from <br>BIOS\n");<br>                goto found;<br><br><br>The PLL values may be bogus..<br><br><br>Thanks for any help.<br>-jf simon<br><br><br>radeonfb_pci_register BEGIN<br>aper_base: 80000000 MC_FB_LOC to: 83ff8000, MC_AGP_LOC to: ffff9000<br>radeonfb (0000:02:01.0): Found 32768k of DDR 64 bits wide videoram<br>radeonfb (0000:02:01.0): mapped 16384k videoram<br>radeonfb: Found Intel x86 BIOS ROM Image<br>radeonfb: No ATY,RefCLK property !<br>radeonfb: Retrieved PLL infos from BIOS<br>radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, <br>System=150.00 MHz<br>radeonfb:
 PLL min 12000 max 35000<br>1 chips in connector info<br> - chip 1 has 2 connectors<br>  * connector 0 of type 2 (CRT) : 2300<br>  * connector 1 of type 3 (DVI-I) : 3201<br>Starting monitor auto detection...<br>radeonfb: I2C (port 1) ... not found<br>radeonfb: I2C (port 2) ... not found<br>radeonfb: I2C (port 3) ... found CRT display<br>radeonfb: I2C (port 4) ... not found<br>radeon_probe_OF_head<br>radeonfb: I2C (port 2) ... not found<br>radeonfb: I2C (port 4) ... not found<br>radeon_probe_OF_head<br>radeonfb: I2C (port 3) ... found CRT display<br>radeonfb: Monitor 1 type CRT found<br>radeonfb: EDID probed<br>radeonfb: Monitor 2 type no found<br>hStart = 1328, hEnd = 1440, hTotal = 1688<br>vStart = 1025, vEnd = 1028, vTotal = 1066<br>h_total_disp = 0x9f00d2    hsync_strt_wid = 0xe053a<br>v_total_disp = 0x3ff0429           vsync_strt_wid = 0x30400<br>pixclock = 9259<br>freq = 10800<br>freq = 10800, PLL min = 12000, PLL max = 35000<br>ref_div = 60, ref_clk = 2700,
 output_freq = 21600<br>ref_div = 60, ref_clk = 2700, output_freq = 21600<br>post div = 0x1<br>fb_div = 0x1e0<br>ppll_div_3 = 0x101e0<br>Console: switching to colour frame buffer device 160x64<br>radeonfb (0000:02:01.0): ATI Radeon QY<br>radeonfb_pci_register END<br>kobject_register failed for radeonfb (-17)<br>Call Trace:<br>[C000000000BFFB60] [C00000000000E97C] .show_stack+0x68/0x1b4 <br>(unreliable)<br>[C000000000BFFC10] [C00000000017EC54] .kobject_register+0x5c/0x8c<br>[C000000000BFFCA0] [C0000000001FAAF0] .bus_add_driver+0x7c/0x1b4<br>[C000000000BFFD50] [C0000000001FBDC8] .driver_register+0xac/0xc8<br>[C000000000BFFDD0] [C00000000018D084] .__pci_register_driver+0x8c/0xdc<br>[C000000000BFFE60] [C0000000003CCC9C] .radeonfb_old_init+0x164/0x188<br>[C000000000BFFF00] [C00000000000929C] .init+0x258/0x3d0<br>[C000000000BFFF90] [C00000000001E848] .kernel_thread+0x4c/0x68<br>vga16fb: unable to map device<br>vga16fb: probe of vga16fb.0 failed with error
 -12</tt></tt></pre><p>&#32;
		<hr size="1">
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Demandez à ceux qui savent sur <a href="http://fr.rd.yahoo.com/evt=42054/*http://fr.answers.yahoo.com">Yahoo! Questions/Réponses</a>.
--0-1813975178-1160512579=:99772--

Message-Id: <374413A8.E8E74F85@schweiz.ch>
Date: Thu, 20 May 1999 15:52:40 +0200
From: Andreas Tobler <a.tobler@schweiz.ch>
Mime-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, Andreas Tobler <a.tobler@schweiz.ch>
Subject: ATI-chip in PowerbookG3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I want to find out if my ATI chip is supported by the atyfb driver. The
things I can find are the following:
Powerbook Wallstreet G3 from June 98 250MHz 13.1 TFT 96MB Ram
System Profiler output:
Card Name:      ATY,264LT-G
Card Model:     ATY,LT-G
Card Rom:       113-XXXXX-1.0028
Card Revision:  128
Card Vendor ID  1002
Slot $E1

When I have a look into the file atyfb.c I see the following:
static struct aty_features {
    u16 pci_id;
    u16 chip_type;
    const char *name;
} aty_features[] __initdata = {
    /* mach64GX family */
    { 0x4758, 0x00d7, "mach64GX (ATI888GX00)" },
    { 0x4358, 0x0057, "mach64CX (ATI888CX00)" },

    /* mach64CT family */
    { 0x4354, 0x4354, "mach64CT (ATI264CT)" },
    { 0x4554, 0x4554, "mach64ET (ATI264ET)" },

    /* mach64CT family / mach64VT class */
    { 0x5654, 0x5654, "mach64VT (ATI264VT)" },
    { 0x5655, 0x5655, "mach64VTB (ATI264VTB)" },
    { 0x5656, 0x5656, "mach64VT4 (ATI264VT4)" },

    /* mach64CT family / mach64GT (3D RAGE) class */
    { 0x4c42, 0x4c42, "3D RAGE LT PRO (AGP)" },
    { 0x4c44, 0x4c44, "3D RAGE LT PRO" },
    { 0x4c47, 0x4c47, "3D RAGE LT PRO" },
    { 0x4c49, 0x4c49, "3D RAGE LT PRO" },
    { 0x4c50, 0x4c50, "3D RAGE LT PRO" },
    { 0x4c54, 0x4c54, "3D RAGE LT" },
    { 0x4754, 0x4754, "3D RAGE (GT)" },
    { 0x4755, 0x4755, "3D RAGE II+ (GTB)" },
    { 0x4756, 0x4756, "3D RAGE IIC (PCI)" },
    { 0x4757, 0x4757, "3D RAGE IIC (AGP)" },
    { 0x475a, 0x475a, "3D RAGE IIC (AGP)" },
    { 0x4742, 0x4742, "3D RAGE PRO (BGA, AGP)" },
    { 0x4744, 0x4744, "3D RAGE PRO (BGA, AGP, 1x only)" },
    { 0x4749, 0x4749, "3D RAGE PRO (BGA, PCI)" },
    { 0x4750, 0x4750, "3D RAGE PRO (PQFP, PCI)" },
    { 0x4751, 0x4751, "3D RAGE PRO (PQFP, PCI, limited 3D)" },
};
Sorry for the length..

Which of the devices above corresponds to my PB chip? 

My kernels come up with the following message:

MacOS display is /pci/ATY,264LT-G
atyfb: 3D RAGE LT PRO [0x4c47 rev 0x80] 4M SGRAM, 230 MHz PLL, 63 Mhz
MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on /pci/ATY,264LT-G 

The BootX parameters are the following:
video=atyfb:vmode:14,cmode:32,mclk:63
Is this valid? At least for kernels < 2.2.7 it works. 

I wouldn't ask if'd trust the situation. I already had two repair trips.
And I don't like a third one.


Thanks for any hint


Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

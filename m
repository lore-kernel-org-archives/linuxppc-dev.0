Message-ID: <83E3831A88E65844B01DB1A73FB66F93140828@CSDNT99.cdcgy.com>
From: "Dang, James" <James.Dang@gdcanada.com>
To: "'greggiraud@netcourrier.com'" <greggiraud@netcourrier.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: boot linux on a MPC8266ADS board
Date: Wed, 9 Apr 2003 09:36:00 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First, the IMAP_ADDR should be at 0xF0000000 or above. Otherwise you run
into problem with MMU. Second, you have to change ppcboot CFG_IMMR (in
MPC8260ADS.h) to the address of linux IMAP_ADDR above.

-----Original Message-----
From: greggiraud@netcourrier.com [mailto:greggiraud@netcourrier.com]
Sent: Wednesday, April 09, 2003 6:14 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: boot linux on a MPC8266ADS board

I 've installed PPCBOOT1.2 (eldk2.0), it runs OK.
Now I have generate a kernel Linux2.4.4, so I follow these steps:
->in the file /linux-2.4.4/include/asm-ppc/mpc8260ads/mpc8260ads.h
I add:   #include <asm/ppcboot.h> /*as I read on the forum*/
         #define PHY_INTERRUPT 25
         #define IMAP_ADDR 0x04700000
->make config
->make dep
->make pImage

->Then with my ppcboot, I load the kernel, and the ramdisk(simple ramdisk).
->I try to run the kernel: and print "Uncompressing OK..."
"Transferring OK..." and it hangs.

I know some people had this problem. And you said that the bd structure had
to be the same as defined in the ppcboot.
So you advice to put "#include <asm/ppcboot.h>" in
/linux-2.4.4/include/asm-ppc/mpc8260ads/mpc8260ads.h

The file /linux-2.4.4/include/asm-ppc/ppcboot.h have in the bd struct
definition a line "mon_fnc_t *bi_mon_fnv".

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

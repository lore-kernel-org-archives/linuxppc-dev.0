Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B8D0@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel 2.2.14 and SMC2 on an 823/850
Date: Tue, 31 Oct 2000 15:56:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

There seems to be an error in uart.c from mvista kernel 2.2.14.

If "Alternate SMC pins" is selected, SMC2 gets enabled like this (line 2772
in uart.c):

/* SMC2 is on Port A.
	*/
	iobits = 0x300;
	immap->im_ioport.iop_papar |= iobits;
	immap->im_ioport.iop_padir &= ~iobits;
	immap->im_ioport.iop_paodr &= ~iobits;

According to the User's Manual (and to Dan
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200006/msg00066.html)
bit 8 and 9 should be set in papar, and cleared in padir, to make SMC2 work
on an 823/850.

iobits should be set to 0xC0 and not 0x300.

--
Kim Jorgensen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

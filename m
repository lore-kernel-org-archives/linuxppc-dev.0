From: Ruedi.Hofer@ascom.ch
Date: Fri, 04 Feb 2000 08:30:27 +0100 (CET)
Subject: initrd
To: linuxppc-embedded@lists.linuxppc.org
Cc: damm@kieraypc01.p.y.ki.era.ericsson.se
Message-id: <0FPE0004LA7GMA@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_wtihOt1D2xjHJK4tcIm4tw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_wtihOt1D2xjHJK4tcIm4tw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I got initrd running. The problem is exactly as assumed by Wolfgang.


Change in /usr/src/linux/arch/ppc/mbxboot/misc.c  ~ line 225

from

#ifdef CONFIG_MBX
        cmd_line = (char *)(load_addr - 0x10000);
#else
        cmd_line = (char *)(0x200000);
#endif

to

#if (defined CONFIG_MBX || defined CONFIG_ADS)
        cmd_line = (char *)(load_addr - 0x10000);
#else
        cmd_line = (char *)(0x200000);
#endif

Then the mapping is alright.

Might the change be necessary for FADS as well ?!?

Cheers and thanks for your help

Ruedi


--Boundary_(ID_wtihOt1D2xjHJK4tcIm4tw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

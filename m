Message-ID: <034c01c40775$1dbb9fe0$3000a8c0@foundation>
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem during kernel init with mmu_off
Date: Thu, 11 Mar 2004 08:28:25 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to boot the 2.4 PPC kernel on a PPC750FX eval board.   The
bootloader in the boards firmware has the mmu _on_ with block addr
translation enabled.  It seems that all the BAT mappings are 1:1.

The kernel source as well as comments in the archive of this mailing list
indicate that the mmu being on during kernel initialization should not be an
issue.

However, I've determined through leds and uart that the kernel makes it to
the RFI in mmu_off, but from that point goes into never-never land (I can't
tell exactly what happened).

I've verified that the values in SRR0 and SRR1 are what is expected prior to
the RFI which is supposed to turn the mmu off.

I also tried using MTMSR instead of RFI to turn the mmu off but the
processor seems to halt at that instruction.

I don't have a jtag debugger (yet) so I'm relying on leds and uart to debug.
I really have no idea of the state of the chip after the RFI or MTMSR.

Anyone out there have any ideas?   Anything about the 750FX that is
different than other processors?

Thanks,

Stuart Yoder


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

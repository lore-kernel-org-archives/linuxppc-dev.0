From: Christian.Peter@ascom.ch
Date: Thu, 04 Jan 2001 14:47:53 +0100 (CET)
Subject: Linux boot fails after MMU (MPC8260)
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0G6N00K6Y4ZYFB@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_ZKCeXe92pJnJv3yLcC1nsw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_ZKCeXe92pJnJv3yLcC1nsw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I try to boot linux 2.4.0test8 on a custom 8260 board. It fails to start the kernel (no output) and
i think it hangs somewhere after the mmu initialization (ppc/kernel/head.S).
My knowledge of the mmu and the 8260 is not very good, therefore i'm not sure!
A prior co-worker (unfortunately not in the company anymore) had successfully started the kernel
on a SBC8260 board with a vxworks bootloader and some patches for the mbxboot.
I have near the same configuration, some difference in the vxworks bootloader (chip-select, IMMR 0x0f00000), but
i set this new in mbxboot/head_8260.S to the following values.

Memory Map
----------
0x00000000     60x SDRAM
0x20000008     some LEDs
0xFE000000     Flash
IMMR           0xF0000000

Currently i'm debugging with 2 LEDs on the board and i can switch the LED's on and off until
the RFI. After RFI the code should jump to start_here, but it never gets there.

  ppc/kernel/head.S

  mfmsr r0
  ori r0,r0,MSR_DR|MSR_IR
  mtspr SRR1,r0
  lis r0,start_here@h
  ori r0,r0,start_here@l
  mtspr SRR0,r0
  SYNC
  RFI                       /* enables MMU */

This is a extract of the terminal output.

  TFTP_CLIENT...
  Starting at 0x400000...

  CPU/CPM/BUS: 165/132/66 Mhz

  Ethernet (in decimal): 0:160:30:1:4:5

  loaded at:     00400000 0040B274
  board data at: 00FFFFC0 00FFFFEC
  relocated to:  00200100 0020012C
  zimage at:     0040B274 0047F33D
  avail ram:     00480000 01000000

  Linux/PPC load:
  Uncompressing Linux...
  done.
  Now booting the kernel

Is this a configuration problem (memory map)? Any ideas or suggestions?

Many thanks in advance.

Chris

--Boundary_(ID_ZKCeXe92pJnJv3yLcC1nsw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

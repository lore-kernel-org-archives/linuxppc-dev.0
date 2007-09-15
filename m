Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09479DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 07:27:00 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IWfAH-0001oK-3P
	for linuxppc-embedded@ozlabs.org; Sat, 15 Sep 2007 14:26:57 -0700
Message-ID: <12694083.post@talk.nabble.com>
Date: Sat, 15 Sep 2007 14:26:57 -0700 (PDT)
From: Junqiang Hu <jqhu936@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Linux booting problem on Xilinx ppc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Dear friends,

   I'm trying to run Linux in AvNet (Memec) Xilinx-XC2VP50-EVKT-FF1152
 board.  The Linux version I'm using is 2.4; the cross-compiler is
gcc-4.1.0, glibc 2.3.6.  When booting the kernel, it shows:
      loaded at:     00400000 004B51E4
      board data at: 00000000 00000018
      relocated to:  0040526C 00405284
      zimage at:     00405B2B 004B177C
      avail ram:     004B6000 60000000

      Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 rw
      Uncompressing Linux...done.
      Now booting the kernel

Then it hangs. First it seems to me that the "avail ram" is not correct,
since I configured only 32MB SDRAM.  Moreover, if it's first powered on, the
end address of "avail ram" would be FFD9FBED. Then I tried to investigate
the problem using xmd.  When  launched, it says:

  Processor(s) in System ::

  PowerPC405(1) : ppc405_0
  Address Map for Processor ppc405_0
    (0x00000000-0x01ffffff) Infineon_Mobile_SDRAM_HYB25L128160AC_8plb
    (0x40600000-0x4060ffff) RS232 plb->plb2opb->opb
    (0x41200000-0x4120ffff) opb_intc_0    plb->plb2opb->opb
    (0x41800000-0x4180ffff) SysACE_CompactFlash   plb->plb2opb->opb
    (0x41c00000-0x41c0ffff) opb_timer_1   plb->plb2opb->opb
    (0x80200000-0x8020ffff) RS232_1       plb
    (0x80400000-0x8040ffff) Broadcom_BCM5221_Ethernet_Transceiver plb
    (0xfffe0000-0xffffffff) plb_bram_if_cntlr_1   plb

  PowerPC405(2) : ppc405_1
  Address Map for Processor ppc405_1

  Connecting to cable (Parallel Port - LPT1).
  Checking cable driver.
   Driver windrvr6.sys version = 7.0.0.0. LPT base address = 0378h.
   ECP base address = 0778h.
  Cable connection established.
  INFO:MDT - Assumption: Selected Device 2 for debugging.

  JTAG chain configuration
  --------------------------------------------------
  Device   ID Code        IR Length    Part Name
   1       0a001093           8        System_ACE
   2       0129e093          14        XC2VP50

  XMD: Connected to PowerPC target. Processor Version No : 0x200108a0
  Address mapping for accessing special PowerPC features from XMD/GDB:
      I-Cache (Data)  :  Disabled
      I-Cache (Tag)   :  Disabled
      D-Cache (Data)  :  Disabled
      D-Cache (Tag)   :  Disabled
      ISOCM           :  Start Address  -  0xfffe0000, Size - 131072 bytes
      TLB             :  Disabled
      DCR             :  Disabled
 
  Connected to "ppc" target. id = 0
  Starting GDB server for "ppc" target (id = 0) at TCP port no 1234

Then I download the Linux kernel using dow, and the following message
 appears:

  WARNING: Attempted to read location: 0xfffffffc. Reading ISOCM memory
 not supported
        section, .text: 0x00400000-0x00404b6c
        section, .data: 0x00405000-0x004b2000
        section, .bss: 0x004b2000-0x004b51e4
  Downloaded Program linux_kernel/zImage.elf
  Setting PC with program start addr = 0x00400000
  PC reset to 0x00400000, Clearing MSR Register

After typing "run" command, the following appears:
    PC reset to 0x00400000, Clearing MSR Register
    Processor started. Type "stop" to stop processor
Then after issuing "stop", it says "unable to stop processor"

I also tried kernel version 2.6.22, but the same thing happens, except that
the "avail ram" changed to 7C9E2378 and it's the same no matter first
powered on or not.

  No idea how to continue...

  Could somebody give me some help? Thanks!


-- 
View this message in context: http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html#a12694083
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

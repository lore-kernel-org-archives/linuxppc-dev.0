Message-ID: <3771D987.C59A9374@mpifr-bonn.mpg.de>
Date: Thu, 24 Jun 1999 09:08:55 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
CC: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
Subject: Help: Porting PCI driver from Linux/Intel -> PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[sorry, this is a rather long post]
Hi all,

	I wrote a driver for a pci dsp card, which works fine on several Intel/
Linux boxes both with 2.0.x and 2.2.x.  This encouraged to make a test with my
PMac 7300/166, running R5 with the stock 2.2.6 kernel.  I compiled and inserted
the driver --- and got a kernel panic :-(

Maybe I missed some setup which is needed with LinuxPPC but not with Intel?  Or
does this card simply not work on my Mac?  I hope some PCI/kernel gurus could 
help me or point me to a "PCI-for-LinuxPPC-beginners-page".

Some details about the problem:

The output of lspci for the dsp card is:

00:0f.0 Class ff00: Applied Micro Circuits Corporation S5933_HEPC3
	Flags: bus master, fast devsel, latency 32, IRQ 25
	I/O ports at 08c0 [disabled]
	I/O ports at 0880 [disabled]
	I/O ports at 0840 [disabled]
	I/O ports at 0800 [disabled]
	I/O ports at 0400 [disabled]
00: e8 10 9c 80 04 00 00 00 00 00 00 ff 00 20 00 00
10: c1 08 00 00 81 08 00 00 41 08 00 00 01 08 00 00
20: 01 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 80 80 00 00 00 00 00 00 00 00 01 01 ff 00

Now I try to insmod my driver, which reads the configuration space (using calls
to pci_read_config_dword) and dumps it, reads irq and board revision, reads the
base adresses of the five io regions, and reads one io address via inl().  The
last operation leads to a panic:

hepc3offset 0x00 == 0x809c10e8 
hepc3offset 0x04 == 0x00000004 
hepc3offset 0x08 == 0xff000000 
hepc3offset 0x0c == 0x00002000 
hepc3offset 0x10 == 0x000008c1 
hepc3offset 0x14 == 0x00000881 
hepc3offset 0x18 == 0x00000841 
hepc3offset 0x1c == 0x00000801 
hepc3offset 0x20 == 0x00000401 
hepc3offset 0x24 == 0x00000000 
hepc3offset 0x28 == 0x00000000 
hepc3offset 0x2c == 0x00000000 
hepc3offset 0x30 == 0x80800000 
hepc3offset 0x34 == 0x00000000 
hepc3offset 0x38 == 0x00000000 
hepc3offset 0x3c == 0x00ff0101 
hepc3 irq = 1, revision = 0 
hepc3 Base 0 = 0x000008c0 
hepc3 Base 1 = 0x00000880 
hepc3 Base 3 = 0x00000800 
hepc3 Base 4 = 0x00000400 
Machine check in kernel mode. 
Caused by (from msr): regs c24d7ca0 Unknown values in msr 
NIP: C483CFA0 XER: 00000000 LR: C483CF54 REGS: c24d7ca0 TRAP: 0200 
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 
TASK = c24d6000[578] 'insmod' mm->pgd c269b000 Last syscall: 128  
last math c24d6000 
GPR00: 000008C0 C24D7D90 C24D6000 C483E180 C024C920 000008DC 000008F8 000008FC  
GPR08: 00000000 F20008DC F20008FC F20008F8 84222424 0184F370 00000000 00000000  
GPR16: 018F8790 00000000 FFFFFFFF 00000000 00009032 024D7E80 00000000 00000001  
GPR24: C483C048 C483E51C C483D4C4 C4840000 C24D7D9C C02D04A0 C024C920 00000040  
Call backtrace:  
C483CF54 C483C0A8 C0016968 C000388C 018056D4 01803428 01803AD4  
016DF7D4 00000000  
Instruction DUMP: 3863e180  7fc4f378  4cc63182 <480015c1> 38600000  80010034 
7c0803a6  8361001c  83810020  
Kernel panic: machine check 

Some puzzling details:

* lspci reports irq #25, but the value in the config space is 1
* the regions 0 to 3 are 256 bytes each, so they would overlap if the values
  reported would be correct.

Thanks in advance for any help!!!

	Albrecht.
-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

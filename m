Date: Thu, 24 Jun 1999 22:03:07 -0400
From: Daniel Jacobowitz <drow@false.org>
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>, ad@MPIfR-Bonn.MPG.de
Subject: Re: Help: Porting PCI driver from Linux/Intel -> PPC
Message-ID: <19990624220307.A9159@drow.res.cmu.edu>
References: <3771D987.C59A9374@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: =?iso-8859-1?Q?=3C3771D987=2EC59A9374=40mpifr-bonn=2Empg=2Ede=3E=3B_from?=
 =?iso-8859-1?Q?_Albrecht_Dre=DF_on_Thu=2C_Jun_24=2C_1999_at_09:08:55AM_+?=
 =?iso-8859-1?Q?0200?=
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 24, 1999 at 09:08:55AM +0200, Albrecht Dreß wrote:
> 
> [sorry, this is a rather long post]
> Hi all,
> 
> 	I wrote a driver for a pci dsp card, which works fine on several Intel/
> Linux boxes both with 2.0.x and 2.2.x.  This encouraged to make a test with my
> PMac 7300/166, running R5 with the stock 2.2.6 kernel.  I compiled and inserted
> the driver --- and got a kernel panic :-(
> 
> Maybe I missed some setup which is needed with LinuxPPC but not with Intel?  Or
> does this card simply not work on my Mac?  I hope some PCI/kernel gurus could 
> help me or point me to a "PCI-for-LinuxPPC-beginners-page".

> Now I try to insmod my driver, which reads the configuration space (using calls
> to pci_read_config_dword) and dumps it, reads irq and board revision, reads the
> base adresses of the five io regions, and reads one io address via inl().  The
> last operation leads to a panic:


> Machine check in kernel mode. 
> Caused by (from msr): regs c24d7ca0 Unknown values in msr 
> NIP: C483CFA0 XER: 00000000 LR: C483CF54 REGS: c24d7ca0 TRAP: 0200 

                                                                ^^^^

> MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 
> TASK = c24d6000[578] 'insmod' mm->pgd c269b000 Last syscall: 128  
> last math c24d6000 
> GPR00: 000008C0 C24D7D90 C24D6000 C483E180 C024C920 000008DC 000008F8 000008FC  
> GPR08: 00000000 F20008DC F20008FC F20008F8 84222424 0184F370 00000000 00000000  
> GPR16: 018F8790 00000000 FFFFFFFF 00000000 00009032 024D7E80 00000000 00000001  
> GPR24: C483C048 C483E51C C483D4C4 C4840000 C24D7D9C C02D04A0 C024C920 00000040  
> Call backtrace:  
> C483CF54 C483C0A8 C0016968 C000388C 018056D4 01803428 01803AD4  
> 016DF7D4 00000000  
> Instruction DUMP: 3863e180  7fc4f378  4cc63182 <480015c1> 38600000  80010034 
> 7c0803a6  8361001c  83810020  
> Kernel panic: machine check 


What I highlighted above is your clue.  I don't remember off the top of
my head which 0200 is, but I'm willing to bet it's Open Firmware's data
access exception - attempting to access physical memory unmapped by the
MMU.  Along with the other suggestion for enabling memory, be very sure
about endianness issues - that's the major porting pitfall.  Where are
you inl()'ing from?


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Thu, 7 Jan 1999 12:55:22 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux-2.2.0-pre5 SMP broken on PReP?
Message-ID: <Pine.LNX.4.04.9901071243090.32305-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After working with 2.1.132 for awhile, I decided it was time to try
Linus's 2.2.0-pre5, however I haven't been able to successfully boot with
it. I have tweaked code and tried various revisions includeing pre1 and
pre4 (pre1 wouldn't compile).

I have been getting crashes in the ncr53c8xx driver, but the dump doesn't
seem to be providing valid information.

I tracked NIP in the following dump to '<vread+280> lmw r29,20(r1)'. From
my point of view, it looks like the stack got messed up somewhere.
I am also building this kernel in a CONFIG_SMP=y configuration since I am
going to work on MTX SMP once the kernel runs again ;).

ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: reallocating base (Wacky IBM)ncr53c8xx: reallocating base2
(Wacky IBM)<
ncr53c875-0: rev=0x04, base=0x1fffe00, io_port=0xffffe00, irq=14
ncr53c875-0: NCR clock is 26691KHz, 26772KHz
ncr53c875-0: ID 7, Fast-20, Parity Checking
ncr53c875-0: on-chip RAM at 0x1ffe000
ncr53c875-0: restart (scsi reset).
ncr53c875-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - revision 3.1d
scsi : 1 host.
NIP: C00246F8 XER: 00000000 LR: C0024634 REGS: c7ffff00 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c03b0000[3] 'kswapd' mm->pgd c0128000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 0
GPR00: C0024634 C7FFFFF0 C03B0000 7BDFFFE0 FFFFFFFF 00000000 FFFFFC18 00000000
GPR08: 00000000 C0160000 00008000 C03B1F10 84200020 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
GPR24: 00000000 C0133330 C0140000 C0140000 C0170000 00000000 00000000 00000000
Call backtrace:
00000000
Instruction DUMP: 2c870000  4086ff34  7c6c4050 <bba10014> 38210020 4e800020  9421
Kernel panic: kernel access of bad area pc c00246f8 lr c0024634 address C8000004 t3
Rebooting in 180 seconds..global_restore_flags: 00000042 (00418570)       

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

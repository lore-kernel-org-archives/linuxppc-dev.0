Date: Fri, 22 Jan 1999 13:44:25 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: kswapd and SMP still broke on 2.2.0-pre9
Message-ID: <Pine.LNX.4.04.9901221336410.12144-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


kswapd is still dieing on boot with SMP enabled (and this time the second
processor is actually active)

Does this indicate something is wrong with SMP and the MM code, or that
some PPC-specific part needs fixing? I've tried to keep up on
linux-kernel, but it's a little overwhelming ;)

ncr53c875-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - revision 3.1f
scsi : 1 host.
Trying to vfree() nonexistent vm area (ffffffff)
NIP: 00000000 XER: 20000000 LR: 00000000 REGS: c03d5e30 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c03d4000[3] 'kswapd' mm->pgd c012a000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 1
GPR00: 00000000 C03D5F20 C03D4000 00000031 00000001 00000000 C0140000 C0140C18
GPR08: 000F3F26 C0160000 000003F8 C03D5E50 00000000 07F719C0 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
GPR24: 00000000 C0140000 C0135314 C0140000 C0180000 00000064 C0140000 C00FF064
Call backtrace:
00000000 80097188
Instruction DUMP:NIP: C0007290 XER: 20000000 LR: C0007278 REGS: c03d5cf0
TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c03d4000[3] 'kswapd' mm->pgd c012a000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 1
GPR00: C0007278 C03D5DE0 C03D4000 00000011 00000000 00000000 00000000 C0140C18
GPR08: 000F3F26 C0160000 000003F8 C03D5D20 00000000 07F719C0 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 003D5E20 00000000 C0003A98
GPR24: C00057A8 C0140000 C0135314 C0140000 C0100000 00000000 FFFFFFF4 FFFFFFFD
Call backtrace:
C0007278 C00055D0 C00057EC C0003A98 00000000 80097188
Instruction DUMP: 309fffff  7c842110  548606bc <7cbee82e> 548406ba
60840020  60c6
 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

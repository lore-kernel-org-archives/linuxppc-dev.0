Date: Tue, 26 Jan 1999 00:02:36 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: 2.2.0 SMP kswapd okay, but rpciod crashes
In-Reply-To: <Pine.LNX.3.96.990125190836.12469A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.04.9901252133110.27126-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



2.2.0 fixes the kswapd crashes, but nfs has some problems in rpciod.

(as you can see I haven't finished the IPI support ;)

The crash occures at 
<rpciod_tcp_dispatcher+1568>		lwz r0,16256(r21)

This appears to be a problem with r20, r21, and r22 getting trashed
somewhere. This is supposed to be loading rpc_debug into r0.

If comment out #define RPC_DEBUG in linux/include/linux/sunrpc/debug.h,
and fix a couple of nfs-related stuff, nfs works without crashing again.

 NIP: C0090724 XER: 20000000 LR: C00906D0 REGS: c6e8fe20 TRAP : 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c6e8e000[311] 'rpciod' mm->pgd c012a000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 1
GPR00: 00000000 C6E8FF10 C6E8E000 0000001F C0143ADC C0143ADC 00000002 C01450E0
GPR08: 00000000 FFFFFFF5 00000000 3FEBAF20 82242428 018529A0 00000001 00000000
GPR16: 00000000 00000000 0184D3A0 0184D3B0 00009032 0184D3E0 0184D3C0 00000000
GPR24: 0184D3C0 C0143F64 C0140000 C0140000 C0140000 FFFFFFF5 00000001 C0140000
Call backtrace:
C00906D0 C00093E8
Instruction DUMP: 40820008  901c0e0c  3ae00000 <80153f80> 70070001 4182001c
	3c60c011  80bc0e0c  80dc0e18
Kernel panic: kernel access of bad area pc c0090724 lr c00906d0 address
1851360 ts
k rpciod/311

Message from syslogd@kalmia at Mon Jan 25 21:53:30 1999 ...
kalmia kernel: KOpenPIC IPI support not done yet!!
ernel panic: kerRebooting in 180 seconds..nel access of bad area pc
c0090724 lr c0
0906d0 address 1851360 tsk rpciod/311

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

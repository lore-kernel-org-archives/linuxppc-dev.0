Date: Mon, 22 Feb 1999 16:19:17 +0100 (MET)
From: Marc Dejardin <Marc.Dejardin@cern.ch>
Reply-To: Marc Dejardin <Marc.Dejardin@cern.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel panic with kernel 2.2.1
Message-ID: <Pine.A41.3.95a.990222150156.146678A-100000@rsplus05.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I have experienced kernel panics with kernel 2.2.1
when I run X. I got a beep and then everything freezed.
In the /ver/log/messages file I have found the following :

 NIP: C00D56B0 XER: 00000000 LR: C00D1998 REGS: c1e69c90 TRAP: 0300
 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
 TASK = c1e68000[322] 'X' mm->pgd c1e67000 Last syscall: 142 
 last math c483c000
 GPR00: 00000000 C1E69D80 C1E68000 C200F100 C200F970 00000000 C1ADC86C 00000010 
 GPR08: 00000010 C200F000 00000000 00000001 0000009C 01A87568 01A80000 215C7C5A 
 GPR16: 01A8B3AC 01A8B52C 01A80000 01A80000 00009032 00000001 C1E69E28 C4227000 
 GPR24: 0000000F 00000028 00000000 00000000 C1E69D88 C1E69E08 C1C83560 C200F000 
 Call backtrace: 
 C008B274 C00D1998 C00358C4 C0035D20 C0007E80 C00038AC 01837B64  0180E1D4 01822310 01801BD4 
 Instruction DUMP: 38000000  3b810008  901c0004 <801b0084> 2c000000  41820150 3bbb0970  7fe000a6  4bf329ad 
 Kernel panic: kernel access of bad area pc c00d56b0 lr c00d1998 address 84 tsk X/322

Call traceback in System.map :
C008B274: c008b220 T tcp_poll
C00D1998: c00d18e8 t tty_poll
C00358C4: c00357a4 T do_select
C0035D20: c00359e0 T sys_select
C0007E80: c0007dcc T ppc_select
C00038AC: c00038ac T syscall_ret_1

C00D56B0: c00d5688 T tty_wait_until_sent

If somebody could help me to debug this problem, I would apreciate very much !
It seems that this problem occur with all kernels > 2.1.1xx
and If I run with 2.1.24 everything is very stable.

 thanks in advance...
                                 Marc Dejardin

PS: If it stays like that, I will not be able to run the R5 release that I have
already ordered... 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

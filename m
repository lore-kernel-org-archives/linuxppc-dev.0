MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC5200Lite performances
Date: Tue, 25 May 2004 19:09:48 +0200
Message-ID: <5A96167EBCEA8440A48790B5419953AE13C42A@gr-lafayette.lacie.com>
From: "Bertrand Baudet" <bbaudet@lacie.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to get good IO throughput for network and IDE with my
MPC5200Lite board but for now I only have poor performances.

I got an answer from Wolfgang Denk regarding the MPC5200Lite board
issues and I would like to have more technical information.

The issues are:
* The FEC is working in HD mode and not in full duplex!
* No IDE DMA transfers because IDE DMA conflicts with the FEC driver.

It looks like the issues are known problem and it is being worked on.
What are exactly the issues here? Is it more hardware issues that need a
software workaround? Or is it just the driver that is buggy/not
optimized?
What are the tracks that are investigated to fix the issues?

Is there any idea on when those issues are going to be resolved? (Less
than a month or more than 6 months?)


I tried the linuxppc_2_4_devel tree from cvs.denx.de and I got a kernel
panic. Is that a result from the conflict between the FEC driver and the
IDE?

Probing IDE interface ide0...
hda: WDC WD800BB-00DKA0, ATA DISK drive
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
Oops: kernel access of bad area, sig: 11
NIP: C00EBD10 XER: 20000000 LR: C00EB2F0 SP: C0357E10 REGS: c0357d60
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 22000000
TASK = c0356000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000001 C0357E10 C0356000 C0362860 000000F0 00000000 C0357E78
0000000A
GPR08: C01CC524 00000000 C0362860 000000F0 24004048 FFF7FEFF 03FBA000
007FFF94
GPR16: 00000000 00000001 007FFF00 03FB4E70 003FF000 00000000 00000002
03F51BF0
GPR24: C01CC528 C0357E78 00000000 C01AEC50 00000000 C0362860 C0357E78
C0362860
Call backtrace:
C0013D24 C00EFBC4 C00EF914 C00EF854 C00EBBE8 C00EB164 C01C60B8
C01B963C C01B9688 C0003970 C00082B8
Kernel panic: Attempted to kill init!
 <0>Rebooting in 1 seconds..


Regards,
Bertrand

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: 2.4.13-pre5 crash when mounting proc
Date: Mon, 22 Oct 2001 07:40:29 +0200
Message-ID: <2C5637A6A7CE844EA3C0A94565479F520BCCC4@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: "Stefan Jeglinski" <jeglin@4pi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have the same error here with an old iBook, but

  mount -t proc ...

    segfaults

I have a special iBook configuration missing /devpts
and some other features. I boot using an (older) yaboot
from a HFS+ Partition. My installation is basesd on Suse
7.0 (waiting for 7.2 ...)

I can "boot" until a login, but the machine is
(due to misssing /proc) almost unusable.

As of now I can't put my .config or dmesg or whatever
onto some public server, please email me for the complete
details:

Snippet from dmesg:
------------------------------------------------------------------------
-------
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.c4
input2: ADB HID on ID 7:7.1f
ADB mouse at 3, handler set to 4 (trackpad)
input3: ADB HID on ID 3:3.01
adb: finished probe task...
floating point used in kernel (task=c7fa2000, pc=c015f490)
Oops: kernel access of bad area, sig: 11
NIP: C015F490 XER: 00000000 LR: C00522D8 SP: C7FA3EF0 REGS: c7fa3e40
TRAP: 0300
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 000032B8, DSISR: 40000000
TASK = c7fa2000[19] 'mount' Last syscall: 21
last math c7fa2000 last altivec 00000000
GPR00: 00000080 C7FA3EF0 C7FA2000 00000084 01822FFC 00000000 C7F4B8CC
00000000
GPR08: 00000000 00000000 00000000 00000004 30026B70 018284EC 00000000
00000000
GPR16: 7FFFFC8C 7FFFFC98 7FFFFC88 00000000 00009032 07FA3F40 00000000
C0003C88
GPR24: C0003A00 018226F0 7FFFFECC C7FA3F18 C7F4B000 01822710 01822730
00001000
Call backtrace:
C0052274 C0052540 C0003A5C FFFFFFFF 018024F8 0180349C 01804D48
01805DD4 0170785C 00000000
Adding Swap: 524280k swap-space (priority -1)
floating point used in kernel (task=c7fa2000, pc=c015f4e0)
Oops: kernel access of bad area, sig: 11
NIP: C015F4E0 XER: 00000000 LR: C00522D8 SP: C7FA3EF0 REGS: c7fa3e40
TRAP: 0300
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 000033E4, DSISR: 40000000
TASK = c7fa2000[31] 'mount' Last syscall: 21
last math c7fa2000 last altivec 00000000
GPR00: 00000080 C7FA3EF0 C7FA2000 00000084 0182AFFC 00000000 C7F5D41C
00000000
GPR08: 00000000 00000000 00000000 00000004 30026B70 018284EC 00000000
00000000
GPR16: 7FFFFBAC 7FFFFBB8 7FFFFBA8 00000000 00009032 07FA3F40 00000000
C0003C88
GPR24: C0003A00 01822890 01822870 C7FA3F18 C7F5D000 01822800 0182ABE0
00001000
Call backtrace:
C0052274 C0052540 C0003A5C FFFFFFFF 018024F8 0180349C 01804D48
018053B4 01805B28 0170785C 00000000
floating point used in kernel (task=c7fa2000, pc=c015f4e0)
Oops: kernel access of bad area, sig: 11
------------------------------------------------------------------------
-------
and so on

Mhh, looks like "mount" uses/needs floating point where it should not.
May I need to re-configure somethinging.

Greetings,
	Klaus Halfmann http://klaus.halfmann.bei.t-online.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

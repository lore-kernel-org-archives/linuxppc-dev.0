To: Tom Rini <trini@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Wild Pointer!!!! ( some more info ) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Oct 2001 10:12:39 PDT."
             <20011022101239.K4933@cpe-24-221-152-185.az.sprintbbd.net>
Date: Tue, 23 Oct 2001 00:45:51 +0200
Message-Id: <20011022224556.576D110CD6@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20011022101239.K4933@cpe-24-221-152-185.az.sprintbbd.net> you wrote:
>
> > I see similar effects from linuxppc_2_4_devel (CS 1.592); I've traced
> > a few of them down;  they  are  "strange"  -  usually  it's  a  store
> > operation into a normal variable in BSS.
>
> Can you try 2_4 ?

Did so, cs-1.438 to be precise. It's the same, at least for the  860P
board I tested it on:

...
root@vl:~# mount -t devpts devpts /dev/pts
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C01293FC XER: 00000000 LR: C004CFAC SP: C0AFDEF0 REGS: c0afde40 TRAP: 1000    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0afc000[78] 'mount' Last syscall: 21
last math 00000000 last altivec 00000000
GPR00: 00000100 C0AFDEF0 C0AFC000 C0AD9000 10020FF4 00000000 C0AD9E7C 00000000
GPR08: 00000000 00000000 00000000 00000004 44000088 10026370 00000000 00000000
GPR16: 7FFFFC5C 7FFFFC58 10020000 00000000 00009032 00AFDF40 00000000 C00026E8
GPR24: C0002460 10020138 7FFFFE99 C0AFDF18 C0AD9000 44000088 10020178 00001000
Call backtrace:
C004CF48 C004D214 C00024BC FFFFFFFF 10002604 10003148 10003DD0
10004BA0 0FED9DBC 00000000
Floating point exception

0xc004cf48 -- 0xc004cf10 + 0x0038   copy_mount_options
0xc004d214 -- 0xc004d1e8 + 0x002c   sys_mount
0xc00024bc -- 0xc00024bc + 0x0000   ret_from_syscall_1

Exactly the same place.

But at least GDB can load the vmlinux file...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One possible reason that things aren't going  according  to  plan  is
that there never was a plan in the first place.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

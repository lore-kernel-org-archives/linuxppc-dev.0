Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020510095821.44488.qmail@web15005.mail.bjs.yahoo.com>
Date: Fri, 10 May 2002 17:58:21 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: Re: Why system panic after sometimes? 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020510064334.4B2301195B@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello denk,
I am sorry i have not described clear.
We use HardHat CDK1.2's cross compile.
We use firmware from pSOS's, and just move kernel's
image from flash into sdram then jump to it.

We have not use USB driver yet, I have writed a driver
for a MPEGI coder chip (operate it via data and
address bus).I think my driver (just handle interrupts
from chip) is safe and will not affect kernel
here is ps's output:
# ps -e

  PID TTY          TIME CMD

    1 ?        00:00:15 init

    2 ?        00:00:00 keventd

    3 ?        00:00:02 kswapd  //here sometimes will
change to <defunct>

    4 ?        00:00:00 kreclaimd

    5 ?        00:00:00 bdflush

    6 ?        00:00:01 kupdated

   12 ?        00:00:00 sh

   14 ?        00:00:00 inetd

   77 ?        01:23:54 video_start  //this is our
server application

   80 ?        00:00:00 ps


and i don't know how to decode backtrace?

thanks.



 --- Wolfgang Denk <wd@denx.de> µÄÕýÎÄ£º>
> In message
>
<20020510031854.87945.qmail@web15005.mail.bjs.yahoo.com>
> you wrote:
> >
> > This question has bothered me,I use linux-2.4.4 (
> > downloaded from denx.de and porting to our borad
> > MPC850+4Mflash+32Mram+USB).We run a server
> application
>
> Which version of cross tools are you using?
>
> What firmware is used to initialize the board?
>
> Which device drivers are used? USB???
>
> > in borad,but after sometimes such as about a day
> or
> > even several hours ,system will panic. I check our
> > program, i think there are no memory leak(or it
> will
> > panic in same time) and other fatal error.
> > Here is my dump information:
> >
> > # Oops: Kernel Mode Software FPU Emulation, sig: 8
> > NIP: 00001FFC XER: E0007B7F LR: 0000098C SP:
> C011AE90
> > REGS: c011ade0 TRAP: 1000
> > MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> > TASK = c0118fe0[0] 'swapper' Last syscall: 120
> > last math 00000000 last altivec 00000000
> > GPR00: 00000002 C011AE90 C0118FE0 C011AEA0
> 0035E000
> > C18FDDE8 C0118FE0 00000017
> > GPR08: C0124094 000E711D C18FC000 C014B3E0
> 30026438
> > 100195BC 94FF7FD7 B97FDD3E
> > GPR16: DBFFE6E5 028002E8 FA200000 FFFFFFF6
> 00001032
> > 0011AE90 C000BEDC 00009032
> > GPR24: 00000000 00000001 C18FC000 0020000D
> C03E2190
> > 00002000 C03E2190 C011AF50
> > Call backtrace:
> > C0003800 00009032 C0003E44 C0003E5C C0128750
> C00021E4
> > Kernel panic: Attempted to kill the idle task!
>
> Did you ever try to decode this backtrace? What's
> that C0128750 there?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> "Buy land. They've stopped making it."
>     - Mark Twain
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

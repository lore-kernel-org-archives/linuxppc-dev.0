Message-ID: <3DA704E7.DF667121@esteem.com>
Date: Fri, 11 Oct 2002 10:05:43 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021010230042.GA8690@segfault.usine.8d.com> <3DA62C69.A5BD884F@esteem.com> <20021011155904.GA9579@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First I must appologize, I sent you the stable C code version instead of the
stable inlined asm version. It appears I deleted the wrong file a month or
so ago  :-( . Oh well it appears you like C anyway.




Patrick Mahoney wrote:
>
> Hi Conn,
>
> > I forgot to mention my kernel source tree was directly from kernel.org
>
> Fell free to correct me, but I believe the ppc patched kernel is
> identical to the one at source.mvista.com. Still, I'll try with the
> latest patch (2.4.18) available on kernel.org.
>
> > When using my idle loop, does it crash right away or only when you try to
> > use the PIT?

Strange....... Hmmmm.....


>
> It crashes before I get a chance to load my module. I dont get to the
> shell. It's got nothing to do with the PIT. Here's what my console
> gives me:
>
>         i2c-algo-8xx.o: i2c mpc8xx algorithm module version 2.6.5 (20020915)
>         i2c-rpx.o: i2c MPC8xx module version 2.6.5 (20020915)
>         i2c-algo-8xx.o: scanning bus m8xx...
>         Machine check in kernel mode.
>         Caused by (from SRR1=1000): Transfer error ack signal
>         Oops: machine check, sig: 7
>         NIP: 00004038 XER: 20000000 LR: 0002B91C SP: C0143F30 REGS: c0143e80 TRAP: 0200    Not tainted
>         MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
>         TASK = c0141fa0[0] 'swapper' Last syscall: 120
>         last math 00000000 last altivec 00000000
>         GPR00: 00000000 C0143F30 C0141FA0 00000000 00048000 00000000 00000001 FFFFFC18
>         GPR08: 00000100 C015F00C C014DBFF C014DCEE 0000000D FA202210 00000000 00000000
>         GPR16: 00000000 00000000 00000000 00000000 42004022 00EA5F40 00000000 C0004654
>         GPR24: 00000000 00000000 FA200000 743D2F62 00000000 C0160000 C014DC01 55CCAA32
>         Call backtrace:
>         C0005C94 C0005CA8 C0002268 C0152544 C0002138
>         Kernel panic: Attempted to kill the idle task!
>         In idle task - not syncing
>         <0>Rebooting in 180 seconds..
>
> ... and it normally fives me...
>
>         i2c-core.o: i2c core module version 2.6.5 (20020915)
>         i2c-dev.o: i2c /dev entries driver module version 2.6.5 (20020915)
>         i2c-algo-8xx.o: i2c mpc8xx algorithm module version 2.6.5 (20020915)
>         i2c-rpx.o: i2c MPC8xx module version 2.6.5 (20020915)
>          i2c-algo-8xx.o: scanning bus m8xx...
>         (90)(a8)(aa)
>         i2c-proc.o version 2.6.5 (20020915)
>         CPM UART driver version 0.03
>         ttyS00 at 0x0280 is a SMC
>         eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:33:ce
>
> Hmmm... It seems to oops in the i2c initialisation...
>
> <recompiling...>
>
> Ok. I took out the i2c stuff. It doesn't oops anymore... In fact, in
> enters the power saving mode (doze?) you put in the idle.c file before
> reaching the console! :))

PHEW... Good.


>
> Could be stuck waiting for a never-coming-interrupt? I gave the
> parameter "init=/bin/sash" to the kernel... Any logical explanation to this?
>

Strange you should be getting some intermitant interupts from things such as
the real time clock and other misc things and timers. Hmmm... Must be a RPX
hardware thing or something.


> >       Well if you put the power saving code in the idle loop, when there
> > isn't anything to do the processor sleeps. When an interrupt happens it
> > wakes up to service the interrupt then checks to see if it is needed for
> > other things and if not it goes back to bed (much like me ;-)). If you need
> > to do something 5 seconds later a sleep call should do the trick unless
> > you need more precision.
>
> It's not a precision thing. It's not so important. It would be neat,
> thats all.  :)
>
> Thanks again for your help.
> Best regards,
>
> Pat Mahoney

Well I have no idea whats going on. You should be getting some interrupts.
Unless your RPX board is entering the idle loop before these things get
initalized (which I don't think is possible). This has me stumped...

Good Luck,

	Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <20020606203514.70819.qmail@web11106.mail.yahoo.com>
Date: Thu, 6 Jun 2002 13:35:14 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: Sungem bug or something else?
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020606194518.27675@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Benjamin Herrenschmidt <benh@kernel.crashing.org>
wrote:
> >I encounter an oops during boot bringing up a
> sungem
> >interface. (smp g4 450/gcc 3.1/glibc 2.2.5) If I
> defer
> >bringing up the network at boot, I can successfully
> >start eth0 (sungem) if I start eth1 (tulip) first,
> so
> >it may not be the sungem driver itself. This
> happens
> >on benh 2.4.19-Bpre10, and pre9.
>
> What kind of error is it ? A Machine Check ?
>
> Looking at your backtrace, it looks like the driver
> is
> trying to access the PHY chip. That can sometimes
> happen
> if you have some tool like miitool or ethtool trying
> to
> get at the link status while the chip isn't powered
> up.
>
> The problem here is that sungem on Apple HW only
> powers
> the chip when the interface is brought up, and
> powers it
> down about 10 seconds after bringing the interface
> down.
>
> This improve power management, but kills link
> monitoring
> tools.
>
> There may be also a bug in the driver causing it to
> try
> to access the PHY registers when the chip is in down
> mode & getting the ethtool ioctl's
>
> Ben.
>
>
Ben,
 I suspect your last thought may be correct. From the
oops:
Machine check in kernel mode.
Oops: machine check, sig: 7
NIP: C00DE2A8 XER: 20000000 LR: C00E319C SP: DDBB5E10
REGS: ddbb5d60 TRAP: 0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = ddbb4000[753] 'mii-tool' Last syscall: 54
last math 00000000 last altivec 00000000 CPU: 0

Note mii-tool is running.

The backtrace:

Trace; 02000000 Before first symbol
Trace; c00e319c <gem_ioctl+158/178>
Trace; c01785d0 <dev_ifsioc+414/484>
Trace; c0178850 <dev_ioctl+210/39c>
Trace; c01b6f08 <inet_ioctl+200/20c>
Trace; c016de8c <sock_ioctl+40/ac>
Trace; c005785c <sys_ioctl+13c/338>
Trace; c000601c <ret_from_syscall_1+0/b4>
Trace; 7ffff9e0 Before first symbol
Trace; 100012cc Before first symbol
Trace; 1000195c Before first symbol
Trace; 0fed8d94 Before first symbol
Trace; 00000000 Before first symbol

shows clearly that an ioctl is in progress.

-roger

=====
no microsoft products were used in the production of this email


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

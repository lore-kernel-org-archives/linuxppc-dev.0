Date: Tue, 12 Feb 2002 19:33:17 +0100
From: Werner Almesberger <wa@almesberger.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: performance monitor exceptions
Message-ID: <20020212193317.F5079@almesberger.net>
References: <20020211233730.E5079@almesberger.net> <20020212125502.32396@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020212125502.32396@mailhost.mipsys.com>; from benh@kernel.crashing.org on Tue, Feb 12, 2002 at 01:55:01PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:
>  - I don't know how the perf. mon stuff works, but couldn't you
> enter a condition were the CPU is continuously sending your the
> pef monitor exception until you clear something else ?

No, in a performance monitor exception, PMXE (PM exception enable)
is cleared in MMCR0, and I need to set it explicitly to get another
exception. The only performance event source that's enabled is the
one using the timer base, so this gives me exceptions at 200 Hz,
more if I want.

>  - I encountered a problem with the TAU stuff and the 7400 where
> the CPU could actually get mixed up when getting both a normal
> interrupt and a TAU exception and scew up itself (by taking both
> exceptions and screwing up SRR0/1)

Bingo ! That seems to be the one:

http://www.mot.co.jp/SPS/html/lit/pdf/mpc7410pns_rev0.pdf

  #5:
  Description: Consecutive Performance Monitor, Decrementer,
  or Thermal Management Interrupts may become non-recoverable.

  Work-Around: Avoid enabling any combination of
  Performance Monitor, Decrementer, or Thermal Management
  Interrupts at the same time.

Hmm, working around this will be tricky ...

Thanks a lot !

- Werner

--
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

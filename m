Message-ID: <3CC006F1.5940B04E@imc-berlin.de>
Date: Fri, 19 Apr 2002 14:00:49 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>,
	Frank Przybylski <frank.przybylski@vas-gmbh.de>
Subject: Re: MPC8xx and IDMA !?!?
References: <3CBD321A.60CE328@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To whom it may concern,

> a while ago (aprox. kernel 2.4.11) I succesfully played around with IDMA
> on MPC855/860.
> ...
> The code is NOT working on recent kernels (I pulled it yesterday).
> I set up the IDMA. Trigger DREQ0 using a GPIO pin. SDMACK1 is going LOW
> but then instead of toggeling it just stays LOW. And instead of
> transfering data the MPC8xx just hangs.
>
> Have there been changes in the DPRAM layout ..?

I (think I) figured out the problem:

I use
	m8xx_cpm_dpalloc( sizeof(idma_bd_t) );

to allocate space for the buffer descriptors in the DP ram.

The User Man says "Note that IBASE should be burst-aligned (divisible by
16)"
(Does the English "should be" means "have to be, otherwise everything
goes wrong!"???)

The older kernel versions always returned (by pure accident?) a
burst-aligned address (%16) (e.g. 0x850 offset from dpmem start). So
everything was fine.

The newer kernels return (by pure accident?) a NON burst-aligned address
(e.g. 0x0918) und the IDMA crashes.

So my workaround for now is to allocate more than I need and correct the
value for IBASE like
	ibase += ibase % 16

Could anyone think of a better solution? Since I waste at least 16 bytes
in the DPRAM.

BTW:
Where is Wolfgangs m8xx_cpm_dpfree() !?!?
I can't find it in the recent source trees.

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

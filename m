Message-ID: <20000501101916.E6832@lx.c-side.com>
Date: Mon, 1 May 2000 10:19:16 -0700
From: Neil Russell <caret@c-side.com>
To: Arto Vuori <avuori@ssh.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 io and caches
References: <390DB320.DC787D62@ssh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <390DB320.DC787D62@ssh.com>; from Arto Vuori on Mon, May 01, 2000 at 07:38:56PM +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From what I can see, the uart driver in the current linux source is written
for the 860, with no mods for the 8260.  The 8260 has some different bits
in the RFCR/TFCR parameter RAM fields.  There is a GBL bit (bit 2) that
enables cache snooping.

I'm looking at the 2.3.99-pre5 sources, at about line 2519 in uart.c:

	up->smc_rfcr = SMC_EB;
	up->smc_tfcr = SMC_EB;

change them to:

	up->smc_rfcr = SMC_EB | 0x20;
	up->smc_tfcr = SMC_EB | 0x20;

and see what happens.  Of course, you probably want to add a SMC_GBL
#define to do this properly.


Neil.


On Mon, May 01, 2000 at 07:38:56PM +0300, Arto Vuori wrote:
> I'm currently trying to get linux running on EST SBC8260 board. I had
> some problems with serial ports. Initially it just sent some garbage. I
> found that serial port driver doesn't initialize BRG division factor in
> SCCR register even though it assumes that it should be set to 0. I
> modified my bootloader to initialize it and output looks now much
> better.
>
> There still seems to be some problems with caches. Everything is just
> fine with caches disabled, but if i enable caches output doesn't look
> correct. Adding some flush_dcache_range() calls to uart.c seems to fix
> that problem, but shouldn't rx & tx buffers be allocated from some non
> cacheable region??

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

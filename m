Date: Sun, 30 Mar 2003 17:08:49 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: llandre <r&d@wawnet.biz>
Subject: Re: Script for BDI2000 for IBM 405EP Eval. Board
Message-ID: <20030331010848.GA20162@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <5.1.1.6.0.20030330184543.00a832e0@dns.struinfo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.1.6.0.20030330184543.00a832e0@dns.struinfo.it>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Mar 30, 2003 at 07:52:41PM +0200, llandre wrote:
> 1) Sometimes the processor jumps to 0x700. This usually occurs during the
> execution of a printf function or when the CPU executes a mtmsr
> instruction. For example there is a mtmsr instruction at the end of
> interrupt_init function. I noted that this instruction does not make the
> CPU to jump to 0x700 during the first debug session, I mean just after
> power up, but it does if I start a new debug session without turning off
> and on the board (even the RESET command from telnet nor the reset button
> on the board are useful).
> 2) From telnet I can erase the Flash without any problem, but I can't
> complete its programming. The PROG command crashes at a random address.

According to what I see here, you never set up the SDRAM contoller via
the BDI.  Without that, writing flash using WORKSPACE is pretty unlikely
to work.

> ; Setup SDRAM Controller
> ;WDCR   16      0x00000080      ;Select SDTR1
> ;WDCR   17      0x0086400D      ;SDTR1: SDRAM Timing Register
> ;WDCR   16      0x00000040      ;Select MB0CF
> ;WDCR   17      0x00046001      ;MB0CF: 16MB @ 0x00000000
> ;WDCR   16      0x00000048      ;Select MB2CF
> ;WDCR   17      0x01046001      ;MB2CF: 16MB @ 0x01000000
> ;WDCR   16      0x00000030      ;Select RTR
> ;WDCR   17      0x05F00000      ;RTR: Refresh Timing Register
> ;WDCR   16      0x00000020      ;Select MCOPT1
> ;WDCR   17      0x80800000      ;MCOPT1: Enable SDRAM Controller
>
> ; Setup MMU info
> ;WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
> ;WM32    0x000000f8  0x00000000  ;invalidate process page table base
> ;WM32    0x000000f0  0xc00000f4  ;invalidate page table base

In the interim, you can disable the SDRAM scratch workspace and
you should hopefully be able to write to flash.

At some point though, you're going to have the get the SDRAM setup for
your board done.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <390EEDC5.362C58FB@motorola.com>
Date: Tue, 02 May 2000 10:01:25 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>
CC: Jochen Roth <jochen@znyx.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board boots when in BDM, hangs otherwise
References: <2.2.32.20000501224050.00d776fc@electra.znyx.com> <390E1575.5FED84DD@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lewis wrote:
>
> Hi Josh,
..
> Ther is one register that the IN command sets that it does not tell you about. That
> is the ICTRL register, which controls serialization of the core, among other
> things. On powerup, it is set to SHOW-ALL-INSTRUCTION-FETCH-CYCLES. Some 8xx
> processors have problems with this. Read the errata. Check to make sure you are
> setting ICTRL to something like 0x07 in your firmware.
>
> -Jim

This is also probably the source of your slowdown when running
off of BDM.

Also make sure the watchdog is disabled (Dan's code does this, I think).

If anyone is interested, I can post the startup file I use for
running from flash on the FADS board using Metrowerks.  I finally
figured out a way that I can run the same flash image standalone,
and through MPC8bug.

--
MPC823 Applications Engineering Development

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

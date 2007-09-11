Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18151.2374.68378.969061@cargo.ozlabs.ibm.com>
Date: Wed, 12 Sep 2007 07:31:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] pm: Handle HID0_SLEEP in the TLF_NAPPING hack.
In-Reply-To: <20070905220638.GA11353@ld0162-tx32.am.freescale.net>
References: <20070905220438.GA11283@ld0162-tx32.am.freescale.net>
	<20070905220638.GA11353@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> The e300 core (and probably most other 6xx chips) can only come out of
> sleep mode with an interrupt.  However, interrupts are logically disabled
> by the power management layer.
> 
> This hack extends the existing doze/nap hack to also suppress the running
> of the interrupt handler when in sleep mode.

Having thought about this for a bit, I have come to the conclusion
that it would be a lot cleaner to use a new TLF_SLEEPING bit rather
than having to read HID0 to know whether we were napping or sleeping.
There are plenty of bits left in thread_info.local_flags; we've only
used 1 so far. :)

Paul.

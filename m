Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 305292C0126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 07:03:12 +1000 (EST)
Message-ID: <50048188.8060409@freescale.com>
Date: Mon, 16 Jul 2012 16:03:04 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
 <CAOZdJXVMdr4MzH56FLKaQCk5FAfSpEQ9crka93djeMiU3s_FtA@mail.gmail.com>
 <CA+5PVA7WSTK9Ad7yocSrsnFcsp7L1hyzJjKrWkKU7Yak=2ZoZg@mail.gmail.com>
In-Reply-To: <CA+5PVA7WSTK9Ad7yocSrsnFcsp7L1hyzJjKrWkKU7Yak=2ZoZg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jiang Lu <lu.jiang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer wrote:

> I have no idea about FSL cores, but the 4xx maximum value selects TBU
> bit 31.  When that bit flips is going to be determined by the speed of
> the clock driving TB.  Most of the 4xx implementations I have seen use
> the CPU clock, so to take the example from the 44x user manuals, a 400
> MHz clock results in a maximum time period of ~21 seconds.  Multiply
> by 3 to get the time before the WDT actually does a reset and you're
> at about 1min.

Ah, that is a problem.

> NOWAYOUT is working.  The patch was basically forcing it on, even if
> the end user doesn't want the behavior described.  From what you've
> said, that simply doesn't matter in the FSL case because the machine
> will run for a really long time.  On 4xx, something needs to be done
> to keep the machine running if the user doesn't want the NOWAYOUT
> behavior, which is why I suggested a kernel timer.

Yes, I agree now -- a kernel timer is a better idea.  And it doesn't need
to be 4xx-specific.  Although, I wonder if it's the time is reliable enough.

We already have an exception handler:

#ifdef CONFIG_BOOKE_WDT
/*
 * Default handler for a Watchdog exception,
 * spins until a reboot occurs
 */
void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
{
	/* Generic WatchdogHandler, implement your own */
	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
	return;
}

void WatchdogException(struct pt_regs *regs)
{
	printk (KERN_EMERG "PowerPC Book-E Watchdog Exception\n");
	WatchdogHandler(regs);
}
#endif

Maybe instead of disabling interrupts, we should ping the watchdog instead?

-- 
Timur Tabi
Linux kernel developer at Freescale

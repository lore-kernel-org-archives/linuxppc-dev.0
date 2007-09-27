Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id 239FCDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 04:12:36 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so527277ele
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 11:12:35 -0700 (PDT)
Message-ID: <9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
Date: Thu, 27 Sep 2007 14:12:34 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
In-Reply-To: <200709271907.50479.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<200709271907.50479.jbe@pengutronix.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/27/07, Juergen Beisert <jbe@pengutronix.de> wrote:
> On Friday 10 August 2007 11:51, Domen Puncer wrote:
> > Not for merge (yet)! But please do review.
> >
> > fec_mpc52xx driver (not in-tree, but floating around) isn't in very
> > good shape, so I tried to change that.
> > Diff against original is quite big (fec_phy.c is completely rewritten)
> > and confuzing, so I'm including whole drivers/net/fec_mpc52xx/ .
> >
> > I still have 'make CONFIG_FEC_MPC52xx_MDIO=n compile and work' on my
> > TODO, maybe even ethtool support.
>
> Currently I'm trying with your fec driver and Sylvain Munaut's bestcomm driver
> *and* rt-preemt 2.6.23-rc8-rt1 and now I'm getting this error while stress
> test the network:
>
> BUG: scheduling while atomic: softirq-timer/0/0x00000002/5, CPU#0
> Call Trace:
> [c0309e00] [c0007ddc] show_stack+0x3c/0x194 (unreliable)
> [c0309e30] [c0017934] __schedule_bug+0x38/0x48
> [c0309e40] [c01c8f24] __schedule+0x3e8/0x428
> [c0309e70] [c01c96d4] schedule+0x54/0xf0
> [c0309e80] [c01c9e8c] schedule_timeout+0x68/0xe4
> [c0309ec0] [c00282dc] msleep+0x1c/0x34
> [c0309ed0] [c0125fb8] fec_stop+0xbc/0x1a8
> [c0309ef0] [c0126530] fec_reset+0x20/0xb0
> [c0309f10] [c0127840] fec_tx_timeout+0x3c/0xa4
> [c0309f30] [c016b5dc] dev_watchdog+0x13c/0x14c
> [c0309f50] [c0027c90] run_timer_softirq+0x2e4/0x444
> [c0309f90] [c00239a4] ksoftirqd+0x134/0x214
> [c0309fd0] [c0034d94] kthread+0x48/0x84
> [c0309ff0] [c000f828] kernel_thread+0x44/0x60
>
> Do you have an idea what happens?

The call to msleep() is inside a block protected with
:#define in_interrupt()          (irq_count())
if (!in_interrupt)

The stack trace looks like it is in a timer interrupt so shouldn't
irq_count be non-zero?
Could there be some lack of coordination on irq_count and the timer
tick with the preempt patch applied?  Or does irq_count() not count
soft irqs?

(!in_interrupt) may be the wrong way to protect this code.

-- 
Jon Smirl
jonsmirl@gmail.com

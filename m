Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18163.20403.967082.774118@cargo.ozlabs.ibm.com>
Date: Fri, 21 Sep 2007 14:59:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
In-Reply-To: <1190347546.15347.27.camel@imap.mvista.com>
References: <20070921032603.07AF232C889@thor>
	<1190347546.15347.27.camel@imap.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Daniel Walker writes:

> I don't think the RTC frequency isn't the same as the timebase? Seems
> like the RTC only case about seconds at the lowest level. If that's the
> case then the jiffies clock might be better to use .. The other thing I
> wonder is if the __USE_RTC boards might have lower level clocks that
> could be used instead ..

It's OK, the RTC isn't what you think it is, it's a pair of
CPU-internal registers which count seconds and nanoseconds.  On
processors with the RTC, tb_ticks_per_sec is initialized to
1000000000.  Trust me, this code is OK. :)

Paul.

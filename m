Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 1A76DDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 03:31:29 +1000 (EST)
Subject: Re: [RFC] clocksouce implementation for powerpc
From: Thomas Gleixner <tglx@linutronix.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <467961F1.1060909@ru.mvista.com>
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>
	<1182009083.11539.369.camel@imap.mvista.com>
	<20070620065710.GR9768@bakeyournoodle.com>
	<1182351439.18168.79.camel@imap.mvista.com>
	<467961F1.1060909@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 19:31:21 +0200
Message-Id: <1182360681.3316.25.camel@chaos>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
	john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-20 at 21:20 +0400, Sergei Shtylyov wrote:
> >>+void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
> >>+{
> >>+	timer_recalc_offset(tb_last_jiffy);
> >>+	timer_check_rtc();
> >>+}
> 
> > Hmm .. This doesn't look like it's taking into account that the time has
> > changed ..
> 
>     Why? By the time it gets called (form the timer softirq context) 

It is called from interrupt context at least in mainline. Only the -rt
patch moves this to the softirq.

	tglx

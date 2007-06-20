Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CA5F9DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 04:10:17 +1000 (EST)
Message-ID: <46796DEE.5090206@ru.mvista.com>
Date: Wed, 20 Jun 2007 22:11:58 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] clocksouce implementation for powerpc
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>	
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>	
	<1182009083.11539.369.camel@imap.mvista.com>	
	<20070620065710.GR9768@bakeyournoodle.com>	
	<1182351439.18168.79.camel@imap.mvista.com>	
	<467961F1.1060909@ru.mvista.com> <1182360681.3316.25.camel@chaos>
In-Reply-To: <1182360681.3316.25.camel@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Thomas Gleixner wrote:

>>>>+void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
>>>>+{
>>>>+	timer_recalc_offset(tb_last_jiffy);
>>>>+	timer_check_rtc();
>>>>+}
>>
>>>Hmm .. This doesn't look like it's taking into account that the time has
>>>changed ..
>>
>>    Why? By the time it gets called (form the timer softirq context) 
> 
> 
> It is called from interrupt context at least in mainline. Only the -rt
> patch moves this to the softirq.

    Anyway, by the time it gets called, tb_last_jiffy gets updated.

> 	tglx

WBR, Sergei

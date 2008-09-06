Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 6AE50DDDE0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 15:09:08 +1000 (EST)
Message-Id: <20080906050602.409299112@goodmis.org>
Date: Sat, 06 Sep 2008 01:06:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ftrace: fixes for PPC
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I spent the day chasing a bug that would hang PPC on boot up when ftrace
is configured in. I found that it was simply a stupid bug I did to
handle the non MCOUNT_RECORD case. Since I was testing only on x86,
and the MCOUNT_RECORD is automatically set for dynamic ftrace if
it is available, I did not test the case where MCOUNT_RECORD was not
set.

I have not finished porting MCOUNT_RECORD to PPC, but have found
that it has caused some issues for archs that do not support it yet.

This patch series handles these cases.

-- Steve

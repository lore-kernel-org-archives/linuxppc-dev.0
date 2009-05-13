Return-Path: <zbr@ioremap.net>
Received: from tservice.net.ru (matrixpower.ru [195.178.208.66])
	by ozlabs.org (Postfix) with ESMTP id 831A2DDF9B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 16:15:01 +1000 (EST)
Date: Wed, 13 May 2009 09:55:11 +0400
From: Evgeniy Polyakov <zbr@ioremap.net>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: question about softirqs
Message-ID: <20090513055511.GA8529@ioremap.net>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<1242119578.11251.321.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242119578.11251.321.camel@twins>
Cc: netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

On Tue, May 12, 2009 at 11:12:58AM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> Wouldn't the even better solution be to get rid of softirqs
> all-together?

And move tasklets into some thread context?

Only if we are ready to fix 7 times rescheduling regressions compared to
kernel threads (work queue actually). At least that's how tasklet
behaved compared to work queue 1.5 years ago in the simplest
and quite naive test where tasklet/work rescheduled iself number of
times:

http://marc.info/?l=linux-crypto-vger&m=119462472517405&w=2

-- 
	Evgeniy Polyakov

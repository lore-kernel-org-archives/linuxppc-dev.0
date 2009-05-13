Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 85B01DDFA4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 15:28:54 +1000 (EST)
Date: Tue, 12 May 2009 22:28:48 -0700 (PDT)
Message-Id: <20090512.222848.152842353.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: question about softirqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <18954.22390.754419.803434@cargo.ozlabs.ibm.com>
References: <20090512092348.GA29796@elte.hu>
	<20090512.214427.193728136.davem@davemloft.net>
	<18954.22390.754419.803434@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: a.p.zijlstra@chello.nl, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	rostedt@goodmis.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 13 May 2009 15:15:34 +1000

> David Miller writes:
> 
>> I fully expected us to be, at this point, talking about putting the
>> pending softirq check back into the trap return path :-/
> 
> Would that actually do any good, in the case where the system has
> decided that ksoftirqd is handling soft irqs at the moment?

Even if ksoftirqd is running, we check and run pending softirqs from
trap return.

Sure, I imagine we could re-enter this "ksoftirq blocked by highprio
thread" situation if we get flooded every single time over and over
again.

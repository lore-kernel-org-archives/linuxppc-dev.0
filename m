Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id ECBFADDDA2
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 16:48:22 +1000 (EST)
Date: Fri, 08 May 2009 23:48:15 -0700 (PDT)
Message-Id: <20090508.234815.127227651.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: question about softirqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
References: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>
	<20090508.165358.97542490.davem@davemloft.net>
	<18948.63755.279732.294842@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 9 May 2009 13:31:23 +1000

> David Miller writes:
> 
>> Grumble, when did that happen :-(
> 
> Ages ago (i.e. before the switch to git :).  Talk to Ingo, it's his
> doing IIRC.

I'll first do some data mining before coming to any (further)
conclusions :-)

>> That's horrible for latency compared to handling it directly
>> in the trap return path.
> 
> Actually, I don't know why we ever let there be softirqs pending when
> we're in process context.  I would think that we should just call
> do_softirq immediately if we raise a softirq when !in_interrupt().
> But I might be missing some subtlety.

I bet it was a non-starter before IRQ stacks.

It does seem like a good idea to me.

You know, for networking over loopback (one of the only real cases
that even matters, if we get a hard interrupt then the return from
that would process any softints), we probably make out just fine
anyways.  As long as we hit a local_bh_enable() (and in the return
path from device transmit that's exceedingly likely as all of the
networking locking is BH safe) we'll run the softints from that and
thus long before we get to syscall return.

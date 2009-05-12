Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 95357DDF7B
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 10:43:44 +1000 (EST)
Message-ID: <4A08C62F.1050105@nortel.com>
Date: Mon, 11 May 2009 18:43:27 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: question about softirqs
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>	<20090508.234815.127227651.davem@davemloft.net>	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
In-Reply-To: <20090511.162436.193717082.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This started out as a thread on the ppc list, but on the suggestion of
DaveM and Paul Mackerras I'm expanding the receiver list a bit.

Currently, if a softirq is raised in process context the
TIF_RESCHED_PENDING flag gets set and on return to userspace we run the
scheduler, expecting it to switch to ksoftirqd to handle the softirqd
processing.

I think I see a possible problem with this. Suppose I have a SCHED_FIFO
task spinning on recvmsg() with MSG_DONTWAIT set. Under the scenario
above, schedule() would re-run the spinning task rather than ksoftirqd,
thus preventing any incoming packets from being sent up the stack until
we get a real hardware interrupt--which could be a whole jiffy if
interrupt mitigation is enabled in the net device.

DaveM pointed out that if we're doing transmits we're likely to hit
local_bh_enable(), which would process the softirq work.  However, I
think we may still have a problem in the above rx-only scenario--or is
it too contrived to matter?

Thanks,

Chris

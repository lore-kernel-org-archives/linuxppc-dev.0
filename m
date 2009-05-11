Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A46DFDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 04:26:17 +1000 (EST)
Message-ID: <4A086DB2.8040703@nortel.com>
Date: Mon, 11 May 2009 12:25:54 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: question about softirqs
References: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>	<20090508.165358.97542490.davem@davemloft.net>	<18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
In-Reply-To: <20090508.234815.127227651.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:

> You know, for networking over loopback (one of the only real cases
> that even matters, if we get a hard interrupt then the return from
> that would process any softints), we probably make out just fine
> anyways.  As long as we hit a local_bh_enable() (and in the return
> path from device transmit that's exceedingly likely as all of the
> networking locking is BH safe) we'll run the softints from that and
> thus long before we get to syscall return.

What about the issue I raised earlier?  (I don't think you were copied
at that point.)

Suppose I have a SCHED_FIFO task spinning on recvmsg() with MSG_DONTWAIT
set (and maybe doing other stuff if there are no messages). In this
case, schedule() would re-run the spinning task rather than running
ksoftirqd. This could prevent any incoming packets from actually being
sent up the stack until we get a real hardware interrupt--which could be
a whole jiffy if interrupt mitigation is enabled in the net device.
(And maybe longer if NOHZ is enabled.)

Chris

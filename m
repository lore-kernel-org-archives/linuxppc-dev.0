Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57C01DDF85
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 09:34:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18952.46585.142619.53608@cargo.ozlabs.ibm.com>
Date: Tue, 12 May 2009 09:34:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: question about softirqs
In-Reply-To: <4A086DB2.8040703@nortel.com>
References: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>
	<20090508.165358.97542490.davem@davemloft.net>
	<18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> Suppose I have a SCHED_FIFO task spinning on recvmsg() with MSG_DONTWAIT
> set (and maybe doing other stuff if there are no messages). In this
> case, schedule() would re-run the spinning task rather than running
> ksoftirqd. This could prevent any incoming packets from actually being
> sent up the stack until we get a real hardware interrupt--which could be
> a whole jiffy if interrupt mitigation is enabled in the net device.

I suggest you ask Ingo Molnar about that.

> (And maybe longer if NOHZ is enabled.)

We still have a timer interrupt every jiffy when stuff is running; we
only turn off the timer interrupts when idle.

Paul.

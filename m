Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 496E8DDF9F
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 13:31:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
Date: Sat, 9 May 2009 13:31:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: question about softirqs
In-Reply-To: <20090508.165358.97542490.davem@davemloft.net>
References: <4A04B76D.20106@nortel.com>
	<18948.49541.735156.176919@cargo.ozlabs.ibm.com>
	<20090508.165358.97542490.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> Grumble, when did that happen :-(

Ages ago (i.e. before the switch to git :).  Talk to Ingo, it's his
doing IIRC.

> That's horrible for latency compared to handling it directly
> in the trap return path.

Actually, I don't know why we ever let there be softirqs pending when
we're in process context.  I would think that we should just call
do_softirq immediately if we raise a softirq when !in_interrupt().
But I might be missing some subtlety.

Paul.

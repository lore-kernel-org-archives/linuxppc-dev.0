Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9C0CCDDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 23:40:00 +1000 (EST)
Message-ID: <464DAD06.2060504@ru.mvista.com>
Date: Fri, 18 May 2007 17:41:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>	<464CB071.5050504@ru.mvista.com>	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>	<464CB460.40905@ru.mvista.com>	<97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>	<1179464690.32247.370.camel@localhost.localdomain>	<1179466769.3658.0.camel@localhost.localdomain>
	<1179472096.32247.394.camel@localhost.localdomain>
In-Reply-To: <1179472096.32247.394.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	Dave Liu <r63238@freescale.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>>>Yes, on some implementations there can be other conditions that
>>>>make a decrementer exception go away; there is no contradiction
>>>>here (thankfully).  My wording was sloppy.

>>>Some CPUs have the DEC exceptions basically edge triggered (yeah I know

>>for example?

>>>it sucks). That's why, among others, the IRQ soft-disable code has code
>>>to re-trigger DEC exceptions ASAP (by setting it to 1.. note that we
>>>could probably use 0 here, we've been a bit conservative).

    Yeah, the classic decrementer is programmed off-by-one.

> I'm not 100% certain... Paulus thinks all the old 6xx are like that, and
> maybe POWER4. If I look at the oldest BookIV I can find (the 601), it

    From the "PowerPC Operating Environment Architecture" that I've already 
quoated t follows that POWER4-compatible decremented exception *must* be edge 
triggered.

> says that an exception is generated when the MSB transitions from 0 to
> 1. It's not clear wether the exception sticks while that bit is 1 or is

    Freescale MPC 7450 manual says the same, for example.

> indeed considered as an "edge" event that gets cleared as soon as
> delivered.

> Ben.

WBR, Sergei

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00457DE055
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:25:06 +1100 (EST)
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 11:24:57 +1100
Message-Id: <1236731097.7086.32.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-10 at 19:22 -0500, Timur Tabi wrote:
> 
> Alan did have one valid point though.  Determining how long to loop
> for is architecture-specific.  Using jiffies is bad, because even one
> jiffy is too long.  Adding a udelay() inside the loop means that it
> only checks he condition every microsecond.  So the real solution is
> to use keep looping until a certain amount of time has passed.  This
> means using an architecture-specific timebase register.

> Now we can create a generic version of the function that uses jiffies,
> and then arch-specific versions where possible.  But Alan still needs
> to be convinced.  I already posted a length rebuttal to his email, but
> I haven't gotten a reply yet.
> 
There are several aspects here:

 - The amount of time to wait should be specified by the caller since
it's generally going to come from HW specs

 - The amount of time between the polls ... that could also be an
argument to the macro, not sure there

 - The precision of the actual wait calls... I vote for microseconds for
everything and udelay. The arch will do its best.

Cheers,
Ben.

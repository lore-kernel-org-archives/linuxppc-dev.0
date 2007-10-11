Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14FE1DE0D4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:58:58 +1000 (EST)
Subject: Re: [PATCH] Make clockevents work on PPC601 processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <96C1AFB8-784F-445E-A3F2-5D68494541CD@kernel.crashing.org>
References: <18190.3365.54961.935346@cargo.ozlabs.ibm.com>
	<96C1AFB8-784F-445E-A3F2-5D68494541CD@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 06:58:52 +1000
Message-Id: <1192136332.8476.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-11 at 09:12 -0500, Kumar Gala wrote:
> On Oct 11, 2007, at 6:46 AM, Paul Mackerras wrote:
> 
> > In testing the new clocksource and clockevent code on a PPC601
> > processor, I discovered that the clockevent multiplier value for the
> > decrementer clockevent was overflowing.  Because the RTCL register in
> > the 601 effectively counts at 1GHz (it doesn't actually, but it
> > increases by 128 every 128ns), and the shift value was 32, that meant
> > the multiplier value had to be 2^32, which won't fit in an unsigned
> > long on 32-bit.  The same problem would arise on any platform where
> > the timebase frequency was 1GHz or more (not that we actually have any
> > such machines today).
> 
> do you still have a 601 running somewhere?

On my desk :-) (and he also has a 601 card for the 7500 iirc)

/me remembers to revive his dual 604 8500 one of these days.

Ben.

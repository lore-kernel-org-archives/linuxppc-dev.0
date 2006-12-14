Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D9A4367CAA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:07:34 +1100 (EST)
Date: Wed, 13 Dec 2006 19:06:59 -0600
From: Olof Johansson <olof@lixom.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Message-ID: <20061213190659.7922c15e@pb15>
In-Reply-To: <1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
	<20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Dec 2006 11:59:00 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:

> Nah I didn't make it U3/U4 specific, although I could. If we do that,
> then I think the logic needs to be:
> 
> if get_property("msi_available")
> 	mpic_msi_reserve_dt_irqs()
> elif is_u3_or_u4()
> 	mpic_msi_reserve_u3u4_irqs()
> else
> 	return error
> 
> Because if we don't have a firmware property, and we don't make an
> educated guess at what's reserved, then there's a very good chance our
> first MSI will get hwirq 0 and that it won't work.

Looks like a good solution to me.

> As far as putting hacks in the MPIC driver .. have you read it
> lately? ;)  But seriously, I think if there's anyway these magic numbers
> should be, it is in this code, not the platform code.

It used to be fairly OK, but the TSI merge really pushed it over the
edge, obfuscation-wise. :(

But that's no excuse to make it worse than it has to be.


-Olof

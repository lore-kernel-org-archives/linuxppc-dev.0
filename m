Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A99E67C7A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:02:42 +1100 (EST)
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 12:02:28 +1100
Message-Id: <1166058148.11914.255.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> if get_property("msi_available")
> 	mpic_msi_reserve_dt_irqs()

available-msi is a better name now that I think of it, or better even:
"msi-ranges"

> elif is_u3_or_u4()
> 	mpic_msi_reserve_u3u4_irqs()
> else
> 	return error
> 
> Because if we don't have a firmware property, and we don't make an
> educated guess at what's reserved, then there's a very good chance our
> first MSI will get hwirq 0 and that it won't work.
> 
> As far as putting hacks in the MPIC driver .. have you read it
> lately? ;)  But seriously, I think if there's anyway these magic numbers
> should be, it is in this code, not the platform code.

Ben.

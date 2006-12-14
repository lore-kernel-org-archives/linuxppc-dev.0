Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0EB9567C88
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 11:33:06 +1100 (EST)
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061213180921.487b1cea@pb15>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:32:53 +1100
Message-Id: <1166056373.11914.246.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So make the platform register the range of (possibly) usable MSI
> addresses instead of adding a nasty hack like that to the mpic driver.

The hack is not that nasty... it's only ever run on U3/U4 on which it's
actually correct, at least if Michael did what I told him to do which is
to test the MPIC_BROKEN_U3 bit :-)

> Adding numeric constants like that (completely without comments as to
> where they came from) in a function called
> mpic_msi_auto_reserve_hwirqs() is just too ugly.

Yes, it should be mpic_msi_reserve_u3u4_irqs() or something like that.

Ben.

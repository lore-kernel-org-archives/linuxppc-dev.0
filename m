Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EB10567C1E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 11:10:01 +1100 (EST)
Date: Wed, 13 Dec 2006 18:09:21 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Message-ID: <20061213180921.487b1cea@pb15>
In-Reply-To: <1166052344.11914.233.camel@localhost.localdomain>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
	<20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Mackerras <paulus@samba.org>, Paul
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Dec 2006 10:25:44 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> This code in MPIC currently is only ever used on U3/U4 and so that code
> reserves IRQs we know are used for U3/U4 internal IRQs and not available
> for HT interrupts (or MSIs). The code, then, does a second pass also
> exclusing all IRQs for all devices in the device-tree.
> 
> This is a "hack" that works until device-trees provide the right
> property we have defined for mpic to indicate what range of irqs is to
> be used for MSIs.

So make the platform register the range of (possibly) usable MSI
addresses instead of adding a nasty hack like that to the mpic driver.

Adding numeric constants like that (completely without comments as to
where they came from) in a function called
mpic_msi_auto_reserve_hwirqs() is just too ugly.


-Olof

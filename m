Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95A15DDF06
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 15:00:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m81507Xc027294
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 01:00:07 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m81505wh049798
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 23:00:05 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m81503qq019352
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 23:00:04 -0600
Date: Sun, 31 Aug 2008 22:00:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] prevent powerpc from invoking irq handlers on offline CPUs
Message-ID: <20080901050003.GN7015@linux.vnet.ibm.com>
References: <20080831173127.GA15296@linux.vnet.ibm.com>
	<1220229284.13162.411.camel@pasglop>
	<20080901020640.GM7015@linux.vnet.ibm.com>
	<1220238880.13010.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220238880.13010.4.camel@pasglop>
Cc: tnt@246tNt.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 01, 2008 at 01:14:40PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2008-08-31 at 19:06 -0700, Paul E. McKenney wrote:
> > On Mon, Sep 01, 2008 at 10:34:44AM +1000, Benjamin Herrenschmidt wrote:
> > > On Sun, 2008-08-31 at 10:31 -0700, Paul E. McKenney wrote:
> > > > Make powerpc refrain from clearing a given to-be-offlined CPU's bit in the
> > > > cpu_online_mask until it has processed pending irqs.  This change
> > > > prevents other CPUs from being blindsided by an apparently offline CPU
> > > > nevertheless changing globally visible state.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > ---
> > > 
> > > Sounds reasonable... the only possible worry here is if somebody tries
> > > an IPI ... The IPI code will and the target CPU mask with the online
> > > map, so it may try to send to the to-be-offlined CPU and timeout, no ?
> > 
> > OK.  Do we need separate IPI and online masks?
> 
> Shouldn't we already have routed all interrupts to other CPUs anyway ?
> 
> IE. The affinity of all interrupts should have been updated. So the
> only thing we're going to get here are possibly IPIs and decrementer, 
> I don't see it being a big deal making sure we test we are online when
> receiving it.

It did look to me that the CPU removed itself from the interrupt queue
before re-enabling interrupts, so makes sense to me...

							Thanx, Paul

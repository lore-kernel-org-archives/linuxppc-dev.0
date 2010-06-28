Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD419B6EED
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 02:49:11 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5SGa9Yp017085
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 12:36:09 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5SGn8uU122110
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 12:49:08 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5SGn70k011285
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 12:49:08 -0400
Date: Mon, 28 Jun 2010 09:49:06 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG: scheduling while atomic: swapper/0/0x00000002
Message-ID: <20100628164906.GA6667@linux.vnet.ibm.com>
References: <20100609215229.GA12774@linux.vnet.ibm.com>
	<1276125608.1962.0.camel@pasglop>
	<20100610010854.GA11432@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100610010854.GA11432@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 06:08:54PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 10, 2010 at 09:20:08AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2010-06-09 at 14:52 -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > I get the following during boot on a 16 CPU Power box.  Thoughts?
> > > (/proc/config attached)
> > 
> > Wow... looks like the preempt count of the idle task got busted or
> > something ... how reproduceable ? Something like a record of previous
> > interrupts might be useful..
> 
> I have seen it only once, but it did get my attention.  I will try running
> it again this evening when/if kernel-ml8 is free again.  2.6.35-rc2,
> I should have mentioned.

And it does appear to be reproducible perhaps 50% of boots running
CONFIG_PREEMPT on kernel-ml8.  I have not yet seen it on any other system.
Do you have a patch to instrument the interrupts so as to get the info
you need, or should I improvise?

 							Thanx, Paul

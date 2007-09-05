Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38973DDE43
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 21:57:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l85AoOt9028059
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 06:50:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l85Bvnmm389854
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 05:57:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l85Bvn0b010133
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 05:57:49 -0600
Subject: Re: [patch 2/6] cuimage for Bamboo board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070905054645.GA26788@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.029244000@linux.vnet.ibm.com>
	<20070903010111.GC31499@localhost.localdomain>
	<1188826931.3772.11.camel@localhost.localdomain>
	<20070905011045.GC17189@localhost.localdomain>
	<1188952819.3223.5.camel@localhost.localdomain>
	<20070905054645.GA26788@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 00:53:54 -0500
Message-Id: <1188971635.3223.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-05 at 15:46 +1000, David Gibson wrote:
> > > > > There must surely be a way to get the MAC addresses out of OpenBIOS...
> > > > 
> > > > Probably.  I just need to find out where they are stored.
> > > 
> > > It's not buried somewhere in the arch/ppc/boot code?
> > 
> > It's not OpenBIOS, it's PIBS.  And the arch/ppc port uses __res, which
> > I'd rather avoid.  But I did find where it's stored in flash, so I can
> > read it from there.  I just need to do a little more work to get it in a
> > manner that can be used.
> 
> Hrm.. is that address actually guaranteed to be stable across PIBS
> versions?  If arch/ppc uses __res, I think we should do that too.  It
> shouldn't be any worse than what we already do fot cuboot.

The address should be stable for all versions of PIBS that come on the
Bamboo boards, yes.  And after looking at it a bit more, the wrapper in
arch/ppc for PIBS essentially mocks up __res by reading the values out
of flash.  So the way I'm doing it is the way it was already done.

josh

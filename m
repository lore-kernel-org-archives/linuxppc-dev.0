Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5061DDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:46:07 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8H2k60q011504
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:46:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8H2neXv290844
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:49:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8H2jnvB007757
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:45:49 +1000
Date: Mon, 17 Sep 2007 12:03:08 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Message-ID: <20070917020308.GF32725@localhost.localdomain>
References: <20070915150901.AC712247CE@gemini.denx.de>
	<1189877748.17593.9.camel@localhost.localdomain>
	<addcdbe0ab5b83aa58fc4e7df37b0925@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <addcdbe0ab5b83aa58fc4e7df37b0925@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2007 at 09:20:10PM +0200, Segher Boessenkool wrote:
> >> Maybe we can have  U-Boot  add  the  partition  information  if  it's
> >> missing in the device tree, and extend the mtdparts command in U-Boot
> >> to add / adjust settings so they match what is defined in U-Boot.
> >
> > That would be great for newer U-Boots.  For existing older ones, it
> > doesn't really solve the problem.  But then again, there's no way to
> > possibly define all the partitioning schemes people may have adopted to
> > their needs on their boards.  And I believe that is why David has
> > RedBoot and command line partitioning override what is in the DTS 
> > today.
> 
> Yeah, partitioning information really doesn't belong in the device
> tree -- with the possible exception of the partitions that the
> firmware (uboot in this case) needs to know about anyway.

Indeed - but we had just the same problem, only worse, with the old
approach of hardcoded, configured-in flash maps.

> You *can* put all partitioning info in the device tree, but that
> doesn't mean you *should* :-)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

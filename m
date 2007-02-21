Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13791DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:44:51 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1L10gbg331914
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 12:00:42 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L0mI2L172538
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:48:18 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L0im53027992
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:44:49 +1100
Date: Wed, 21 Feb 2007 11:44:46 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [0/14] Ebony support, 2nd spi
Message-ID: <20070221004446.GL10231@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
	<200702201607.33249.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702201607.33249.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Hartmut Penner <HPENNER@de.ibm.com>,
	Christian Rund <Christian.Rund@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 04:07:32PM +0100, Arnd Bergmann wrote:
> On Tuesday 20 February 2007 16:03, Josh Boyer wrote:
> > And the ebony dts also has the a bus type of "ibm,opb" as well.
> 
> We should really get a common name for these. I don't remember
> what the discussions were, but it seems we came up with different
> results for Axon and ppc4xx, which is very bad.
> 
> Using type "ibm,opb" rather than just "opb" makes sense to me,
> but I don't know if we already have shipping systems that use
> "opb" here.
> 
> There is probably a similar problem with the nodes for "plb4",
> "plb5" and "ebc", as well as the "compatible" property of the
> serial port, which, as you noted earlier is "ns16550" on 
> ebony and "ns16750" on axon, although it is exactly the same
> macro.

Yes, we should have some common names.  I didn't like using bare
"plb", because I was worried that, being such a bland generic name,
some other vendor might apply the same name to their own "processor
local bus" which could be something entirely different.  But, if we
have things in the wild that use "plb" and "opb", then I'll change it
over.

That said, this doesn't actually break anything at present.
legacy_serial is not supposed to find any ports on Ebony, and ebony.c
specifies the bus types to be probed for of_platform devices,
including of_serial.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

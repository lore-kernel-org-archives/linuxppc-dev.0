Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0A5ADDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:53:11 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1GEsVkR7311526
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:54:31 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G2uZT4165802
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:56:35 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G2r5c2000936
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:53:05 +1100
Date: Fri, 16 Feb 2007 13:53:02 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
Message-ID: <20070216025302.GF21654@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<1171381565.4003.48.camel@zod.rchland.ibm.com>
	<1171469183.4003.96.camel@zod.rchland.ibm.com>
	<20070214231204.GB16279@localhost.localdomain>
	<20070216021956.GA1038@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216021956.GA1038@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 08:19:56PM -0600, Josh Boyer wrote:
> On Thu, Feb 15, 2007 at 10:12:04AM +1100, David Gibson wrote:
> > > I still have this issue, just haven't had a chance to figure out why
> > > yet.  Likely because the openbios code is leaving garbage somewhere.
> > 
> > More likely simply because openbios just puts different things in the
> > registers on entry, and we're assuming it uses the same method OF
> > does.  Need to fix the entry path, and get rid of the hardcoded a1 and
> > a2 junk.
> 
> I looked a the openbios code this morning.  For all intents and purposes
> the values it pases in r3 and r4 to the zImage wrapper really are
> garbage.  However, you're right in that we need to fix the boot wrapper
> to not assume all firmwares will follow similar conventions for the entry
> path.

Yes.

> Is there a compat property or something similar that could be defined in
> the DTS that the wrapper could look at to determine what to expect?

I think that's getting way too keen on generality.  I'm almost ready
to send out a patch which alters the entry path to the zImage code to
let the platform code handle the entry parameters.  Then we can just
make the Ebony platform_init() ignore the r3 and r4 values.

Err... except, are they really both junk?  I thought at least one gave
an address for the openbios callback to grab the board info structure.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

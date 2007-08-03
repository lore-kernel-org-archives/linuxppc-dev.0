Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 272BADDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 12:57:18 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l732xqn44481234
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:59:53 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l732uPXq150414
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:56:25 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l732vEZJ000315
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:57:14 +1000
Date: Fri, 3 Aug 2007 12:53:34 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] Use 1TB segments
Message-ID: <20070803025334.GB6418@localhost.localdomain>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1186087283.22717.80.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186087283.22717.80.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 03:41:23PM -0500, Will Schmidt wrote:
> Hi Paul, 
>    just a few questions.  
[snip]
> > +#define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
> 
> > +#define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
> 
> Anything special in how this 24-bit prime value was selected?   (same
> question could be for the 28-bit prime, though I see that value was
> updated at least once a few years back)

I can't speak to the 24-bit value specifically, but I can speak to the
28-bit one:  I did the rewrite of the SLB miss handler to use that
multiplicative hash, and changed the prime value when a bug report
showed problems in the original choice.

Afaict, the value of the prime doesn't matter all that much - in fact
it doesn't strictly even need to be prime, just co-prime to (2^36-1).
Originally, I picked the largest 28-bit prime, on the basis that a
large multiplier should give better scattering/folding.

That turned out to cause problems on some iSeries machines (which
couldn't do 16M pages) - we were filling up hash buckets with the
linear mapping.  I figured out that that was because a very large
28-bit number was in the relevant modulus, sort of equivalent to a
small negative number.  For a big linear mapping, the hash bucket
selected strided gradually backwards through the table - there were
also differences in the high bits of the hash, but they were lost
because of the limited size of the hash table.

So, I changed the multiplier to the median 28-bit prime, in the hopes
that that would give better hash scattering across as many bits of the
VSID as possible.  I don't have much in the way of theoretical
justification for that, but it fixed the iSeries problem and I've
never heard of any regressions, so apparently it's not too bad.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

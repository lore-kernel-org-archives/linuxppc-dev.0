Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78EC6B6F0F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 13:29:00 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB8DSxe8023688
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Dec 2009 00:28:59 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB82PCRE1527836
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 13:25:12 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB82SwZY026674
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 13:28:59 +1100
Date: Tue, 8 Dec 2009 13:28:55 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: using different format for hugetlbfs
Message-ID: <20091208022855.GC15612@yookeroo>
References: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
	<1259917136.2076.1264.camel@pasglop>
	<90D0766D-30A2-4ABE-9707-C7F64A697BFE@kernel.crashing.org>
	<1259961942.2076.1277.camel@pasglop>
	<5034AAE3-CCF9-446D-AC4B-B3F59C81D507@kernel.crashing.org>
	<1260147877.2076.1346.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1260147877.2076.1346.camel@pasglop>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 07, 2009 at 12:04:37PM +1100, Benjamin Herrenschmidt wrote:
> 
> > 
> > Even than, does that preclude the format I suggested?  I'm assuming  
> > that pgd_t/pud_t/pmd_t are always a double word so the low order 4- 
> > bits should be 0 (on 64-bit),

Double word alignment only gives us 3 low bits.

> so using the lsb as the flag between  
> > hugetlb and normal pointer should still work.
> 
> Might do, depends if David has enough bits ...  David ?

Well, the flag can go at the bottom, but that will mean grabbing more
bits at the bottom.  At the moment to cover all the page table sizes
that are wanted on the various setups we have, I need 5 bits, this
would push it to 6.  At present, I just force up the minimum alignment
of any page directory (even if it's natural alignment is smaller) so
as to make sure I have those bits.  That's pretty easy to adjust, but
pushing it up too high will start wasting memory, of course.

If we move to a variable sized encoding, as Ben and I have discussed
on a couple of occasions, I think we could do this though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

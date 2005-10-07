Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from lists.sandelman.ca (cod.sandelman.ca [192.139.46.139])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lists.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1D4F268501
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 03:42:03 +1000 (EST)
Received: from sandelman.ottawa.on.ca
	(CPE0080c8d59fa8-CM0011aea1b6fc.cpe.net.cable.rogers.com
	[69.196.216.20])
	by lists.sandelman.ca (8.11.6p3/8.11.6) with ESMTP id j97HFSG04258
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified
	OK)
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Oct 2005 13:15:35 -0400 (EDT)
Received: from marajade.sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 96CD0E9955
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 13:15:28 -0400 (EDT)
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 07 Oct 2005 13:15:28 -0400
Message-ID: <19942.1128705328@marajade.sandelman.ottawa.on.ca>
Sender: mcr@sandelman.ottawa.on.ca
Subject: stepping through atomic_dec_return
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


I have what I think is a semaphore problem.
Certainly there is an attempt to down(&sem) when sem->count ==
0. (that's my root cause, which I'm now going to examine)

However, down() in semaphore.h should just fail and call __down().

The problem seems to be that loop in atomic_dec_return(), which 
uses lwarx/stwcw seems to never end:

"1:	lwarx	%0,0,%1		# atomic_dec_return\n\
	addic	%0,%0,-1\n"
	PPC405_ERR77(0,%1)
"	stwcx.	%0,0,%1\n\
	bne-	1b"
	SMP_ISYNC
	: "=&r" (t)
	: "r" (&v->counter)
	: "cc", "memory");

lwarx sets the "RESERVED" bit, and stwcx, copies that to the CR0[EQ]
bit, which bne tests. 

I don't know what the "-" in the bne means.  Is it significant?

I checked, and CONFIG_IBM405_ERR77 is in my .config, so that shouldn't
be the issue. (I think the work around is just a performance issue on
devices without the defect)

I can see how setting through this code with the debugger could cause a
problem, since there would be debug exceptions, and there would be other
code in the debug stubs that could set the RESERVED=0.  It's hard to
know, but it seems unlikely to me.

(This is a UP system)

However, I would expect that I can set a break point after this call and
things would work fine. They do not, I get stuck in this loop.

Any comments?


- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQ0atLYqHRg3pndX9AQGtNwQAsys7tNm+oVKkSptxYPbWf4KYCgibCRrt
Utb+8XR44dmIbVSeZdPZntR2Jklu00cFrNWw/2pk+Rv0tWdaiynbqRHdrkaVi9xS
9GEmf6v9FsbElIgeZP3/8FY7cuLu5PIDkuwU9can/mYJ1iZEMbLh4YcSJoNFHHws
ooLSWbz9uV8=
=hh8M
-----END PGP SIGNATURE-----

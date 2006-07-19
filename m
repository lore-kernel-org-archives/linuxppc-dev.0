Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B441867B5D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 04:10:55 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6JIAmXh014479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:10:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6JIAmAL297056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 12:10:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6JIAlRD029306
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 12:10:48 -0600
Date: Wed, 19 Jul 2006 13:10:47 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: AltiVec in the kernel
Message-ID: <20060719181047.GL5905@austin.ibm.com>
References: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
	<005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
	<17597.8378.972640.464219@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17597.8378.972640.464219@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, Jul 19, 2006 at 03:56:10AM +1000, Paul Mackerras wrote:
> A lot of compression and encryption algorithms, by their very nature,
> are very difficult to parallelize enough to get any significant
> improvement from altivec.  I looked at SHA1 for instance, and the
> sequential dependencies in the computation are such that it is
> practically impossible to find a way to do 4 things in parallel.  The
> sequential dependencies are of course a critical part of the way that
> SHA1 ensures that a small change in any part of the input data results
> in substantial changes in every byte of the output.

But perhaps, in principle, couldn't one run four independent streams 
in parallel?  Thus, for example, on an SSL-enabled web server, one 
could service multiple encryption/decryption threads at once. 

In practice, I don't beleive the infrastructure for that kind of
parallelism is in place. I'm struggling to find a reason to develop
that kind of infrastructure. Mumble something about Cell. 

> I think that there are actually very few places in the kernel where we
> are doing something which is parallelizable, sufficiently
> compute-intensive, and not bound by memory bandwidth, to be worth
> using altivec.

Yes.

As to non-kernel applications, is there anything for GMP (the 
Gnu Multi-Precision library, an arbitrary-precision math library)
on the Altivec? How aout the Cell?

--linas

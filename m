Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AAD467A39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 04:29:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JITswo007765
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:29:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8JITsGn258620
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 12:29:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8JITsGe004824
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 12:29:54 -0600
Date: Tue, 19 Sep 2006 13:29:53 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] convert string i/o operations to C
Message-ID: <20060919182953.GK29167@austin.ibm.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 10:23:51PM +1000, Stephen Rothwell wrote:

Perhaps this:

> +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> +{
> +	asm volatile("sync");
> +	if (ns <= 0)
> +		return;
> +	asm volatile(

should be this: 

> +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> +{
> +	if (ns <= 0)
> +		return;
> +	asm volatile("sync");
> +	asm volatile(

to assuage David Howell's concern.  Not that ns should be negative
in the first place ... but what the hey.

Re Davids other comment: "ns" stands for "no  byte-swap", and 
"s" stands for "string" so "insl_ns" is input string of longs, 
no byte swap.

Here's a question:

> +	asm volatile(
> +		"mtctr	%2\n"
> +		"subi	%1,%1,1\n"
> +		"0:	lbz	%2,0(%0)\n"
> +		"eieio\n"
> +		"stbu	%2,1(%1)\n"
> +		"bdnz	0b\n"
> +		"twi	0,%2,0\n"

What does this twi do? According to my powerpc docs, this would be a
no-op.  Does this have some magic synchronizing powers on certain
implementations? If so, there should be at least a comment card added
about why the twi is there. (This special ability of twi might be
well-known to some, but still, this is not immediately obvious,
and not immedately documented in e.g. the PEM.)

--linas

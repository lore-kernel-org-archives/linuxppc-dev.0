Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59FDDDDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 09:51:23 +1100 (EST)
Message-ID: <475472A8.1020708@itee.uq.edu.au>
Date: Tue, 04 Dec 2007 07:18:32 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: SMP on linux with Microblaze?
References: <14137760.post@talk.nabble.com>
In-Reply-To: <14137760.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

khollan wrote:

>Now that Full Linux can run on Microblaze with the addition of the MMU, are
>there plans to enable Symmetric Multi-Processing of two or more Microblaze
>cores running Linux?
>  
>
This isn't really the right list for direct microblaze discussion, but
since you asked..  The challenge with SMP is not an MMU, but cache
coherency.  This is why native SMP on dual PPC on V4/V5 is also a
non-starter.  It is possible to build software driven snoop/invalidate
mechanisms that might allow a crippled SMP on MicroBlaze, but I think
the performance would be pretty nasty. 

The Blackfin Linux team have done some interesting things towards SMP on
non cache-coherent dual CPUs.  Basically they do a local cache
invalidation upon acquiring any kernel lock, on the theory that if you
are accessing a shared data structure you will grab a lock first.  Thus,
the cache flush will make sure you get the "true" value, not some stale
locally cached result.  But, it's still pretty inefficient, and cannot
do things like processor affinity and process migration.  Google the
bfin lists for details and patches.

Regards,

John

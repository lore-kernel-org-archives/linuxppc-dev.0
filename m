Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/15] powerpc: Define slb0_limit() for BOOK3E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <5313E556-6BFA-48D0-921F-7CF91892514A@freescale.com>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
	<DB59DA71-C6DA-4E65-9251-C29B973345AD@freescale.com>
	<1303162902.28876.164.camel@pasglop>
	<5313E556-6BFA-48D0-921F-7CF91892514A@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Apr 2011 08:50:39 +1000
Message-ID: <1303167039.28876.172.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ozlabs.org>, Jimi Xenidis <jimix@watson.ibm.com>,
	jack@codezen.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-18 at 17:30 -0500, Kumar Gala wrote:
> > On Mon, 2011-04-18 at 07:42 -0500, Kumar Gala wrote:
> >> Let's rename this function to something 'linear_map'.  As on FSL
> >> Book-E 64 we do things a bit differently and have more covered in
> >> linear map than 1G
> > 
> > It's not quite linear_map. It's whatever can be accessed without
> taking
> > exceptions. IE. What is bolted.
> > 
> > It should probably go into a variable initialized by the mm code
> tho.
> > 
> > Cheers,
> > Ben.
> 
> Is this 'ppc64_rma_size' ? 

Not quite either :-)

The RMA (on server) is the amount of memory that is accessible in real
mode (with MMU off).

SLB0 is segment 0, which is 256M or 1T depending on what segment size we
use, and is a bolted segment in Linux. Thus all accesses to SLB0 are
guaranteed to not generate an SLB miss fault. Since on server our linear
mapping is bolted in the hash, what that means is that any access to
memory in segment 0 is guaranteed to not take an exception (ie not
clobber SRR0/1 for example).

We re-use the SLB0 concept on BookE to represent the bolted portion of
the linear mapping since it has the same characteristics, ie, accesses
will not cause an exception that can clobber SRR0/1.

The patch Michael posted is indeed a bit gross (it's my code btw :-) and
we'll need to clean it up, my idea is to have a global set by the
platform, but maybe we can have some generic code that performs a TLB
search for IPROT entries :-)

Cheers,
Ben.

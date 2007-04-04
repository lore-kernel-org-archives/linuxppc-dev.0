Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17939.11371.206449.628682@cargo.ozlabs.ibm.com>
Date: Wed, 4 Apr 2007 14:41:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
In-Reply-To: <adar6r0dg0q.fsf@cisco.com>
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
	<adar6r0dg0q.fsf@cisco.com>
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier writes:

> I assume this is an eHCA-specific problem.

Guilty as charged. :)

> Another approach is simply not to enable the other 4K pages that are
> exposed when mapping a 64K page into userspace - ie only use 1/16th of
> the available contexts.  Although perhaps eHCA has such a limited # of
> contexts that this is not practical.

I believe the hypervisor controls the allocation of contexts to
partitions, so this wouldn't be practical.

> The problem with this approach is that remap_4k_pfn is
> powerpc-specific, right?

It is powerpc-specific, but so is the eHCA driver...

>  For example, I don't believe that an ia64
> kernel running with 16K pages could implement this.  Which means that
> any driver that calls remap_4k_pfn is now powerpc-specific (or has an
> #ifdef to work around this).

I am a complete ia64-ignoramus, so I couldn't say whether ia64 could
do it or not.

> In fact my impression was that the powerpc MMU is not part of the
> architecture, in the sense that a new implementation could come along
> that supported 64K pages without the ability to do this 4K aliasing
> trick.  Which would make multiplatform kernels very painful, since
> remap_4k_pfn might work for some platforms the kernel could boot on.
> Or is this not a problem?

The PowerPC architecture distinguishes between server and embedded
processors.  The MMU is part of the architecture for server
processors, and is specified reasonably tightly.  For embedded there
is also a specification of the MMU but it is very loose.  In any case,
all PowerPC processors can do 4k pages, so I don't see any problem.

Paul.

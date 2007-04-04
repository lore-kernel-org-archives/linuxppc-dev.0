Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5386DDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 13:24:19 +1000 (EST)
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adar6r0dg0q.fsf@cisco.com>
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
	<adar6r0dg0q.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 13:23:45 +1000
Message-Id: <1175657025.30879.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The problem with this approach is that remap_4k_pfn is
> powerpc-specific, right?  For example, I don't believe that an ia64
> kernel running with 16K pages could implement this.  Which means that
> any driver that calls remap_4k_pfn is now powerpc-specific (or has an
> #ifdef to work around this).
> 
> In fact my impression was that the powerpc MMU is not part of the
> architecture, in the sense that a new implementation could come along
> that supported 64K pages without the ability to do this 4K aliasing
> trick.  Which would make multiplatform kernels very painful, since
> remap_4k_pfn might work for some platforms the kernel could boot on.
> Or is this not a problem?

It's somewhat architected. I doubt there will ever be a processor that
can have an eHCA and doesn't support that trick. The thing is, eHCA is
platform specific, so the remap_4k_pfn would have to be called by driver
specific code, but that's not a problem since that driver will only ever
be used on those platforms that support that call.

Ben.

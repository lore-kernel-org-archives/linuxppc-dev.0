Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CC711A00F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 11:14:10 +1000 (EST)
In-Reply-To: <1408482065-18457-1-git-send-email-bobby.prani@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Fix build failure when MEMORY_HOTPLUG=y
Message-Id: <20140925011409.F1A20140143@ozlabs.org>
Date: Thu, 25 Sep 2014 11:14:09 +1000 (EST)
Cc: Andew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-19-08 at 21:01:05 UTC, Pranith Kumar wrote:
> ARCH_ENABLE_MEMORY_HOTPLUG is enabled by default for powerpc. This causes build
> failures when SPARSEMEM=n as memory hotplug needs definition which are defined
> only when SPARSEMEM=y. The error is as follows:

> arch/powerpc/platforms/pseries/hotplug-memory.c:27:31: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)
> arch/powerpc/platforms/pseries/hotplug-memory.c:27:31: note: each undeclared identifier is reported only once for each function it appears in

I don't see how you can even build pseries without SPARSEMEM=y ?

The three options are:

	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
	default FLATMEM_MANUAL

We don't have DISCONTIGMEM.

FLATMEM_MANUAL depends on !ARCH_SPARSEMEM_ENABLE.

We turn on ARCH_SPARSEMEM_ENABLE, and it's not user editable.

cheers

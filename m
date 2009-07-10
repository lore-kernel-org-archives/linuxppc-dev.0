Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD61BB7084
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 15:57:24 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED1F3DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 15:57:23 +1000 (EST)
Subject: Re: [PATCH 00/11] swiotlb: Introduce architecture-specific APIs to
	replace __weak functions (v2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Campbell <ian.campbell@citrix.com>
In-Reply-To: <1243870383-12954-1-git-send-email-ian.campbell@citrix.com>
References: <1243870383-12954-1-git-send-email-ian.campbell@citrix.com>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 15:55:56 +1000
Message-Id: <1247205356.15530.18.camel@pasglop>
Mime-Version: 1.0
Cc: x86@kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Olaf Kirch <okir@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-01 at 16:32 +0100, Ian Campbell wrote:
> This series:
> * removes the swiotlb_(arch_)_phys_to_bus and bus_to_phys __weak
>   hooks, replacing them with an architecture-specific phys_to_dma and
>   dma_to_phys interface. These are used by both PowerPC and Xen to
>   provide the correct mapping from physical to DMA addresses.
> * removes the swiotlb_address_needs_mapping and
>   swiotlb_range_needs_mapping __weak functions as well as
>   is_buffer_dma_capable (which should never have been a generic
>   function). All three are replaced by a single architecture-specific
>   interface which meets the needs of both PowerPC and Xen.
> * removes the swiotlb_virt_to_bus __weak function and replaces it with
>   a CONFIG_HIGHMEM compatible version when high memory is in use. This
>   is needed for 32 bit PowerPC swiotlb support.
> * removes the swiotlb_alloc* __weak functions and replaces them with
>   swiotlb_init_with_buffer which allows the use of a caller allocated
>   buffer (and emergency pool).
> 
> I think these new interfaces are cleaner than the existing __weak
> functions and isolate the swiotlb code from architecture internals.
> 
> This series does not contain any Xen or PowerPC specific changes, those
> will follow in separate postings. The complete patchset has been boot
> tested under Xen and native-x86 and compiled for IA64 and PowerPC
> 
> Changes since v1: 
> - Fixed compile error in swiotlb_dma_to_virt highmem version. Moved
>   #ifdef into function to avoid prototype drift.
> - checkpatch fixes.
> - missed a swiotlb_arch_range_needs_mapping in swiotlb.h and x86
>   pci-swiotlb.c and swiotlb_bus_to_phys/phys_to_bus implementations in
>   x86.
> - additionally replaced __weak swiotlb_alloc* with
>   swiotlb_init_with_buffer.

Looks like I was only CCed on part of them... it's not very handy for me
as I end up having some of the patches in one folder and some
elsewhere :-)

I don't have a firm objection but they will have to go through Becky
and Kumar since they are the one who need swiotlb for their embedded
platforms.

Cheers,
Ben.

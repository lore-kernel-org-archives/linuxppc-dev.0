Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id DE9B4B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 16:28:22 +1100 (EST)
Date: Thu, 25 Mar 2010 16:28:14 +1100
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Export purge_vmap_area_lazy()
Message-ID: <20100325052814.GA7493@laptop.nomadix.com>
References: <1269417391.8599.188.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269417391.8599.188.camel@pasglop>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 24, 2010 at 06:56:31PM +1100, Benjamin Herrenschmidt wrote:
> Some powerpc code needs to ensure that all previous iounmap/vunmap has
> really been flushed out of the MMU hash table. Without that, various
> hotplug operations may fail when trying to return those pieces to
> the hypervisor due to existing active mappings.
> 
> This exports purge_vmap_area_lazy() to allow the powerpc code to perform
> that purge when unplugging devices.

You want vm_unmap_aliases(), which also flushes entries in the
per-cpu vmap allocator (and is already exported for other code
that has similar problems).

Thanks,
Nick

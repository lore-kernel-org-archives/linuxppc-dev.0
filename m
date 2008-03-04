Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 4D8C5DE8AF
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:01:36 +1100 (EST)
Date: Tue, 4 Mar 2008 12:01:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
In-Reply-To: <84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0803041200140.18277@schroedinger.engr.sgi.com>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20080304103636.3e7b8fdd.akpm@linux-foundation.org>
	<47CDA081.7070503@cs.helsinki.fi> <20080304193532.GC9051@csn.ul.ie>
	<84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Mar 2008, Pekka Enberg wrote:

> >  > >> [c000000009edf5f0] [c0000000000b56e4] .__alloc_pages_internal+0xf8/0x470
> >  > >> [c000000009edf6e0] [c0000000000e0458] .kmem_getpages+0x8c/0x194
> >  > >> [c000000009edf770] [c0000000000e1050] .fallback_alloc+0x194/0x254
> >  > >> [c000000009edf820] [c0000000000e14b0] .kmem_cache_alloc+0xd8/0x144

Ahh! This is SLAB. slub does not suffer this problem since new_slab() 
masks the bits correctly.

So we need to fix SLAB.

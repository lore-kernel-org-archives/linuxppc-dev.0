Return-Path: <dave@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28A44B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 09:30:27 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dave@linux.vnet.ibm.com>;
 Thu, 26 Jan 2012 15:30:23 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B1463C90051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 17:30:18 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0QMUIh1296108
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 17:30:18 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0QMUHT6026521
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 15:30:17 -0700
Message-ID: <4F21D3F4.7020904@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2012 14:30:12 -0800
From: Dave Hansen <dave@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
In-Reply-To: <1327613953.24487.9.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2012 01:39 PM, Benjamin Herrenschmidt wrote:
> Can you explain to me a bit more the whole business in this patch set
> about doing kmap_atomic() vs. manually trying to populate the PTEs ? 

They're compressing pages and the allocator is trying getting very poor
packing of compressed pages in to PAGE_SIZE chunks.  So, they're moving
to 2-page allocations that they need to be mapped contiguously to make
it easier on the users of the allocator.

> Why not just use two kmap atomic entries ? If interrupts are disabled
> kmap_atomic() should give you contiguous ones I suppose

I think you and I are at least on the same page on this one:

https://lkml.org/lkml/2012/1/26/355

> (unless NMIs are allowed to use kmap_atomic, are they ?)

Surely they can't be.  Even if they could use it, they'd have to return
the __kmap_atomic_idx back to the place where it started before they
returned, so the interrupted code wouldn't notice.

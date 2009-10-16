Return-Path: <cl@linux-foundation.org>
Received: from smtp.ultrahosting.com (smtp2.ultrahosting.com [74.213.174.253])
	by ozlabs.org (Postfix) with ESMTP id 3022BB7BE0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:01:52 +1100 (EST)
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 88FEE82C6D8
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 13:01:30 -0400 (EDT)
Received: from smtp.ultrahosting.com ([74.213.174.253])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id m2l6Kz-CBUtk for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Oct 2009 13:01:30 -0400 (EDT)
Received: from gentwo.org (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id B764782C6D6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 13:01:25 -0400 (EDT)
Date: Fri, 16 Oct 2009 12:48:34 -0400 (EDT)
From: Christoph Lameter <cl@linux-foundation.org>
To: gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 2/2][v2] powerpc: Make the CMM memory hotplug aware
In-Reply-To: <4AD7681C.7060800@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.1.10.0910161246010.6120@gentwo.org>
References: <20091002184458.GC4908@austin.ibm.com>
	<20091002185248.GD4908@austin.ibm.com>
	<4ACDD71D.30809@linux.vnet.ibm.com>
	<20091008131355.GA22118@austin.ibm.com>
	<4AD7681C.7060800@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Badari Pulavarty <pbadari@us.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Oct 2009, Gerald Schaefer wrote:

> > The pages allocated as __GFP_MOVABLE are used to store the list of pages
> > allocated by the balloon.  They reference virtual addresses and it would
> > be fine for the kernel to migrate the physical pages for those, the
> > balloon would not notice this.
>
> Does page migration really work for kernel pages that were allocated
> with __get_free_page()? I was wondering if we can do this on s390, where
> we have a 1:1 mapping of kernel virtual to physical addresses, but
> looking at migrate_pages() and friends, it seems that kernel pages
> w/o mapping and rmap should not be migrateable at all. Any thoughts from
> the memory migration experts?

page migration only works for pages where we have some way of accounting
for all the references to a page. This usually mean using reverse mappings
(anon list, radix trees and page tables).

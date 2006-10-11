Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 641B767BFD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 01:20:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9BFKJPR009189
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 11:20:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9BFKILb331310
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 09:20:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9BFKH9c007095
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 09:20:18 -0600
Date: Wed, 11 Oct 2006 10:20:17 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
Message-ID: <20061011152016.GU4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
	<20061010212324.GR4381@austin.ibm.com>
	<452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <452C4CE0.5010607@am.sony.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2006 at 06:46:08PM -0700, Geoff Levand wrote:
> > Linas Vepstas wrote:
> >> The current driver code performs 512 DMA mappns of a bunch of 
> >> 32-byte structures. This is silly, as they are all in contiguous 
> >> memory. Ths patch changes the code to DMA map the entie area
> >> with just one call.
> 
> Linas, 
> 
> Is the motivation for this change to improve performance by reducing the overhead
> of the mapping calls?  

Yes.

> If so, there may be some benefit for some systems.  Could
> you please elaborate?

I started writingthe patch thinking it will have some huge effect on
performance, based on a false assumption on how i/o was done on this
machine

*If* this were another pSeries system, then each call to 
pci_map_single() chews up an actual hardware "translation 
control entry" (TCE) that maps pci bus addresses into 
system RAM addresses. These are somewhat limited resources,
and so one shouldn't squander them.  Furthermore, I thouhght
TCE's have TLB's associated with them (similar to how virtual
memory page tables are backed by hardware page TLB's), of which 
there are even less of. I was thinking that TLB thrashing would 
have a big hit on performance. 

Turns out that there was no difference to performance at all, 
and a quick look at "cell_map_single()" in arch/powerpc/platforms/cell
made it clear why: there's no fancy i/o address mapping.

Thus, the patch has only mrginal benefit; I submit it only in the 
name of "its the right thing to do anyway".

--linas

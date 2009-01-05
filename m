Return-Path: <chandru@in.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A0D6DE001
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 00:49:57 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n05DmHEJ005181
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 00:48:17 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n05Dns95223440
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 00:49:54 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n05DnrCs006802
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 00:49:53 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Mon, 5 Jan 2009 19:19:52 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<18772.11376.339295.42622@cargo.ozlabs.ibm.com>
	<1230586567.19452.100.camel@nimitz>
In-Reply-To: <1230586567.19452.100.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051919.52327.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 December 2008 03:06:07 Dave Hansen wrote:
> On Fri, 2008-12-26 at 11:59 +1100, Paul Mackerras wrote:
> > > +     }
> > > +
> > > +     for_each_online_node(nid) {
> > >               /*
> > > -              * Be very careful about moving this around.  Future
> > > -              * calls to careful_allocation() depend on this getting
> > > -              * done correctly.
> > > +              * Be very careful about moving this around.
> > >                */
> > >               mark_reserved_regions_for_nid(nid);
> > >               sparse_memory_present_with_active_regions(nid);
>
> I think this reintroduces one of the bugs that I squashed.  You *have*
> to call mark_reserved_regions_for_nid() right after you do
> free_bootmem_with_active_regions().  Otherwise, someone else can
> bootmem_alloc() a reserved region from that node.

Thanks for the review comments Dave. With the commit:a4c74ddd5ea3db53fc73d29c222b22656a7d05be, I see this has been taken care in mark_reserved_regions_for_nid(). In that case we may only need the change made in reserve_bootmem_node(). 

Hello Andrew, 
Could you please consider the following patch instead of the original patch in this thread. 
Thanks, 


When booted with crashkernel=224M@32M or any memory size less than this, the system boots properly. The system comes up with two nodes (0-256M and 256M-4GB). The crashkernel memory reservation spans across these two nodes. The mark_reserved_regions_for_nid() in arch/powerpc/numa.c resizes the reserved part of the memory within it as... 

	 if (end_pfn > node_ar.end_pfn)
		reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
				- (start_pfn << PAGE_SHIFT);

but the reserve_bootmem_node() in mm/bootmem.c raises the pfn value of end

	end = PFN_UP(physaddr + size);

This causes end to get a value past the last page in the 0-256M node. The following change restricts the value of end if it exceeds the last pfn in a given node.

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>
---

 mm/bootmem.c |    4 ++++
 1 file changed, 4 insertions(+)


--- linux-2.6.28/mm/bootmem.c.orig	2009-01-05 20:42:12.000000000 +0530
+++ linux-2.6.28/mm/bootmem.c	2009-01-05 20:43:53.000000000 +0530
@@ -375,10 +375,14 @@ int __init reserve_bootmem_node(pg_data_
 				 unsigned long size, int flags)
 {
 	unsigned long start, end;
+	bootmem_data_t *bdata = pgdat->bdata;
 
 	start = PFN_DOWN(physaddr);
 	end = PFN_UP(physaddr + size);
 
+	if (end > bdata->node_low_pfn)
+		end = bdata->node_low_pfn;
+
 	return mark_bootmem_node(pgdat->bdata, start, end, 1, flags);
 }
 

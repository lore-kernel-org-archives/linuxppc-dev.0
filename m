Return-Path: <dave@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2017DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 12:17:27 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAM1Gr20001278
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:16:53 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAM1HNaC157042
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:17:23 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAM1HNug025105
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:17:23 -0700
Subject: Re: Nodes with no memory
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20081122004956.GT6830@localdomain>
References: <1227311441.11607.57.camel@nimitz>
	<20081122004956.GT6830@localdomain>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 17:17:22 -0800
Message-Id: <1227316642.11607.69.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mjw <mjw@linux.vnet.ibm.com>,
	anton <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-21 at 18:49 -0600, Nathan Lynch wrote:
> Dave Hansen wrote:
> > I was handed off a bug report about a blade not booting with a, um
> > "newer" kernel.
> 
> If you're unable to provide basic information such as the kernel
> version then perhaps this isn't the best forum for discussing this.  :)

Let's just say a derivative of 2.6.27.5.  I will, of course be trying to reproduce on mainline.  I'm just going with the kernel closest to the bug report as I can get for now. 

> > I'm thinking that we need to at least fix careful_allocation() to oops
> > and not return NULL, or check to make sure all it callers check its
> > return code.
> 
> Well, careful_allocation() in current mainline tries pretty hard to
> panic if it can't satisfy the request.  Why isn't that happening?

I added some random debugging to careful_alloc() to find out.

careful_allocation(1, 7680, 80, 0)
careful_allocation() ret1: 00000001dffe4100
careful_allocation() ret2: 00000001dffe4100
careful_allocation() ret3: 00000001dffe4100
careful_allocation() ret4: c000000000000000
careful_allocation() ret5: 0000000000000000

It looks to me like it is hitting 'the memory came from a previously
allocated node' check.  So, the __lmb_alloc_base() appears to get
something worthwhile, but that gets overwritten later.

I'm still not quite sure what this comment means.  Are we just trying to
get node locality from the allocation?

I also need to go look at how __alloc_bootmem_node() ends up returning
c000000000000000.  It should be returning NULL, and panic'ing, in
careful_alloc().  This probably has to do with the fact that NODE_DATA()
isn't set up, yet, but I'll double check.

        /*
         * If the memory came from a previously allocated node, we must
         * retry with the bootmem allocator.
         */
        new_nid = early_pfn_to_nid(ret >> PAGE_SHIFT);
        if (new_nid < nid) {
                ret = (unsigned long)__alloc_bootmem_node(NODE_DATA(new_nid),
                                size, align, 0);
                dbg("careful_allocation() ret4: %016lx\n", ret);

                if (!ret)
                        panic("numa.c: cannot allocate %lu bytes on node %d",
                              size, new_nid);

                ret = __pa(ret);
                dbg("careful_allocation() ret5: %016lx\n", ret);

                dbg("alloc_bootmem %lx %lx\n", ret, size);
        }



-- Dave

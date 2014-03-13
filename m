Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4902B2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 03:49:13 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 13 Mar 2014 10:49:10 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 17B2B38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 12:49:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2DGn7tT55181364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 16:49:08 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2DGn6I0022591
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 12:49:07 -0400
Date: Thu, 13 Mar 2014 09:48:49 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: Node 0 not necessary for powerpc?
Message-ID: <20140313164849.GB22247@linux.vnet.ibm.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1403111900100.19193@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1403111900100.19193@chino.kir.corp.google.com>
Cc: linux-mm@kvack.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11.03.2014 [19:02:17 -0700], David Rientjes wrote:
> On Tue, 11 Mar 2014, Nishanth Aravamudan wrote:
> 
> > I have a P7 system that has no node0, but a node0 shows up in numactl
> > --hardware, which has no cpus and no memory (and no PCI devices):
> > 
> > numactl --hardware
> > available: 4 nodes (0-3)
> > node 0 cpus:
> > node 0 size: 0 MB
> > node 0 free: 0 MB
> > node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
> > node 1 size: 0 MB
> > node 1 free: 0 MB
> > node 2 cpus:
> > node 2 size: 7935 MB
> > node 2 free: 7716 MB
> > node 3 cpus:
> > node 3 size: 8395 MB
> > node 3 free: 8015 MB
> > node distances:
> > node   0   1   2   3 
> >   0:  10  20  10  20 
> >   1:  20  10  20  20 
> >   2:  10  20  10  20 
> >   3:  20  20  20  10 
> > 
> > This is because we statically initialize N_ONLINE to be [0] in
> > mm/page_alloc.c:
> > 
> >         [N_ONLINE] = { { [0] = 1UL } },
> > 
> > I'm not sure what the architectural requirements are here, but at least
> > on this test system, removing this initialization, it boots fine and is
> > running. I've not yet tried stress tests, but it's survived the
> > beginnings of kernbench so far.
> > 
> > numactl --hardware
> > available: 3 nodes (1-3)
> > node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
> > node 1 size: 0 MB
> > node 1 free: 0 MB
> > node 2 cpus:
> > node 2 size: 7935 MB
> > node 2 free: 7479 MB
> > node 3 cpus:
> > node 3 size: 8396 MB
> > node 3 free: 8375 MB
> > node distances:
> > node   1   2   3 
> >   1:  10  20  20 
> >   2:  20  10  20 
> >   3:  20  20  10
> > 
> > Perhaps we could put in a ARCH_DOES_NOT_NEED_NODE0 and only define it on
> > powerpc for now, conditionalizing the above initialization on that?
> > 
> 
> I don't know if anything has recently changed in the past year or so, but 
> I've booted x86 machines with a hacked BIOS so that all memory on node 0 
> is hotpluggable and offline, so I believe this is possible on x86 as well.

Good to know, thanks! This is also certainly not very common on powerpc,
but it is possible -- and the topology ends up being inaccurate because
of the static initialization.

Thanks,
Nish

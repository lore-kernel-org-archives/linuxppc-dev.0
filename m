Return-Path: <rientjes@google.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B22D72C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 13:02:21 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so384544pad.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 19:02:19 -0700 (PDT)
Date: Tue, 11 Mar 2014 19:02:17 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Node 0 not necessary for powerpc?
In-Reply-To: <20140311195632.GA946@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1403111900100.19193@chino.kir.corp.google.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 11 Mar 2014, Nishanth Aravamudan wrote:

> I have a P7 system that has no node0, but a node0 shows up in numactl
> --hardware, which has no cpus and no memory (and no PCI devices):
> 
> numactl --hardware
> available: 4 nodes (0-3)
> node 0 cpus:
> node 0 size: 0 MB
> node 0 free: 0 MB
> node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
> node 1 size: 0 MB
> node 1 free: 0 MB
> node 2 cpus:
> node 2 size: 7935 MB
> node 2 free: 7716 MB
> node 3 cpus:
> node 3 size: 8395 MB
> node 3 free: 8015 MB
> node distances:
> node   0   1   2   3 
>   0:  10  20  10  20 
>   1:  20  10  20  20 
>   2:  10  20  10  20 
>   3:  20  20  20  10 
> 
> This is because we statically initialize N_ONLINE to be [0] in
> mm/page_alloc.c:
> 
>         [N_ONLINE] = { { [0] = 1UL } },
> 
> I'm not sure what the architectural requirements are here, but at least
> on this test system, removing this initialization, it boots fine and is
> running. I've not yet tried stress tests, but it's survived the
> beginnings of kernbench so far.
> 
> numactl --hardware
> available: 3 nodes (1-3)
> node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
> node 1 size: 0 MB
> node 1 free: 0 MB
> node 2 cpus:
> node 2 size: 7935 MB
> node 2 free: 7479 MB
> node 3 cpus:
> node 3 size: 8396 MB
> node 3 free: 8375 MB
> node distances:
> node   1   2   3 
>   1:  10  20  20 
>   2:  20  10  20 
>   3:  20  20  10
> 
> Perhaps we could put in a ARCH_DOES_NOT_NEED_NODE0 and only define it on
> powerpc for now, conditionalizing the above initialization on that?
> 

I don't know if anything has recently changed in the past year or so, but 
I've booted x86 machines with a hacked BIOS so that all memory on node 0 
is hotpluggable and offline, so I believe this is possible on x86 as well.

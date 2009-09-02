Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B3C1B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:09:06 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89569DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 16:09:05 +1000 (EST)
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com
	[172.24.198.97]) by smtp-out.google.com with ESMTP id n825wlSg001091
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 22:58:47 -0700
Received: from pxi34 (pxi34.prod.google.com [10.243.27.34])
	by wpaz33.hot.corp.google.com with ESMTP id n825vcwU004576
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 22:58:45 -0700
Received: by pxi34 with SMTP id 34so547879pxi.4
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Sep 2009 22:58:44 -0700 (PDT)
Date: Tue, 1 Sep 2009 22:58:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH] Fix fake numa on ppc
In-Reply-To: <20090902053653.GA3806@in.ibm.com>
Message-ID: <alpine.DEB.1.00.0909012246350.26930@chino.kir.corp.google.com>
References: <20090901050316.GA4076@in.ibm.com>
	<20090901055753.GB5563@balbir.in.ibm.com>
	<20090901092407.GC4076@in.ibm.com>
	<20090901142729.GA5022@balbir.in.ibm.com>
	<20090902053653.GA3806@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2 Sep 2009, Ankita Garg wrote:

> > > With the patch,
> > > 
> > > # cat /proc/cmdline
> > > root=/dev/sda6  numa=fake=2G,4G,,6G,8G,10G,12G,14G,16G
> > > # cat /sys/devices/system/node/node0/cpulist
> > > 0-3
> > > # cat /sys/devices/system/node/node1/cpulist
> > > 
> > 
> > Oh! interesting.. cpuless nodes :) I think we need to fix this in the
> > longer run and distribute cpus between fake numa nodes of a real node
> > using some acceptable heuristic.
> >
> 
> True. Presently this is broken on both x86 and ppc systems. It would be
> interesting to find a way to map, for example, 4 cpus to >4 number of
> fake nodes created from a single real numa node!
>  

We've done it for years on x86_64.  It's quite trivial to map all fake 
nodes within a physical node to the cpus to which they have affinity both 
via node_to_cpumask_map() and cpu_to_node_map().  There should be no 
kernel space dependencies on a cpu appearing in only a single node's 
cpumask and if you map each fake node to its physical node's pxm, you can 
index into the slit and generate local NUMA distances amongst fake nodes.

So if you map the apicids and pxms appropriately depending on the 
physical topology of the machine, that is the only emulation necessary on 
x86_64 for the page allocator zonelist ordering, task migration, etc.  (If 
you use CONFIG_SLAB, you'll need to avoid the exponential growth of alien 
caches, but that's an implementation detail and isn't really within the 
scope of numa=fake's purpose to modify.)

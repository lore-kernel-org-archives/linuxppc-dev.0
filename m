Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 389D2B7CD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:37:21 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DD84DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 16:37:18 +1000 (EST)
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id n826bAdA023477
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 23:37:10 -0700
Received: from pxi36 (pxi36.prod.google.com [10.243.27.36])
	by zps36.corp.google.com with ESMTP id n826b7A0013616
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 23:37:08 -0700
Received: by pxi36 with SMTP id 36so606769pxi.7
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Sep 2009 23:37:07 -0700 (PDT)
Date: Tue, 1 Sep 2009 23:37:05 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH v2] Fix fake numa on ppc
In-Reply-To: <20090902060911.GA5728@in.ibm.com>
Message-ID: <alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
References: <20090902060911.GA5728@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2 Sep 2009, Ankita Garg wrote:

> Hi,
> 
> Below is a patch to fix a couple of issues with fake numa node creation
> on ppc:
> 
> 1) Presently, fake nodes could be created such that real numa node
> boundaries are not respected. So a node could have lmbs that belong to
> different real nodes.
> 

On x86_64, we can use numa=off to completely disable NUMA so that all 
memory and all cpus are mapped to a single node 0.  That's an extreme 
example of the above and is totally permissible.

> 2) The cpu association is broken. On a JS22 blade for example, which is
> a 2-node numa machine, I get the following:
> 
> # cat /proc/cmdline
> root=/dev/sda6  numa=fake=2G,4G,,6G,8G,10G,12G,14G,16G
> # cat /sys/devices/system/node/node0/cpulist
> 0-3
> # cat /sys/devices/system/node/node1/cpulist
> 4-7
> # cat /sys/devices/system/node/node4/cpulist
> 
> #
> 

This doesn't show what the true NUMA topology of the machine is, could you 
please post the output of

	$ cat /sys/devices/system/node/node*/cpulist
	$ cat /sys/devices/system/node/node*/distance
	$ ls -d /sys/devices/system/node/node*/cpu[0-8]

from a normal boot without any numa=fake?

> So, though the cpus 4-7 should have been associated with node4, they
> still belong to node1. The patch works by recording a real numa node
> boundary and incrementing the fake node count. At the same time, a
> mapping is stored from the real numa node to the first fake node that
> gets created on it.
> 

If there are multiple fake nodes on a real physical node, all cpus in that 
node should appear in the cpulist for each fake node for which it has 
local distance.

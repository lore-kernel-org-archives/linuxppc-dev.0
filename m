Return-Path: <ankita@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D52BB7BF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 18:04:03 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99DF4DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 18:04:01 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8283lVE014081
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 13:33:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8283lNc1564918
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 13:33:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8283kKA032755
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 18:03:47 +1000
Date: Wed, 2 Sep 2009 13:33:46 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] Fix fake numa on ppc
Message-ID: <20090902080346.GB3806@in.ibm.com>
References: <20090902060911.GA5728@in.ibm.com>
	<alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: Ankita Garg <ankita@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

On Tue, Sep 01, 2009 at 11:37:05PM -0700, David Rientjes wrote:
> On Wed, 2 Sep 2009, Ankita Garg wrote:
> 
> > Hi,
> > 
> > Below is a patch to fix a couple of issues with fake numa node creation
> > on ppc:
> > 
> > 1) Presently, fake nodes could be created such that real numa node
> > boundaries are not respected. So a node could have lmbs that belong to
> > different real nodes.
> > 
> 
> On x86_64, we can use numa=off to completely disable NUMA so that all 
> memory and all cpus are mapped to a single node 0.  That's an extreme 
> example of the above and is totally permissible.
> 
> > 2) The cpu association is broken. On a JS22 blade for example, which is
> > a 2-node numa machine, I get the following:
> > 
> > # cat /proc/cmdline
> > root=/dev/sda6  numa=fake=2G,4G,,6G,8G,10G,12G,14G,16G
> > # cat /sys/devices/system/node/node0/cpulist
> > 0-3
> > # cat /sys/devices/system/node/node1/cpulist
> > 4-7
> > # cat /sys/devices/system/node/node4/cpulist
> > 
> > #
> > 
> 
> This doesn't show what the true NUMA topology of the machine is, could you 
> please post the output of
> 
> 	$ cat /sys/devices/system/node/node*/cpulist
> 	$ cat /sys/devices/system/node/node*/distance
> 	$ ls -d /sys/devices/system/node/node*/cpu[0-8]
> 
> from a normal boot without any numa=fake?
>

Heres the output as requested by you:

# ls /sys/devices/system/node/
has_cpu  has_normal_memory  node0  node1  online  possible
# cat /sys/devices/system/node/node*/cpulist
0-3
4-7
# cat /sys/devices/system/node/node*/distance
10 20
20 10
# ls -d /sys/devices/system/node/node*/cpu[0-8]
/sys/devices/system/node/node0/cpu0  /sys/devices/system/node/node0/cpu3
/sys/devices/system/node/node1/cpu6
/sys/devices/system/node/node0/cpu1  /sys/devices/system/node/node1/cpu4
/sys/devices/system/node/node1/cpu7
/sys/devices/system/node/node0/cpu2  /sys/devices/system/node/node1/cpu5

 
> > So, though the cpus 4-7 should have been associated with node4, they
> > still belong to node1. The patch works by recording a real numa node
> > boundary and incrementing the fake node count. At the same time, a
> > mapping is stored from the real numa node to the first fake node that
> > gets created on it.
> > 
> 
> If there are multiple fake nodes on a real physical node, all cpus in that 
> node should appear in the cpulist for each fake node for which it has 
> local distance.

Currently, the behavior of fake numa is not so on x86 as well? Below is
a sample output from a single node x86 system booted with numa=fake=8:

# cat node0/cpulist

# cat node1/cpulist

...
# cat node6/cpulist

# cat node7/cpulist
0-7

Presently, just fixing the cpu association issue with ppc, as explained
in my previous mail.

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

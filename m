Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBc9r1FmzzDq9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:39:27 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0U4cnS8060687
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 23:39:25 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 289haac05c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 23:39:25 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 14:39:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 14A703578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:39:21 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0U4dDFr29229266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:39:21 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0U4cm3r011991
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 15:38:48 +1100
Date: Mon, 30 Jan 2017 15:38:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan>
 <20170127124910.GA2668@localhost.localdomain>
 <20170130120240.5018f476@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170130120240.5018f476@kryten>
Message-Id: <20170130043823.GA30920@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2017 at 12:02:40PM +1100, Anton Blanchard wrote:
>> Anton suggested that NUMA distances in powerpc mattered and hurted
>> performance without this setting. We need to validate to see if this
>> is still true. A simple way to start would be benchmarking
>
>The original issue was that we never reclaimed local clean pagecache.
>
>I just tried all settings for /proc/sys/vm/zone_reclaim_mode and none
>of them caused me to reclaim local clean pagecache! We are very broken.
>
>I would think we have test cases for this, but here is a dumb one.
>First something to consume memory:
>
># cat alloc.c
>
>#include <stdlib.h>
>#include <unistd.h>
>#include <string.h>
>#include <assert.h>
>
>int main(int argc, char *argv[])
>{
>	void *p;
>
>	unsigned long size;
>
>	size = strtoul(argv[1], NULL, 0);
>
>	p = malloc(size);
>	assert(p);
>	memset(p, 0, size);
>	printf("%p\n", p);
>
>	sleep(3600);
>
>	return 0;
>}
>
>Now create a file to consume pagecache. My nodes have 32GB each, so
>I create 16GB, enough to consume half of the node:
>
>dd if=/dev/zero of=/tmp/file bs=1G count=16
>
>Clear out our pagecache:
>
>sync
>echo 3 > /proc/sys/vm/drop_caches
>
>Bring it in on node 0:
>
>taskset -c 0 cat /tmp/file > /dev/null
>
>Consume 24GB of memory on node 0:
>
>taskset -c 0 ./alloc 25769803776
>
>In all zone reclaim modes, the pagecache never gets reclaimed:
>
># grep FilePages /sys/devices/system/node/node0/meminfo
>
>Node 0 FilePages:      16757376 kB
>
>And our alloc process shows lots of off node memory used:
>
>3ff9a4630000 default anon=393217 dirty=393217 N0=112474 N1=220490 N16=60253 kernelpagesize_kB=64
>
>Clearly nothing is working. Gavin, if your patch fixes this we should
>get it into stable too.
>

Anton, thanks for the detailed test case. I tried what you suggested
on the box that has only one node. The memory capacity is 16GB. So
the parameters I used are different from what you had. First of all,
I observed same behaviour that the pagecache can't be reclaimed when
allocating memory for heap. With the patch applied, the pagecache
can be dropped for page reclaim and more details are showed as below
Everything looks good. I'll put your testcase, its result and stable tag
to next revision.

   root@palm8:/home/gavin# grep FilePages /sys/devices/system/node/node0/meminfo
   Node 0 FilePages:        142400 kB

   root@palm8:/home/gavin# sync
   root@palm8:/home/gavin# echo 3 > /proc/sys/vm/drop_caches

   root@palm8:/home/gavin# grep FilePages /sys/devices/system/node/node0/meminfo
   Node 0 FilePages:         62848 kB

   root@palm8:/home/gavin# du -sh file
   8.1G    file
   root@palm8:/home/gavin# cat file > /dev/null
   root@palm8:/home/gavin# grep FilePages /sys/devices/system/node/node0/meminfo
   Node 0 FilePages:       8448000 kB

   root@palm8:/home/gavin# ./alloc 17179869184
   root@palm8:/home/gavin# grep FilePages /sys/devices/system/node/node0/meminfo
   Node 0 FilePages:        387584 kB

Thanks,
Gavin

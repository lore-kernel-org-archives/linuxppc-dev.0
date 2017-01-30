Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC2Bh3XLLzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:11:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
In-Reply-To: <20170130043823.GA30920@gwshan>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan> <20170127124910.GA2668@localhost.localdomain>
 <20170130120240.5018f476@kryten> <20170130043823.GA30920@gwshan>
Date: Tue, 31 Jan 2017 08:11:39 +1100
Message-ID: <87zii8uub8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> On Mon, Jan 30, 2017 at 12:02:40PM +1100, Anton Blanchard wrote:
>>> Anton suggested that NUMA distances in powerpc mattered and hurted
>>> performance without this setting. We need to validate to see if this
>>> is still true. A simple way to start would be benchmarking
>>
>>The original issue was that we never reclaimed local clean pagecache.
>>
>>I just tried all settings for /proc/sys/vm/zone_reclaim_mode and none
>>of them caused me to reclaim local clean pagecache! We are very broken.
>>
>>I would think we have test cases for this, but here is a dumb one.
>>First something to consume memory:
>>
>># cat alloc.c
>>
>>#include <stdlib.h>
>>#include <unistd.h>
>>#include <string.h>
>>#include <assert.h>
>>
>>int main(int argc, char *argv[])
>>{
>>	void *p;
>>
>>	unsigned long size;
>>
>>	size = strtoul(argv[1], NULL, 0);
>>
>>	p = malloc(size);
>>	assert(p);
>>	memset(p, 0, size);
>>	printf("%p\n", p);
>>
>>	sleep(3600);
>>
>>	return 0;
>>}
>>
>>Now create a file to consume pagecache. My nodes have 32GB each, so
>>I create 16GB, enough to consume half of the node:
>>
>>dd if=/dev/zero of=/tmp/file bs=1G count=16
>>
>>Clear out our pagecache:
>>
>>sync
>>echo 3 > /proc/sys/vm/drop_caches
>>
>>Bring it in on node 0:
>>
>>taskset -c 0 cat /tmp/file > /dev/null
>>
>>Consume 24GB of memory on node 0:
>>
>>taskset -c 0 ./alloc 25769803776
>>
>>In all zone reclaim modes, the pagecache never gets reclaimed:
>>
>># grep FilePages /sys/devices/system/node/node0/meminfo
>>
>>Node 0 FilePages:      16757376 kB
>>
>>And our alloc process shows lots of off node memory used:
>>
>>3ff9a4630000 default anon=393217 dirty=393217 N0=112474 N1=220490 N16=60253 kernelpagesize_kB=64
>>
>>Clearly nothing is working. Gavin, if your patch fixes this we should
>>get it into stable too.
>>
>
> Anton, thanks for the detailed test case. I tried what you suggested
> on the box that has only one node. The memory capacity is 16GB. So
> the parameters I used are different from what you had. First of all,
> I observed same behaviour that the pagecache can't be reclaimed when
> allocating memory for heap. With the patch applied, the pagecache
> can be dropped for page reclaim and more details are showed as below
> Everything looks good. I'll put your testcase, its result and stable tag
> to next revision.

Hi Gavin,

I'd like to see some test results from multi-node systems.

I'd also like to understand what has changed since we changed
RECLAIM_DISTANCE in the first place, ie. why did it used to work and now
doesn't?

cheers

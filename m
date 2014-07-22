Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9C321A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 09:47:37 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 22 Jul 2014 17:47:34 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CA35D1FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 17:47:31 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6MNkI8f3604890
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 01:46:18 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6MNlVNH004733
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 17:47:32 -0600
Date: Tue, 22 Jul 2014 16:47:26 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140722234726.GO4156@linux.vnet.ibm.com>
References: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.02.1402080154140.9668@chino.kir.corp.google.com>
 <20140210010936.GA12574@lge.com>
 <20140722010305.GJ4156@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1407211809140.9778@chino.kir.corp.google.com>
 <20140722214311.GM4156@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140722214311.GM4156@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22.07.2014 [14:43:11 -0700], Nishanth Aravamudan wrote:
> Hi David,

<snip>

> on powerpc now, things look really good. On a KVM instance with the
> following topology:
> 
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
> node 0 size: 0 MB
> node 0 free: 0 MB
> node 1 cpus: 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99
> node 1 size: 16336 MB
> node 1 free: 14274 MB
> node distances:
> node   0   1 
>   0:  10  40 
>   1:  40  10 
> 
> 3.16.0-rc6 gives:
> 
>         Slab:            1039744 kB
> 	SReclaimable:      38976 kB
> 	SUnreclaim:      1000768 kB

<snip>

> Adding my patch on top of Joonsoo's and the revert, I get:
> 
> 	Slab:             411776 kB
> 	SReclaimable:      40960 kB
> 	SUnreclaim:       370816 kB
> 
> So CONFIG_SLUB still uses about 3x as much slab memory, but it's not so
> much that we are close to OOM with small VM/LPAR sizes.

Just to clarify/add one more datapoint, with a balanced topology:

available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
node 0 size: 8154 MB
node 0 free: 8075 MB
node 1 cpus: 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99
node 1 size: 8181 MB
node 1 free: 7776 MB
node distances:
node   0   1 
  0:  10  40 
  1:  40  10

I see the following for my patch + Joonsoo's + the revert:

Slab:             495872 kB
SReclaimable:      46528 kB
SUnreclaim:       449344 kB

(Although these numbers fluctuate quite a bit between 250M and 500M),
which indicates that the memoryless node slab consumption is now on-par
with a populated topology. And both are still more than CONFIG_SLAB
requires.

Thanks,
Nish

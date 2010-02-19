Return-Path: <anton@ozlabs.org>
Date: Fri, 19 Feb 2010 11:07:30 +1100
From: Anton Blanchard <anton@samba.org>
To: mel@csn.ul.ie, benh@kernel.crashing.org, cl@linux-foundation.org
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
Message-ID: <20100219000730.GD31681@kryten>
References: <20100218222923.GC31681@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100218222923.GC31681@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> The patch below sets a smaller value for RECLAIM_DISTANCE and thus enables
> zone reclaim.

FYI even with this enabled I could trip it up pretty easily with a multi
threaded application. I tried running stream across all threads in node 0. The
machine looks like:

node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 free: 30254 MB
node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 1 free: 31832 MB

Now create some clean pagecache on node 0:

# taskset -c 0 dd if=/dev/zero of=/tmp/bigfile bs=1G count=16
# sync

node 0 free: 12880 MB
node 1 free: 31830 MB

I built stream to use about 25GB of memory. I then ran stream across all
threads in node 0:

# OMP_NUM_THREADS=16 taskset -c 0-15 ./stream

We exhaust all memory on node 0, and start using memory on node 1:

node 0 free: 0 MB
node 1 free: 20795 MB

ie about 10GB of node 1. Now if we run the same test with one thread:

# OMP_NUM_THREADS=1 taskset -c 0 ./stream

things are much better:

node 0 free: 11 MB
node 1 free: 31552 MB

Interestingly enough it takes two goes to get completely onto node 0, even
with one thread. The second run looks like:

node 0 free: 14 MB
node 1 free: 31811 MB

I had a quick look at the page allocation logic and I think I understand why
we would have issues with multple threads all trying to allocate at once.

- The ZONE_RECLAIM_LOCKED flag allows only one thread into zone reclaim at
  a time, and whatever thread is in zone reclaim probably only frees a small
  amount of memory. Certainly not enough to satisfy all 16 threads.

- We seem to end up racing between zone_watermark_ok, zone_reclaim and
  buffered_rmqueue. Since everyone is in here the memory one thread reclaims
  may be stolen by another thread.

I'm not sure if there is an easy way to fix this without penalising other
workloads though.

Anton

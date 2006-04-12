Return-Path: <tony.luck@intel.com>
Received: from orsmga101-1.jf.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 4428E67C3E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 02:36:30 +1000 (EST)
Date: Wed, 12 Apr 2006 09:36:19 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060412163619.GA11085@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
	<20060412000500.GA8532@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
	<20060412154633.GA10589@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
Cc: linuxppc-dev@ozlabs.org, ak@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bob.picco@hp.com, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
> Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into 
> my mail setup. I've added Bob Picco to the cc list as he will hit the same 
> issue with whitespace corruption.

Ok!  That boots on the tiger_defconfig.

Some stuff is weird in the dmesg output though.  You report about
twice as many pages in each zone, but then the total memory is
about right.  Here's the diff of my regular kernel (got a bunch of
patches post-2.6.17-rc1) against a 2.6.17-rc1 with your patches
applied.  Note also that the Dentry and Inode caches allocated
twice as much space (presumably based on the belief that there
is more memory).  My guess is that you are counting the holes.

-Tony

19,21c20,37
< On node 0 totalpages: 260725
<   DMA zone: 129700 pages, LIFO batch:7
<   Normal zone: 131025 pages, LIFO batch:7
---
> add_active_range(0, 1024, 130688): New
> add_active_range(0, 130984, 131020): New
> add_active_range(0, 393216, 524164): New
> add_active_range(0, 524192, 524269): New
> Dumping sorted node map
> entry 0: 0  1024 -> 130688
> entry 1: 0  130984 -> 131020
> entry 2: 0  393216 -> 524164
> entry 3: 0  524192 -> 524269
> Hole found index 0: 1024 -> 1024
> Hole found index 1: 130688 -> 130984
> Hole found index 3: 524164 -> 524192
> On node 0 totalpages: 522921
> Hole found index 0: 1024 -> 1024
> Hole found index 1: 130688 -> 130984
>   DMA zone: 260824 pages, LIFO batch:7
> Hole found index 3: 524164 -> 524192
>   Normal zone: 262097 pages, LIFO batch:7
25c41
< Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smp.gz  root=LABEL=/ console=tty1 console=ttyS1,115200 ro
---
> Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smpxx.gz  root=LABEL=/ console=uart,io,0x2f8 ro
29,30c45,46
< Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
< Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
---
> Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
32c48
< Memory: 4070560k/4171600k available (6836k code, 99792k reserved, 2749k data, 256k init)
---
> Memory: 4064416k/4171600k available (6832k code, 105936k reserved, 2753k data, 256k init)

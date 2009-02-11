Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49924348.5050702@am.sony.com>
Date: Tue, 10 Feb 2009 19:17:28 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: problem with numa reserve bootmem
References: <48EE6720.6010601@linux.vnet.ibm.com>
In-Reply-To: <48EE6720.6010601@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

Jon Tollefson wrote:
> This patch takes out the reserved region loop from inside
> the loop that goes over each node.  It looks up the active region containing
> the start of the reserved region.  If it extends past that active region then
> it adjusts the size and gets the next active region containing it.
> 
>  numa.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 80 insertions(+), 28 deletions(-)

I had some problems with this numa change (commit 8f64e1f2d1e09267ac926e15090fd505c1c0cbcb)
missing an lmb reserved region.

There have been some changes to this code since this patch was committed,
but the general problem still exists.

With the PS3 platform, the boot wrapper program puts the device tree
above the boot wrapper's _end symbol.  So with this there is a small
reserved bootmem section for the DT of about 0x270 bytes
(reserved.region[0x1]):

lmb_dump_all:
    memory.cnt            = 0x1
    memory.size           = 0x8000000
    memory.region[0x0].base       = 0x0
                      .size     = 0x8000000
    reserved.cnt          = 0x2
    reserved.size         = 0x8000000
    reserved.region[0x0].base       = 0x0
                      .size     = 0xcc8000
    reserved.region[0x1].base       = 0xce0300
                      .size     = 0x270

> +	/* Mark reserved regions */
> +	for (i = 0; i < lmb.reserved.cnt; i++) {
> +		unsigned long physbase = lmb.reserved.region[i].base;
> +		unsigned long size = lmb.reserved.region[i].size;
> +		unsigned long start_pfn = physbase >> PAGE_SHIFT;
> +		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);

With reserved.region[0x1] start_pfn and end_pfn are equal (0xce0) here.

> +		struct node_active_region node_ar;
> +
> +		get_node_active_region(start_pfn, &node_ar);
> +		while (start_pfn < end_pfn) {

And this while (start_pfn < end_pfn) test fails,

> +			/*
> +			 * if reserved region extends past active region
> +			 * then trim size to active region
> +			 */
> +			if (end_pfn > node_ar.end_pfn)
> +				size = (node_ar.end_pfn << PAGE_SHIFT)
> +					- (start_pfn << PAGE_SHIFT);
> +			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase, size,
> +				node_ar.nid);
> +			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
> +						size, BOOTMEM_DEFAULT);

And so this reserve_bootmem_node() is never called for the small region.

I'm not sure if the problem is the calculation of the end_pfn, or if we
need to test for equality in the while: (start_pfn <= end_pfn).  Please
let me know what you think.  I'll look at it some more tomorrow.

-Geoff

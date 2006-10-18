Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
Date: Wed, 18 Oct 2006 16:11:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph,

I also am hitting this BUG on a POWER5 partition.  The relevant boot
messages are:

Zone PFN ranges:
  DMA             0 ->   524288
  Normal     524288 ->   524288
early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->   278528
    1:   278528 ->   524288
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 513760
Kernel command line: root=/dev/sdc3
[snip]
freeing bootmem node 0
freeing bootmem node 1
Memory: 2046852k/2097152k available (5512k kernel code, 65056k reserved, 2204k data, 554k bss, 256k init)
kernel BUG in __cache_alloc_node at /home/paulus/kernel/powerpc/mm/slab.c:3177!

Since this is a virtualized system there is every possibility that the
memory we get won't be divided into nodes in the nice neat manner you
seem to be expecting.  It just depends on what memory the hypervisor
has free, and on what nodes, when the partition is booted.

In other words, the assumption that node pfn ranges won't overlap is
completely untenable for us.

Linus' tree is currently broken for us.  Any suggestions for how to
fix it, since I am not very familiar with the NUMA code?

Paul.

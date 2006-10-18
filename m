Return-Path: <benh@kernel.crashing.org>
Subject: ibmveth and LIOBN field
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Santiago Leon <santil@us.ibm.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:41:09 +1000
Message-Id: <1161150069.23947.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Santiago !

I'm a bit annoyed by a bit of code in the ibmveth driver:

It accesses the iommu table pointer, to get the index and put it into
it's own private adapter->liobn member. However, that is never used
anywhere except in ibmveth_seq_show() for the /proc stuff to display
this LIOBN value.

Is this actually useful ? I'd like to just remove that code. I'm
changing the DMA operations management globally in the powerpc
architecture and that code now needs fixups. I've done them, but it
annoys me to have this driver dive into data structures like iommu_table
that is should have no business mucking with.

Cheers,
Ben.

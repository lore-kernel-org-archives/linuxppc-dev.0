Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id EF26F67C70
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 05:25:18 +1000 (EST)
Date: Mon, 16 Oct 2006 12:25:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1161026409.31903.15.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 16 Oct 2006, Will Schmidt wrote:

> Node 1 MemTotal:       327680 kB
> Node 1 MemFree:        435704 kB

Too big.

> Node 1 MemUsed:      18446744073709443592 kB

Memused is going negative?

> Node 1 Active:          41412 kB
> Node 1 Inactive:        19976 kB
> Node 1 HighTotal:           0 kB
> Node 1 HighFree:            0 kB
> Node 1 LowTotal:       327680 kB
> Node 1 LowFree:        435704 kB
> Node 1 Dirty:               0 kB
> Node 1 Writeback:           0 kB
> Node 1 Mapped:              0 kB
> Node 1 Slab:                0 kB

zero slab??? That cannot be. The slab allocator always allocs on each 
node. Or is this <2.6.18 with the strange counters that we had before?


> Node 0 MemTotal:       229376 kB
> Node 0 MemFree:             0 kB
> Node 0 MemUsed:        229376 kB

Node 0 is filled up during bootup?

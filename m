Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 99C18DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 03:41:51 +1000 (EST)
Date: Wed, 16 May 2007 10:41:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Slab allocators: Define common size limitations
In-Reply-To: <Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0705161039260.9142@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0705152313490.5832@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 May 2007, Geert Uytterhoeven wrote:

> On Tue, 15 May 2007, Christoph Lameter wrote:
> > So define a common maximum size for kmalloc. For conveniences sake
> > we use the maximum size ever supported which is 32 MB. We limit the maximum
> > size to a lower limit if MAX_ORDER does not allow such large allocations.
> 
> What are the changes a large allocation will actually succeed?
> Is there an alignment rule for large allocations?
> 
> E.g. for one of the PS3 drivers I need a physically contiguous 256 KiB-aligned
> block of 256 KiB. Currently I'm using __alloc_bootmem() for that, but maybe
> kmalloc() becomes a suitable alternative now?

The chance of succeeding drops with the time that the system has been 
running. Typically these large allocs are used when the system is brought 
up. Maybe we will be able to successfully allocate these even after 
memory has gotten significant use when Mel's antifrag/defrag work has 
progressed more.

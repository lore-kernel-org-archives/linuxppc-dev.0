Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91325686EC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 04:25:43 +1100 (EST)
Date: Wed, 9 Nov 2005 10:04:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051109120450.GB8588@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
	<1131396000.4652.24.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131396000.4652.24.camel@gaston>
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 07:39:59AM +1100, Benjamin Herrenschmidt wrote:
<snip>
> I think the current code, even with your fix, is sub-optimal. But of
> course, the only way to be sure is to do real measurements


Hi folks,

I've written a simple app to estimate pagefault latency using gettimeofday().

Can be found at http://hera.kernel.org/~marcelo/measurefault/

/* This simple program attemps to estimate how long a pagefault takes.
 * It does that by mmaping() /tmp/latency-test, and touching a page.
 * Time measurement is done with gettimeofday() before and after the 
 * data touch.
 *
 * In the hope to have a more precise measurement two values are subtracted
 * from the pagefault time delta:
 *
 * - Estimated time between two subsequent gettimeofday() calls, average
 *   of 100 runs (this average is around 8ms on 48Mhz PPC 8xx, 
 *   0ms on 1Ghz Pegasos G4)
 * 
 * - Time taken to touch the data after its TLB cached, aka second run.
 *   This takes  1 and 2ms on 8xx (it varies) and 0ms on 1Ghz Pegasos.
 */

And results with 48Mhz 855T, comparing internal v2.4.17, vanilla v2.6.14
and v2.6.14-jump-direct (jumping directly to handle_page_fault if the
pte is zeroed).

Each "avg:" entry is an average of 100 "measure-fault-latency.c" runs.

2.6's root is mounted on NFS.

** 2.6.14 DataTLBHandler jump direct ("two exceptions"):

first batch:
avg: 287ms
avg: 287ms
avg: 287ms
avg: 287ms
avg: 287ms

second batch:
avg: 287ms
avg: 287ms
avg: 287ms
avg: 287ms
avg: 287ms

** 2.6.14 vanilla ("three exceptions"):

first batch:
avg: 288ms
avg: 285ms
avg: 287ms
avg: 287ms
avg: 288ms

second batch:
avg: 288ms
avg: 288ms
avg: 287ms
avg: 287ms
avg: 287ms

** 2.4.17 (root on RAMDISK):

avg: 309ms
avg: 313ms
avg: 312ms
avg: 311ms
avg: 310ms


The v2.6.14's kernel jump-direct is more consistent at 287ms,
while vanilla 2.6.14 oscillates between 285 and 288ms, but 
no significant difference between the two.

v2.6's fault handling is clearly faster than 2.4's (note that the compiler
is also different, 2.4 uses gcc 2.95 and 2.6 gcc 3.3).

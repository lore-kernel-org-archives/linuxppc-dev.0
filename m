Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F03FDDDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:10:21 +1100 (EST)
Message-ID: <47CDAC58.6090207@cs.helsinki.fi>
Date: Tue, 04 Mar 2008 22:08:56 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20080304103636.3e7b8fdd.akpm@linux-foundation.org>
	<47CDA081.7070503@cs.helsinki.fi> <20080304193532.GC9051@csn.ul.ie>
	<84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
	<Pine.LNX.4.64.0803041151360.18160@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0803042200410.8545@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0803041205370.18277@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0803041205370.18277@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Lameter wrote:
> I think this is the correct fix.
> 
> The NUMA fallback logic should be passing local_flags to kmem_get_pages() 
> and not simply the flags.
> 
> Maybe a stable candidate since we are now simply 
> passing on flags to the page allocator on the fallback path.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Indeed, good catch. I spotted the same thing just few seconds ago.

Reviewed-by: Pekka Enberg <penberg@cs.helsinki.fi>

Was it you Kamalesh that reported this? Can you please re-test?

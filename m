Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEFBB67D2F
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:53:39 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
Date: Thu, 13 Apr 2006 01:53:07 +0200
References: <20060412232036.18862.84118.sendpatchset@skynet>
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604130153.08604.ak@suse.de>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, bob.picco@hp.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 April 2006 01:20, Mel Gorman wrote:
> This is V2 of the patchset. They have been boot tested on x86, ppc64
> and x86_64 but I still need to do a double check that zones are the
> same size before and after the patch on all arches. IA64 passed a
> basic compile-test. a driver program that fed in the values generated
> by IA64 to add_active_range(), zone_present_pages_in_node() and
> zone_absent_pages_in_node() seemed to generate expected values.

For x86-64  the new code seems far more complicated than the old one and keeps
the same information in two places now. I have my doubts that is really a 
improvement over the old state.

I think it would be better if you just defined some simple "library functions"
that can be called from the architecture specific code instead of adding
all this new high level code.

-Andi

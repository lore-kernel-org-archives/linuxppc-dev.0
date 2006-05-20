Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE5DD679F6
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 08:54:29 +1000 (EST)
Date: Sat, 20 May 2006 15:54:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
Message-Id: <20060520155401.3048be0d.akpm@osdl.org>
In-Reply-To: <200605210017.59984.ak@suse.de>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<200605202327.19606.ak@suse.de>
	<20060520144043.22f993b1.akpm@osdl.org>
	<200605210017.59984.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	mel@csn.ul.ie, linux-kernel@vger.kernel.org, bob.picco@hp.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andi Kleen <ak@suse.de> wrote:
>
>  
> > Well, it creates arch-neutral common code, teaches various architectures
> > use it.  It's the sort of thing we do all the time.
> > 
> > These things are opportunities to eliminate crufty arch code which few
> > people understand and replace them with new, clean common code which lots
> > of people understand.  That's not a bad thing to be doing.
> 
> I'm not fundamentally against that, but so far it seems to just generate lots of 
> new bugs?  I'm not sure it's really worth the pain.
> 

It is a bit disproportionate.  But in some ways that's a commentary on the
current code.   All this numa/sparse/flat/discontig/holes-in-zones/
virt-memmap/ stuff is pretty hairy, especially in its initalisation.

I'm willing to go through the pain if it ends up with something cleaner
which more people understand a little bit.

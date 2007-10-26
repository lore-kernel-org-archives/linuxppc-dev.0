Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 68C86DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 12:45:26 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so637699rvf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 19:45:25 -0700 (PDT)
Message-ID: <fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
Date: Thu, 25 Oct 2007 20:45:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: Apparent kernel bug with GDB on ppc405
In-Reply-To: <1193363202.7018.36.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org,
	Matt Mackall <mpm@selenic.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/25/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Wed, 2007-10-24 at 14:46 -0500, Matt Mackall wrote:
> >
> > My first suspicion was a dcache/icache coherency issue in
> > copy_to_user_page, so I added flush_dcache_icache_page(page) here to
> > no avail. On closer inspection, it looks like both icache and dcache
> > are already being flushed by flush_icache_user_range().
> >
> > Adding printk(".") (or any printk) in this function here fixes things
> > (serial console at 115k), while printk("") and udelay(100) do not.
> > Which still suggests an icache bug..?
> >
> > Any suggestions?
>
> I think you're hitting a known bug of 44x support. Those CPUs have a
> crazy virtually tagged icache and the kernel doesn't deal with it at all
> (pretty much...). We just are lucky things generally work :-)
>
> That means among other things that flush_icache_* will not work because
> they kmap pages and use that mapping. The only way to flush icache user
> pages with 44x is to actually flush with the user virtual address
> (meaning you have to be in the current context, and you probably need to
> have a TLB entry there... yuck)... or just blow the whole icache away.

This is actually 405.  Does that have the same issue?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 03C76DDF23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 06:42:24 +1000 (EST)
Date: Wed, 24 Oct 2007 15:42:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Apparent kernel bug with GDB on ppc405
Message-ID: <20071024204215.GC19691@waste.org>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 02:28:14PM -0600, Grant Likely wrote:
> On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> > I'm trying to debug a trivial statically-linked hello world program on
> > a Xilinx PPC 405 and I'm seeing the following behavior:
> >
> <snip>
> >
> > Any suggestions?
> 
> http://thread.gmane.org/gmane.linux.ports.ppc.embedded/11202
> 
> I was fighting with a similar problem almost 2 years ago.  Looks like
> it might be related.  At some point the problem seemed to go away and
> I determined what the root cause was.  :-(
> 
> I haven't been using gdb lately, so I don't know if it's the same
> problem.  Nobody I had talked to had seen the issue on other 405
> platforms.  It could very well be something virtex-specific.

Could be the same problem, but I'm seeing only your symptom 3 so far.

I've tried throwing some larger hammers at the problem. Flushing all
of the dcache and icache (flush_dcache_all and
flush_instruction_cache) isn't helping. But printk(".") does!

-- 
Mathematics is the supreme nostalgia of our time.

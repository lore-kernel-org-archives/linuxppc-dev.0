Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 4680967A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 10:30:09 +1100 (EST)
Date: Tue, 8 Mar 2005 16:30:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050308163001.D8434@cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592EB@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8592EB@ismail.innsys.innovsys.com>;
	from runet@innovsys.com on Tue, Mar 08, 2005 at 05:20:38PM -0600
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 05:20:38PM -0600, Rune Torgersen wrote:
> > -----Original Message-----
> > From: Kumar Gala [mailto:kumar.gala@freescale.com] 
> > Sent: Tuesday, March 08, 2005 17:14
> > To: Rune Torgersen
> > Cc: linuxppc-embedded@ozlabs.org; Matt Porter
> > Subject: Re: Lots of memory on 826x
> > 
> > Hmm, I think there is an expectation that virt->phys is a simple 
> > translation (ie, subtract KERNELBASE) for lowmem.  lowmem most parts 
> > tops out at 768M.  So changing VMALLOC_START would break that.
> 
> Yep noticed..... (tried changing it...)

Yeah, sorry, got busy and couldn't reply to say, "don't do that!". :)
 
> > Is there an issue with moving the IMMR virt address up higher?
> Not really. Will have to redo a whole lot of address maps for some
> external devices, but not too bad...
> 
> I did change the kernel start address, and that seems to work better,
> except that things is still broken when CONFIG_HIGHMEM is set
> When that option is set, it maps the highmem to 0xFE000000, which is in
> the IO area mapped for IMMR and other memory mapped devices.
> (0xF0000000-0xFFFFFFFF)
> 
> This can be changed by CONFIG_HIGHMEM_START. Any good ideas on where to
> move it to?
> 
> (Maybe change IMMR/IO to 0xF8000000 and up, and set HIGHMEM_START to
> 0xF0000000?)

Ahh, but early ioremaps (before mm is inited) grow down from PKMAP_BASE,
so you will be overlapping the top of lowmem with those allocations.
It wants to be above vmalloc space.  Set HIGHMEM_START to 0xF6000000,
IMMR/IO to 0xF8000000 and you then have vmalloc space between
0xF1000000-0xF5FFFFFF.

-Matt

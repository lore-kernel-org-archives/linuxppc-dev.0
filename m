Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B1DBB6F94
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 20:14:51 +1000 (EST)
Subject: RE: Relocatable kernel for ppc44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD9E@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AD9E@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jun 2011 20:14:36 +1000
Message-ID: <1308132876.2516.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu,
	Suzuki Poulose <suzuki@in.ibm.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-15 at 10:30 +0100, David Laight wrote:
> > The PPC440X currently uses 256M TLB entries to pin the 
> > lowmem. When we go for a relocatable kernel we have to :
> > 
> > 1) Restrict the kernel load address to be 256M aligned
> > 
> > OR
> > 
> > 2) Use 16M TLB(the next possible TLB page size supported) 
> > entries till the first
> > 256M and then use the 256M TLB entries for the rest of lowmem.
> 
> What is wrong with:
> 
> 3) Use 256M TLB entries with the lowest one including
>    addresses below the kernel base.
> 
> Clearly the kernel shouldn't be accessing the addresses
> below its base address - but that is true of a lot of
> address space mapped into the kernel.

In the case of a relocatable kernel it's perfectly kosher to access
addresses below the kernel itself... Typically this is used for kdump
where the kdump kernel excecutes in place in a reserved area but access
to the rest of memory is allowed to ... well, do the dump :-) There
could be other reasons to do that too.

Cheers,
Ben.

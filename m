Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CF49DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 23:01:51 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc: Fix 32 bits mm operations when not using BATs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1174564853.10836.39.camel@localhost.localdomain>
References: <20070322030114.D5B9FDDF2B@ozlabs.org>
	<3839ac2050c6dcf8c0062b4a367b2ba9@kernel.crashing.org>
	<1174564853.10836.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 23:01:40 +1100
Message-Id: <1174564900.10836.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-22 at 23:00 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-03-22 at 12:55 +0100, Segher Boessenkool wrote:
> > > +	 * If the hash table bucket is full of kernel text entries, we'll
> > > +	 * lockup here but that shouldn't happen
> > 
> > On 32-bit we have room for one HPTE per real page -- assuming
> > the kernel text is fully enclosed inside one power-of-two
> > size and aligned range of address space (i.e. always ;-) ),
> > a lockup here _cannot_ happen.  It doesn't get tight until you
> > start using all of memory as kernel text.
> 
> I know, which is why "shouldn't" is a good enough choice of word :-)
> 
> > So replace this comment with something like "the HTAB is
> > sized such that no PTEG can overflow from kernel text alone"?
> > It sounds a lot less hand-wavy than "but this shouldn't happen".

Note that there is still a potential of a second entry due to the
secondary group but that wouldn't happen in practice :-)

Ben.

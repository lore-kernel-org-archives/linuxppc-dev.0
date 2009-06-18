Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 39133B728F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 08:24:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85931DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 08:24:39 +1000 (EST)
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
In-Reply-To: <4A3AA3FE.8090903@freescale.com>
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
	<1245124418.12400.67.camel@pasglop>  <4A37AC09.1020200@freescale.com>
	<1245188026.14036.17.camel@pasglop>  <4A3AA3FE.8090903@freescale.com>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 08:22:31 +1000
Message-Id: <1245363751.8693.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-18 at 16:30 -0400, Geoff Thorpe wrote:
> I've left the volatile qualifier in the generated API because I didn't
> feel so comfortable changing APIs, but I also added the "memory" clobber
> for all cases - whereas it seems the existing set_bits(), clear_bits(),
> [...] functions didn't declare this... Do you see any issue with having
> the 'volatile' in the prototype as well as the clobber in the asm?
> 
> Actually, might as well just respond to the new patch instead... :-) Thx.

I think the story with the memory clobber is that it depends whether
we consider the functions as ordering accesses or not (ie, can
potentially be used with lock/unlock semantics).

The general rule is that those who don't return anything don't need
to have those semantics, and thus could only be advertised as clobbering
p[word] -but- there are issues there. For example, despite the
(relatively new) official _lock/_unlock variants, there's still code
that abuses constructs like test_and_set_bit/clear_bit as locks and in
that case, clear bits needs a clobber.

So I would say at this stage better safe than having to track down
incredibly hard to find bugs, and let's make them all take that clobber.

Cheers,
Ben.

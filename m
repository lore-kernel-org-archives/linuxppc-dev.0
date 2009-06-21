Return-Path: <elendil@planet.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5C7CEB7214
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 14:28:39 +1000 (EST)
Received: from CPSMTPM-EML102.kpnxchange.com (cpsmtpm-eml102.kpnxchange.com
	[195.121.3.6]) by ozlabs.org (Postfix) with ESMTP id 9CCE6DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 14:28:38 +1000 (EST)
From: Frans Pop <elendil@planet.nl>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Badness on the Warp
Date: Sun, 21 Jun 2009 06:28:33 +0200
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
	<20090620194250.5a3e826f@lappy.seanm.ca>
In-Reply-To: <20090620194250.5a3e826f@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906210628.35553.elendil@planet.nl>
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 21 June 2009, Sean MacLennan wrote:
> I found the source of the badness. The backtrace is correct:
>
> uic_init_one

So that's in arch/powerpc/sysdev/uic.c.

> ___alloc_bootmem
> ___alloc_bootmem_nopanic
> alloc_arch_preferred_bootmem
>
> In alloc_arch_preferred_bootmem we have:
>
> 	if (WARN_ON_ONCE(slab_is_available()))
> 		return kzalloc(size, GFP_NOWAIT);
>
> Since the slab is available (it had better be or the call will return
> NULL), we get the badness message, then a successful return from
> kzalloc.
>
> I believe the author wants something like:
>
> 	if (slab_is_available())
> 		return kzalloc(size, GFP_NOWAIT);
> 	else
> 		WARN_ON_ONCE(1);

Well, I myself have no idea. It could also indicate a bug in the uic code.

But let's CC some people responsible for this code. Pekka recently added 
this WARN that triggers in your case; David and Paul look to be the 
people most involved in the uic code.

Start of the thread is at http://lkml.org/lkml/2009/6/20/165.

Cheers,
FJP

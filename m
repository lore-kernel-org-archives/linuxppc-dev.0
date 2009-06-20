Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF943B723D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 09:42:54 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 92255DDD1C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 09:42:53 +1000 (EST)
Date: Sat, 20 Jun 2009 19:42:50 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Frans Pop <elendil@planet.nl>
Subject: Re: Badness on the Warp
Message-ID: <20090620194250.5a3e826f@lappy.seanm.ca>
In-Reply-To: <200906202256.46073.elendil@planet.nl>
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I found the source of the badness. The backtrace is correct:

uic_init_one
___alloc_bootmem
___alloc_bootmem_nopanic
alloc_arch_preferred_bootmem

In alloc_arch_preferred_bootmem we have:

	if (WARN_ON_ONCE(slab_is_available()))
		return kzalloc(size, GFP_NOWAIT);

Since the slab is available (it had better be or the call will return
NULL), we get the badness message, then a successful return from
kzalloc.

I believe the author wants something like:

	if (slab_is_available())
		return kzalloc(size, GFP_NOWAIT);
	else
		WARN_ON_ONCE(1);

Cheers,
   Sean

Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BFF767B59
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:06:18 +1000 (EST)
In-Reply-To: <20060919182953.GK29167@austin.ibm.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <77C8C668-35CF-48A9-8E5F-352E496E25D4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] convert string i/o operations to C
Date: Tue, 19 Sep 2006 21:06:02 +0200
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What does this twi do? According to my powerpc docs, this would be a
> no-op.  Does this have some magic synchronizing powers on certain
> implementations?

On all implementations; it's in the PowerPC architecture.

A data-dependent branch followed by an isync ensures that no
instructions after the isync in program order will be
(speculatively) executed, so the load that the twi depends
on has to complete before anything else is executed; in
particular, it's a barrier to keep MMIO reads ordered before
main-storage accesses.

Note that twi alone is not enough; it needs an isync as well.
Any other data-dependent branch instead of twi would do fine
as well.


Segher

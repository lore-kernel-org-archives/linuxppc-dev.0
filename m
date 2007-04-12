Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52E50DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 17:43:14 +1000 (EST)
In-Reply-To: <boot-4-04.miltonm@bga.com>
References: <boot-4-04.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a965688ebce046ac66fe18168e0d24e1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/8] bootwrapper: help for 64 bit cpus
Date: Thu, 12 Apr 2007 09:43:09 +0200
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	/* We are in 64-bit mode.  This program must run in 32 bit
> +	 * mode.  Assume we are actually running somewhere in the
> +	 * low 32 bits of the address space, so we can just turn
> +	 * off MSR[SF] which is bit 0.
> +	 */
> +	.machine push
> +	.machine "ppc64"
> +	rldicl	r0,r0,0,1
> +	sync
> +	mtmsrd	r0
> +	isync
> +	.machine pop

I'm not sure this actually works on all CPUs --
aren't you supposed to use rfid for this?


Segher

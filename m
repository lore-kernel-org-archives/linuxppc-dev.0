Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1FA3DDF65
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:55:53 +1100 (EST)
In-Reply-To: <20070322030114.D5B9FDDF2B@ozlabs.org>
References: <20070322030114.D5B9FDDF2B@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3839ac2050c6dcf8c0062b4a367b2ba9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc: Fix 32 bits mm operations when not using BATs
Date: Thu, 22 Mar 2007 12:55:46 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	 * If the hash table bucket is full of kernel text entries, we'll
> +	 * lockup here but that shouldn't happen

On 32-bit we have room for one HPTE per real page -- assuming
the kernel text is fully enclosed inside one power-of-two
size and aligned range of address space (i.e. always ;-) ),
a lockup here _cannot_ happen.  It doesn't get tight until you
start using all of memory as kernel text.

So replace this comment with something like "the HTAB is
sized such that no PTEG can overflow from kernel text alone"?
It sounds a lot less hand-wavy than "but this shouldn't happen".


Segher

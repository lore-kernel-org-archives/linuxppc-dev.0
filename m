Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A197DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 23:50:30 +1000 (EST)
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Mon, 14 May 2007 15:50:07 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  - Cleanup and separate tracking of the ISA space in the reserved
>    low 64K of IO space. No ISA -> Nothing mapped there.

> I now always reserve the first 64K of IO space for the bridge with
> the ISA bus on it.

This is wrong -- there are systems with ISA that
also have PCI devices that require 16-bit legacy
I/O windows (e.g., systems with the AMD8111 chip,
like Maple).

Or do you mean you reserve the low 64k for the PHB?
That would work in this case, but still not in
general.  Not sure if we care though.


Segher

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A5BAEDDF20
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 09:17:22 +1000 (EST)
Date: Mon, 09 Apr 2007 16:17:22 -0700 (PDT)
Message-Id: <20070409.161722.59655367.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: David Miller <davem@davemloft.net>
In-Reply-To: <17946.33766.593173.670008@cargo.ozlabs.ibm.com>
References: <1175814107.30879.143.camel@localhost.localdomain>
	<1e26dd33aaeae9c55962be681b85e75e@kernel.crashing.org>
	<17946.33766.593173.670008@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 10 Apr 2007 04:20:22 +1000

> This is true according to the standard (as I understand it), and also
> a classic example of the C standards committee stuffing up the C
> language by trying to turn it into a "high-level" language.  From the
> earliest days of C on the PDP-11 it was understood that memory was an
> array of bytes which could be addressed and interpreted in any way the
> programmer chose.  For systems programming tasks that is a very useful
> facility, and one which the kernel code generally assumes.  It's a
> pity IMHO that the committee chose to throw that away (and yes I
> understand that throwing it away makes more optimization opportunities
> available).

To be honest I think they did the right thing.

99,999,999,999 times out of 100,000,000,000 independant pointers do
not alias each other at all.

But regardless of what one thinks, we don't enable strict aliasing in
the kernel build anyways, so none of this even matters for us.

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B65E5DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 17:02:30 +1000 (EST)
Date: Wed, 16 May 2007 00:02:36 -0700 (PDT)
Message-Id: <20070516.000236.71091606.davem@davemloft.net>
To: Geert.Uytterhoeven@sonycom.com
Subject: Re: Slab allocators: Define common size limitations
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0705152313490.5832@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, clameter@sgi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Wed, 16 May 2007 08:58:39 +0200 (CEST)

> E.g. for one of the PS3 drivers I need a physically contiguous 256
> KiB-aligned block of 256 KiB. Currently I'm using __alloc_bootmem()
> for that, but maybe kmalloc() becomes a suitable alternative now?

I'm allocating up to 1MB for per-process TLB hash tables
on sparc64.  But I can gracefully handle failures and it's
just a performance tweak to use such large sized tables.

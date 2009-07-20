Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 064E6B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 11:54:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63A82DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 11:54:16 +1000 (EST)
Subject: Re: proper way to reserve a chunk of memory at the top of the kernel?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4A5CF62F.6020102@nortel.com>
References: <4A5CF62F.6020102@nortel.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 11:54:05 +1000
Message-Id: <1248054845.13067.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-14 at 15:18 -0600, Chris Friesen wrote:
> I have a powerpc board with 512BM of memory.  The BIOS has a chunk of
> memory at the top end of physical memory which it does not zero out over
> a reboot.
> 
> What's the proper way to tell linux that this chunk of physical memory
> should be ignored (so that we can access it later without worrying that
> Linux will try to allocate it)?  Should I be calling
> 
> lmb_reserve(lmb_end_of_DRAM() - size, size);
> 
> in early_reserve_mem() or is there a better mechanism?

The device-tree blob contains a special "reserve map" in the header,
which automatically turns into calls to lmb_reserve() early during boot,
so putting your special region in that map should be the right way to do
what you want without special code.

> For comparison, in an older kernel this was done in set_phys_avail(), by
> calling mem_pieces_remove(&phys_avail, total_lowmem - size, size, 1);

Cheers,
Ben.

> Thanks,
> 
> Chris
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

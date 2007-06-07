Return-Path: <SRS0+8f2be1f524bb961c24bd+1383+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EEBC8DDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:01:07 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: David Woodhouse <dwmw2@infradead.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <466323EF.5040807@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 16:00:42 +0100
Message-Id: <1181228442.2785.60.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 00:26 +0400, Sergei Shtylyov wrote:
>     Erm, FSL boards seem to generally have dual 16-bit NOR flash chips 
> interleaved -- and that's seems quite a common case, not only in PPC world.

Yes, it's something we've seen quite frequently. It's a common way of
improving read/write/erase speed.

>     Perhaps... those interleaved chips could really be merged (abstracted) 
> into a single one, with the bus width being a sum of two?

That's how Linux deals with it, as I'm sure you're aware. Other
operating systems do likewise. If two 'separate' flash chips hold
alternate bytes of a given address range, you really don't gain much by
representing them as two separate devices to the system.

Any representation of flash devices in the device-tree should ideally
have 'bus width' and 'interleave' properties to contain this
information.

The 'bus width' cannot necessarily be inferred, especially where a given
bus can be configured to allow multiple sizes of access. It's purely a
function of how the flash chips are wired up. That's why we actually
call it 'bank width', not 'bus width' in the Linux code.

-- 
dwmw2

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1FF15DDEE4
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 14:47:10 +1100 (EST)
Date: Sat, 03 Nov 2007 20:47:08 -0700 (PDT)
Message-Id: <20071103.204708.53698457.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [POWERPC] Fix link errors for allyesconfig
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
References: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 4 Nov 2007 13:28:39 +1100

> An allyesconfig build creates a .text section that is so big that the
> .text.init.refok and .fixup sections are too far away for the relocations
> to be fixed up correctly. This patch fixes that by linking all the
> relevent text sections for each file together.
> 
> Suggested by Paul Mackerras.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> This still leaves us with the problem that the TOC overflows.
> 
> Dave, would something like this help as an alternative to the .fixup
> change you committed recently?

It might, I'll make some tests when I get a chance.

Thanks for pointing this out Stephen.

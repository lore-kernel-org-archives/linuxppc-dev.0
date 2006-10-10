Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 816EA67B56
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 05:34:56 +1000 (EST)
Date: Tue, 10 Oct 2006 12:34:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-Id: <20061010123449.7be924f0.akpm@osdl.org>
In-Reply-To: <20061010121519.447d62f8@localhost.localdomain>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<20061010121519.447d62f8@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Vadim Lobanov <vlobanov@speakeasy.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2006 12:15:19 -0500
Olof Johansson <olof@lixom.net> wrote:

> I keep hitting this on -rc1-mm1. The system comes up but I can't login
> since login hits it.
> 
> Bisect says that fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.
> 
> CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's fine.
> 
> (Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES, defaults 
> on all new options)
> 
> 
> 
> kernel BUG in copy_fdtable at fs/file.c:138!

OK, thanks.  I put the revert patch into
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes/

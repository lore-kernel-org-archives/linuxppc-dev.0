Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77H94DkvzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:47:17 +1000 (AEST)
In-Reply-To: <1492089276-13713-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: lorenzo.pieralisi@arm.com, linux@armlinux.org.uk
Subject: Re: powerpc: Drop include of linux/io.h from asm/io.h
Message-Id: <3w77H939cXz9s7M@ozlabs.org>
Date: Wed, 19 Apr 2017 13:47:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 13:14:36 UTC, Michael Ellerman wrote:
> Currently powerpc's asm/io.h includes linux/io.h, and linux/io.h
> includes asm/io.h.
> 
> This can cause problems because depending on which is included first the
> order of definitions between the two files will change.
> 
> The include of linux/io.h was added back in 2008 in commit b41e5fffe8b8
> ("[POWERPC] devres: Add devm_ioremap_prot()"). It's not entirely clear
> it was needed then, but devm_ioremap_prot() has since been removed
> entirely as unused, in dedd24a12fe6 ("powerpc: Remove unused
> devm_ioremap_prot()").
> 
> So it seems to be unnecessary and can potentially cause problems, so
> remove the include of linux/io.h from asm/io.h
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/590c369e7ecc00be736be39ae0c62d

cheers

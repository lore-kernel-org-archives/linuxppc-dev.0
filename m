Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90B931A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 21:06:52 +1100 (AEDT)
Message-ID: <1445335611.2152.4.camel@ellerman.id.au>
Subject: Re: linux-next: build warning after merge of the powerpc tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Denis Kirjanov
 <kda@linux-powerpc.org>
Date: Tue, 20 Oct 2015 21:06:51 +1100
In-Reply-To: <20151020162155.01391301@canb.auug.org.au>
References: <20151020162155.01391301@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-20 at 16:21 +1100, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> WARNING: vmlinux.o(.text+0x9367c): Section mismatch in reference from the function .msi_bitmap_alloc() to the function .init.text:.memblock_virt_alloc_try_nid()
> The function .msi_bitmap_alloc() references
> the function __init .memblock_virt_alloc_try_nid().
> This is often because .msi_bitmap_alloc lacks a __init
> annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.
> 
> Introduced (probably) by commit
> 
>   cb2d3883c603 ("powerpc/msi: Free the bitmap if it was slab allocated")


Yeah that's correct, though it should be safe in practice.

I'm not sure why you only saw that now though, the patch has been in next since
the 13th of October.

cheers

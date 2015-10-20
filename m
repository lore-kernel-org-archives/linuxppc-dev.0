Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32A391A0B9E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:45:08 +1100 (AEDT)
Date: Wed, 21 Oct 2015 07:45:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt  <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Denis Kirjanov  <kda@linux-powerpc.org>
Subject: Re: linux-next: build warning after merge of the powerpc tree
Message-ID: <20151021074507.46c85604@canb.auug.org.au>
In-Reply-To: <1445335611.2152.4.camel@ellerman.id.au>
References: <20151020162155.01391301@canb.auug.org.au>
 <1445335611.2152.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, 20 Oct 2015 21:06:51 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> On Tue, 2015-10-20 at 16:21 +1100, Stephen Rothwell wrote:
> 
> > After merging the powerpc tree, today's linux-next build (powerpc
> > allyesconfig) produced this warning:
> > 
> > WARNING: vmlinux.o(.text+0x9367c): Section mismatch in reference from the function .msi_bitmap_alloc() to the function .init.text:.memblock_virt_alloc_try_nid()
> > The function .msi_bitmap_alloc() references
> > the function __init .memblock_virt_alloc_try_nid().
> > This is often because .msi_bitmap_alloc lacks a __init
> > annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.
> > 
> > Introduced (probably) by commit
> > 
> >   cb2d3883c603 ("powerpc/msi: Free the bitmap if it was slab allocated")  
> 
> Yeah that's correct, though it should be safe in practice.
> 
> I'm not sure why you only saw that now though, the patch has been in next since
> the 13th of October.

I don't always notice new warnings immediately among all the others :-(

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

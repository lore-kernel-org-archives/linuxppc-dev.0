Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC5951A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 17:40:08 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/msi: fix section mismatch warning
Date: Wed, 21 Oct 2015 08:34:33 +0200
Message-ID: <29528945.sG1Zff2dkQ@wuerfel>
In-Reply-To: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
References: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 21 October 2015 08:56:44 Denis Kirjanov wrote:
> Building with CONFIG_DEBUG_SECTION_MISMATCH
> gives the following warning:
> 
> WARNING: vmlinux.o(.text+0x41fa8): Section mismatch in reference from
> the function .msi_bitmap_alloc() to the function
> .init.text:.memblock_virt_alloc_try_nid()
> The function .msi_bitmap_alloc() references
> the function __init .memblock_virt_alloc_try_nid().
> This is often because .msi_bitmap_alloc lacks a __init
> annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> 

A patch like this usually requires an explanation why the warning is
a false positive and why there is no way to solve it besides suppressing
the warning.

	Arnd

Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0105.outbound.protection.outlook.com [65.55.169.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 259BE1A05FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 09:39:14 +1000 (AEST)
Date: Mon, 28 Sep 2015 18:39:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 05/25] powerpc/8xx: Fix vaddr for IMMR early remap
Message-ID: <20150928233900.GB6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <83ffd345e7a3fe00443e32b6caf900e7618453d6.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <83ffd345e7a3fe00443e32b6caf900e7618453d6.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:38PM +0200, Christophe Leroy wrote:
> Memory: 124428K/131072K available (3748K kernel code, 188K rwdata,
> 648K rodata, 508K init, 290K bss, 6644K reserved)
> Kernel virtual memory layout:
>   * 0xfffdf000..0xfffff000  : fixmap
>   * 0xfde00000..0xfe000000  : consistent mem
>   * 0xfddf6000..0xfde00000  : early ioremap
>   * 0xc9000000..0xfddf6000  : vmalloc & ioremap
> SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> 
> Mapping IMMR 1:1 is just wrong because it may overlap with another
> area. On most mpc8xx boards it is OK because IMMR is set to
> 0xff000000 but for instance on EP88xC board, IMMR is at 0xfa200000
> which overlaps with VM ioremap area
> 
> This patch fixes the virtual address for remapping IMMR to 0xff000000,
> regardless of the value of IMMR.
> 
> The size of IMMR area is 256kbytes (CPM at offset 0, security engine
> at offset 128) so 512kbytes is enough and allows to handle the EP88xC
> case (which is not 8Mbytes but only 2Mbytes aligned) the same way.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Instead of hardcoding 0xff000000, can you use asm/fixmap.h to allocate a
virtual address at compile time?

-Scott

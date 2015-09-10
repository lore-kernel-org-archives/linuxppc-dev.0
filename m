Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED4871A0796
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 14:55:08 +1000 (AEST)
Message-ID: <1441860908.31931.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: MSI: Fix race condition in tearing down MSI
 interrupts
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 10 Sep 2015 14:55:08 +1000
In-Reply-To: <20150910043621.GA21735@iris.ozlabs.ibm.com>
References: <20150910043621.GA21735@iris.ozlabs.ibm.com>
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

On Thu, 2015-09-10 at 14:36 +1000, Paul Mackerras wrote:
> This fixes a race which can result in the same virtual IRQ number
> being assigned to two different MSI interrupts.  The most visible
> consequence of that is usually a warning and stack trace from the
> sysfs code about an attempt to create a duplicate entry in sysfs.
> 
> The race happens when one CPU (say CPU 0) is disposing of an MSI
> while another CPU (say CPU 1) is setting up an MSI.  CPU 0 calls
> (for example) pnv_teardown_msi_irqs(), which calls
> msi_bitmap_free_hwirqs() to indicate that the MSI (i.e. its
> hardware IRQ number) is no longer in use.  Then, before CPU 0 gets
> to calling irq_dispose_mapping() to free up the virtal IRQ number,
> CPU 1 comes in and calls msi_bitmap_alloc_hwirqs() to allocate an
> MSI, and gets the same hardware IRQ number that CPU 0 just freed.
> CPU 1 then calls irq_create_mapping() to get a virtual IRQ number,
> which sees that there is currently a mapping for that hardware IRQ
> number and returns the corresponding virtual IRQ number (which is
> the same virtual IRQ number that CPU 0 was using).  CPU 0 then
> calls irq_dispose_mapping() and frees that virtual IRQ number.
> Now, if another CPU comes along and calls irq_create_mapping(), it
> is likely to get the virtual IRQ number that was just freed,
> resulting in the same virtual IRQ number apparently being used for
> two different hardware interrupts.
> 
> To fix this race, we just move the call to msi_bitmap_free_hwirqs()
> to after the call to irq_dispose_mapping().  Since virq_to_hw()
> doesn't work for the virtual IRQ number after irq_dispose_mapping()
> has been called, we need to call it before irq_dispose_mapping() and
> remember the result for the msi_bitmap_free_hwirqs() call.
> 
> The pattern of calling msi_bitmap_free_hwirqs() before
> irq_dispose_mapping() appears in 5 places under arch/powerpc, and
> appears to have originated in commit 05af7bd2d75e ("[POWERPC] MPIC
> U3/U4 MSI backend") from 2007.

Guilty.

Any reason this shouldn't go to stable too?

>  arch/powerpc/platforms/pasemi/msi.c  | 5 +++--
>  arch/powerpc/platforms/powernv/pci.c | 5 +++--
>  arch/powerpc/sysdev/fsl_msi.c        | 5 +++--
>  arch/powerpc/sysdev/mpic_u3msi.c     | 5 +++--
>  arch/powerpc/sysdev/ppc4xx_msi.c     | 5 +++--
>  5 files changed, 15 insertions(+), 10 deletions(-)

I assume you've tested on powernv, but none of the other platforms?

cheers

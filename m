Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA05147505
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 01:37:17 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBEaWYJ030416
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:36:32 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBEbECU173074
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:37:14 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBFbOqF010794
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 10:37:24 -0500
Date: Thu, 11 Dec 2008 09:37:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] NOMMU: Rename PowerPC's struct vm_region
Message-ID: <20081211093709.30ca04f6@zod.rchland.ibm.com>
In-Reply-To: <20081211125354.20641.23213.stgit@warthog.procyon.org.uk>
References: <20081211125354.20641.23213.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 12:53:54 +0000
David Howells <dhowells@redhat.com> wrote:

> Rename PowerPC's struct vm_region so that I can introduce my own global version
> for NOMMU.  It's feasible that the PowerPC version may wish to use my global
> one instead.
> 
> The NOMMU vm_region struct defines areas of the physical memory map that are
> under mmap.  This may include chunks of RAM or regions of memory mapped
> devices, such as flash.  It is also used to retain copies of file content so
> that shareable private memory mappings of files can be made.  As such, it may
> be compatible with what is described in the banner comment for PowerPC's
> vm_region struct.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  arch/powerpc/lib/dma-noncoherent.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> 
> diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
> index 31734c0..a55c6ca 100644
> --- a/arch/powerpc/lib/dma-noncoherent.c
> +++ b/arch/powerpc/lib/dma-noncoherent.c
> @@ -77,26 +77,26 @@ static DEFINE_SPINLOCK(consistent_lock);
>   * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
>   * would have to initialise this each time prior to calling vm_region_alloc().
>   */
> -struct vm_region {
> +struct ppc_vm_region {
>  	struct list_head	vm_list;
>  	unsigned long		vm_start;
>  	unsigned long		vm_end;
>  };
> 
> -static struct vm_region consistent_head = {
> +static struct ppc_vm_region consistent_head = {
>  	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
>  	.vm_start	= CONSISTENT_BASE,
>  	.vm_end		= CONSISTENT_END,
>  };
> 
> -static struct vm_region *
> -vm_region_alloc(struct vm_region *head, size_t size, gfp_t gfp)
> +static struct ppc_vm_region *
> +ppc_vm_region_alloc(struct ppc_vm_region *head, size_t size, gfp_t gfp)

Is there a reason you renamed all the function names as well when they
are static?

josh

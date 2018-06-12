Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414b9T1mY9zF12N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 13:34:53 +1000 (AEST)
Date: Tue, 12 Jun 2018 11:34:43 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com,
 nicolas.pitre@linaro.org, josh@joshtriplett.org,
 fengguang.wu@intel.com, bp@suse.de
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com,
 dmitry.torokhov@gmail.com, frowand.list@gmail.com,
 keith.busch@intel.com, jonathan.derrick@intel.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
 brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
 gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
 richard.weiyang@gmail.com, devel@linuxdriverproject.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
 davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
 gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
 seanpaul@chromium.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Message-ID: <20180612033443.GB1820@MiWiFi-R3L-srv>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180612032831.29747-2-bhe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/18 at 11:28am, Baoquan He wrote:
> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> so that it's shared. Later its code also need be updated using list_head
> to replace singly linked list.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v4->v5:
>   Fix several code bugs reported by test robot on ARCH powerpc and
>   microblaze.

Oops, I mistakenly added the patch change log of the current patch 0002
here. This patch is a newly added one.

> 
> v3->v4:
>   Fix several bugs test robot reported. And change patch log.
> 
> v2->v3:
>   Rename resource functions first_child() and sibling() to
>   resource_first_chils() and resource_sibling(). Dan suggested this.
> 
>   Move resource_first_chils() and resource_sibling() to linux/ioport.h
>   and make them as inline function. Rob suggested this. Accordingly add
>   linux/list.h including in linux/ioport.h, please help review if this
>   bring efficiency degradation or code redundancy.
> 
>   The change on struct resource {} bring two pointers of size increase,
>   mention this in git log to make it more specifically, Rob suggested
>   this.
> 
>  arch/microblaze/pci/pci-common.c | 37 -------------------------------------
>  arch/powerpc/kernel/pci-common.c | 35 -----------------------------------
>  include/linux/ioport.h           |  1 +
>  kernel/resource.c                | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index f34346d56095..7899bafab064 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -619,43 +619,6 @@ int pcibios_add_device(struct pci_dev *dev)
>  EXPORT_SYMBOL(pcibios_add_device);
>  
>  /*
> - * Reparent resource children of pr that conflict with res
> - * under res, and make res replace those children.
> - */
> -static int __init reparent_resources(struct resource *parent,
> -				     struct resource *res)
> -{
> -	struct resource *p, **pp;
> -	struct resource **firstpp = NULL;
> -
> -	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> -		if (p->end < res->start)
> -			continue;
> -		if (res->end < p->start)
> -			break;
> -		if (p->start < res->start || p->end > res->end)
> -			return -1;	/* not completely contained */
> -		if (firstpp == NULL)
> -			firstpp = pp;
> -	}
> -	if (firstpp == NULL)
> -		return -1;	/* didn't find any conflicting entries? */
> -	res->parent = parent;
> -	res->child = *firstpp;
> -	res->sibling = *pp;
> -	*firstpp = res;
> -	*pp = NULL;
> -	for (p = res->child; p != NULL; p = p->sibling) {
> -		p->parent = res;
> -		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
> -			 p->name,
> -			 (unsigned long long)p->start,
> -			 (unsigned long long)p->end, res->name);
> -	}
> -	return 0;
> -}
> -
> -/*
>   *  Handle resources of PCI devices.  If the world were perfect, we could
>   *  just allocate all the resource regions and do nothing more.  It isn't.
>   *  On the other hand, we cannot just re-allocate all devices, as it would
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index fe9733ffffaa..926035bb378d 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1088,41 +1088,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  EXPORT_SYMBOL(pcibios_align_resource);
>  
>  /*
> - * Reparent resource children of pr that conflict with res
> - * under res, and make res replace those children.
> - */
> -static int reparent_resources(struct resource *parent,
> -				     struct resource *res)
> -{
> -	struct resource *p, **pp;
> -	struct resource **firstpp = NULL;
> -
> -	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> -		if (p->end < res->start)
> -			continue;
> -		if (res->end < p->start)
> -			break;
> -		if (p->start < res->start || p->end > res->end)
> -			return -1;	/* not completely contained */
> -		if (firstpp == NULL)
> -			firstpp = pp;
> -	}
> -	if (firstpp == NULL)
> -		return -1;	/* didn't find any conflicting entries? */
> -	res->parent = parent;
> -	res->child = *firstpp;
> -	res->sibling = *pp;
> -	*firstpp = res;
> -	*pp = NULL;
> -	for (p = res->child; p != NULL; p = p->sibling) {
> -		p->parent = res;
> -		pr_debug("PCI: Reparented %s %pR under %s\n",
> -			 p->name, p, res->name);
> -	}
> -	return 0;
> -}
> -
> -/*
>   *  Handle resources of PCI devices.  If the world were perfect, we could
>   *  just allocate all the resource regions and do nothing more.  It isn't.
>   *  On the other hand, we cannot just re-allocate all devices, as it would
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..dfdcd0bfe54e 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -192,6 +192,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
>  struct resource *lookup_resource(struct resource *root, resource_size_t start);
>  int adjust_resource(struct resource *res, resource_size_t start,
>  		    resource_size_t size);
> +int reparent_resources(struct resource *parent, struct resource *res);
>  resource_size_t resource_alignment(struct resource *res);
>  static inline resource_size_t resource_size(const struct resource *res)
>  {
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..5e7c56d5d838 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -983,6 +983,42 @@ int adjust_resource(struct resource *res, resource_size_t start,
>  }
>  EXPORT_SYMBOL(adjust_resource);
>  
> +/*
> + * Reparent resource children of pr that conflict with res
> + * under res, and make res replace those children.
> + */
> +static int reparent_resources(struct resource *parent,
> +				     struct resource *res)
> +{
> +	struct resource *p, **pp;
> +	struct resource **firstpp = NULL;
> +
> +	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> +		if (p->end < res->start)
> +			continue;
> +		if (res->end < p->start)
> +			break;
> +		if (p->start < res->start || p->end > res->end)
> +			return -1;	/* not completely contained */
> +		if (firstpp == NULL)
> +			firstpp = pp;
> +	}
> +	if (firstpp == NULL)
> +		return -1;	/* didn't find any conflicting entries? */
> +	res->parent = parent;
> +	res->child = *firstpp;
> +	res->sibling = *pp;
> +	*firstpp = res;
> +	*pp = NULL;
> +	for (p = res->child; p != NULL; p = p->sibling) {
> +		p->parent = res;
> +		pr_debug("PCI: Reparented %s %pR under %s\n",
> +			 p->name, p, res->name);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(reparent_resources);
> +
>  static void __init __reserve_region_with_split(struct resource *root,
>  		resource_size_t start, resource_size_t end,
>  		const char *name)
> -- 
> 2.13.6
> 

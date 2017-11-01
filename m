Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRV4D5LvnzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 11:50:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/kernel/sysfs: Export ldbar spr to sysfs
In-Reply-To: <1509466547-761-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1509466547-761-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Wed, 01 Nov 2017 11:50:04 +1100
Message-ID: <87h8ue960z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Add ldbar spr to sysfs. The spr will hold thread level In-Memory Collection (IMC)
> counter configuration data.

This is missing any justification for why we would want to expose this,
and in particular why we would make it *writable*.

cheers

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 4437c70..f8caee0 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -485,6 +485,7 @@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
>  SYSFS_SPRSETUP(purr, SPRN_PURR);
>  SYSFS_SPRSETUP(spurr, SPRN_SPURR);
>  SYSFS_SPRSETUP(pir, SPRN_PIR);
> +SYSFS_SPRSETUP(ldbar, SPRN_LDBAR);
>  
>  /*
>    Lets only enable read for phyp resources and
> @@ -492,6 +493,7 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
>    Lets be conservative and default to pseries.
>  */
>  static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
> +static DEVICE_ATTR(ldbar, 0600, show_ldbar, store_ldbar);
>  static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>  static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>  			device_create_file(s, &pmc_attrs[i]);
>  
>  #ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		device_create_file(s, &dev_attr_ldbar);
> +
>  	if (cpu_has_feature(CPU_FTR_MMCRA))
>  		device_create_file(s, &dev_attr_mmcra);
>  
> @@ -842,6 +847,9 @@ static int unregister_cpu_online(unsigned int cpu)
>  			device_remove_file(s, &pmc_attrs[i]);
>  
>  #ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		device_remove_file(s, &dev_attr_ldbar);
> +
>  	if (cpu_has_feature(CPU_FTR_MMCRA))
>  		device_remove_file(s, &dev_attr_mmcra);
>  
> -- 
> 2.7.4

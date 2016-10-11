Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stcx05yp2zDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 00:17:40 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id fn2so741800pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 06:17:40 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] mm: enable CONFIG_MOVABLE_NODE on non-x86 arches
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-6-git-send-email-arbab@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <6d781236-3f2a-8fe6-682f-efa2c01bf429@gmail.com>
Date: Wed, 12 Oct 2016 00:17:31 +1100
MIME-Version: 1.0
In-Reply-To: <1475778995-1420-6-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/10/16 05:36, Reza Arbab wrote:
> To support movable memory nodes (CONFIG_MOVABLE_NODE), at least one of
> the following must be true:
> 
> 1. We're on x86. This arch has the capability to identify movable nodes
>    at boot by parsing the ACPI SRAT, if the movable_node option is used.
> 
> 2. Our config supports memory hotplug, which means that a movable node
>    can be created by hotplugging all of its memory into ZONE_MOVABLE.
> 
> Fix the Kconfig definition of CONFIG_MOVABLE_NODE, which currently
> recognizes (1), but not (2).
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index be0ee11..5d0818f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -153,7 +153,7 @@ config MOVABLE_NODE
>  	bool "Enable to assign a node which has only movable memory"
>  	depends on HAVE_MEMBLOCK
>  	depends on NO_BOOTMEM
> -	depends on X86_64
> +	depends on X86_64 || MEMORY_HOTPLUG
>  	depends on NUMA
>  	default n
>  	help
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>

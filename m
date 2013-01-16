Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE0872C0093
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 01:14:48 +1100 (EST)
Date: Wed, 16 Jan 2013 15:14:36 +0100
From: Michal Hocko <mhocko@suse.cz>
To: Lin Feng <linfeng@cn.fujitsu.com>
Subject: Re: [PATCH v3 1/2] memory-hotplug: introduce
 CONFIG_HAVE_BOOTMEM_INFO_NODE and revert register_page_bootmem_info_node()
 when platform not support
Message-ID: <20130116141436.GE343@dhcp22.suse.cz>
References: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
 <1358324059-9608-2-git-send-email-linfeng@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358324059-9608-2-git-send-email-linfeng@cn.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, aquini@redhat.com, heiko.carstens@de.ibm.com,
 tangchen@cn.fujitsu.com, dhowells@redhat.com, paul.gortmaker@windriver.com,
 paulus@samba.org, jbeulich@suse.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 mingo@redhat.com, gerald.schaefer@de.ibm.com, fenghua.yu@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, mel@csn.ul.ie, tglx@linutronix.de,
 kamezawa.hiroyu@jp.fujitsu.com, tony.luck@intel.com, laijs@cn.fujitsu.com,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 minchan@kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 16-01-13 16:14:18, Lin Feng wrote:
[...]
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 278e3ab..f8c5799 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -162,10 +162,18 @@ config MOVABLE_NODE
>  	  Say Y here if you want to hotplug a whole node.
>  	  Say N here if you want kernel to use memory on all nodes evenly.
>  
> +#
> +# Only be set on architectures that have completely implemented memory hotplug
> +# feature. If you are not sure, don't touch it.
> +#
> +config HAVE_BOOTMEM_INFO_NODE
> +	def_bool n
> +
>  # eventually, we can have this option just 'select SPARSEMEM'
>  config MEMORY_HOTPLUG
>  	bool "Allow for memory hot-add"
>  	select MEMORY_ISOLATION
> +	select HAVE_BOOTMEM_INFO_NODE if X86_64
>  	depends on SPARSEMEM || X86_64_ACPI_NUMA
>  	depends on HOTPLUG && ARCH_ENABLE_MEMORY_HOTPLUG
>  	depends on (IA64 || X86 || PPC_BOOK3S_64 || SUPERH || S390)

I am still not sure I understand the relation to MEMORY_HOTREMOVE.
Is register_page_bootmem_info_node required/helpful even if
!CONFIG_MEMORY_HOTREMOVE?

Also, now that I am thinking about that more, maybe it would
be cleaner to put the select into arch/x86/Kconfig and do it
same as ARCH_ENABLE_MEMORY_{HOTPLUG,HOTREMOVE} (and name it
ARCH_HAVE_BOOTMEM_INFO_NODE).
-- 
Michal Hocko
SUSE Labs

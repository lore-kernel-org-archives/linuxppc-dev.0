Return-Path: <mpe@ellerman.id.au>
Message-ID: <1385088872.26020.1.camel@concordia>
Subject: Re: [PATCH] PPC64: Adding symbols in vmcoreinfo to facilitate dump
 filtering
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 22 Nov 2013 13:54:32 +1100
In-Reply-To: <20131115173132.1121.61175.stgit@localhost.localdomain>
References: <20131115173132.1121.61175.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-15 at 23:01 +0530, Hari Bathini wrote:
> When CONFIG_SPARSEMEM_VMEMMAP option is used in kernel, makedumpfile fails
> to filter vmcore dump as it fails to do vmemmap translations. So far
> dump filtering on ppc64 never had to deal with vmemmap addresses seperately
> as vmemmap regions where mapped in zone normal. But with the inclusion of
> CONFIG_SPARSEMEM_VMEMMAP config option in kernel, this vmemmap address
> translation support becomes necessary for dump filtering. For vmemmap adress
> translation, few kernel symbols are needed by dump filtering tool. This patch
> adds those symbols to vmcoreinfo, which a dump filtering tool can use for
> filtering the kernel dump. Tested this changes successfully with makedumpfile
> tool that supports vmemmap to physical address translation outside zone normal.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgalloc-64.h |    4 ++++
>  arch/powerpc/kernel/machine_kexec.c   |   12 ++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
> index f65e27b..33e507a 100644
> --- a/arch/powerpc/include/asm/pgalloc-64.h
> +++ b/arch/powerpc/include/asm/pgalloc-64.h
> @@ -17,6 +17,10 @@ struct vmemmap_backing {
>  	unsigned long virt_addr;
>  };
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +extern struct vmemmap_backing *vmemmap_list;
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */

In general you don't need #ifdefs around externs, they just add noise. The
exception is when the type you're using isn't defined, but that isn't the case
here AFAICS.

cheers

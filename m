Return-Path: <paulus@ozlabs.org>
Date: Fri, 22 Nov 2013 09:11:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH 2/2] powerpc: mm: change pgtable index size for 64K page
Message-ID: <20131121221150.GB26359@iris.ozlabs.ibm.com>
References: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1385000275-5988-2-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385000275-5988-2-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 21, 2013 at 10:17:55AM +0800, Liu Ping Fan wrote:
> For 64K page, we waste half of the pte_t page. With this patch, after
> changing PGD_INDEX_SIZE from 12 to 11, PTE_INDEX_SIZE from 8 to 9,
> we can improve the usage of pte_t page and shrink the continuous phys
> size for pgd_t.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64-64k.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
> index a56b82f..f6955ff 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
> @@ -4,10 +4,10 @@
>  #include <asm-generic/pgtable-nopud.h>
>  
>  
> -#define PTE_INDEX_SIZE  8
> +#define PTE_INDEX_SIZE  9
>  #define PMD_INDEX_SIZE  10
>  #define PUD_INDEX_SIZE	0
> -#define PGD_INDEX_SIZE  12
> +#define PGD_INDEX_SIZE  11

Nack.  Those definitions are the way they are in order to have the PMD
map 16MB, which is our large page size, so that transparent huge pages
work.

Paul.

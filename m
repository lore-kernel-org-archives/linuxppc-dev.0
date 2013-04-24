Return-Path: <paulus@ozlabs.org>
Date: Wed, 24 Apr 2013 16:29:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 23/27] powerpc: Replace find_linux_pte with
 find_linux_pte_or_hugepte
Message-ID: <20130424062931.GB2073@drongo>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366624861-24948-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 03:30:57PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Replace find_linux_pte with find_linux_pte_or_hugepte and explicitly
> document why we don't need to handle transparent hugepages at callsites.

> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 19c93ba..aa6a351 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -24,13 +24,15 @@
>  /* Translate address of a vmalloc'd thing to a linear map address */
>  static void *real_vmalloc_addr(void *x)
>  {
> +	unsigned shift;
>  	unsigned long addr = (unsigned long) x;
>  	pte_t *p;
>  
> -	p = find_linux_pte(swapper_pg_dir, addr);
> +	p = find_linux_pte_or_hugepte(swapper_pg_dir, addr, &shift);
>  	if (!p || !pte_present(*p))
>  		return NULL;
>  	/* assume we don't have huge pages in vmalloc space... */
> +	BUG_ON(shift);

Please don't add BUG_ON in this file.  At this point we're basically
still in guest context (though in real mode), and BUG_ON would cause a
trap which we would handle very badly...

Paul.

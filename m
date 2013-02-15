Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Feb 2013 14:13:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: aik@ozlabs.ru
Subject: Re: [PATCH 1/4] powerpc: lookup_linux_pte has been made public
Message-ID: <20130215031335.GA25015@drongo>
References: <1360584763-21988-1-git-send-email-a>
 <5118e055.22ca320a.1f08.ffffe2e5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5118e055.22ca320a.1f08.ffffe2e5@mx.google.com>
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 11:12:40PM +1100, aik@ozlabs.ru wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> The lookup_linux_pte() function returns a linux PTE which
> is required to convert KVM guest physical address into host real
> address in real mode.
> 
> This convertion will be used by upcoming support of H_PUT_TCE_INDIRECT
> as TCE list address comes from the guest directly so it is a guest
> physical.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h |    3 +++
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c      |    4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index 0182c20..ddcc898 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -377,6 +377,9 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>  }
>  #endif /* !CONFIG_HUGETLB_PAGE */
>  
> +pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> +		int writing, unsigned long *pte_sizep);
> +

This seems a slightly odd place to put the declaration of a function
which is defined in the KVM code.  kvm-ppc.h might be a better place.

Paul.

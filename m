Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 15:11:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 12/26] powerpc: Return all the valid pte ecndoing in
 KVM_PPC_GET_SMMU_INFO ioctl
Message-ID: <20130313041102.GG21125@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362550227-575-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 06, 2013 at 11:40:13AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 48f6d99..e50eb0d 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1508,14 +1508,21 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
>  static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
>  				     int linux_psize)
>  {
> +	int i, index = 0;
>  	struct mmu_psize_def *def = &mmu_psize_defs[linux_psize];
>  
>  	if (!def->shift)
>  		return;
>  	(*sps)->page_shift = def->shift;
>  	(*sps)->slb_enc = def->sllp;
> -	(*sps)->enc[0].page_shift = def->shift;
> -	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
> +	for (i = 0; i < MMU_PAGE_COUNT; i++) {
> +		if ((signed int)def->penc[i] != -1) {
> +			BUG_ON(index >= KVM_PPC_PAGE_SIZES_MAX_SZ);

BUG_ON is a bit harsh; just WARN_ON and break out of the loop.

Paul.

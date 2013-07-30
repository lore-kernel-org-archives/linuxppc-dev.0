Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 761632C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 12:57:22 +1000 (EST)
Message-ID: <51F72B50.2050404@asianux.com>
Date: Tue, 30 Jul 2013 10:56:16 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Gleb Natapov <gleb@redhat.com>, pbonzini@redhat.com, agraf@suse.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH] arch: powerpc: kvm: add signed type cast for comparation
References: <51ECD203.9050507@asianux.com>
In-Reply-To: <51ECD203.9050507@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Maintainers:

Please help check this patch whether OK or not, when you have time.

Thanks.

On 07/22/2013 02:32 PM, Chen Gang wrote:
> 'rmls' is 'unsigned long', lpcr_rmls() will return negative number when
> failure occurs, so it need a type cast for comparing.
> 
> 'lpid' is 'unsigned long', kvmppc_alloc_lpid() return negative number
> when failure occurs, so it need a type cast for comparing.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 2efa9dd..7629cd3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1809,7 +1809,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
>  		rma_size <<= PAGE_SHIFT;
>  		rmls = lpcr_rmls(rma_size);
>  		err = -EINVAL;
> -		if (rmls < 0) {
> +		if ((long)rmls < 0) {
>  			pr_err("KVM: Can't use RMA of 0x%lx bytes\n", rma_size);
>  			goto out_srcu;
>  		}
> @@ -1874,7 +1874,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
>  	/* Allocate the guest's logical partition ID */
>  
>  	lpid = kvmppc_alloc_lpid();
> -	if (lpid < 0)
> +	if ((long)lpid < 0)
>  		return -ENOMEM;
>  	kvm->arch.lpid = lpid;
>  
> 


-- 
Chen Gang

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 2A2952C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 21:39:37 +1000 (EST)
Subject: Re: [RFC PATCH 01/11] kvm: powerpc: book3s hv: Fix vcore leak
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380276233-17095-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 13:39:30 +0200
Message-Id: <C2D21FC4-8722-4CE1-984D-330F9CBF0120@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:

> From: Paul Mackerras <paulus@samba.org>
> 
> add kvmppc_free_vcores() to free the kvmppc_vcore structures
> that we allocate for a guest, which are currently being leaked.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This one doesn't look like an RFC to me. Applied to kvm-ppc-queue :).


Alex

> ---
> arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 62a2b5a..edc7f9f 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1931,10 +1931,20 @@ int kvmppc_core_init_vm(struct kvm *kvm)
> 	return 0;
> }
> 
> +static void kvmppc_free_vcores(struct kvm *kvm)
> +{
> +	long int i;
> +
> +	for (i = 0; i < KVM_MAX_VCORES; ++i)
> +		kfree(kvm->arch.vcores[i]);
> +	kvm->arch.online_vcores = 0;
> +}
> +
> void kvmppc_core_destroy_vm(struct kvm *kvm)
> {
> 	uninhibit_secondary_onlining();
> 
> +	kvmppc_free_vcores(kvm);
> 	if (kvm->arch.rma) {
> 		kvm_release_rma(kvm->arch.rma);
> 		kvm->arch.rma = NULL;
> -- 
> 1.8.1.2
> 

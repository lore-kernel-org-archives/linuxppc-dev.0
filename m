Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76BC81A0745
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 11:45:35 +1100 (AEDT)
Date: Thu, 27 Nov 2014 11:45:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] KVM: PPC: BOOK3S: HV: Rename variable for better
 readability
Message-ID: <20141127004526.GB778@iris.ozlabs.ibm.com>
References: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1413815340-22426-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413815340-22426-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2014 at 07:59:00PM +0530, Aneesh Kumar K.V wrote:
> Minor cleanup
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 78e689b066f1..2922f8d127ff 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -523,7 +523,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
>  	unsigned long *args = &vcpu->arch.gpr[4];
>  	__be64 *hp, *hptes[4];
>  	unsigned long tlbrb[4];
> -	long int i, j, k, n, found, indexes[4];
> +	long int i, j, k, collected_hpte, found, indexes[4];

Hmmm... I don't find it more readable, because "collected_hpte" sounds
like it contains a HPTE value.  Also I don't like using a long name
for something that is just a temporary value inside a function, and
"n" is a suitable name for a temporary variable counting the number of
things we have.  I would prefer just adding a comment like this:

-		n = 0;
+		n = 0;	/* # values collected in tlbrb[], indexes[] etc. */

Paul.

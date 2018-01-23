Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQk0X2ys4zDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 20:44:28 +1100 (AEDT)
Date: Tue, 23 Jan 2018 20:44:16 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 23/26] KVM: PPC: Book3S PR: add emulation for tabort. for
 privilege guest
Message-ID: <20180123094416.GO3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-24-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-24-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:36PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently privilege guest will be run with TM disabled.
> 
> Although the privilege guest cannot initiate a new transaction,
> it can use tabort to terminate its problem state's transaction.
> So it is still necessary to emulate tabort. for privilege guest.
> 
> This patch adds emulation for tabort. of privilege guest.
> 
> Tested with:
> https://github.com/justdoitqd/publicFiles/blob/master/test_tabort.c
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s.h |  1 +
>  arch/powerpc/kvm/book3s_emulate.c     | 31 +++++++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_pr.c          |  2 +-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index 524cd82..8bd454c 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -258,6 +258,7 @@ extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
>  void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
>  void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
>  void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
> +void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu);

Why do you add this declaration, and change it from "static inline" to
"inline" below, when this patch doesn't use it?  Also, making it
"inline" is pointless if it has a caller outside the source file where
it's defined (if gcc wants to inline uses of it inside the same source
file, it will do so anyway even without the "inline" keyword.)

Paul.

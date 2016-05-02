Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzCBq6xH7zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 04:14:58 +1000 (AEST)
Subject: Re: [PATCH kernel] KVM: PPC: Fix debug macros
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <1461905843-22673-1-git-send-email-aik@ozlabs.ru>
Cc: Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5727991A.6000309@redhat.com>
Date: Mon, 2 May 2016 20:14:50 +0200
MIME-Version: 1.0
In-Reply-To: <1461905843-22673-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.04.2016 06:57, Alexey Kardashevskiy wrote:
> When XICS_DBG is enabled, gcc produces format errors. This fixes
> formats to match passed values types.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_xics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
> index 46871d5..95896d7 100644
> --- a/arch/powerpc/kvm/book3s_xics.c
> +++ b/arch/powerpc/kvm/book3s_xics.c
> @@ -280,7 +280,7 @@ static inline bool icp_try_update(struct kvmppc_icp *icp,
>  	if (!success)
>  		goto bail;
>  
> -	XICS_DBG("UPD [%04x] - C:%02x M:%02x PP: %02x PI:%06x R:%d O:%d\n",
> +	XICS_DBG("UPD [%04lx] - C:%02x M:%02x PP: %02x PI:%06x R:%d O:%d\n",
>  		 icp->server_num,
>  		 old.cppr, old.mfrr, old.pending_pri, old.xisr,
>  		 old.need_resend, old.out_ee);
> @@ -336,7 +336,7 @@ static bool icp_try_to_deliver(struct kvmppc_icp *icp, u32 irq, u8 priority,
>  	union kvmppc_icp_state old_state, new_state;
>  	bool success;
>  
> -	XICS_DBG("try deliver %#x(P:%#x) to server %#x\n", irq, priority,
> +	XICS_DBG("try deliver %#x(P:%#x) to server %#lx\n", irq, priority,
>  		 icp->server_num);
>  
>  	do {

Reviewed-by: Thomas Huth <thuth@redhat.com>

Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83E931A0BF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:42:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 14:42:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9F5EB2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:42:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3N4gMhJ37224642
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:42:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3N4fu6E031136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:41:56 +1000
Message-ID: <553877FB.4040507@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 10:11:31 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: mpe@ellerman.id.au, agraf@suse.de
Subject: Re: [PATCH] kvm: powerpc: Fix ppc64_defconfig + PPC_POWERNV=n build
 error
References: <1429181889-1448-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1429181889-1448-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any suggestions on this?

On Thursday 16 April 2015 04:28 PM, Shreyas B. Prabhu wrote:
> kvm_no_guest function calls power7_wakeup_loss to put the thread into
> the deepest supported idle state. power7_wakeup_loss is defined in
> arch/powerpc/kernel/idle_power7.S, which is compiled only when PPC_P7_NAP=y.
> And PPC_P7_NAP is selected when PPC_POWERNV=y.
> Hence in cases where PPC_POWERNV=n and KVM_BOOK3S_64_HV=y we see the
> following error:
> 
> arch/powerpc/kvm/built-in.o: In function `kvm_no_guest':
> arch/powerpc/kvm/book3s_hv_rmhandlers.o:(.text+0x42c): undefined reference to `power7_wakeup_loss'
> 
> Fix this by adding PPC_POWERNV as a dependency for KVM_BOOK3S_64_HV.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 11850f3..b3b3d9f 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -75,7 +75,7 @@ config KVM_BOOK3S_64
> 
>  config KVM_BOOK3S_64_HV
>  	tristate "KVM support for POWER7 and PPC970 using hypervisor mode in host"
> -	depends on KVM_BOOK3S_64
> +	depends on KVM_BOOK3S_64 && PPC_POWERNV
>  	select KVM_BOOK3S_HV_POSSIBLE
>  	select MMU_NOTIFIER
>  	select CMA
> 

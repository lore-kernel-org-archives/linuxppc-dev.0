Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 9DDD5B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 04:28:44 +1000 (EST)
Received: from mail26-tx2 (localhost.localdomain [127.0.0.1])	by
	mail26-tx2-R.bigfish.com (Postfix) with ESMTP id 9FD24E010D	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2010 18:28:31 +0000 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.252])	by
	mail26-tx2.bigfish.com (Postfix) with ESMTP id E24AF1590051	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2010 18:28:29 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7HISFkY016254	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 11:28:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o7HISLJB000656	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 13:28:21 -0500 (CDT)
Date: Tue, 17 Aug 2010 13:28:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 21/26] KVM: PPC: Force enable nap on KVM
Message-ID: <20100817132813.05efb21d@schlenkerla.am.freescale.net>
In-Reply-To: <1282053481-18787-22-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
	<1282053481-18787-22-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 17 Aug 2010 15:57:56 +0200
Alexander Graf <agraf@suse.de> wrote:

> There are some heuristics in the PPC power management code that try to find
> out if the particular hardware we're running on supports proper power management
> or just hangs the machine when going into nap mode.
> 
> Since we know that KVM is safe with nap, let's force enable it in the PV code
> once we're certain that we are on a KVM VM.

Could this cause the cache to be flushed unnecessarily on e500?  Where
available, doze would probably be better for signalling the hypervisor
that the guest is idle.

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kernel/kvm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 517da39..95aed6b 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -583,6 +583,9 @@ static int __init kvm_guest_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
>  		kvm_use_magic_page();
>  
> +	/* Enable napping */
> +	powersave_nap = 1;
> +
>  free_tmp:
>  	kvm_free_tmp();
>  

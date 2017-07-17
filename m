Return-Path: <srs0=ec42=6u=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xB1sK0LYJzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 21:53:41 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xB1sJ5lC4z8sxj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 21:53:40 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xB1sJ0Cpjz9sBR
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2017 21:53:39 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id o88so1270437pfk.1
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2017 04:53:39 -0700 (PDT)
Message-ID: <1500292365.8256.15.camel@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Fix boot on Power8 bare metal due to
 opal_configure_cores()
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: abdhalee@linux.vnet.ibm.com
Date: Mon, 17 Jul 2017 21:52:45 +1000
In-Reply-To: <1500291060-8133-1-git-send-email-mpe@ellerman.id.au>
References: <1500291060-8133-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 21:31 +1000, Michael Ellerman wrote:
> In commit 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode
> on POWER9"), we added additional flags to the OPAL call to configure
> CPUs at boot.
> 
> These flags only work on Power9 firmwares, and worse can cause boot
> failures on Power8 machines, so we check for CPU_FTR_ARCH_300 (aka POWER9)
> before adding the extra flags.
> 
> Unfortunately we forgot that opal_configure_cores() is called before
> the CPU feature checks are dynamically patched, meaning the check
> always returns true.
> 
> We definitely need to do something to make the CPU feature checks less
> prone to bugs like this, but for now the minimal fix is to use
> early_cpu_has_feature().
> 
> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Fixes: 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode on POWER9")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 9b87abb178f0..cad6b57ce494 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -78,7 +78,7 @@ void opal_configure_cores(void)
>  	 *  ie. Host hash  supports  hash guests
>  	 *      Host radix supports  hash/radix guests
>  	 */
> -	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (early_cpu_has_feature(CPU_FTR_ARCH_300)) {
>  		reinit_flags |= OPAL_REINIT_CPUS_MMU_HASH;
>  		if (early_radix_enabled())
>  			reinit_flags |= OPAL_REINIT_CPUS_MMU_RADIX;

We do have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG, but I am not sure if there
is an efficient way to enable it till we actually get the key enabled. I wonder
if a branch hint will help, but I still feel its expensive.

Acked-by: Balbir Singh <bsingharora@gmail.com>

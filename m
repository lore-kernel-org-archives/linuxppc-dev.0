Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slng76SddzDvMC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 20:26:59 +1000 (AEST)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3slng70ystz9sD5
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2016 20:26:59 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id t6so1065958pae.2
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2016 03:26:59 -0700 (PDT)
Subject: Re: [PATCH] powerpc/fadump: Fix build break when CONFIG_PROC_VMCORE=n
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1475196706-6105-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3695a3c0-2168-372d-1642-d569edbc6ed9@gmail.com>
Date: Fri, 30 Sep 2016 20:27:39 +1000
MIME-Version: 1.0
In-Reply-To: <1475196706-6105-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 30/09/16 10:51, Michael Ellerman wrote:
> The fadump code calls vmcore_cleanup() which only exists if
> CONFIG_PROC_VMCORE=y. We don't want to depend on CONFIG_PROC_VMCORE,
> because it's user selectable, so just wrap the call in an #ifdef.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/fadump.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index b3a663333d36..8d461303dd13 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1104,7 +1104,9 @@ static ssize_t fadump_release_memory_store(struct kobject *kobj,
>  		 * Take away the '/proc/vmcore'. We are releasing the dump
>  		 * memory, hence it will not be valid anymore.
>  		 */
> +#ifdef CONFIG_PROC_VMCORE
>  		vmcore_cleanup();
> +#endif

I wonder if this should be fixed in crash_dump.h more generically.

Balbir Singh.

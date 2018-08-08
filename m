Return-Path: <srs0=5cqx=kx=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41llpG201YzDrH0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 19:05:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41llpG0Lwrz8sxN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 19:05:10 +1000 (AEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41llpD5C8bz9s4V
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 19:05:08 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id n7-v6so793887pgq.4
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2018 02:05:08 -0700 (PDT)
Date: Wed, 8 Aug 2018 19:04:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michal Suchanek
 <msuchanek@suse.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 5/9] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
Message-ID: <20180808190456.59c03b8b@roar.ozlabs.ibm.com>
In-Reply-To: <153365142349.14256.9954484737438718329.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365142349.14256.9954484737438718329.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 07 Aug 2018 19:47:14 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On pseries, as of today system crashes if we get a machine check
> exceptions due to SLB errors. These are soft errors and can be fixed by
> flushing the SLBs so the kernel can continue to function instead of
> system crash. We do this in real mode before turning on MMU. Otherwise
> we would run into nested machine checks. This patch now fetches the
> rtas error log in real mode and flushes the SLBs on SLB errors.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.com>
> ---
> 
> Changes in V7:
> - Fold Michal's patch into this patch.
> - Handle MSR_RI=0 and evil context case in MC handler.
> ---


> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index cb796724a6fc..e89f675f1b5e 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -145,6 +145,12 @@ void slb_flush_and_rebolt(void)
>  	get_paca()->slb_cache_ptr = 0;
>  }
>  
> +void slb_flush_and_rebolt_realmode(void)
> +{
> +	__slb_flush_and_rebolt();
> +	get_paca()->slb_cache_ptr = 0;
> +}
> +
>  void slb_vmalloc_update(void)
>  {
>  	unsigned long vflags;

Can you use this patch for the SLB flush?

https://patchwork.ozlabs.org/patch/953034/

Thanks,
Nick

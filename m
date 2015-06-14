Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BAA21A0862
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 02:30:11 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E52EB140129
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 02:30:10 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 02:30:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C086F357804C
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 02:30:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5EGSfVB7536700
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 02:28:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5EGSIl8030015
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 02:28:19 +1000
Message-ID: <557DAB91.7000100@linux.vnet.ibm.com>
Date: Sun, 14 Jun 2015 21:58:01 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: pnv_init_idle_states() should only run
 on powernv
References: <1434103220-8591-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1434103220-8591-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/12/2015 03:30 PM, Michael Ellerman wrote:
> Although this init call checks for device tree properties before doing
> anything, it should still only run on powernv machines.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index bd39a120bd60..e8168cf13812 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -289,5 +289,4 @@ out_free:
>  out:
>  	return 0;
>  }
> -
> -subsys_initcall(pnv_init_idle_states);
> +machine_subsys_initcall(powernv, pnv_init_idle_states);
> 

<asm/machdep.h> needs to be included, otherwise I get a build error.

With that,
Reviewed-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>

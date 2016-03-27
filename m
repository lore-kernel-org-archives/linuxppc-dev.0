Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qY1gD0jlMzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:49:12 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 28 Mar 2016 01:49:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 219962CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:49:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2RFmweh46137562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:49:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2RFmYnp017368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:48:34 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
 mpe <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 06/65] powerpc/cxl: Use REGION_ID instead of opencoding
In-reply-to: <1459067053-10835-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 27 Mar 2016 10:48:07 -0500
Message-Id: <1459093368-sup-4481@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Copying in Andrew Donnellan - this looks to be roughly equivalent to
your patch:

[PATCH] cxl: fix setting of _PAGE_USER bit when handling page faults

I think we were waiting on a v2 of that patch - does the below replace
the need for that?

Also copying cxlflash folk as an FYI

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Aneesh Kumar K.V's message of 2016-03-27 03:23:14 -0500:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 33bd0ee30edd..67cc657e96cc 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -154,7 +154,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>          access |= _PAGE_WRITE;
>  
>      access |= _PAGE_PRIVILEGED;
> -    if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> +    if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
>          access &= ~_PAGE_PRIVILEGED;
>  
>      if (dsisr & DSISR_NOHPTE)

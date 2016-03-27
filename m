Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qY1XC5tJxzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:43:07 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 28 Mar 2016 01:43:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6C47A2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:42:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2RFgacP57802888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:42:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2RFgBeE014930
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:42:12 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
 mpe <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/65] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIVILEGED
In-reply-to: <1459067053-10835-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 27 Mar 2016 10:41:45 -0500
Message-Id: <1459092969-sup-1173@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Aneesh Kumar K.V's message of 2016-03-27 03:23:13 -0500:
> _PAGE_PRIVILEGED means the page can be accessed only by kernel. This is done
> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
> pages are now makred by clearing _PAGE_PRIVILEGED bit.
> 
> Previously we allowed kernel to have a privileged page
> in the lower address range(USER_REGION). With this patch such access
> is denied.

Copying in cxlflash folks - as the only in-kernel user of the cxl driver
can you do some testing and make sure that the driver still works with
this change?

Copying in Andrew Donnellan since he has a patch to fix the kernel test
that hasn't been merged yet that might be impacted by this.

> We also prevent a kernel access to a non-privileged page in
> higher address range (ie, REGION_ID != 0). Both the above access
> scenario should never happen.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index a3d5e1e16c21..33bd0ee30edd 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -152,8 +152,10 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>      access = _PAGE_PRESENT | _PAGE_READ;
>      if (dsisr & CXL_PSL_DSISR_An_S)
>          access |= _PAGE_WRITE;
> +
> +    access |= _PAGE_PRIVILEGED;
>      if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> -        access |= _PAGE_USER;
> +        access &= ~_PAGE_PRIVILEGED;
>  
>      if (dsisr & DSISR_NOHPTE)
>          inv_flags |= HPTE_NOHPTE_UPDATE;

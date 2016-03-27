Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qY1P44dTJzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:36:56 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 28 Mar 2016 01:36:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 424C42CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:36:40 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2RFaRLa61145238
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:36:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2RFa27s006482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 02:36:03 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
 mpe <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 02/65] powerpc/mm: use _PAGE_READ to indicate Read access
In-reply-to: <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 27 Mar 2016 10:35:35 -0500
Message-Id: <1459092757-sup-379@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'll leave it to others to work out whether the general approach & code
in /arch/powerpc is right, but at least for the cxl driver:

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Aneesh Kumar K.V's message of 2016-03-27 03:23:10 -0500:
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 81c3f75b7330..a3d5e1e16c21 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -149,9 +149,9 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>       * update_mmu_cache() will not have loaded the hash since current->trap
>       * is not a 0x400 or 0x300, so just call hash_page_mm() here.
>       */
> -    access = _PAGE_PRESENT;
> +    access = _PAGE_PRESENT | _PAGE_READ;
>      if (dsisr & CXL_PSL_DSISR_An_S)
> -        access |= _PAGE_RW;
> +        access |= _PAGE_WRITE;
>      if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
>          access |= _PAGE_USER;

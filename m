Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0C071A1E13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 10:30:31 +1000 (AEST)
Message-ID: <1441153816.4966.109.camel@freescale.com>
Subject: Re: [PATCH V7 1/3] genalloc:support memory-allocation with
 bytes-alignment to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Tue, 1 Sep 2015 19:30:16 -0500
In-Reply-To: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:
> Bytes alignment is required to manage some special RAM,
> so add gen_pool_first_fit_align to genalloc,
> meanwhile add gen_pool_alloc_data to pass data to
> gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> Changes for v6:
>       - patches set v6 include a new patch because of using 
>       - genalloc to manage QE MURAM, patch 0001 is the new 
>       - patch, adding bytes alignment for allocation for use.
> Changes for v7:
>       - cpm muram also need to use genalloc to manage, it has 
>         a function to reserve a specific region of muram,
>         add offset to genpool_data for start addr to be allocated.

This seems to be describing more than just the changes in this patch.  What 
does also handling cpm have to do with this patch?  Are you adding support 
for reserving a specific region in this patch?  I don't see it, and in any 
case it should go in a different patch.

> +/*
> + *  gen_pool data descriptor for gen_pool_first_fit_align.
> + */
> +struct genpool_data_align {
> +     int align;              /* alignment by bytes for starting address */
> +     unsigned long offset;   /* the offset of allocation start addr*/
> +};

The offset belongs on the caller side, not here.

-Scott

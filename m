Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35C251A0D7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 08:19:46 +1000 (AEST)
Message-ID: <1436480372.2658.153.camel@freescale.com>
Subject: Re: [RFC] genalloc:add an gen_pool_alloc_align func to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
CC: <lauraa@codeaurora.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
 <olof@lixom.net>, <catalin.marinas@arm.com>, <X.xie@freescale.com>
Date: Thu, 9 Jul 2015 17:19:32 -0500
In-Reply-To: <1436428063-893-1-git-send-email-B45475@freescale.com>
References: <1436428063-893-1-git-send-email-B45475@freescale.com>
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

On Thu, 2015-07-09 at 15:47 +0800, Zhao Qiang wrote:
> @@ -541,13 +562,14 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
>   * which we can allocate the memory.
>   */
>  unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
> -             unsigned long start, unsigned int nr, void *data)
> +                             unsigned long start, unsigned int nr,
> +                             void *data, unsigned long align_mask)
>  {
>       unsigned long start_bit = size;
>       unsigned long len = size + 1;
>       unsigned long index;
>  
> -     index = bitmap_find_next_zero_area(map, size, start, nr, 0);
> +     index = bitmap_find_next_zero_area(map, size, start, nr, align_mask);
>  
>       while (index < size) {
>               int next_bit = find_next_bit(map, size, index + nr);

What about the other call to bitmap_find_next_zero_area()?

-Scott

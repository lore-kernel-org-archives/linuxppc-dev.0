Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309431A0655
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 13:14:05 +1000 (AEST)
Message-ID: <1438830829.2097.143.camel@freescale.com>
Subject: Re: [RFC v4] genalloc:support memory-allocation with
 bytes-alignment to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <lauraa@codeaurora.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
 <olof@lixom.net>, <catalin.marinas@arm.com>, <X.xie@freescale.com>
Date: Wed, 5 Aug 2015 22:13:49 -0500
In-Reply-To: <1438757404-17777-1-git-send-email-qiang.zhao@freescale.com>
References: <1438757404-17777-1-git-send-email-qiang.zhao@freescale.com>
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

On Wed, 2015-08-05 at 14:50 +0800, Zhao Qiang wrote:
> Bytes alignment is required to manage some special RAM,
> so add gen_pool_first_fit_align to genalloc,
> meanwhile add gen_pool_alloc_data to pass data to
> gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> *v2:
> changes:
> title has been modified, original patch link: 
> http://patchwork.ozlabs.org/patch/493297/
> 
> original patch add a func gen_pool_alloc_align, 
> then pass alignment to it as an parameter.
> after discussing with lauraa and scott, they recommend 
> to pass alignment as part of data based on 
> commit message for ca279cf1065fb689abea1dc7d8c11787729bb185 which adds 
> "data":
> 
> "As I can't predict all the possible requirements/needs for all allocation  
>   
> uses cases, I add a "free" field 'void *data' to pass any needed     
> information to the allocation function.  For example 'data' could be used   
>   
> to handle a structure where you store the alignment, the expected memory    
> bank, the requester device, or any information that could influence the     
> allocation algorithm."
> 
> *v3:
> changes:
> title has been modified, original patch link: 
> http://patchwork.ozlabs.org/patch/500317/
> 
> according to the comments, add gen_pool_alloc_data,
> modify gen_pool_alloc as a wrapper, define struct data_align
> for gen_pool_first_fit_align algorithm. add parameter 
> pointer pool to algorithm.
> 
> *v4:
> changes:
> v3 link: 
> http://patchwork.ozlabs.org/patch/500317/
> There are comments for v3, according to the comments,
> modify the patch for v4. such as modifying annotations,
> removing unnecessary chek, removing unnecessary cast and so on.
> 
>  include/linux/genalloc.h | 23 +++++++++++++++----
>  lib/genalloc.c           | 58 +++++++++++++++++++++++++++++++++++++++++++--
> ---
>  2 files changed, 72 insertions(+), 9 deletions(-)
> 

Looks good to me (except a minor change to the comments described below); 
send a non-RFC patch with the patches that use it.

> @@ -500,15 +518,42 @@ EXPORT_SYMBOL(gen_pool_set_algo);
>   * @start: The bitnumber to start searching at
>   * @nr: The number of zeroed bits we're looking for
>   * @data: additional data - unused
> + * @pool: unused, but the algorithm functions have same format.
>   */

Describe what pool actually is.  Whether it's used is irrelevant (and you can 
assume the reader knows that all algorithm functions have the same 
signature).  @data is different because it's defined per-algorithm and thus 
unused means no definition.

In other words, the purpose of these headers is to be a guide to the caller 
of the function, describing the API, not the function internals.

-Scott

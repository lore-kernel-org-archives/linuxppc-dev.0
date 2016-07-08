Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlzwN46NXzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 13:08:52 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id us13so3283614pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 20:08:52 -0700 (PDT)
Subject: Re: [RFC/PATCH 3/4] powerpc/64/kexec: Copy image with MMU off when
 possible
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467779707.13965.103.camel@kernel.crashing.org>
Cc: Anton Blanchard <anton@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f1887661-e287-2235-ab72-0d2abdce7dfa@gmail.com>
Date: Fri, 8 Jul 2016 13:08:44 +1000
MIME-Version: 1.0
In-Reply-To: <1467779707.13965.103.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/07/16 14:35, Benjamin Herrenschmidt wrote:
> Currently we turn the MMU off after copying the image, and we make
> sure there is no overlap between the hash table and the target pages
> in that case.
> 
> That doesn't work for Radix however. In that case, the page tables
> are scattered and we can't really enforce that the target of the
> image isn't overlapping one of them.
> 
> So instead, let's turn the MMU off before copying the image in radix
> mode. Thankfully, in radix mode, even under a hypervisor, we know we
> don't have the same kind of RMA limitations that hash mode has.
> 
> While at it, also turn the MMU off early when using hash in non-LPAR
> mode, that way we can get rid of the collision check completely.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Currently only compile tested

This makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>

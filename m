Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJRk02sm4zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 17:39:20 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id i63so1149555pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:39:20 -0700 (PDT)
Message-ID: <1493883553.7934.5.camel@gmail.com>
Subject: Re: [RFC 2/2] cxl: Mark context requiring global TLBIs
From: Balbir Singh <bsingharora@gmail.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Date: Thu, 04 May 2017 17:39:13 +1000
In-Reply-To: <20170503142906.29220-3-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-3-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 16:29 +0200, Frederic Barrat wrote:
> The PSL needs to see all TLBI pertinent to the memory contexts used on
> the cxl adapter. For the hash memory model, it was done by making all
> TLBIs global as soon as the cxl driver is in us. For radix, we need
> something similar, but we can refine and only convert to global the
> invalidations for contexts actually used by the device.
> 
> So mark the contexts being attached to the cxl adapter as requiring
> global TLBIs.
>
<snip> 
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (ctx->mm)
> +		mm_context_set_global_tlbi(&ctx->mm->context);

Just curious and wondering

Could we do mm_context_set_global_tlbi() before ->attach_process() that
way we won't need atomic tests (set_bit() and test_bit())? May be a memory
barrier would suffice. Not 100% sure, hence checking

Balbir Singh.

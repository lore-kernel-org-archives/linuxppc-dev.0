Return-Path: <srs0=l0xe=35=gondor.apana.org.au=herbert@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cJY0gCVzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:38:37 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w8cJY03gPz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:38:37 +1000 (AEST)
Received: from deadmen.hmeau.com (unknown [198.176.57.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w8cJX2zxMz9ryk
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 23:38:36 +1000 (AEST)
Date: Fri, 21 Apr 2017 21:16:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/crypto/crct10dif-vpmsum: Fix missing
 preempt_disable()
Message-ID: <20170421131635.GH14803@gondor.apana.org.au>
References: <1492666509-4568-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492666509-4568-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2017 at 03:35:09PM +1000, Michael Ellerman wrote:
> In crct10dif_vpmsum() we call enable_kernel_altivec() without first
> disabling preemption, which is not allowed.
> 
> It used to be sufficient just to call pagefault_disable(), because that
> also disabled preemption. But the two were decoupled in commit 8222dbe21e79
> ("sched/preempt, mm/fault: Decouple preemption from the page fault
> logic") in mid 2015.
> 
> The crct10dif-vpmsum code inherited this bug from the crc32c-vpmsum code
> on which it was modelled.
> 
> So add the missing preempt_disable/enable(). We should also call
> disable_kernel_fp(), although it does nothing by default, there is a
> debug switch to make it active and all enables should be paired with
> disables.
> 
> Fixes: b01df1c16c9a ("crypto: powerpc - Add CRC-T10DIF acceleration")
> Acked-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

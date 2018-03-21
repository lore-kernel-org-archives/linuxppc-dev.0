Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mD24rqfzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:25:54 +1100 (AEDT)
Date: Wed, 21 Mar 2018 15:11:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 2/4] powerpc/mm: Add support for handling > 512TB
 address in SLB miss
Message-ID: <20180321041111.GA30287@fergus.ozlabs.ibm.com>
References: <20180318110558.30493-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180318110558.30493-3-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180318110558.30493-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 18, 2018 at 04:35:56PM +0530, Aneesh Kumar K.V wrote:

[snip]
> +static inline int get_ea_context(mm_context_t *ctx, unsigned long ea)
> +{
> +	int index = ea >> MAX_EA_BITS_PER_CONTEXT;
> +
> +	if (likely(index < ARRAY_SIZE(ctx->extended_id)))
> +		return ctx->extended_id[index];
> +	/* should never happen */
> +	BUG();

Are you absolutely sure that we can never get here with an address
greater than 4PB no matter what userspace does?

I would much prefer that we just return 0 here.  I can't see that the
kernel is in a position where it really cannot continue execution at
this point, so BUG is not appropriate.

Paul.

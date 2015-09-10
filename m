Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62B081A2AE7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 08:05:57 +1000 (AEST)
Message-ID: <1441922743.2909.8.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc32: memcpy/memset: only use dcbz once cache
 is enabled
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <sojkam1@fel.cvut.cz>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 10 Sep 2015 17:05:43 -0500
In-Reply-To: <20150910064112.7B7791A241C@localhost.localdomain>
References: <20150910064112.7B7791A241C@localhost.localdomain>
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

On Thu, 2015-09-10 at 08:41 +0200, Christophe Leroy wrote:
>  
> +/* Cache related sections */
> +#define BEGIN_CACHE_SECTION_NESTED(label)    START_FTR_SECTION(label)
> +#define BEGIN_CACHE_SECTION                  START_FTR_SECTION(97)
> +
> +#define END_CACHE_SECTION_NESTED(msk, val, label)            \
> +     FTR_SECTION_ELSE_NESTED(label)                          \
> +     MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
> +
> +#define END_CACHE_SECTION(msk, val)          \
> +     END_CACHE_SECTION_NESTED(msk, val, 97)
> +
> +#define END_CACHE_SECTION_IFSET(msk) END_CACHE_SECTION((msk), (msk))
> +#define END_CACHE_SECTION_IFCLR(msk) END_CACHE_SECTION((msk), 0)
> +
> +/* CACHE feature sections with alternatives, use BEGIN_FTR_SECTION to 
> start */
> +#define CACHE_SECTION_ELSE_NESTED(label)     FTR_SECTION_ELSE_NESTED(label)
> +#define CACHE_SECTION_ELSE   CACHE_SECTION_ELSE_NESTED(97)
> +#define ALT_CACHE_SECTION_END_NESTED(msk, val, label)        \
> +     MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
> +#define ALT_CACHE_SECTION_END_NESTED_IFSET(msk, label)       \
> +     ALT_CACHE_SECTION_END_NESTED(msk, msk, label)
> +#define ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, label)       \
> +     ALT_CACHE_SECTION_END_NESTED(msk, 0, label)
> +#define ALT_CACHE_SECTION_END(msk, val)      \
> +     ALT_CACHE_SECTION_END_NESTED(msk, val, 97)
> +#define ALT_CACHE_SECTION_END_IFSET(msk)     \
> +     ALT_CACHE_SECTION_END_NESTED_IFSET(msk, 97)
> +#define ALT_CACHE_SECTION_END_IFCLR(msk)     \
> +     ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, 97)

I don't think this duplication is what Michael meant by "the normal cpu 
feature sections".  What else is going to use this very specific 
infrastructure?

-Scott

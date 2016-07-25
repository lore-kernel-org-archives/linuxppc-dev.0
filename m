Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rySKd1LYVzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:03:33 +1000 (AEST)
Date: Mon, 25 Jul 2016 14:03:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mm: Fix build break due when PPC_NATIVE=n
Message-ID: <20160725140332.0c0b6acd@canb.auug.org.au>
In-Reply-To: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, 25 Jul 2016 12:57:49 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The recent commit to rework the hash MMU setup broke the build when
> CONFIG_PPC_NATIVE=n. Fix it by providing a fallback implementation of
> hpte_init_native().

Alternatively, you could make the call site dependent on
IS_ENABLED(CONFIG_PPC_NATIVE) and not need the fallback.

so:

	else if (IS_ENABLED(CONFIG_PPC_NATIVE))
		hpte_init_native();

in arch/powerpc/mm/hash_utils_64.c and let the compiler elide the call.
-- 
Cheers,
Stephen Rothwell

Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz3x710mKzDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 13:47:55 +1000 (AEST)
Date: Tue, 26 Jul 2016 13:47:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] powerpc/mm: Fix build break when PPC_NATIVE=n
Message-ID: <20160726134754.61bea4e9@canb.auug.org.au>
In-Reply-To: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
References: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
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

On Tue, 26 Jul 2016 13:38:37 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The recent commit to rework the hash MMU setup broke the build when
> CONFIG_PPC_NATIVE=n. Fix it by adding an IS_ENABLED() check before
> calling hpte_init_native().
> 
> Removing the else clause opens the possibility that we don't set any
> ops, which would probably lead to a strange crash later. So add a check
> that we correctly initialised at least one member of the struct.
> 
> Fixes: 166dd7d3fbf2 ("powerpc/64: Move MMU backend selection out of platform code")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell

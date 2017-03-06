Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcWtb6C75zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 07:42:15 +1100 (AEDT)
Date: Tue, 7 Mar 2017 07:42:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] powerpc: Sort the selects under CONFIG_PPC
Message-ID: <20170307074214.63ac935c@canb.auug.org.au>
In-Reply-To: <1488801917-17782-1-git-send-email-mpe@ellerman.id.au>
References: <1488801917-17782-1-git-send-email-mpe@ellerman.id.au>
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

On Mon,  6 Mar 2017 23:05:17 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> We have a big list of selects under CONFIG_PPC, and currently they're
> completely unsorted. This means people tend to add new selects at the
> bottom of the list, and so two commits which both add a new select will
> often conflict.
> 
> Instead sort it alphabetically. This is nicer in and of itself, but also
> means two commits that add a new select will have a greater chance of
> not conflicting.
> 
> Add a note at the top and bottom asking people to keep it sorted.
> 
> And while we're here pad out the 'if' expressions to make them stand
> out.
> 
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Looks good.

> +	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64

Why not just move these "if PPC64" selects to "config PPC64" in
arch/powerpc/platforms/Kconfig.cputype?  Secondary question: why not
move "config PPC64" to this file?

> +	select GENERIC_ATOMIC64			if PPC32

Similarly ...

-- 
Cheers,
Stephen Rothwell

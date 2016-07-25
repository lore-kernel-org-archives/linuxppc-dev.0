Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryd6W6SzPzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 20:39:31 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <87y44qz1f3.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <20160725140332.0c0b6acd@canb.auug.org.au>
 <87y44qz1f3.fsf@concordia.ellerman.id.au>
Message-ID: <146944317083.4433.13452510294448721403@concordia>
Subject: Re: [PATCH 1/3] powerpc/mm: Fix build break due when PPC_NATIVE=n
Date: Mon, 25 Jul 2016 20:39:30 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Michael Ellerman (2016-07-25 16:17:52)
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> =

> > Hi Michael,
> >
> > On Mon, 25 Jul 2016 12:57:49 +1000 Michael Ellerman <mpe@ellerman.id.au=
> wrote:
> >>
> >> The recent commit to rework the hash MMU setup broke the build when
> >> CONFIG_PPC_NATIVE=3Dn. Fix it by providing a fallback implementation of
> >> hpte_init_native().
> >
> > Alternatively, you could make the call site dependent on
> > IS_ENABLED(CONFIG_PPC_NATIVE) and not need the fallback.
> >
> > so:
> >
> >       else if (IS_ENABLED(CONFIG_PPC_NATIVE))
> >               hpte_init_native();
> >
> > in arch/powerpc/mm/hash_utils_64.c and let the compiler elide the call.
> =

> That would mean we might fall through and not assign any ops, so I think
> it's preferable to have a fallback that explicitly panics().

Actually I think this works and is smaller all round.

Will test and resend.

cheers

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_6=
4.c
index 341632471b9d..e44f2d759055 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -885,11 +885,6 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 =

-void __init __weak hpte_init_lpar(void)
-{
-	panic("FW_FEATURE_LPAR set but no LPAR support compiled\n");
-}
-
 void __init hash__early_init_mmu(void)
 {
 	/*
@@ -931,9 +926,12 @@ void __init hash__early_init_mmu(void)
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
-	else
+	else if IS_ENABLED(CONFIG_PPC_NATIVE)
 		hpte_init_native();
 =

+	if (!mmu_hash_ops.hpte_insert)
+		panic("hash__early_init_mmu: No MMU hash ops defined!\n");
+
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.

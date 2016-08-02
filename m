Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Q4448RTzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 15:39:00 +1000 (AEST)
Message-ID: <1470116323.12584.11.camel@kernel.crashing.org>
Subject: Re: MPC5200 does not boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Aug 2016 15:38:43 +1000
In-Reply-To: <874m74w1m7.fsf@steelpick.2x.cz>
References: <874m74w1m7.fsf@steelpick.2x.cz>
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

On Tue, 2016-08-02 at 00:44 +0200, Michal Sojka wrote:
> Hi Benjamin,
> 
> the following commit causes my MPC5200 not to boot.
> 
>     commit 9402c684613163888714df0955fa1f17142b08bf
>     Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Date:   Tue Jul 5 15:03:41 2016 +1000
>      
>         powerpc: Factor do_feature_fixup calls
>         
>         32 and 64-bit do a similar set of calls early on, we move it
> all to
>         a single common function to make the boot code more readable.
>         
>         Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.o
> rg>
>         Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> I suspect that the cause will be similar as described in commit
> 1cd03890ea64795e53f17a94928cca22495acb2a. Unfortunately, I don't have
> much time to debug this, but I can easily test patches.

Does this fixes it for you ?

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index defb299..fd36e13 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -154,7 +154,7 @@ static void do_final_fixups(void)
 
 void apply_feature_fixups(void)
 {
-	struct cpu_spec *spec = *PTRRELOC(&cur_cpu_spec);
+	struct cpu_spec *spec = PTRRELOC(*PTRRELOC(&cur_cpu_spec));
 
 	/*
 	 * Apply the CPU-specific and firmware specific fixups to kernel text

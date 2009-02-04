Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B31FDDEF7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 16:22:22 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: G4 oprofile: variable number of counters
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Octavian Purdila <opurdila@ixiacom.com>
In-Reply-To: <1231246535-13151-2-git-send-email-opurdila@ixiacom.com>
References: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
	<1231246535-13151-2-git-send-email-opurdila@ixiacom.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 16:22:14 +1100
Message-Id: <1233724934.16867.290.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-06 at 14:55 +0200, Octavian Purdila wrote:
> For ppc750 processors which use 4 performance counters instead of the
> 6 G4 uses but otherwise is compatible with G4.
> 
> Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>
> ---
>  arch/powerpc/oprofile/op_model_7450.c |   21 +++++++++++----------
>  1 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/oprofile/op_model_7450.c b/arch/powerpc/oprofile/op_model_7450.c
> index cc599eb..97348f5 100644
> --- a/arch/powerpc/oprofile/op_model_7450.c
> +++ b/arch/powerpc/oprofile/op_model_7450.c
> @@ -29,7 +29,7 @@
>  static unsigned long reset_value[OP_MAX_COUNTER];
>  
>  static int oprofile_running;
> -static u32 mmcr0_val, mmcr1_val, mmcr2_val;
> +static u32 mmcr0_val, mmcr1_val, mmcr2_val, ctrs;

This may be static but it's still a global scope as far as kernel
symbols are concerned. Care to give it a slightly better name ? num_pmcs
would probably be already more telling.

Cheers,
Ben.

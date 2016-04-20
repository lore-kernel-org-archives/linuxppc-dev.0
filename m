Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqRSV6bx7zDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:59:54 +1000 (AEST)
In-Reply-To: <1460182444-2468-69-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,
 68/68] powerpc/mm/radix: Use firmware feature to disable radix
Message-Id: <3qqRSV5jq0z9sRB@ozlabs.org>
Date: Wed, 20 Apr 2016 12:59:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-09-04 at 06:14:04 UTC, "Aneesh Kumar K.V" wrote:
> We can depend on ibm,pa-features to enable/disable radix. This gives us
> a nice way to test p9 hash config, by changing device tree property.

I think we might want to be more careful here.

You set MMU_FTR_RADIX in the cputable entry. So it's on by default on P9 cpus.

Then if there is an ibm,pa-features property *and* it is >= 41 bytes long, the
below feature entry will hit. In that case the firmware controls whether it's on
or off.

I think it would be clearer if we removed RADIX from the cputable, and the below
became the only way to turn it on. Would that break anything?

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 7030b035905d..a4d1f44364b8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -165,6 +165,7 @@ static struct ibm_pa_feature {
>  	 * which is 0 if the kernel doesn't support TM.
>  	 */
>  	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
> +	{0, MMU_FTR_RADIX, 0,		40, 0, 0},

So that says bit 0 of byte 40 enables MMU_FTR_RADIX. Where is that documented?

cheers

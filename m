Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCAA52C009C
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 04:10:51 +1000 (EST)
Received: from mail1-ch1 (localhost [127.0.0.1])	by mail1-ch1-R.bigfish.com
 (Postfix) with ESMTP id 935074029B	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun
 2013 18:10:47 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail1-ch1.bigfish.com (Postfix) with ESMTP id
 032641E011D
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun 2013 18:10:46 +0000 (UTC)
Date: Tue, 4 Jun 2013 13:10:43 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/perf: add 2 additional performance monitor
 counters for e6500 core
To: Lijun Pan <Lijun.Pan@freescale.com>
References: <1369865562-29525-1-git-send-email-Lijun.Pan@freescale.com>
 <1369865562-29525-2-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1369865562-29525-2-git-send-email-Lijun.Pan@freescale.com>
 (from Lijun.Pan@freescale.com on Wed May 29 17:12:41 2013)
Message-ID: <1370369443.748.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org, Lijun.Pan@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2013 05:12:41 PM, Lijun Pan wrote:
> diff --git a/arch/powerpc/kernel/cputable.c =20
> b/arch/powerpc/kernel/cputable.c
> index cc39139..2d4eee2 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2073,7 +2073,7 @@ static struct cpu_spec __initdata cpu_specs[] =3D =20
> {
>  			MMU_FTR_USE_TLBILX,
>  		.icache_bsize		=3D 64,
>  		.dcache_bsize		=3D 64,
> -		.num_pmcs		=3D 4,
> +		.num_pmcs		=3D 6,
>  		.oprofile_cpu_type	=3D "ppc/e6500",
>  		.oprofile_type		=3D PPC_OPROFILE_FSL_EMB,
>  		.cpu_setup		=3D __setup_cpu_e6500,

This will overflow MAX_HWEVENTS.  Please include "powerpc perf: =20
increase the perf HW events to 6" from our SDK tree before this patch =20
(be sure to change "powerpc perf" to "powerpc/perf" and remove the =20
gerrit tags when you do so).

-Scott=

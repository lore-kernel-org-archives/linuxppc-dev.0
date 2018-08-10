Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mx9M1dqTzF0PM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:10:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/idle: Fix build error
In-Reply-To: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
References: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
Date: Fri, 10 Aug 2018 17:10:45 +1000
Message-ID: <87k1oy8znu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Fix the below build error using strlcpy instead of strncpy
>
> In function 'pnv_parse_cpuidle_dt',
>     inlined from 'pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:840:7,
>     inlined from '__machine_initcall_powernv_pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:870:1:
> arch/powerpc/platforms/powernv/idle.c:820:3: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>    strncpy(pnv_idle_states[i].name, temp_string[i],
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     PNV_IDLE_NAME_LEN);

I'm curious why I haven't seen this? What compiler are you using?

cheers

> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index ecb002c5db83..35f699ebb662 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -817,7 +817,7 @@ static int pnv_parse_cpuidle_dt(void)
>  		goto out;
>  	}
>  	for (i = 0; i < nr_idle_states; i++)
> -		strncpy(pnv_idle_states[i].name, temp_string[i],
> +		strlcpy(pnv_idle_states[i].name, temp_string[i],
>  			PNV_IDLE_NAME_LEN);
>  	nr_pnv_idle_states = nr_idle_states;
>  	rc = 0;
> -- 
> 2.17.1

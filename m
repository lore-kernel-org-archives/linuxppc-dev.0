Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7mB5601yzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 21:30:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shriya <shriyak@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Cc: mikey@neuling.org, aneesh.kumar@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shriya <shriyak@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Return the actual CPU frequency in
 /proc/cpuinfo
In-Reply-To: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
References: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
Date: Fri, 06 Oct 2017 21:30:36 +1100
Message-ID: <87mv544lgz.fsf@concordia.ellerman.id.au>
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

Shriya <shriyak@linux.vnet.ibm.com> writes:

> Make /proc/cpuinfo read the frequency of the CPU it is running at
> instead of reading the cached value of the last requested frequency.
> In conditions like WOF/throttle CPU can be running at a different
> frequency than the requested frequency.

Sounds like a bug fix to me ?

cheers

> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 897aa14..55ea4bf 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -311,7 +311,7 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
>  {
>  	unsigned long ret_freq;
>  
> -	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
> +	ret_freq = cpufreq_get(cpu) * 1000ul;
>  
>  	/*
>  	 * If the backend cpufreq driver does not exist,
> -- 
> 1.9.1

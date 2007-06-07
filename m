Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18023.24703.555674.28511@cargo.ozlabs.ibm.com>
Date: Thu, 7 Jun 2007 11:33:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix stolen time for SMT without LPAR 
In-Reply-To: <16370.1180069711@neuling.org>
References: <12635.1180013602@neuling.org>
	<16370.1180069711@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling writes:

> -	if (!cpu_has_feature(CPU_FTR_PURR))
> +	if (!cpu_has_feature(CPU_FTR_PURR) &&
> +	    !firmware_has_feature(FW_FEATURE_SPLPAR))
>  		return;
>  	for_each_possible_cpu(cpu)
>  		spin_lock_init(&per_cpu(cpu_purr_data, cpu).lock);

This means that on a machine with SPLPAR but not a PURR, e.g. a JS21,
we'll try to read the PURR register and do the stolen time calculation
with whatever value was in the register before the mfspr from the
PURR.  If we're going to make this change then we also need to add
code to do the H_PURR hcall instead of reading the PURR directly on
such machines.

Paul.

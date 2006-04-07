Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17462.63610.217794.308786@cargo.ozlabs.ibm.com>
Date: Sat, 8 Apr 2006 09:40:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 2/4] tickless idle cpu: Skip ticks when CPU is idle
In-Reply-To: <20060407063131.GB22416@in.ibm.com>
References: <20060407063131.GB22416@in.ibm.com>
Cc: sri_vatsa_v@yahoo.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srivatsa Vaddagiri writes:

> diff -puN arch/powerpc/kernel/idle_power4.S~no_idle_hz arch/powerpc/kernel/idle_power4.S
> --- linux-2.6.17-rc1/arch/powerpc/kernel/idle_power4.S~no_idle_hz	2006-04-07 04:14:39.000000000 +0530
> +++ linux-2.6.17-rc1-root/arch/powerpc/kernel/idle_power4.S	2006-04-07 04:14:58.000000000 +0530
> @@ -30,6 +30,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
>  	cmpwi	0,r4,0
>  	beqlr
>  
> +	mflr	r4
> +	bl	.stop_hz_timer
> +	mtlr	r4

This won't work - r4 is volatile across function calls, that is,
stop_hz_timer() could change r4 and is not required to save and
restore it.

Paul.

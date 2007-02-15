Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17875.55046.873365.575945@cargo.ozlabs.ibm.com>
Date: Thu, 15 Feb 2007 14:44:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
In-Reply-To: <1171293354.10344.6.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170973463.2620.373.camel@localhost.localdomain>
	<1171035382.4520.7.camel@johannes.berg>
	<1171293354.10344.6.camel@johannes.berg>
Cc: linux-pm@lists.osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> +_GLOBAL(power4_idle_irqs_softdisabled)
> +	li	r6,1
> +	b	0f
>  _GLOBAL(power4_idle)
> +	li	r6,0
> +0:
>  BEGIN_FTR_SECTION
>  	blr
>  END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
> @@ -35,8 +40,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
>  	rotldi	r0,r0,16
>  	mtmsrd	r0,1			/* hard-disable interrupts */
>  	li	r0,1
> -	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
> -	stb	r0,PACAHARDIRQEN(r13)
> +	stb	r0,PACAHARDIRQEN(r13)	/* we'll hard-enable shortly */
> +	stb	r6,PACASOFTIRQEN(r13)	/* set softirqs enabled bit */

Don't you have something backwards here?  If we come in through
power4_idle_irqs_softdisabled, the name would indicate to me that we
want to end up with paca->soft_enabled set to 0, not 1.

Paul.

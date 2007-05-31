Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 05A0BDE07F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 06:09:15 +1000 (EST)
Date: Thu, 31 May 2007 15:14:48 -0500
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] Donate dedicated CPU cycles
Message-ID: <20070531201447.GA30760@lixom.net>
References: <1180638885.5756.11.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180638885.5756.11.camel@goblue>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, May 31, 2007 at 02:14:45PM -0500, Jake Moilanen wrote:
> A Power6 can give up CPU cycles on a dedicated CPU (as opposed to a
> shared CPU) to other shared processors if the administrator asks for it
> (via the HMC).
> 
> This patch enables that to work properly on P6.
> 
> This just involves setting a bit in the CAS structure as well as the
> VPA.  To donate cycles, a CPU has to have all SMT threads idle and w/
> donate bit set in the VPA.  Then call H_CEDE.

[...]

> Index: powerpc/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
> +++ powerpc/arch/powerpc/platforms/pseries/setup.c
> @@ -399,6 +399,7 @@ static void pseries_dedicated_idle_sleep
>  	 * a good time to find other work to dispatch.
>  	 */
>  	get_lppaca()->idle = 1;
> +	get_lppaca()->cpuctls_task_attrs = 1;
>  
>  	/*
>  	 * We come in with interrupts disabled, and need_resched()
> @@ -431,6 +432,7 @@ static void pseries_dedicated_idle_sleep
>  
>  out:
>  	HMT_medium();
> +	get_lppaca()->cpuctls_task_attrs = 0;
>  	get_lppaca()->idle = 0;
>  }

Is this really the cpu controls task attribute field any more?  If this
is not just a flag (stored in a byte), the variable should be renamed
accordingly. If it is truly an attribute bitfield, then the attributes
should be named and constants used instead.


-Olof

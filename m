Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F39C767A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 04:40:52 +1100 (EST)
Date: Mon, 21 Mar 2005 09:40:49 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050321174049.GA11734@gate.ebshome.net>
References: <20050321152728.GS8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050321152728.GS8345@smtp.west.cox.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc44x: Remove PVR_440G* and change usages
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2005 at 08:27:29AM -0700, Tom Rini wrote:
> The following patch changes the usages of PVR_440* into strcmp's with
> the cpu_name field, and removes the defines altogether.  The Ebony
> portion was briefly tested.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
>  arch/ppc/platforms/4xx/ebony.c    |   13 ++++---------
>  arch/ppc/syslib/ibm440gx_common.c |    7 ++++---
>  include/asm-ppc/reg.h             |    6 ------
>  3 files changed, 8 insertions(+), 18 deletions(-)
> --- 1.11/arch/ppc/platforms/4xx/ebony.c	2005-03-04 23:41:48 -07:00
> +++ edited/arch/ppc/platforms/4xx/ebony.c	2005-03-08 15:22:19 -07:00
> @@ -97,15 +97,10 @@
>  	 * on Rev. C silicon then errata forces us to
>  	 * use the internal clock.
>  	 */
> -	switch (PVR_REV(mfspr(PVR))) {
> -		case PVR_REV(PVR_440GP_RB):
> -			freq = EBONY_440GP_RB_SYSCLK;
> -			break;
> -		case PVR_REV(PVR_440GP_RC1):
> -		default:
> -			freq = EBONY_440GP_RC_SYSCLK;
> -			break;
> -	}
> +	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GP Rev. B") == 0)
> +		freq = EBONY_440GP_RB_SYSCLK;
> +	else
> +		freq = EBONY_440GP_RC_SYSCLK;
>  
>  	ibm44x_calibrate_decr(freq);
>  }
> --- 1.3/arch/ppc/syslib/ibm440gx_common.c	2004-11-07 19:08:31 -07:00
> +++ edited/arch/ppc/syslib/ibm440gx_common.c	2005-03-21 08:20:17 -07:00
> @@ -221,9 +221,10 @@
>  	/* Disable L2C on rev.A, rev.B and 800MHz version of rev.C,
>  	   enable it on all other revisions
>  	 */
> -	u32 pvr = mfspr(PVR);
> -	if (pvr == PVR_440GX_RA || pvr == PVR_440GX_RB ||
> -	    (pvr == PVR_440GX_RC && p->cpu > 667000000))
> +	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. A") == 0 ||
> +			strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. B") == 0
> +			|| (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. C")
> +				== 0 && p->cpu > 667000000))


While I applaud Tom's quest to eliminate _useless_ PVR defines I think 
this change looks strange.

It substitutes simple and clear (for those who are reading this code) 
check to something more involved without good reason, IMHO.

Also, it adds additional "point of failure" making this code more 
fragile. We never used those CPU ID strings anywhere in the kernel 
code before, people are used to the fact that they don't matter much 
(maybe only for user-mode) and it's possible that during some future 
"cleanup" code will break. One could say that we aren't allowed to 
change such strings because something in user-mode could break, and 
while I agree with that, I don't think it's good argument to _add_ 
additional point where code could break.

--
Eugene

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E5301A0072
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 21:26:57 +1000 (AEST)
Message-ID: <1433158011.1004.3.camel@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/pseries: Ratelimit EPOW event warnings
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
Date: Mon, 01 Jun 2015 21:26:51 +1000
In-Reply-To: <1432787595-9946-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1432787595-9946-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-28 at 10:03 +0530, Kamalesh Babulal wrote:
> We print the respective warning after parsing EPOW interrupts,
> prompting user to take action depending upon the severity of the
> event.
> 
> Some times same EPOW event warning, such as below could flood kernel
> log, within very short duration. So Limit the message by using
> ratelimit variant of pr_err.
> 
> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
> May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
> May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared

Looking at the time stamps those are actually all fairly far apart in time,
aren't they? So do we actually see them within a short duration in practice?

It does seem sensible to rate limit them though.

> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..2556bc2 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -145,17 +145,17 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  
>  	switch (action_code) {
>  	case EPOW_RESET:
> -		pr_err("Non critical power or cooling issue cleared");
> +		pr_err_ratelimited("Non critical power or cooling issue cleared");
>  		break;
>  
>  	case EPOW_WARN_COOLING:
> -		pr_err("Non critical cooling issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err_ratelimited("Non critical cooling issue reported by firmware");
> +		pr_err_ratelimited("Check RTAS error log for details");
>  		break;
>  
>  	case EPOW_WARN_POWER:
> -		pr_err("Non critical power issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err_ratelimited("Non critical power issue reported by firmware");
> +		pr_err_ratelimited("Check RTAS error log for details");
>  		break;

Those last two could be collapsed onto one line which would reduce the spam.

cheers

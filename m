Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 331FADE238
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 07:39:37 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6FLfxBX006066
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 17:41:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6FLdThB234378
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 17:39:29 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6FLdS36032438
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 17:39:28 -0400
Message-ID: <487D1902.20609@linux.vnet.ibm.com>
Date: Tue, 15 Jul 2008 16:39:14 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: correct CMO feature flag enablement
References: <20080715212008.GA25230@linux.vnet.ibm.com>
In-Reply-To: <20080715212008.GA25230@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked by: Brian King <brking@linux.vnet.ibm.com>

Robert Jennings wrote:
> Correct string conversion for rtas value being read for CMO configuration.
> A value of -1 in the string indicates that CMO is not enabled and we
> had used simple_strtoul rather than simple_strtol which caused problems.
> 
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> 
> ---
> 
> This patch applies on top of the CMO patchset sent to the list.
> 
> ---
>  arch/powerpc/platforms/pseries/setup.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -366,9 +366,9 @@ void pSeries_cmo_feature_init(void)
>  			}
> 
>  			if (0 == strcmp(key, "PrPSP"))
> -				PrPSP = simple_strtoul(value, NULL, 10);
> +				PrPSP = simple_strtol(value, NULL, 10);
>  			else if (0 == strcmp(key, "SecPSP"))
> -				SecPSP = simple_strtoul(value, NULL, 10);
> +				SecPSP = simple_strtol(value, NULL, 10);
>  			value = key = ptr + 1;
>  		}
>  		ptr++;


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

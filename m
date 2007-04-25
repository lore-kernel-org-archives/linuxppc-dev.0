Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id DC732DDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 22:07:40 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HggHa-0004Xl-DM
	for linuxppc-embedded@ozlabs.org; Wed, 25 Apr 2007 14:07:38 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
Date: Wed, 25 Apr 2007 14:07:38 +0200
In-Reply-To: <11766220693636-git-send-email-grant.likely@secretlab.ca> (Grant
	Likely's message of "Sun, 15 Apr 2007 01:27:39 -0600")
Message-ID: <87d51sac8l.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

GL> The header files for the ml403 and ml300 are virtually identical,
GL> merge them into a single file.

GL> diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
GL> index 92fd02d..ed6891a 100644
GL> --- a/include/asm-ppc/ibm4xx.h
GL> +++ b/include/asm-ppc/ibm4xx.h
GL> @@ -47,12 +47,8 @@
GL>  #include <platforms/4xx/walnut.h>
GL>  #endif
GL>  
GL> -#if defined(CONFIG_XILINX_ML300)
GL> -#include <platforms/4xx/xilinx_ml300.h>
GL> -#endif
GL> -
GL> -#if defined(CONFIG_XILINX_ML403)
GL> -#include <platforms/4xx/xilinx_ml403.h>
GL> +#if defined(CONFIG_XILINX_VIRTEX)
GL> +#include <platforms/4xx/virtex.h>
GL>  #endif

Could we make that

#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)

instead? I'm using RedBoot on a virtex platform, and hence another
struct bd_info than the ML300/ML403.

Other than that,

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard

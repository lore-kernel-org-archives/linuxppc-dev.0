Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xtKdX07WpzDrZs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 23:49:19 +1000 (AEST)
Date: Thu, 14 Sep 2017 14:49:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, arnd@arndb.de, madalin.bucur@nxp.com,
 linux@armlinux.org.uk, oss@buserror.net,
 Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [v4 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
Message-ID: <20170914134916.evw2mhjhxa6zo72x@localhost>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 04:37:49PM -0400, Roy Pledge wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Not relevant and arch dependent. Overkill for PPC.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
> index 2ce394a..f85c319 100644
> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
> @@ -49,10 +49,6 @@
>  #define DPAA_PORTAL_CE 0
>  #define DPAA_PORTAL_CI 1
>  
> -#if (L1_CACHE_BYTES != 32) && (L1_CACHE_BYTES != 64)
> -#error "Unsupported Cacheline Size"
> -#endif

Maybe this check was for a reason on PPC as it uses WB memory mappings
for some of the qbman descriptors (which IIUC fit within a cacheline).
You could add a check for CONFIG_PPC if you think there is any chance of
this constant going higher.

-- 
Catalin

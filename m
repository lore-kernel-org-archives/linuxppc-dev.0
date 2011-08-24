Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A954FB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 04:54:01 +1000 (EST)
Date: Wed, 24 Aug 2011 11:53:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Liu Gang-B34182 <B34182@freescale.com>
Subject: Re: [PATCH] fsl-rio: Correct IECSR register clear value
Message-Id: <20110824115355.92febdfc.akpm@linux-foundation.org>
In-Reply-To: <9A1C2A9ACC704641BC472A1588CE16470EC9C3@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1312798419-3912-1-git-send-email-b34182@freescale.com>
	<9A1C2A9ACC704641BC472A1588CE16470EC9C3@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
	Li Yang-R58472 <r58472@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 24 Aug 2011 09:31:21 +0000
Liu Gang-B34182 <B34182@freescale.com> wrote:

> Hi, Andrew,
> 
> Thank you for applying the patch "[PATCH] rio: Use discovered bit to test if enumeration is complete "!
> 
> So far the following patch "[PATCH] fsl-rio: Correct IECSR register clear value " has no comment or response.

Perhaps because you didn't tell anyone what the patch does.

> To: linuxppc-dev@ozlabs.org
> Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang Roy-R61911; Liu Gang-B34182; Liu Gang-B34182
> Subject: [PATCH] fsl-rio: Correct IECSR register clear value
> 
> The RETE bit in IECSR is cleared by writing a 1 to it.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c index b3fd081..cdd765b 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -54,6 +54,7 @@
>  #define ODSR_CLEAR		0x1c00
>  #define LTLEECSR_ENABLE_ALL	0xFFC000FC
>  #define ESCSR_CLEAR		0x07120204
> +#define IECSR_CLEAR		0x80000000
>  
>  #define RIO_PORT1_EDCSR		0x0640
>  #define RIO_PORT2_EDCSR		0x0680
> @@ -1089,11 +1090,11 @@ static void port_error_handler(struct rio_mport *port, int offset)
>  
>  	if (offset == 0) {
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT1_EDCSR), 0);
> -		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), 0);
> +		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), IECSR_CLEAR);
>  		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
>  	} else {
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT2_EDCSR), 0);
> -		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), 0);
> +		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), IECSR_CLEAR);
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT2_ESCSR), ESCSR_CLEAR);
>  	}
>  }

Apparently it fixes some bug.  But because you didn't tell us what the
user-visible effects of that bug are, I am unable to determine what
kernel versions (if any) the patch should be merged into.

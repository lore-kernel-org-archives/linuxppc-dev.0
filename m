Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFz4f4lhwzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 17:01:54 +1000 (AEST)
Date: Sun, 30 Apr 2017 02:01:44 -0500
From: Scott Wood <oss@buserror.net>
To: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Ronak Desai <ronak.desai@rockwellcollins.com>
Message-ID: <20170430070144.5ofjqykho5fmf2ah@home.buserror.net>
References: <1493315980-28480-1-git-send-email-matthew.weber@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493315980-28480-1-git-send-email-matthew.weber@rockwellcollins.com>
Subject: Re: [1/1] powerpc/traps : Updated MC for E6500 L1D cache err
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2017 at 12:59:40PM -0500, Matt Weber wrote:
> This patch updates the machine check handler of Linux kernel to
> handle the e6500 architecture case. In e6500 core, L1 Data Cache Write
> Shadow Mode (DCWS) register is not implemented but L1 data cache always
> runs in write shadow mode. So, on L1 data cache parity errors, hardware
> will automatically invalidate the data cache but will still log a
> machine check interrupt.
> 
> Signed-off-by: Ronak Desai <ronak.desai@rockwellcollins.com>
> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
> ---
>  arch/powerpc/include/asm/reg_booke.h |  1 +
>  arch/powerpc/kernel/traps.c          | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index 737e012..c811128 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -196,6 +196,7 @@
>  #define SPRN_DEAR	0x03D	/* Data Error Address Register */
>  #define SPRN_ESR	0x03E	/* Exception Syndrome Register */
>  #define SPRN_PIR	0x11E	/* Processor Identification Register */
> +#define SPRN_PVR	0x11F	/* Processor Version Register */
>  #define SPRN_DBSR	0x130	/* Debug Status Register */
>  #define SPRN_DBCR0	0x134	/* Debug Control Register 0 */
>  #define SPRN_DBCR1	0x135	/* Debug Control Register 1 */

This is already defined in asm/reg.h

> @@ -545,8 +546,15 @@ int machine_check_e500mc(struct pt_regs *regs)
>  		 * may still get logged and cause a machine check.  We should
>  		 * only treat the non-write shadow case as non-recoverable.
>  		 */
> -		if (!(mfspr(SPRN_L1CSR2) & L1CSR2_DCWS))
> -			recoverable = 0;
> +		/* On e6500 core, L1 DCWS (Data cache write shadow mode) bit is
> +		 * not implemented but L1 data cache is by default configured
> +		 * to run in write shadow mode. Hence on data cache parity errors
> +		 * HW will automatically invalidate the L1 Data Cache.
> +		 */

Please wrap at under 80 columns.

"default" implies it can be changed, so:
s/is by default configured to run in write shadow mode/always runs in
write shadow mode/

Otherwise looks good.

-Scott

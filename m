Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTM504ZYTzDrpR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 08:40:52 +1000 (AEST)
Message-ID: <1473201626.30217.1.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Sep 2016 17:40:26 -0500
In-Reply-To: <20160905064232.2CEB11A245A@localhost.localdomain>
References: <20160905064232.2CEB11A245A@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/8xx: add system_reset_exception
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-05 at 08:42 +0200, Christophe Leroy wrote:
> When the watchdog is in NMI mode, the system reset interrupt is
> generated when the watchdog counter expires.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/head_8xx.S | 2 +-
>  arch/powerpc/kernel/traps.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 43ddaae..f7b8007 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -227,7 +227,7 @@ i##n:							
> 	\
>  			  ret_from_except)
>  
>  /* System reset */
> -	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
> +	EXCEPTION(0x100, Reset, system_reset_exception, EXC_XFER_STD)

Does this do anything useful beyond what unknown_exception does?  Do you plan
to have a ppc_md.system_reset_exception callback?

-Scott

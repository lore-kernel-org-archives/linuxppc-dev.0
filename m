Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmLgv0yVlzF1Ds
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 13:16:10 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g12so88387pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 18:16:10 -0800 (PST)
Date: Wed, 21 Feb 2018 12:15:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [RFC] powerpc/powernv/mce: Don't silently restart the machine
Message-ID: <20180221121554.67ab6847@roar.ozlabs.ibm.com>
In-Reply-To: <20180221010111.30517-1-bsingharora@gmail.com>
References: <20180221010111.30517-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Feb 2018 12:01:11 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On MCE the current code will restart the machine with
> ppc_md.restart(). This case was extremely unlikely since
> prior to that a skiboot call is made and that resulted in
> a checkstop for analysis.
> 
> With newer skiboots, on P9 we don't checkstop the box by
> default, instead we return back to the kernel to extract
> useful information at the time of the MCE. While we still
> get this information, this patch converts the restart to
> a panic(), so that if configured a dump can be taken and
> we can track and probably debug the potential issue causing
> the MCE.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Seems like something we should be doing.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 69b5263fc9e3..b510a6f41b00 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -500,9 +500,12 @@ void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
>  	 *    opal to trigger checkstop explicitly for error analysis.
>  	 *    The FSP PRD component would have already got notified
>  	 *    about this error through other channels.
> +	 * 4. We are running on a newer skiboot that by default does
> +	 *    not cause a checkstop, drops us back to the kernel to
> +	 *    extract context and state at the time of the error.
>  	 */
>  
> -	ppc_md.restart(NULL);
> +	panic("PowerNV Unrecovered Machine Check");
>  }
>  
>  int opal_machine_check(struct pt_regs *regs)

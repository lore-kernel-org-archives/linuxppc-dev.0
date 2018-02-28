Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrrPy4WntzF1Zm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 20:49:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: Re: powerpc/powernv/mce: Don't silently restart the machine
In-Reply-To: <20180228010636.22772-1-bsingharora@gmail.com>
References: <20180228010636.22772-1-bsingharora@gmail.com>
Date: Wed, 28 Feb 2018 20:49:32 +1100
Message-ID: <87a7vt4f6b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

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
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 69b5263fc9e3..b510a6f41b00 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -500,9 +500,12 @@ void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
                                                                            ^^^^^^^^^^^^^^^
Why don't we use the msg ..

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
              ^
              Here.

Because we can get here from a HMI so it's confusing to print "Machine
Check" in that case, and we have the msg already.

So just:

> +	panic(msg);

cheers

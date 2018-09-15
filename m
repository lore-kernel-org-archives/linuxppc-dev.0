Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42CMnz0qyszF22s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 05:26:45 +1000 (AEST)
Message-ID: <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org,  mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org,  rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-clk@vger.kernel.org,  linux-pm@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org,  catalin.marinas@arm.com,
 will.deacon@arm.com, gregkh@linuxfoundation.org,  arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com, Yogesh Gaur
 <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>
Date: Sat, 15 Sep 2018 14:24:21 -0500
In-Reply-To: <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
 <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 02:07 +0530, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3a1812f..e9ae70b 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -79,7 +79,7 @@ struct clockgen_chipinfo {
>  	const struct clockgen_muxinfo *cmux_groups[2];
>  	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
>  	void (*init_periph)(struct clockgen *cg);
> -	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than
> NUM_CMUX */
> +	int cmux_to_group[NUM_CMUX+1]; /* -1 terminate if fewer to
> NUM_CMUX+1 */

You need to add the -1 terminator to p4080, and remove the "if fewer" comment
since the whole point of this is that every array gets -1 terminated.

Why did you change "terminates" to "terminate" and "than" to "to"?

This +1 change should be a separate patch from lx2160a support.

-Scott

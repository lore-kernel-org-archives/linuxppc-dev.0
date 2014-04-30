Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C691B140102
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 09:24:21 +1000 (EST)
Message-ID: <1398900249.24575.229.camel@snotra.buserror.net>
Subject: Re: [PATCH][v3] powerpc: move epapr paravirt init of power_save to
 an initcall
From: Scott Wood <scottwood@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Date: Wed, 30 Apr 2014 18:24:09 -0500
In-Reply-To: <1398900192-2646-1-git-send-email-stuart.yoder@freescale.com>
References: <1398900192-2646-1-git-send-email-stuart.yoder@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-30 at 18:23 -0500, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> some restructuring of epapr paravirt init resulted in
> ppc_md.power_save being set, and then overwritten to
> NULL during machine_init.  This patch splits the
> initialization of ppc_md.power_save out into a postcore
> init call.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> -v3
>    -changed approach slightly, set flag in the dt scanning
>     code and just look at that flag in the initcall
> 
> 
>  arch/powerpc/kernel/epapr_paravirt.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
> index 7898be9..6596cd7 100644
> --- a/arch/powerpc/kernel/epapr_paravirt.c
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -30,6 +30,7 @@ extern u32 epapr_ev_idle_start[];
>  #endif
>  
>  bool epapr_paravirt_enabled;
> +bool epapr_has_idle;

static

-Scott

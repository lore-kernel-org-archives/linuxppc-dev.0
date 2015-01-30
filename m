Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 744561A010D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:42:52 +1100 (AEDT)
Date: Thu, 29 Jan 2015 23:42:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexandru-Cezar Sardan <alexandru.sardan@freescale.com>
Subject: Re: perf/powerpc: reset event hw state when adding it to the PMU
Message-ID: <20150130054238.GA14897@home.buserror.net>
References: <1403773138-7558-1-git-send-email-alexandru.sardan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1403773138-7558-1-git-send-email-alexandru.sardan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2014 at 11:58:58AM +0300, Alexandru-Cezar Sardan wrote:
> When adding an event to the PMU with PERF_EF_START the STOPPED and UPTODATE
> flags need to be cleared in the hw.event status variable because they are
> preventing the update of the event count on overflow interrupt.
> 
> Signed-off-by: Alexandru-Cezar Sardan <alexandru.sardan@freescale.com>
> ---
>  arch/powerpc/perf/core-fsl-emb.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Sorry for the delay -- it wasn't CCed to me and the subject line didn't
indicate that it was fsl related.

> diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
> index d35ae52..ef2ce48 100644
> --- a/arch/powerpc/perf/core-fsl-emb.c
> +++ b/arch/powerpc/perf/core-fsl-emb.c
> @@ -330,9 +330,11 @@ static int fsl_emb_pmu_add(struct perf_event *event, int flags)
>  	}
>  	local64_set(&event->hw.prev_count, val);
>  
> -	if (!(flags & PERF_EF_START)) {
> +	if (unlikely(!(flags & PERF_EF_START))) {
>  		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>  		val = 0;
> +	} else {
> +		event->hw.state &= ~(PERF_HES_STOPPED | PERF_HES_UPTODATE);
>  	}

Why unlikely()?  None of the other perf drivers have that there.

Commit f53d168c does something similar for book3s.  It sets hw.state to
zero instead of clearing the flags.  Any reason why core-fsl-emb should
be different?

-Scott

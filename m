Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 327181A2BAD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2015 11:10:20 +1000 (AEST)
Date: Fri, 11 Sep 2015 20:10:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roy Pledge <Roy.Pledge@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [v2 04/11] soc/fsl: Introduce drivers for the DPAA QMan
Message-ID: <20150912011005.GA8796@home.buserror.net>
References: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
 <1439410497-19039-5-git-send-email-Roy.Pledge@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1439410497-19039-5-git-send-email-Roy.Pledge@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 04:14:50PM -0400, Roy Pledge wrote:
> +/* Lock/unlock frame queues, subject to the "LOCKED" flag. This is about
> + * inter-processor locking only. Note, FQLOCK() is always called either under a
> + * local_irq_save() or from interrupt context - hence there's no need for irq
> + * protection (and indeed, attempting to nest irq-protection doesn't work, as
> + * the "irq en/disable" machinery isn't recursive...). */
> +#define FQLOCK(fq) \
> +	do { \
> +		struct qman_fq *__fq478 = (fq); \
> +		if (fq_isset(__fq478, QMAN_FQ_FLAG_LOCKED)) \
> +			spin_lock(&__fq478->fqlock); \
> +	} while (0)
> +#define FQUNLOCK(fq) \
> +	do { \
> +		struct qman_fq *__fq478 = (fq); \
> +		if (fq_isset(__fq478, QMAN_FQ_FLAG_LOCKED)) \
> +			spin_unlock(&__fq478->fqlock); \
> +	} while (0)
> +

I don't see QMAN_FQ_FLAG_LOCKED set anywhere.  What is the use case?

-Scott

Return-Path: <david-b@pacbell.net>
Received: from smtp118.sbc.mail.sp1.yahoo.com (smtp118.sbc.mail.sp1.yahoo.com
	[69.147.64.91]) by ozlabs.org (Postfix) with SMTP id 9654CDE0FE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 06:45:40 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc5200: Fix locking on mpc52xx_spi driver
Date: Sun, 27 Jul 2008 13:45:37 -0700
References: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
In-Reply-To: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807271345.37360.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, dwalker@mvista.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Applying patch mpc52xx-spi-fix0.patch
patching file drivers/spi/mpc52xx_spi.c
Hunk #1 FAILED at 149.
Hunk #2 succeeded at 154 (offset -7 lines).
Hunk #3 succeeded at 311 (offset -7 lines).
1 out of 3 hunks FAILED -- rejects in file drivers/spi/mpc52xx_spi.c
Patch mpc52xx-spi-fix0.patch does not apply (enforce with -f)

... looks like chunk #1 was against something other than
what you posted, and was partly reversed ..


> +static irqreturn_t mpc52xx_spi_irq(int irq, void *_ms)
> +{
> +	struct mpc52xx_spi *ms = _ms;
> +	spin_lock(&ms->lock);

Blank line after variable declaration blocks please ... and
also, since you're not using IRQF_DISABLED when you request
this IRQ, you've got locking trouble here.  Either specify
IRQF_DISABLED (my preference) or use spin_lock_irqsave().

> +	mpc52xx_spi_fsm_process(irq, ms);
> +	spin_unlock(&ms->lock);
>  	return IRQ_HANDLED;
>  }

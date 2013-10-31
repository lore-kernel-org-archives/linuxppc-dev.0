Return-Path: <B42378@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E33A2C035A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 23:29:01 +1100 (EST)
From: Chen Guangyu-B42378 <B42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 12:28:49 +0000
Message-ID: <oxq6yw1a1g6ccnd85o4ral9y.1383222536476@email.android.com>
References: <cover.1383207153.git.b42378@freescale.com>
 <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>,
 <5272474D.5000207@tabi.org>
In-Reply-To: <5272474D.5000207@tabi.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "philippe.retornaz@gmail.com" <philippe.retornaz@gmail.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you for the comments.
I'll refine this part.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Nicolin Chen wrote:
> +     if (ssi_private->use_dual_fifo) {
> +             write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
> +             write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
> +             write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
> +     } else {
> +             write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
> +             write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
> +             write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
> +     }

Why do you need the "else" part?  Why can't you just do this:

if (ssi_private->use_dual_fifo) {
        write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
        write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
        write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
}

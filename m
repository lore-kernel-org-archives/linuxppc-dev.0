Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwzxy3s4rzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 13:41:09 +1000 (AEST)
Received: by mail-ig0-x235.google.com with SMTP id u10so11217495igr.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 20:41:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461609378-467-1-git-send-email-caleb@crome.org>
References: <1461609378-467-1-git-send-email-caleb@crome.org>
Date: Fri, 29 Apr 2016 00:41:05 -0300
Message-ID: <CAOMZO5DK2nd+VfkSAgbgByPU+vhY2DG0dsZT_mKtEX+4b+p0Fw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to
 volatile register list
From: Fabio Estevam <festevam@gmail.com>
To: Caleb Crome <caleb@crome.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2016 at 3:36 PM, Caleb Crome <caleb@crome.org> wrote:
> The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
> on the i.MX SSI port.  The fsl_ssi_trigger writes this register in
> order to clear the fifo at trigger time.
>
> However, since the CCSR_SSI_SOR register is not in the volatile list,
> the caching mechanism prevented the register write in the trigger
> function.  This caused the fifo to not be cleared (because the value
> was unchanged from the last time the register was written), and thus
> causes the channels in both TDM or simple I2S mode to slip and be in
> the wrong time slots on SSI restart.
>
> This has gone unnoticed for so long because with simple stereo mode,
> the consequence is that left and right are swapped, which isn't that
> noticeable.  However, it's catestrophic in some systems that
> require the channels to be in the right slots.
>
> Signed-off-by: Caleb Crome <caleb@crome.org>
> Suggested-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

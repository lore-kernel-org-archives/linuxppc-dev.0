Return-Path: <festevam@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B617E1A05C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 08:03:31 +1100 (AEDT)
Received: by mail-lb0-f179.google.com with SMTP id z11so9269700lbi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Dec 2014 13:03:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <547CD2C6.2060107@tabi.org>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <2547588.Qc4F2IfZke@wuerfel> <547CC89F.1030205@tabi.org>
 <3401240.VsRpsiV8WN@wuerfel> <547CCB78.5090007@tabi.org>
 <547CCFF7.2000205@metafoo.de>
 <CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
 <547CD2C6.2060107@tabi.org>
Date: Mon, 1 Dec 2014 19:03:27 -0200
Message-ID: <CAOMZO5Cz60D5V2uKM4ivWp9s44XXqVsuEJhpmSWoBuq+yUvNMw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
From: Fabio Estevam <festevam@gmail.com>
To: Timur Tabi <timur@tabi.org>
Content-Type: text/plain; charset=UTF-8
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>,
 Markus Pargmann <mpa@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 1, 2014 at 6:42 PM, Timur Tabi <timur@tabi.org> wrote:

> Would the mapping continue to exist after the driver is unloaded?  Can you
> try multiple loads/unloads and see if interrupts still work?

I tried multiple loads/unloads and audio works fine with those changes.

About the ssi irq we have:

- With the ssi driver loaded:
root@freescale /home$ cat /proc/interrupts | grep ssi
 79:          0          0          0          0       GIC  79  202c000.ssi

- After removing the ssi driver:
root@freescale /home$ rmmod   snd-soc-fsl-ssi
root@freescale /home$ cat /proc/interrupts | grep ssi
root@freescale /home$

,so it seems to behave properly.

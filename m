Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 100EC1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 07:42:52 +1100 (AEDT)
Message-ID: <547CD2C6.2060107@tabi.org>
Date: Mon, 01 Dec 2014 14:42:46 -0600
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>	<2547588.Qc4F2IfZke@wuerfel>	<547CC89F.1030205@tabi.org>	<3401240.VsRpsiV8WN@wuerfel>	<547CCB78.5090007@tabi.org>	<547CCFF7.2000205@metafoo.de>
 <CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Arnd Bergmann <arnd@arndb.de>, Jiada Wang <jiada_wang@mentor.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On 12/01/2014 02:40 PM, Fabio Estevam wrote:
>> >Hm... that's new. But it's not really a driver issue anymore if it is done
>> >in the core. So I guess for now just use platform_get_irq() and ignore the
>> >other issue.

> With the suggested changes below, the removal of the driver works fine on a mx6:

Would the mapping continue to exist after the driver is unloaded?  Can 
you try multiple loads/unloads and see if interrupts still work?

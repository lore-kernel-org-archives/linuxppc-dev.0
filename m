Return-Path: <lars@metafoo.de>
Received: from smtp-out-249.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by lists.ozlabs.org (Postfix) with ESMTP id D2B6B1A05F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 07:30:41 +1100 (AEDT)
Message-ID: <547CCFF7.2000205@metafoo.de>
Date: Mon, 01 Dec 2014 21:30:47 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <2547588.Qc4F2IfZke@wuerfel> <547CC89F.1030205@tabi.org>
 <3401240.VsRpsiV8WN@wuerfel> <547CCB78.5090007@tabi.org>
In-Reply-To: <547CCB78.5090007@tabi.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>,
 Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 09:11 PM, Timur Tabi wrote:
> On 12/01/2014 02:01 PM, Arnd Bergmann wrote:
>>> >Does this mean that fsl_ssi.c should not be calling
>>> >irq_of_parse_and_map?  How else should it get the IRQ?
>> platform_get_irq()
>
> Ok, but that function also calls irq_create_of_mapping().  So it still
> appears that the only way to get the IRQ is to map it, but then we can't use
> devm_request_irq().
>

Hm... that's new. But it's not really a driver issue anymore if it is done 
in the core. So I guess for now just use platform_get_irq() and ignore the 
other issue.

Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4182E2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 05:23:09 +1000 (EST)
Date: Wed, 21 Aug 2013 21:22:58 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
Message-ID: <20130821212258.2cbc969c@crub>
In-Reply-To: <1375821851-31609-2-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-2-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:41 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> cleanup the MPC512x SoC's SPI master's use of the clock API
> - get, prepare, and enable the MCLK during probe; disable, unprepare and
>   put the MCLK upon remove; hold a reference to the clock over the
>   period of use
> - fetch MCLK rate (reference) once during probe and slightly reword BCLK
>   (bitrate) determination to reduce redundancy as well as to not exceed
>   the maximum text line length
> - stick with the PPC_CLOCK 'psc%d_mclk' name for clock lookup, only
>   switch to a fixed string later after device tree based clock lookup
>   will have become available
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/spi/spi-mpc512x-psc.c |   48 +++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 18 deletions(-)

Mark, are you going to apply this patch? Or should I queue it
in my mpc5xxx tree (I'd like to get your Acked-by then)?

Thanks,

Anatolij

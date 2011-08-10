Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 64999B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 00:33:08 +1000 (EST)
Date: Wed, 10 Aug 2011 09:33:06 -0500
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v10 3/5] [flexcan] Add of_match to platform_device
	definition.
Message-ID: <20110810143306.GR4926@sgi.com>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-4-git-send-email-holt@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312945564-6626-4-git-send-email-holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	PPC list <linuxppc-dev@lists.ozlabs.org>,
	U Bhaskar-B22300 <B22300@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 10:06:02PM -0500, Robin Holt wrote:
> On powerpc, the OpenFirmware devices are not matched without specifying
> an of_match array.  Introduce that array as that is used for matching
> on the Freescale P1010 processor.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Marc Kleine-Budde <mkl@pengutronix.de>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> To: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: socketcan-core@lists.berlios.de
> Cc: netdev@vger.kernel.org
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> ---
>  drivers/net/can/flexcan.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 68cbe52..662f832 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1027,8 +1027,19 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct of_device_id flexcan_of_match[] = {
> +	{
> +		.compatible = "fsl,flexcan",

Let me make sure I have this correct.  At this point, we would want it
to be fsl,flexcan here.  If, at some point, we find the i.MX-wonderful
has diverged from the -p1010, we would, at that point in the code, use
of_device_is_compatible to differentiate the two, correct?  That would
mean we should make no change to this patch for the fsl,flexcan-p1010,
right?

Robin

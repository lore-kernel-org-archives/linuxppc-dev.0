Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8A11B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 11:34:26 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id wy12so2859324pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 17:34:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Bug fix in commit 178db7d3 triggered a bug in the SPI
 driver for MPC83XX (pdata is NULL).
To: Kenth Eriksson <kenth.eriksson@transmode.com>,
 spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@transmode.com
In-Reply-To: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
References: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
Date: Fri, 30 Mar 2012 16:25:42 -0600
Message-Id: <20120330222542.E63AB3E0709@localhost>
Cc: Kenth Eriksson <kenth.eriksson@transmode.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 30 Mar 2012 17:05:30 +0200, Kenth Eriksson <kenth.eriksson@transmode.com> wrote:
> After commit 178db7d3 devices are initialized as children of the bus master, not children of the bus masters parent device. The pdata pointer used in fsl_spi_chipselect must updated to reflect the changed initialization.
> 
> Signed-off-by: Kenth Eriksson <kenth.eriksson@transmode.com>

Applied; but I have a comments on your commit text.

SHA1 id's are great for looking up commits, but they don't help at all
for casual readers on the mailing list or doing web searches.  Please
always include the commit title when referencing an earlier commit.  I
had to edit the commit text.  Here is what I changed it to:

    spi/mpc83xx: fix NULL pdata dereference bug
    
    Commit 178db7d3, "spi: Fix device unregistration when unregistering
    the bus master", changed device initialization to be children of the
    bus master, not children of the bus masters parent device. The pdata
    pointer used in fsl_spi_chipselect must updated to reflect the changed
    initialization.

g.

> ---
>  drivers/spi/spi-fsl-spi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 7d6ca68..dc747a0 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -139,10 +139,12 @@ static void fsl_spi_change_mode(struct spi_device *spi)
>  static void fsl_spi_chipselect(struct spi_device *spi, int value)
>  {
>  	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
> -	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
> +	struct fsl_spi_platform_data *pdata;
>  	bool pol = spi->mode & SPI_CS_HIGH;
>  	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
>  
> +	pdata = spi->dev.parent->parent->platform_data;
> +
>  	if (value == BITBANG_CS_INACTIVE) {
>  		if (pdata->cs_control)
>  			pdata->cs_control(spi, !pol);
> -- 
> 1.7.3.4
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

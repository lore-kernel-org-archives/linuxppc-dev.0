Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 363CBDDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 22:44:27 +1000 (EST)
Date: Tue, 30 Sep 2008 16:44:24 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
Message-ID: <20080930124424.GA6878@oksana.dev.rtsoft.ru>
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 06:12:19PM +0400, Anton Vorontsov wrote:
> of/base.c matches on the first (most specific) entries, which isn't
> quite practical but it was discussed[1] that this won't change.
> 
> The bindings specifies verbose information for the devices, but
> it doesn't fit in the I2C ID's 20 characters limit. The limit won't
> change[2], and the bindings won't change either as they're correct.
> 
> So we have to put an exception for the MPC8349E-mITX-compatible
> MCUs.
> 
> [1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html
> [2] http://www.nabble.com/-PATCH-1-2--i2c:-expand-I2C's-id.name-to-23-characters-td19577063.html
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/of/base.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Any issues with this or the second patch? Can we merge them?


Thanks,

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ad8ac1a..a726464 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -410,7 +410,7 @@ struct of_modalias_table {
>  	char *modalias;
>  };
>  static struct of_modalias_table of_modalias_table[] = {
> -	/* Empty for now; add entries as needed */
> +	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
>  };
>  
>  /**
> -- 
> 1.5.6.3

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

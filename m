Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 24 Dec 2010 02:15:23 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] misc: at24: add more sanity checks for parameters
Message-ID: <20101224091523.GK5544@angua.secretlab.ca>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
	<1289995250-17927-3-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289995250-17927-3-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 17, 2010 at 01:00:49PM +0100, Wolfram Sang wrote:
> Side-effects happen when passing 0 to either io_limit or page_size. Give
> an error in case of this misconfiguration.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---

Applied for -next, thanks.

g.

>  drivers/misc/eeprom/at24.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 3a53efc..ab1ad41 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -517,6 +517,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (!is_power_of_2(chip.byte_len))
>  		dev_warn(&client->dev,
>  			"byte_len looks suspicious (no power of 2)!\n");
> +	if (!chip.page_size) {
> +		dev_err(&client->dev, "page_size must not be 0!\n");
> +		err = -EINVAL;
> +		goto err_out;
> +	}
>  	if (!is_power_of_2(chip.page_size))
>  		dev_warn(&client->dev,
>  			"page_size looks suspicious (no power of 2)!\n");
> @@ -681,6 +686,11 @@ static struct i2c_driver at24_driver = {
>  
>  static int __init at24_init(void)
>  {
> +	if (!io_limit) {
> +		pr_err("at24: io_limit must not be 0!\n");
> +		return -EINVAL;
> +	}
> +
>  	io_limit = rounddown_pow_of_two(io_limit);
>  	return i2c_add_driver(&at24_driver);
>  }
> -- 
> 1.7.2.3
> 

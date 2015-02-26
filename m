Return-Path: <rjui@broadcom.com>
Received: from mail-gw3-out.broadcom.com (mail-gw3-out.broadcom.com
 [216.31.210.64])
 by lists.ozlabs.org (Postfix) with ESMTP id 6FCF81A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 10:43:39 +1100 (AEDT)
Message-ID: <54EFAD2A.9060501@broadcom.com>
Date: Thu, 26 Feb 2015 15:32:58 -0800
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>
Subject: Re: [RFC V2 12/12] i2c: bcm-iproc: make use of the new infrastructure
 for quirks
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="windows-1252"
Cc: linux-mips@linux-mips.org, Scott Branden <sbranden@broadcom.com>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2/25/2015 8:02 AM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index d3c89157b33774..f9f2c2082151e2 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -160,14 +160,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	u32 val;
>  	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
>  
> -	/* need to reserve one byte in the FIFO for the slave address */
> -	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
> -		dev_err(iproc_i2c->device,
> -			"only support data length up to %u bytes\n",
> -			M_TX_RX_FIFO_SIZE - 1);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	/* check if bus is busy */
>  	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
>  	       BIT(M_CMD_START_BUSY_SHIFT))) {
> @@ -287,6 +279,12 @@ static const struct i2c_algorithm bcm_iproc_algo = {
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>  
> +static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	/* need to reserve one byte in the FIFO for the slave address */
> +	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> +	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
> +};
> +
>  static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
>  {
>  	unsigned int bus_speed;
> @@ -413,6 +411,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(adap, iproc_i2c);
>  	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
>  	adap->algo = &bcm_iproc_algo;
> +	adap->quirks = &bcm_iproc_i2c_quirks;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  
> 

Change on the iproc i2c driver looks good to me. Sanity tested the
change from Wolfram's i2c/quirks branch on Cygnus 958300K combo board.
Sanity tested with an attempt to transfer large amount of I2C data to
ensure the transfer is denied by the i2c-core:

/ # cat /dev/i2c-0
[  657.310261] i2c i2c-0: quirk: msg too long (addr 0x0000, size 4096, read)

Reviewed-by: Ray Jui <rjui@broadcom.com>
Tested-by: Ray Jui <rjui@broadcom.com>

Thanks,

Ray

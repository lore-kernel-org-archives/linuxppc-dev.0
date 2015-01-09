Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B0881A0EDE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 06:35:35 +1100 (AEDT)
Received: by mail-lb0-f181.google.com with SMTP id l4so9772374lbv.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jan 2015 11:35:31 -0800 (PST)
Message-ID: <54B02D7F.7040501@cogentembedded.com>
Date: Fri, 09 Jan 2015 22:35:27 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 01/09/2015 08:21 PM, Wolfram Sang wrote:

> Let the core do the checks if HW quirks prevent a transfer. Saves code
> from drivers and adds consistency.

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8cb1ad..7b10a19abf5b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
>    * ----------------------------------------------------
>    */
>
> +/* Check if val is exceeding the quirk IFF quirk is non 0 */
> +#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
> +
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +	return -EOPNOTSUPP;
> +}

    Always returning the same value doesn't make much sense. Are you trying to 
save space on the call sites?

[...]
> @@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>   	unsigned long orig_jiffies;
>   	int ret, try;
>
> +	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))

    So, you only check for non-zero result of this function? Perhaps it makes 
sense to return true/false instead?

> +		return -EOPNOTSUPP;
> +

WBR, Sergei

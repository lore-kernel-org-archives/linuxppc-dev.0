Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sjBH0bPmzF1g5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:27:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: opal: don't check number of messages in the
 driver
In-Reply-To: <20180520065035.7920-3-wsa@the-dreams.de>
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-3-wsa@the-dreams.de>
Date: Fri, 25 May 2018 20:27:47 +1000
Message-ID: <87muwoqbbw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang <wsa@the-dreams.de> writes:

> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
> I2C core does this check now. We can remove it here.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> Only build tested.

It will get boot tested by me once it's in linux-next, which hopefully
is sufficient for a patch like this.

cheers

> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
> index 0aabb7eca0c5..dc2a23f4fb52 100644
> --- a/drivers/i2c/busses/i2c-opal.c
> +++ b/drivers/i2c/busses/i2c-opal.c
> @@ -94,8 +94,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	memset(&req, 0, sizeof(req));
>  	switch(num) {
> -	case 0:
> -		return 0;
>  	case 1:
>  		req.type = (msgs[0].flags & I2C_M_RD) ?
>  			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> @@ -114,8 +112,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  		req.size = cpu_to_be32(msgs[1].len);
>  		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
>  		break;
> -	default:
> -		return -EOPNOTSUPP;
>  	}
>  
>  	rc = i2c_opal_send_request(opal_id, &req);
> -- 
> 2.11.0

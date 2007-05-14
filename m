Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id CD279DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 03:44:09 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1010604ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:44:07 -0700 (PDT)
Message-ID: <528646bc0705141044s244ce3ecyad5096c441134203@mail.gmail.com>
Date: Mon, 14 May 2007 11:44:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
In-Reply-To: <200705140946.41993.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200705140946.41993.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/14/07, David Brownell <david-b@pacbell.net> wrote:
> Update powerpc platforms to support new-style rtc-ds1307 driver:
>
>  - Make i2c-mpc driver use numbered adapter;
>  - Update boards identified by defconfig to list a ds1339 device:
>     * mpc834x_itx
>     * mpc8313_rdb
>
> Didn't update the pasemi reference board; public info doesn't say
> which chip it uses.
>
> UNTESTED
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> NOTE:  cc'd the relevant powerpc maintainers lists; patches 1-3
> will be archived in the rtc and i2c lists.  I'd like to see these
> get tested/fixed so that the rtc-ds1307 driver can swich completely
> to use the new-style I2c driver model.
>
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c |   11 +++++++++++
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |   12 ++++++++++++
>  drivers/i2c/busses/i2c-mpc.c              |    3 ++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> --- at91.orig/drivers/i2c/busses/i2c-mpc.c      2007-05-10 00:48:22.000000000 -0700
> +++ at91/drivers/i2c/busses/i2c-mpc.c   2007-05-13 10:56:52.000000000 -0700
> @@ -280,6 +280,7 @@ static struct i2c_adapter mpc_ops = {
>         .owner = THIS_MODULE,
>         .name = "MPC adapter",
>         .id = I2C_HW_MPC107,
> +       /* .nr = 0, */
>         .algo = &mpc_algo,
>         .class = I2C_CLASS_HWMON,
>         .timeout = 1,
> @@ -329,7 +330,7 @@ static int fsl_i2c_probe(struct platform
>         i2c->adap = mpc_ops;
>         i2c_set_adapdata(&i2c->adap, i2c);
>         i2c->adap.dev.parent = &pdev->dev;
> -       if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> +       if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
>                 printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
>                 goto fail_add;
>         }

I think this will break many boards as more than one i2c adapter is
common on these chips.  If I read the code correctly, the first
adapter will be registered with adap->nr == 0.  The second adapter
will also be registered with adap->nr == 0; but
i2c_add_numbered_adapter will return -EBUSY because the id is already
used.

I think you need to add this line before the call to i2c_add_numbered_adapter:

i2c->adap.nr = pdev->id;

Cheers,
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

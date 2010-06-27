Return-Path: <dbaryshkov@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 0D1C6B6EF3
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jun 2010 16:38:43 +1000 (EST)
Received: by gwj17 with SMTP id 17so4769091gwj.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jun 2010 23:38:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <352874.17151.qm@web180303.mail.gq1.yahoo.com>
References: <1276778870-1065-1-git-send-email-dbaryshkov@gmail.com>
	<352874.17151.qm@web180303.mail.gq1.yahoo.com>
Date: Sun, 27 Jun 2010 10:38:41 +0400
Message-ID: <AANLkTilGXSg4b2a_-4eSOFwzGrZxU4oAdXS8Wc2CdTZO@mail.gmail.com>
Subject: Re: [PATCH] pcf857x: support working w/o platform data
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: David Brownell <david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 6/25/10, David Brownell <david-b@pacbell.net> wrote:
>
> --- On Thu, 6/17/10, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>
>> Provide sane defaults for pcf857x, so
>> the driver can be used w/o
>> providing platform data (and thus can be simply bound via OF tree).
>
>
> Maybe we can get an ack from some OF folk
> who are using it in that way?

Please see arch/powerpc/boot//dts/mpc8349emitx.dts (the platform I'm using it).

>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  drivers/gpio/pcf857x.c |    9 ++++-----
>>  1 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpio/pcf857x.c
>> b/drivers/gpio/pcf857x.c
>> index 29f19ce..879b473 100644
>> --- a/drivers/gpio/pcf857x.c
>> +++ b/drivers/gpio/pcf857x.c
>> @@ -190,7 +190,6 @@ static int pcf857x_probe(struct
>> i2c_client *client,
>>      pdata = client->dev.platform_data;
>>      if (!pdata) {
>>
>> dev_dbg(&client->dev, "no platform data\n");
>> -        return -EINVAL;
>>      }
>>
>>      /* Allocate, initialize, and register
>> this gpio_chip. */
>> @@ -200,7 +199,7 @@ static int pcf857x_probe(struct
>> i2c_client *client,
>>
>>      mutex_init(&gpio->lock);
>>
>> -    gpio->chip.base =
>> pdata->gpio_base;
>> +    gpio->chip.base = pdata ?
>> pdata->gpio_base : -1;
>>      gpio->chip.can_sleep = 1;
>>      gpio->chip.dev =
>> &client->dev;
>>      gpio->chip.owner = THIS_MODULE;
>> @@ -278,7 +277,7 @@ static int pcf857x_probe(struct
>> i2c_client *client,
>>       * to zero, our software copy
>> of the "latch" then matches the chip's
>>       * all-ones reset
>> state.  Otherwise it flags pins to be driven low.
>>       */
>> -    gpio->out = ~pdata->n_latch;
>> +    gpio->out = pdata ?
>> ~pdata->n_latch : ~0;
>>
>>      status =
>> gpiochip_add(&gpio->chip);
>>      if (status < 0)
>> @@ -299,7 +298,7 @@ static int pcf857x_probe(struct
>> i2c_client *client,
>>      /* Let platform code set up the GPIOs
>> and their users.
>>       * Now is the first time
>> anyone could use them.
>>       */
>> -    if (pdata->setup) {
>> +    if (pdata && pdata->setup)
>> {
>>          status =
>> pdata->setup(client,
>>
>>     gpio->chip.base, gpio->chip.ngpio,
>>
>>     pdata->context);
>> @@ -322,7 +321,7 @@ static int pcf857x_remove(struct
>> i2c_client *client)
>>      struct pcf857x
>>         *gpio =
>> i2c_get_clientdata(client);
>>      int
>>
>> status = 0;
>>
>> -    if (pdata->teardown) {
>> +    if (pdata &&
>> pdata->teardown) {
>>          status =
>> pdata->teardown(client,
>>
>>     gpio->chip.base, gpio->chip.ngpio,
>>
>>     pdata->context);
>> --
>> 1.7.1
>>
>>
>
>


-- 
With best wishes
Dmitry

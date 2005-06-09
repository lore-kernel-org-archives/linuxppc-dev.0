Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-104-thursday.nerim.net [62.4.16.104])
	by ozlabs.org (Postfix) with ESMTP id 034D067B44
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 04:21:10 +1000 (EST)
Date: Thu, 9 Jun 2005 20:21:07 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Randy Vinson <rvinson@mvista.com>
Message-Id: <20050609202107.15ac600e.khali@linux-fr.org>
In-Reply-To: <42A0CD46.60300@mvista.com>
References: <42A0CD46.60300@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH 1/2] Add support for Maxim/Dallas DS1374
 Real-Time Clock Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Randy,

Here are a few random comments on your code, sorry for the delay.

> +static struct i2c_client_address_data addr_data = {
> +	.normal_i2c = normal_addr,
> +	.normal_i2c_range = ignore,
> +	.probe = ignore,
> +	.probe_range = ignore,
> +	.ignore = ignore,
> +	.ignore_range = ignore,
> +	.force = ignore,
> +};

Ranges are gone in -mm, please drop them. You should always base your
patches on -mm BTW, as this is what we will attempt to apply it against.

> +static ulong ds1374_read_rtc(void)
> +{
> +	ulong time = 0;
> +	int reg = DS1374_REG_WDALM0;
> +
> +	while (reg--) {
> +		s32 tmp;
> +		if ((tmp = i2c_smbus_read_byte_data(save_client, reg)) < 0) {
> +			dev_warn(&save_client->dev,
> +				 "can't read from rtc chip\n");
> +			return 0;
> +		}
> +		time = (time << 8) | (tmp & 0xff);

& 0xff isn't needed.

> +ulong ds1374_get_rtc_time(void)
> +{
> +	ulong t1, t2;
> +	int limit = 10;		/* arbitrary retry limit */
> +
> +	down(&ds1374_mutex);
> +
> +	/*
> +	 * Since the reads are being performed one byte at a time using
> +	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
> +	 * carry will occur during the read. To detect this, 2 reads are
> +	 * performed and compared.
> +	 */
> +	do {
> +		t1 = ds1374_read_rtc();
> +		t2 = ds1374_read_rtc();
> +	} while (t1 != t2 && limit--);
> +
> +	up(&ds1374_mutex);
> +
> +	if (t1 != t2) {
> +		dev_warn(&save_client->dev,
> +			 "can't get consistent time from rtc chip\n");
> +		t1 = 0;
> +	}
> +
> +	return t1;
> +}
> +
> +static void ds1374_set_tlet(ulong arg)
> +{
> +	ulong t1, t2;
> +	int limit = 10;		/* arbitrary retry limit */
> +
> +	t1 = *(ulong *) arg;
> +
> +	down(&ds1374_mutex);
> +
> +	/*
> +	 * Since the writes are being performed one byte at a time using
> +	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
> +	 * carry will occur during the write. To detect this, the write
> +	 * value is read back and compared.
> +	 */
> +	do {
> +		ds1374_write_rtc(t1);
> +		t2 = ds1374_read_rtc();
> +	} while (t1 != t2 && limit--);
> +
> +	up(&ds1374_mutex);
> +
> +	if (t1 != t2)
> +		dev_warn(&save_client->dev,
> +			 "can't confirm time set from rtc chip\n");
> +}

The above two functions suggest that a continuous read from the chip
would be very welcome (see my previous message). I even doubt anyone
would connect this kind of RTC to a bus NOT supporting I2C block reads,
because then other models would make more sense. So I'd suggest you use
I2C block reads (and SMBus block writes) here. If anyone really needs a
different access method, they can add it afterwards. Doing so will make
your driver much faster, smaller and more simple.

Which bus are you using this chip BTW, some bit-banging I2C?

Oh, and the ulong* vs. ulong cast is really ugly. Can't it be done
differently?

> +ulong new_time;

Shouldn't it be static?

> +static int ds1374_probe(struct i2c_adapter *adap, int addr, int kind)
> +{
> +	struct i2c_client *client;
> +	int rc;

Here you should check whether the adapter supports the I2C/SMBus
commands you are about to throw upon it. See how the other i2c chip
drivers do.

> +
> +	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	memset(client, 0, sizeof(struct i2c_client));
> +	strncpy(client->name, DS1374_DRV_NAME, I2C_NAME_SIZE);
> +	client->flags = I2C_DF_NOTIFY;

This is a *driver* flag, not meaningful nor suitable for a client
structure. Where did you copy that from?

> +	client->addr = addr;
> +	client->adapter = adap;
> +	client->driver = &ds1374_driver;

You should have some kind of chip detection at this point. Failing to do
so, you may catch any chip at this address and misdrive it. Detection of
these chips is always a bit tricky, but you could do the following:

* Check the 6 zero bits of status register.

* If there are other register-based assertions, use them (I have no time
to read the full datasheet).

* See what happens when you try to read past the register count (0x0A
and above) in either individual byte or block mode. Sometimes it wraps,
sometimes it returns an error, sometimes in repeats the last register,
depends on the chip. This is a trick, but very useful in this situation.

> +static int ds1374_detach(struct i2c_client *client)
> +{
> +	int rc;
> +
> +	if ((rc = i2c_detach_client(client)) == 0) {
> +		kfree(i2c_get_clientdata(client));
> +		tasklet_kill(&ds1374_tasklet);
> +	}

You should kill the tasklet first, else it might try to use the client
after you freed it, right?

> +static struct i2c_driver ds1374_driver = {
> +	.owner = THIS_MODULE,
> +	.name = DS1374_DRV_NAME,
> +	.id = I2C_DRIVERID_DS1374,

You don't need this ID, so you should just omit it. Also, it is
recommended to align structure declarations on the equal sign (using
tabs, not spaces), for a better readability.

Other comments:

1* Your driver construction makes it impossible to support more than one
device.

2* You seem to have two public functions in this driver, yet there is no
symbol export of these?

-- 
Jean Delvare

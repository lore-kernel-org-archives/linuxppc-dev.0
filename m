Return-Path: <andre.prendel@gmx.de>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 1E452B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 05:53:35 +1000 (EST)
Date: Wed, 21 Jul 2010 21:46:50 +0200
From: Andre Prendel <andre.prendel@gmx.de>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Add nfactor support (2nd
	attempt)
Message-ID: <20100721194650.GA2271@andre-laptop>
References: <4BF1A760.2010707@theptrgroup.com>
	<20100518113838.GA2052@andre-laptop>
	<4BF2A5A9.6010907@theptrgroup.com>
	<20100519072659.GA2069@andre-laptop>
	<4BF41C20.60502@theptrgroup.com>
	<20100520185035.GA2153@andre-laptop>
	<4BF58859.3090702@theptrgroup.com>
	<20100520193556.GB2153@andre-laptop>
	<20100720150953.GA9810@andre-laptop>
	<20100720155952.GA27093@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100720155952.GA27093@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 08:59:52AM -0700, Guenter Roeck wrote:
> On Tue, Jul 20, 2010 at 11:09:53AM -0400, Andre Prendel wrote:
> > On Thu, May 20, 2010 at 09:35:56PM +0200, Andre Prendel wrote:
> > > On Thu, May 20, 2010 at 03:07:05PM -0400, Jeff Angielski wrote:
> > > > In any event, here it is again:
> > > 
> > > Acked-by: Andre Prendel <andre.prendel@gmx.de>
> > 
> > Hi Jeff,
> > 
> > I'de suggest to resend the patch with my acked-by to the lm-sensors list and
> > Andrew Morton. It looks like Jean is too busy at the moment.
> > 
> > Regards,
> > Andre
> >  
> > > > >From 9acd29ff48c64e58a7f5cdb888c86e737c56281c Mon Sep 17 00:00:00 2001
> > > > From: Jeff Angielski <jeff@theptrgroup.com>
> > > > Date: Mon, 10 May 2010 10:26:34 -0400
> > > > Subject: [PATCH] hwmon: (tmp421) Add nfactor support
> > > > 
> > > > Add support for reading and writing the n-factor correction
> > > > registers.  This is needed to compensate for the characteristics
> > > > of a particular sensor hanging off of the remote channels.
> > > > 
> 
> My concerns with this approach are 
> 
> 1) It changes the sysfs abi. libsensors won't support it. It opens up
>    a can of worms with everyone starting to put chip-specific extensions
>    into the ABI. If such an extension has to be made, it should be a) really necessary
>    and b) a generic extension which applies to all chips.

A chip-specific extension can't be also generic. So we have to decide whether weaccept chip-specific extensions or not.

> 2) My understanding is that value adjustments are supposed to be made via sensors.conf,
>    and that values reported by the chip should always be 'raw', ie unadjusted
>    values.
> 
> Instead of exporting n_adjust to the user via sysfs, it might make more sense 
> to reset the correction factor to its default (if it was changed), and handle
> required adjustments in sensors.conf.

Jeff, what do you think?
 
> Even if Jean doesn't have time to handle the patch, you should at least get his Ack
> for the ABI changes.

That was the intention of resending the patch to the lm-sensors list. It would
be a pity to lose Jeff's effort.
 
> Guenter

Regards,
Andre
 
> > > > 
> > > > Signed-off-by: Jeff Angielski <jeff@theptrgroup.com>
> > > > ---
> > > >  Documentation/hwmon/tmp421 |   19 +++++++++++++++++++
> > > >  drivers/hwmon/tmp421.c     |   41 +++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 60 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421
> > > > index 0cf07f8..668228a 100644
> > > > --- a/Documentation/hwmon/tmp421
> > > > +++ b/Documentation/hwmon/tmp421
> > > > @@ -17,6 +17,7 @@ Supported chips:
> > > >  
> > > >  Authors:
> > > >  	Andre Prendel <andre.prendel@gmx.de>
> > > > +	Jeff Angielski <jeff@theptrgroup.com>
> > > >  
> > > >  Description
> > > >  -----------
> > > > @@ -34,3 +35,21 @@ the temperature values via the following sysfs files:
> > > >  
> > > >  temp[1-4]_input
> > > >  temp[2-4]_fault
> > > > +
> > > > +The chips allow the user to adjust the n-factor value that is used
> > > > +when converting the remote channel measurements to temperature. The
> > > > +adjustment has a range of -128 to +127 that yields an effective
> > > > +n-factor range of 0.706542 to 1.747977.  The power on reset value
> > > > +for the adjustment is 0 which results in an n-factor of 1.008.
> > > > +
> > > > +The effective n-factor is calculated according to the following
> > > > +equation:
> > > > +
> > > > +n_factor = (1.008 * 300) / (300 - nfactor_adjust)
> > > > +
> > > > +The driver exports the n-factor adjustment value via the following 
> > > > +sysfs files:
> > > > +
> > > > +temp[2-4]_n_adjust
> > > > +
> > > > +
> > > > diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> > > > index 738c472..dfd62be 100644
> > > > --- a/drivers/hwmon/tmp421.c
> > > > +++ b/drivers/hwmon/tmp421.c
> > > > @@ -49,6 +49,7 @@ enum chips { tmp421, tmp422, tmp423 };
> > > >  
> > > >  static const u8 TMP421_TEMP_MSB[4]		= { 0x00, 0x01, 0x02, 0x03 };
> > > >  static const u8 TMP421_TEMP_LSB[4]		= { 0x10, 0x11, 0x12, 0x13 };
> > > > +static const u8 TMP421_N_CORRECT[3]		= { 0x21, 0x22, 0x23 };
> > > >  
> > > >  /* Flags */
> > > >  #define TMP421_CONFIG_SHUTDOWN			0x40
> > > > @@ -76,6 +77,7 @@ struct tmp421_data {
> > > >  	int channels;
> > > >  	u8 config;
> > > >  	s16 temp[4];
> > > > +	s8 n_adjust[3];
> > > >  };
> > > >  
> > > >  static int temp_from_s16(s16 reg)
> > > > @@ -115,6 +117,10 @@ static struct tmp421_data *tmp421_update_device(struct device *dev)
> > > >  			data->temp[i] |= i2c_smbus_read_byte_data(client,
> > > >  				TMP421_TEMP_LSB[i]);
> > > >  		}
> > > > +		for (i = 1; i < data->channels; i++) {
> > > > +			data->n_adjust[i - 1] = i2c_smbus_read_byte_data(client,
> > > > +				TMP421_N_CORRECT[i - 1]);
> > > > +		}
> > > >  		data->last_updated = jiffies;
> > > >  		data->valid = 1;
> > > >  	}
> > > > @@ -157,6 +163,32 @@ static ssize_t show_fault(struct device *dev,
> > > >  		return sprintf(buf, "0\n");
> > > >  }
> > > >  
> > > > +static ssize_t show_n_adjust(struct device *dev,
> > > > +			     struct device_attribute *devattr, char *buf)
> > > > +{
> > > > +	int index = to_sensor_dev_attr(devattr)->index;
> > > > +	struct tmp421_data *data = tmp421_update_device(dev);
> > > > +
> > > > +	return sprintf(buf, "%d\n", data->n_adjust[index - 1]);
> > > > +}
> > > > +
> > > > +static ssize_t set_n_adjust(struct device *dev,
> > > > +			    struct device_attribute *devattr,
> > > > +			    const char *buf, size_t count)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct tmp421_data *data = i2c_get_clientdata(client);
> > > > +	int index = to_sensor_dev_attr(devattr)->index;
> > > > +	int n_adjust = simple_strtol(buf, NULL, 10);
> > > > +
> > > > +	mutex_lock(&data->update_lock);
> > > > +	i2c_smbus_write_byte_data(client, TMP421_N_CORRECT[index - 1],
> > > > +				  SENSORS_LIMIT(n_adjust, -128, 127));
> > > > +	mutex_unlock(&data->update_lock);
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > >  static mode_t tmp421_is_visible(struct kobject *kobj, struct attribute *a,
> > > >  				int n)
> > > >  {
> > > > @@ -177,19 +209,28 @@ static mode_t tmp421_is_visible(struct kobject *kobj, struct attribute *a,
> > > >  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0);
> > > >  static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1);
> > > >  static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_fault, NULL, 1);
> > > > +static SENSOR_DEVICE_ATTR(temp2_n_adjust, S_IRUSR | S_IWUSR | S_IRGRP,
> > > > +			  show_n_adjust, set_n_adjust, 1);
> > > >  static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_value, NULL, 2);
> > > >  static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_fault, NULL, 2);
> > > > +static SENSOR_DEVICE_ATTR(temp3_n_adjust, S_IRUSR | S_IWUSR | S_IRGRP,
> > > > +			  show_n_adjust, set_n_adjust, 2);
> > > >  static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_value, NULL, 3);
> > > >  static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_fault, NULL, 3);
> > > > +static SENSOR_DEVICE_ATTR(temp4_n_adjust, S_IRUSR | S_IWUSR | S_IRGRP,
> > > > +			  show_n_adjust, set_n_adjust, 3);
> > > >  
> > > >  static struct attribute *tmp421_attr[] = {
> > > >  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> > > > +	&sensor_dev_attr_temp2_n_adjust.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp3_input.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> > > > +	&sensor_dev_attr_temp3_n_adjust.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp4_input.dev_attr.attr,
> > > >  	&sensor_dev_attr_temp4_fault.dev_attr.attr,
> > > > +	&sensor_dev_attr_temp4_n_adjust.dev_attr.attr,
> > > >  	NULL
> > > >  };
> > > >  
> > > > -- 
> > > > 1.7.0.4
> > > > 
> > > > 
> > > > -- 
> > > > Jeff Angielski
> > > > The PTR Group
> > > > www.theptrgroup.com
> > > > 
> > > > _______________________________________________
> > > > lm-sensors mailing list
> > > > lm-sensors@lm-sensors.org
> > > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > > 
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > 
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

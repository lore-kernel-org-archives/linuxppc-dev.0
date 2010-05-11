Return-Path: <jeff@theptrgroup.com>
Message-ID: <4BE9B145.7000702@theptrgroup.com>
Date: Tue, 11 May 2010 15:34:29 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
MIME-Version: 1.0
To: Andre Prendel <andre.prendel@gmx.de>
Subject: Re: [PATCH] hwmon: (tmp421) Add nfactor support.
References: <4BE81B7B.7010804@theptrgroup.com>
	<20100511190327.GA2031@andre-laptop>
In-Reply-To: <20100511190327.GA2031@andre-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@lists.ozlabs.org,
	lm-sensors <lm-sensors@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2010 03:03 PM, Andre Prendel wrote:
> On Mon, May 10, 2010 at 10:43:07AM -0400, Jeff Angielski wrote:
>
> Hi Jeff,
>
> A few comments below.
>
>> Add support for reading and writing the n-factor correction
>> registers.  This is needed to compensate for the characteristics
>> of a particular sensor hanging off of the remote channels.
>>
>> Signed-off-by: Jeff Angielski<jeff@theptrgroup.com>
>> ---
>>   drivers/hwmon/tmp421.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
>> index 738c472..c9e9855 100644
>> --- a/drivers/hwmon/tmp421.c
>> +++ b/drivers/hwmon/tmp421.c
>> @@ -49,6 +49,7 @@ enum chips { tmp421, tmp422, tmp423 };
>>
>>   static const u8 TMP421_TEMP_MSB[4]		= { 0x00, 0x01, 0x02, 0x03 };
>>   static const u8 TMP421_TEMP_LSB[4]		= { 0x10, 0x11, 0x12, 0x13 };
>> +static const u8 TMP421_NFACTOR[3]		= { 0x21, 0x22, 0x23 };
>>
>>   /* Flags */
>>   #define TMP421_CONFIG_SHUTDOWN			0x40
>> @@ -157,6 +158,38 @@ static ssize_t show_fault(struct device *dev,
>>   		return sprintf(buf, "0\n");
>>   }
>>
>> +static ssize_t show_nfactor(struct device *dev,
>> +			  struct device_attribute *devattr, char *buf)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct tmp421_data *data = i2c_get_clientdata(client);
>> +	int index = to_sensor_dev_attr(devattr)->index;
>> +	s8 nfactor;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	nfactor = i2c_smbus_read_byte_data(client, TMP421_NFACTOR[index-1]);
>
> There should be spaces within the array index, [index - 1].

Ok.

>
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	return sprintf(buf, "%d\n", nfactor);
>> +}
>
> I'de prefer implementing the sysfs access methods in a consistent way (see other functions). That means adding the nfactor register to the tmp421_data structure and using tmp421_update_device() to update the structure.

I did this on purpose since the nfactor typically only changes once at 
runtime when you program it for your sensor.  It seemed like a waste of 
processing power and i2c bandwidth to read a "pseudo static" register 
over and over again.

It can easily be changed if that's what will help the community the best.

>> +static ssize_t set_nfactor(struct device *dev,
>> +		struct device_attribute *devattr,
>> +		const char *buf, size_t count)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct tmp421_data *data = i2c_get_clientdata(client);
>> +	int index = to_sensor_dev_attr(devattr)->index;
>> +	int nfactor = simple_strtol(buf, NULL, 10);
>> +
>> +	mutex_lock(&data->update_lock);
>> +	i2c_smbus_write_byte_data(client, TMP421_NFACTOR[index-1],
>
> Missing spaces in array index again.

Ok.




-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com

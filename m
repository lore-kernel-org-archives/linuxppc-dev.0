Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E581FDDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 20:59:54 +1100 (EST)
Message-ID: <47D5068F.8050709@tiscali.nl>
Date: Mon, 10 Mar 2008 10:59:43 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ADT746X: logical-bitwise & confusion in set_max_duty_at_crit()
References: <47D47B11.1000303@tiscali.nl>	
	<20080310084633.5246ecfe@paperstreet.colino.net>
	<1205136413.8621.3.camel@pasglop> <47D4EFC1.1050403@tiscali.nl>
	<64d5b5e6dfd0d1820d21db323ef88e25@kernel.crashing.org>
In-Reply-To: <64d5b5e6dfd0d1820d21db323ef88e25@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colin Leroy <colin@colino.net>, "Darrick J. Wong" <djwong@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
>> index 9587869..8ea7da2 100644
>> --- a/drivers/hwmon/adt7473.c
>> +++ b/drivers/hwmon/adt7473.c
>> @@ -570,7 +570,7 @@ static ssize_t set_max_duty_at_crit(struct device
>> *dev,
>>      struct i2c_client *client = to_i2c_client(dev);
>>      struct adt7473_data *data = i2c_get_clientdata(client);
>>      int temp = simple_strtol(buf, NULL, 10);
>> -    temp = temp && 0xFF;
>> +    temp &= 0xFF;
>>
>>      mutex_lock(&data->lock);
>>      data->max_duty_at_overheat = temp;
> 
> The & 0xff here is bogus anyway; temp is only ever used as an u8,
> so just declare it as that, or do proper overflow/underflow checking
> on it.  The patch will need testing on hardware too, since it changes
> behaviour (it should be a bugfix, but who knows).

Maybe someone can test this?
---
logical-bitwise & confusion

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 9587869..2a2de73 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -566,11 +566,11 @@ static ssize_t set_max_duty_at_crit(struct device *dev,
 				    const char *buf,
 				    size_t count)
 {
-	u8 reg;
+	u8 reg, temp;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
-	temp = temp && 0xFF;
+
+	temp = simple_strtol(buf, NULL, 10) & 0xFF;
 
 	mutex_lock(&data->lock);
 	data->max_duty_at_overheat = temp;

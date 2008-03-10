Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79A9DDDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 19:22:35 +1100 (EST)
Message-ID: <47D4EFC1.1050403@tiscali.nl>
Date: Mon, 10 Mar 2008 09:22:25 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: ADT746X: logical-bitwise & confusion in set_max_duty_at_crit()
References: <47D47B11.1000303@tiscali.nl>	
	<20080310084633.5246ecfe@paperstreet.colino.net>
	<1205136413.8621.3.camel@pasglop>
In-Reply-To: <1205136413.8621.3.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colin Leroy <colin@colino.net>, linuxppc-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-03-10 at 08:46 +0100, Colin Leroy wrote:
>> On Mon, 10 Mar 2008 01:04:33 +0100, Roel Kluin wrote:
>>
>>> logical-bitwise & confusion
>> Looks good to me, but I'm not really maintaining that anymore :-)
>> I'm not sure who does, Cc:ing Benjamin as he'll probably know.
> 
> Nobody is U suspect...
> 
> Send it to the list linuxppc-dev@ozlabs.org, it should be picked up
> anyway.
(linuxppc-dev CC'd)
---
logical-bitwise & confusion

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 9587869..8ea7da2 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -570,7 +570,7 @@ static ssize_t set_max_duty_at_crit(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	int temp = simple_strtol(buf, NULL, 10);
-	temp = temp && 0xFF;
+	temp &= 0xFF;
 
 	mutex_lock(&data->lock);
 	data->max_duty_at_overheat = temp;

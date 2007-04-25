Return-Path: <vitb@kernel.crashing.org>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2AE44DDE34
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 03:06:14 +1000 (EST)
Message-ID: <462F8A82.40604@kernel.crashing.org>
Date: Wed, 25 Apr 2007 21:06:10 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH][RFC] i2c: adds support for i2c bus on 8xx
References: <20070420082714.4f10f186@localhost.localdomain>	<20070421095707.6b42a312@hyperion.delvare>	<20070422152937.7332fc31@localhost.localdomain>
	<20070423111950.129856eb@hyperion.delvare>
In-Reply-To: <20070423111950.129856eb@hyperion.delvare>
Content-Type: multipart/alternative;
	boundary="------------090801020203040708070803"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090801020203040708070803
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Vitaly,
>
> On Sun, 22 Apr 2007 15:29:37 +0400, Vitaly Bordug wrote:
>   
>> On Sat, 21 Apr 2007 09:57:07 +0200 Jean Delvare wrote:
>>     
>>> I wonder what's the point of having a separate i2c algorithm driver.
>>> We don't expect any other driver than i2c-rpx to ever use it, do we?
>>> In that case, all the code should be added to i2c-rpx directly, this
>>> will makes things more simple and more efficient.
>>>       
>> That is how it was back in 2.4 - if you see combine is a good move,
>> I'm OK with it. But what shouldn't be rpc then - basically rpx(lite) is
>> 8xx-based target, so let's call it all mpc8xx then.
>>     
>
> Sure, I'm fine with a name change. If it makes more sense to name that
> driver i2c-mpc8xx, that's OK with me.
>
>   
>>>> +		tmo = jiffies + 1 * HZ;
>>>> +		while (!(in_8(&i2c->i2c_i2cer) & 0x11 || time_after(jiffies, tmo))) ;/* Busy wait, with a timeout */
>>>>         
>>> This could result in a one-second busy loop, not very friendly for
>>> other drivers. It should sleep while waiting. Line too long, please
>>> fold.
>>>       
>> Can you please elaborate a little here (or just point to the
>> similar code)? I assume we should not block here, handling timeout
>> in a waitqueue...
>>     
>
> Blocking is not a problem. The problem is that you are keeping the CPU
> for yourself while waiting, for up to one full second. That's not
> acceptable. You should at least call schedule() or cond_resced() (I
> don't know the difference, I admit) and/or cpu_relax() as is done in
> i2c-mpc, i2c-ibm_iic and scx200_acb, or even sleep, as is done in
> i2c-omap. Search for "time_after" in these 4 drivers for examples. I
> believe that sleeping is more friendly.
>
>   
OK, very clear, thanks.
>>> You do not appear to handle repeated start. I can tell because the
>>> code handles all messages the exact same way, be they the first,
>>> second or last message of a group. This means that you don't really
>>> implement the I2C protocol, but an approximation of it. It might be
>>> sufficient for some I2C chips, but others will break. Look in the
>>> specifications of your device for how this could be fixed.
>>>       
>> I doubt 8xx has a full-fledged i2c protocol stuff onboard, and basic
>> code that were residing in 2.4 repo suite my needs quite well (afaict
>> many others just don't care :)).
>> I just think it is silly to drop the code already implemented and working
>> even if it requires some efforts to bring it up to shape.
>>     
>
> Well as far as I can see, only the repeated start is missing, so it's
> not that far from a complete implementation. If the hardware can do it,
> you simply have to add it to the driver. If the hardware really doesn't
> do it (which would surprise me, but you never know), of course you
> cannot implement it in the driver and we'll have to live with (well,
> without) it. But that's definitely an issue to keep in mind if I2C chip
> drivers start failing when used together with this bus driver.
>
>   
>>>> +static struct i2c_adapter rpx_ops = {
>>>>         
>>> Could be const?
>>>
>>>       
>> prolly yes.
>>     
>>>> +	.owner		= THIS_MODULE,
>>>> +	.name		= "m8xx",
>>>>         
>>> Find a better name (e.g. "i2c-rpx").
>>>
>>>       
>> What about mpc8xx?
>>     
>
> i2c-mpc8xx then, OK.
>
>   
>>>> +/* Structure for a device driver */
>>>> +static struct device_driver i2c_rpx_driver = {
>>>> +	.name = "fsl-i2c-cpm",
>>>> +	.bus = &platform_bus_type,
>>>> +	.probe = i2c_rpx_probe,
>>>> +	.remove = i2c_rpx_remove,
>>>> +};
>>>>         
>>> Why don't you declare it as a struct platform_driver, register it with
>>> platform_driver_register() and unregister it with
>>> platform_driver_unregister()?
>>>       
>> Well. This stuff belongs to CPM1, of the mpc8xx family, but the
>> target boards are different, and they may/should provide board
>> specific inits and filling of platform data. With
>> platform_driver_register we may end up with ifdef stuff here
>> (which is evil).
>>     
>
> I don't follow you here, sorry. Platform devices are declared by
> board-specific code which can include all the needed initialization.
> And device-specific data can be carried to the platform driver for
> further use. The platform device/driver infrastructure is meant to
> handle that kind of situation, so there really is no excuse that I can
> see not to use it. i2c-omap and i2c-mpc use it. As a matter of fact you
> _are_ declaring a platform driver (.bus = &platform_bus_type), just not
> using the standard way.
>
>   
Standard way here - platform devices got registered from elsewhere - 
from arch/ppc/ppc_sys.c if arch/ppc or from 
arch/powerpc/sysdev/fsl_soc.c if powerpc.
Every way (powerpc is more flexible since is pulling the information 
from the firmware-passed device tree) fills in the resources and 
platform data, and
is capable with device/drive bound you are talking about.

--
Thanks, Vitaly

--------------090801020203040708070803
Content-Type: text/html; charset=US-ASCII
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=US-ASCII" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jean Delvare wrote:
<blockquote cite="mid20070423111950.129856eb@hyperion.delvare"
 type="cite">
  <pre wrap="">Hi Vitaly,

On Sun, 22 Apr 2007 15:29:37 +0400, Vitaly Bordug wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Sat, 21 Apr 2007 09:57:07 +0200 Jean Delvare wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">I wonder what's the point of having a separate i2c algorithm driver.
We don't expect any other driver than i2c-rpx to ever use it, do we?
In that case, all the code should be added to i2c-rpx directly, this
will makes things more simple and more efficient.
      </pre>
    </blockquote>
    <pre wrap="">That is how it was back in 2.4 - if you see combine is a good move,
I'm OK with it. But what shouldn't be rpc then - basically rpx(lite) is
8xx-based target, so let's call it all mpc8xx then.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Sure, I'm fine with a name change. If it makes more sense to name that
driver i2c-mpc8xx, that's OK with me.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+		tmo = jiffies + 1 * HZ;
+		while (!(in_8(&amp;i2c-&gt;i2c_i2cer) &amp; 0x11 || time_after(jiffies, tmo))) ;/* Busy wait, with a timeout */
        </pre>
      </blockquote>
      <pre wrap="">This could result in a one-second busy loop, not very friendly for
other drivers. It should sleep while waiting. Line too long, please
fold.
      </pre>
    </blockquote>
    <pre wrap="">Can you please elaborate a little here (or just point to the
similar code)? I assume we should not block here, handling timeout
in a waitqueue...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Blocking is not a problem. The problem is that you are keeping the CPU
for yourself while waiting, for up to one full second. That's not
acceptable. You should at least call schedule() or cond_resced() (I
don't know the difference, I admit) and/or cpu_relax() as is done in
i2c-mpc, i2c-ibm_iic and scx200_acb, or even sleep, as is done in
i2c-omap. Search for "time_after" in these 4 drivers for examples. I
believe that sleeping is more friendly.

  </pre>
</blockquote>
OK, very clear, thanks.<br>
<blockquote cite="mid20070423111950.129856eb@hyperion.delvare"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">You do not appear to handle repeated start. I can tell because the
code handles all messages the exact same way, be they the first,
second or last message of a group. This means that you don't really
implement the I2C protocol, but an approximation of it. It might be
sufficient for some I2C chips, but others will break. Look in the
specifications of your device for how this could be fixed.
      </pre>
    </blockquote>
    <pre wrap="">I doubt 8xx has a full-fledged i2c protocol stuff onboard, and basic
code that were residing in 2.4 repo suite my needs quite well (afaict
many others just don't care :)).
I just think it is silly to drop the code already implemented and working
even if it requires some efforts to bring it up to shape.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well as far as I can see, only the repeated start is missing, so it's
not that far from a complete implementation. If the hardware can do it,
you simply have to add it to the driver. If the hardware really doesn't
do it (which would surprise me, but you never know), of course you
cannot implement it in the driver and we'll have to live with (well,
without) it. But that's definitely an issue to keep in mind if I2C chip
drivers start failing when used together with this bus driver.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+static struct i2c_adapter rpx_ops = {
        </pre>
      </blockquote>
      <pre wrap="">Could be const?

      </pre>
    </blockquote>
    <pre wrap="">prolly yes.
    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+	.owner		= THIS_MODULE,
+	.name		= "m8xx",
        </pre>
      </blockquote>
      <pre wrap="">Find a better name (e.g. "i2c-rpx").

      </pre>
    </blockquote>
    <pre wrap="">What about mpc8xx?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
i2c-mpc8xx then, OK.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">+/* Structure for a device driver */
+static struct device_driver i2c_rpx_driver = {
+	.name = "fsl-i2c-cpm",
+	.bus = &amp;platform_bus_type,
+	.probe = i2c_rpx_probe,
+	.remove = i2c_rpx_remove,
+};
        </pre>
      </blockquote>
      <pre wrap="">Why don't you declare it as a struct platform_driver, register it with
platform_driver_register() and unregister it with
platform_driver_unregister()?
      </pre>
    </blockquote>
    <pre wrap="">Well. This stuff belongs to CPM1, of the mpc8xx family, but the
target boards are different, and they may/should provide board
specific inits and filling of platform data. With
platform_driver_register we may end up with ifdef stuff here
(which is evil).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't follow you here, sorry. Platform devices are declared by
board-specific code which can include all the needed initialization.
And device-specific data can be carried to the platform driver for
further use. The platform device/driver infrastructure is meant to
handle that kind of situation, so there really is no excuse that I can
see not to use it. i2c-omap and i2c-mpc use it. As a matter of fact you
_are_ declaring a platform driver (.bus = &amp;platform_bus_type), just not
using the standard way.

  </pre>
</blockquote>
Standard way here&nbsp; - platform devices got registered from elsewhere -
from arch/ppc/ppc_sys.c if arch/ppc or from
arch/powerpc/sysdev/fsl_soc.c if powerpc.<br>
Every way (powerpc is more flexible since is pulling the information
from the firmware-passed device tree)&nbsp; fills in the resources and
platform data, and<br>
is capable with device/drive bound you are talking about.<br>
<br>
--<br>
Thanks, Vitaly<br>
</body>
</html>

--------------090801020203040708070803--

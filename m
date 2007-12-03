Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 16CA0DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 03:09:53 +1100 (EST)
Message-ID: <47542A50.1030208@anagramm.de>
Date: Mon, 03 Dec 2007 17:09:52 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de>
In-Reply-To: <47541D70.2040805@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Olof!

Clemens Koller schrieb:
> Hi, Alessandro, Hi, Olof!
> 
> Olof Johansson wrote:
>  > ds1307 requires you to register i2c_board_info for it to probe properly.
>  > Does your platform do so?
> 
> I started to add some pr_debug()s. It seems that rtc-ds1307's ds1307_init()
> is just never called despite the module gets loaded.

Finally, it works! *sigh* - Thank your for your hint to i2c_board_info!

My platform includes i2c_board_info with some i2c-devices but only uses them
if the device-tree includes the devices.

[OT+sarcasm on]

So, the time is over, where you just enable a driver in the kernel config and
the device gets probed and - if it's probed successfully - it usually works.
Now, the way is like this:

- enable the desired driver in the kernel.
- check that the platform driver fsl_soc.c (in my case) defines the
   desired rtc-chip in the i2c_board_info
- check that the rtc is included in the device tree.
- embed the device tree to the kernel (cuImage)
- boot'n'pray.

That looks really groundbreaking!

Now, I cannot use one kernel for two almost identical hardware revisions
anymore because the rtc's on i2c are different? This must be a joke!

It seems like I first need to have full device tree support included in
the boot-loader to be able to duplicate my configuration work to allow
one kernel to boot on both hardware. Hmmm... this just s****!

[OT+sarcasm off]

Thank you,

-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pd0-x241.google.com (mail-pd0-x241.google.com
 [IPv6:2607:f8b0:400e:c02::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACCE31A1BE3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 02:35:25 +1000 (AEST)
Received: by pdav4 with SMTP id v4so2372431pda.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 09:35:23 -0700 (PDT)
Date: Thu, 30 Jul 2015 09:35:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-leds@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, lm-sensors@lm-sensors.org,
 Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean Delvare <jdelvare@suse.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Lee Jones <lee.jones@linaro.org>, Bryan Wu <cooloney@gmail.com>,
 linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
 linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/27] Export I2C and OF module aliases in missing drivers
Message-ID: <20150730163517.GA13165@dtor-ws>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Javier,

On Thu, Jul 30, 2015 at 06:18:25PM +0200, Javier Martinez Canillas wrote:
> Hello,
> 
> Short version:
> 
> This series add the missing MODULE_DEVICE_TABLE() for OF and I2C tables
> to export that information so modules have the correct aliases built-in
> and autoloading works correctly.
> 
> Longer version:
> 
> Currently it's mandatory for I2C drivers to have an I2C device ID table
> regardless if the device was registered using platform data or OF. This
> is because the I2C core needs an I2C device ID table for two reasons:
> 
> 1) Match the I2C client with a I2C device ID so a struct i2c_device_id
>    is passed to the I2C driver probe() function.
> 
> 2) Export the module aliases from the I2C device ID table so userspace
>    can auto-load the correct module. This is because i2c_device_uevent
>    always reports a MODALIAS of the form i2c:<client->name>.

Why are we not fixing this? We emit specially carved uevent for
ACPI-based devices, why not the same for OF? Platform bus does this...

Thanks.

-- 
Dmitry

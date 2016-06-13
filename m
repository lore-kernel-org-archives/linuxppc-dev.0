Return-Path: <>
From: "Andrew F. Davis" <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis
 <miguel.ojeda.sandonis@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio
 <lauro.venancio@openbossa.org>, Aloisio Almeida Jr
 <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo
 Molnar <mingo@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-leds@vger.kernel.org>, <lguest@lists.ozlabs.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-media@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andrew F .
 Davis" <afd@ti.com>
Subject: [PATCH 00/12] Remove unneeded build directory traversals
Date: Mon, 13 Jun 2016 15:01:59 -0500
Message-ID: <20160613200211.14790-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

I was building a kernel for x86 and noticed Make still descended into
directories like drivers/gpu/drm/hisilicon, this seems kind of odd given
nothing will be built here. It looks to be due to some directories being
included in obj-y unconditionally instead of only when the relevant
CONFIG_ is set.

These patches are split by subsystem in-case, for some reason, a file in
a directory does need to be built, I believe I have checked for all
instances of this, but a quick review from some maintainers would be nice.

Thanks,
Andrew

Andrew F. Davis (12):
  gpio: Only descend into gpio directory when CONFIG_GPIOLIB is set
  pwm: Only descend into pwm directory when CONFIG_PWM is set
  amba: Only descend into amba directory when CONFIG_ARM_AMBA is set
  NFC: Only descend into nfc directory when CONFIG_NFC is set
  macintosh: Only descend into directory when CONFIG_MACINTOSH_DRIVERS
    is set
  hsi: Only descend into hsi directory when CONFIG_HSI is set
  auxdisplay: Only descend into directory when CONFIG_AUXDISPLAY is set
  i2c: Only descend into i2c directory when CONFIG_I2C is set
  [media] Only descend into directory when CONFIG_MEDIA_SUPPORT is set
  lguest: Only descend into lguest directory when CONFIG_LGUEST is set
  mmc: Only descend into mmc directory when CONFIG_MMC is set
  leds: Only descend into leds directory when CONFIG_NEW_LEDS is set

 drivers/Makefile | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.8.3

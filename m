Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67705B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 03:03:49 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id F1CCEDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 03:03:48 +1000 (EST)
Date: Wed, 29 Jul 2009 21:03:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/7] Device table matching for SPI subsystem
Message-ID: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>, David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This patch set implements standard device table matching mechanism
for SPI subsystem, the same device id tables as we use in I2C drivers.

I started this work because m25p80 driver misdetects non-JEDEC
chips when it is used on OpenFirmware platforms (cause we don't pass
platform_data). platform_data is overkill for m25p80 chips, the
driver only needs to know exact chip model, and that's what device
tables are for.

So the patches:

  [1/7] spi: Add support for device table matching
  [2/7] mtd: m25p80: Convert to device table matching
  [3/7] of: Remove "stm,m25p40" alias

The three patches above do real work. I tried to keep the 1/7 patch as
small as possible, and factor out the subsystem cleanups into other,
"cleanup" patches:

  [PATCH 4/7] spi: Prefix modalias with "spi:"
  [PATCH 5/7] spi: Merge probe and probe_id callbacks

These two patches I consider as cleanups, they should not introduce
any behavioural change, but they touch quite a lot of files.

  [PATCH 6/7] hwmon: adxx: Convert to device table matching
  [PATCH 7/7] hwmon: lm70: Convert to device table matching

These two are here because I couldn't stop. :-) Also cleanups.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

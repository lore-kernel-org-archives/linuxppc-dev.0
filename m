Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id E9DAFB6EEE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:30:17 +1100 (EST)
Received: by iwn11 with SMTP id 11so12662662iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 20:30:16 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org,
	lm-sensors@lm-sensors.org
Subject: [RFC/PATCH 0/2] Updates to improve device tree support
Date: Tue,  5 Jan 2010 22:30:33 -0600
Message-Id: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series updates the pca953x GPIO driver to take advantage
of the new of_i2c_gpiochip_add() function, which registers i2c GPIO
devices with the device tree API.  These changes allow i2c-based GPIO
expanders to be properly referenced from the proper entries in a
device tree.

The of_i2c_gpiochip_add() function has been posted for review on the
linuxppc-dev mailing list.

Bill Gatliff (2):
  Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
  Reorder initialization to better support device tree data

 drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
 1 files changed, 88 insertions(+), 80 deletions(-)

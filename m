Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C92606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfilRlIJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1Cr1n7Cz30VV;
	Thu, 12 Nov 2026 11:16:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794442616;
	cv=none; b=myKeqluJFuLpAK4KV+wm7FyOJ9GT750ctlaazz5PkqqM2mvO8dfmrS8HUuekaSLi05PpWnqj432QJsHcfuPJ7s3ckrq2NCKwEXPCBlMxJdcC9gIzNJ9zkpcZHuhVshe6ndQ9kkJpl5pXnHdJCwGAtwJcd8yOB6xH3HDuAIeC1Sdw7KiH1Nm7lQxx5SMguu3yHRdPC95iDLgHbg/E95chRgg+Q3s2mueIGLts3AaSYFI1wQRl8/GzVvdSUfN3hx6xPRcNE/8GQZXPHUsF9ta6Rx/biK6BIfvPaio5lfbhDarTtW9g9BwdYAWgnEcEr47E4BWJI5RBvJgi4xr+gUzOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794442616; c=relaxed/relaxed;
	bh=lT7QylMbD9F1F6uRIBMcbNPNSWEKBWGTEWa84Sr6aB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRVD6C7aiY1ScxqDqJ79aIKDppU+4kYgsONefPo3dLhDmuyTw4GUI/NOftkoUpo6xZys3srYOidYuZ0Xxj1MTqwalbGklo+MHi9bTfSUAJKrQCO6u6bcWq5Wd2T5r8oYSUcOvxRRi2A+GUWtxOuiwYozEhSGAaMizUeufuKtDCQS8byVILfB27UM41GMGxUmBvhCFN6fA598D2igjBSgAkgsRnHMzl4zIDRe9W4p+tH3jAq7TEEGsWPhFWGxnXfQSwX+i+J0191Od0YJZ9hJFyVaGB2lhBeEUq+x5ilR6PDq8hoazlPAfhjl+pCEEguVBCjFb4WzjI0YT+rmEVxCWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfilRlIJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfilRlIJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1Cn68BNz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:16:53 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-37071c0f42aso6349840eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442612; x=1795047412; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lT7QylMbD9F1F6uRIBMcbNPNSWEKBWGTEWa84Sr6aB0=;
        b=nfilRlIJyW0Ful946oK4iWHUFApi+03+DjzLSN/4drlNHx7BNojxKWBc4pOXoJglBb
         HAs5NippPFQlFIF9UkLu/LMsvoE0g8XamJx0h8DjGcn1l1AuhR9lx9h+tSDauKGE49Cs
         ZoGQ+S50mG0mqoNHr4OAOR23KQZH8mqGYYcaPtUMf+FIdy9pTL1/WqoGp71tO5bOX5ug
         n4eoZsFXGfzp+ogYgedZk3zZNS9qmKHq84ID7TzPcAoBgto4fjVQKCntOLSWU5i8LoCb
         KaYvNmVZ8FIRyERB3y5PZOL5IZdHqxaIzWSrAwQXjjTIwtYygcKQnrZgbyIgTioUWGm7
         dLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442612; x=1795047412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lT7QylMbD9F1F6uRIBMcbNPNSWEKBWGTEWa84Sr6aB0=;
        b=MTeZLSyEbyC/mG9svMz9YwBv8IrtLK5DP8qtTCZPTY171k7qMP0SB91jjLriMYGNpi
         H4O3UsoCVl2QiO5EWr/gy1Siq7cbu4uImvis4+X1ioC5N+T3fM3JQ1+tAiRTK1HUU6sC
         RPbZtcZslx0dvV3ZsQB3nrdENIMLDalJ9XXkA70GQUnYfBDRuWPhF9oMAFnCHzFXsUyS
         9Y0k1VdkA8o5RFPKQrx90Kx1lFrQmXNDIwKwJvMW9RJhvD+OUVdYs27j9h7Q3nDY+7EQ
         mBhsZVv6vZVNFQtDbIOJjqsCZxSYdqTDxkHFj9sQDBsMXZVhoGtz90ia9IiIi07B1t3A
         c3Zw==
X-Forwarded-Encrypted: i=1; AL+hErGnGQuS3pJ8FNXvm8EQ1lT/k/3qehaDSjGAkzozXxV0PPG/MHhG2c3qKa0+oBY/xFjA8aANxFXt+zbrug0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z86vUBLWBs8Gh28ROrAvya/AqVeQBnEx9jG42JZ1/nImRPb3tT6
	ks49oLCPuYhKvT2m5h+RE3cLdHLZs3UE09anNmUX9VYhhlnPwQkAm7Ev
X-Gm-Gg: AYBFou1JDnHj0XM8a1A41M6l/jvZNTs4tEYtKZWCgukJYmfF0ml0TOwaEYa5joJzCg/
	NrFMrV3TCwF1vvbLdFNBf9Jhk2bBnAnweCvHWgWi59ZsJUasNrhX61l9AmoP6ytErQJGMJ/eUUd
	/rVt3SQPsOxZVOPnaSxE6JaBvuV/TxKTHM/pRcHCgKut9AEXcgAeWjGT2r7pl6M5vRQufV4PnBr
	Wd6t6kITY55eNi9garPvbVEbZ9A5SX4KI7Y5KnFjVnOqhPp0vIEdXmGfa+mR5EEZFnoJ8y5MfM8
	QjrVBfAN+tivOk5CT5jNWkqtVZ+F2EvpeHdZzMREclFZmxgNoAEpixZh/UJinte2gMMdBlELwzD
	Q7O+wRtVkpJ9laAP7LBk8wrAomWxwAzeMVdlWdVMjZaUpVpLj+G9yZiAaf2v8OQtRzJNeEMF6yN
	3hliVKci1hL0te98wzqjJliGMO886q5l/C75kuKAf3Hz7pIZwTn9kQfJ0Qdz0AS2zncwhSN1GsQ
	XnFMFzn3zZKZuBjzMnITFxNs+1b5ZA5zYk9ZQly6bIATF5u5cpJavCQV+CgdZCl6LQcPvQbvsaK
	oYBDffcfFa6ITlZ7u9mzCG8MSqfLMG6XzpLCmaAHmXUNo+/I2x9lMakvjUaYDzppsIyu/D9gE+9
	U1oX/FD9yYgRr1J50m1x3rfNzvn7woNbmk5fN4w==
X-Received: by 2002:a05:7301:4902:b0:376:f63a:cb24 with SMTP id 5a478bee46e88-376f63ad124mr3435535eec.3.1794442611578;
        Wed, 11 Nov 2026 16:16:51 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm40492697eec.16.2026.11.11.16.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:16:50 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Shaun Jackman <sjackman@gmail.com>,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
	Florian Euchner <florian.euchner@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xue Lei <Xue.Lei@windriver.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: cm109 - remove driver
Date: Wed, 11 Nov 2026 16:16:42 -0800
Message-ID: <20261112001642.243554-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cm109 driver was written in 2007-2008 (modeled after yealink) for
four mid-2000s USB VoIP/Skype handsets (Komunikate KIP1000, Genius
G-talk, Allied-Telesis Corega USBPH01, and ATCom AU-100) built around
the C-Media CM109 USB audio and HID controller (0x0d8c:0x000e). Audio
was handled by snd-usb-audio, while cm109 polled a 4x4 phone keypad
matrix and drove a buzzer wired to the chip's GPIO pins via vendor HID
reports, relying on a module parameter (phone=...) to select the phone
keymap.

The mid-2000s userspace VoIP/Skype bridge ecosystem for these handsets
is long defunct, the driver has had no new hardware support since 2008
(and has had broken keycodesize = sizeof(unsigned char) for
KEY_NUMERIC_* keycodes > 255), while its custom URB state machine
continues to generate syzbot crashes.

Furthermore, because 0x0d8c:0x000e is the generic C-Media CM109 VID:PID
and was added to hid_ignore_list[] so cm109 could claim the USB
interface, cm109 actively interferes with non-phone CM109 hardware
still in use today. Amateur radio interfaces (Direwolf, AllStarLink,
SVXLink, UniPager, Hamlib) must blacklist cm109 so usbhid can expose
/dev/hidraw* and to prevent cm109 from pulsing the GPIO pins (which
keys the radio transmitter's PTT line) when the input device is
opened. Standard USB headsets with 0x0d8c:0x000e can use usbhid
directly via the chip's standard HID Consumer Page volume and mute
descriptors once the hid_ignore_list[] entry is removed. Remove the
driver, its Kconfig and Makefile entries, and the HID ignore-list
entry.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-ids.h       |   1 -
 drivers/hid/hid-quirks.c    |   1 -
 drivers/input/misc/Kconfig  |  12 -
 drivers/input/misc/Makefile |   1 -
 drivers/input/misc/cm109.c  | 940 ------------------------------------
 5 files changed, 955 deletions(-)
 delete mode 100644 drivers/input/misc/cm109.c

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index acfd6fafed73..4f6fe0986b28 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -355,7 +355,6 @@
 #define USB_DEVICE_ID_NITROKEY_U2F	0x4287
 
 #define USB_VENDOR_ID_CMEDIA		0x0d8c
-#define USB_DEVICE_ID_CM109		0x000e
 #define USB_DEVICE_ID_CMEDIA_HS100B	0x0014
 #define USB_DEVICE_ID_CM6533		0x0022
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index f4735b0f01ec..d550dff92c66 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -846,7 +846,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_ULTRAMOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 955cca77e9fe..b108776ae09e 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -469,18 +469,6 @@ config INPUT_POWERMATE
 	  To compile this driver as a module, choose M here: the
 	  module will be called powermate.
 
-config INPUT_CM109
-	tristate "C-Media CM109 USB I/O Controller"
-	depends on USB_ARCH_HAS_HCD
-	select USB
-	help
-	  Say Y here if you want to enable keyboard and buzzer functions of the
-	  C-Media CM109 usb phones. The audio part is enabled by the generic
-	  usb sound driver, so you might want to enable that as well.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called cm109.
-
 config INPUT_REGULATOR_HAPTIC
 	tristate "Regulator haptics support"
 	depends on REGULATOR
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index d4576869aff9..46aadeaba67b 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
 obj-$(CONFIG_INPUT_AW86927)		+= aw86927.o
 obj-$(CONFIG_INPUT_BBNSM_PWRKEY)	+= nxp-bbnsm-pwrkey.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
-obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
deleted file mode 100644
index 353d3c1d347d..000000000000
--- a/drivers/input/misc/cm109.c
+++ /dev/null
@@ -1,940 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Driver for the VoIP USB phones with CM109 chipsets.
- *
- * Copyright (C) 2007 - 2008 Alfred E. Heggestad <aeh@db.org>
- */
-
-/*
- *   Tested devices:
- *	- Komunikate KIP1000
- *	- Genius G-talk
- *	- Allied-Telesis Corega USBPH01
- *	- ...
- *
- * This driver is based on the yealink.c driver
- *
- * Thanks to:
- *   - Authors of yealink.c
- *   - Thomas Reitmayr
- *   - Oliver Neukum for good review comments and code
- *   - Shaun Jackman <sjackman@gmail.com> for Genius G-talk keymap
- *   - Dmitry Torokhov for valuable input and review
- *
- * Todo:
- *   - Read/write EEPROM
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/rwsem.h>
-#include <linux/usb/input.h>
-
-#define DRIVER_VERSION "20080805"
-#define DRIVER_AUTHOR  "Alfred E. Heggestad"
-#define DRIVER_DESC    "CM109 phone driver"
-
-static char *phone = "kip1000";
-module_param(phone, charp, S_IRUSR);
-MODULE_PARM_DESC(phone, "Phone name {kip1000, gtalk, usbph01, atcom}");
-
-enum {
-	/* HID Registers */
-	HID_IR0 = 0x00, /* Record/Playback-mute button, Volume up/down  */
-	HID_IR1 = 0x01, /* GPI, generic registers or EEPROM_DATA0       */
-	HID_IR2 = 0x02, /* Generic registers or EEPROM_DATA1            */
-	HID_IR3 = 0x03, /* Generic registers or EEPROM_CTRL             */
-	HID_OR0 = 0x00, /* Mapping control, buzzer, SPDIF (offset 0x04) */
-	HID_OR1 = 0x01, /* GPO - General Purpose Output                 */
-	HID_OR2 = 0x02, /* Set GPIO to input/output mode                */
-	HID_OR3 = 0x03, /* SPDIF status channel or EEPROM_CTRL          */
-
-	/* HID_IR0 */
-	RECORD_MUTE   = 1 << 3,
-	PLAYBACK_MUTE = 1 << 2,
-	VOLUME_DOWN   = 1 << 1,
-	VOLUME_UP     = 1 << 0,
-
-	/* HID_OR0 */
-	/* bits 7-6
-	   0: HID_OR1-2 are used for GPO; HID_OR0, 3 are used for buzzer
-	      and SPDIF
-	   1: HID_OR0-3 are used as generic HID registers
-	   2: Values written to HID_OR0-3 are also mapped to MCU_CTRL,
-	      EEPROM_DATA0-1, EEPROM_CTRL (see Note)
-	   3: Reserved
-	 */
-	HID_OR_GPO_BUZ_SPDIF   = 0 << 6,
-	HID_OR_GENERIC_HID_REG = 1 << 6,
-	HID_OR_MAP_MCU_EEPROM  = 2 << 6,
-
-	BUZZER_ON = 1 << 5,
-
-	/* up to 256 normal keys, up to 15 special key combinations */
-	KEYMAP_SIZE = 256 + 15,
-};
-
-/* CM109 protocol packet */
-struct cm109_ctl_packet {
-	u8 byte[4];
-} __attribute__ ((packed));
-
-enum { USB_PKT_LEN = sizeof(struct cm109_ctl_packet) };
-
-/* CM109 device structure */
-struct cm109_dev {
-	struct input_dev *idev;	 /* input device */
-	struct usb_device *udev; /* usb device */
-	struct usb_interface *intf;
-
-	/* irq input channel */
-	struct cm109_ctl_packet *irq_data;
-	dma_addr_t irq_dma;
-	struct urb *urb_irq;
-
-	/* control output channel */
-	struct cm109_ctl_packet *ctl_data;
-	dma_addr_t ctl_dma;
-	struct usb_ctrlrequest *ctl_req;
-	struct urb *urb_ctl;
-	/*
-	 * The 3 bitfields below are protected by ctl_submit_lock.
-	 * They have to be separate since they are accessed from IRQ
-	 * context.
-	 */
-	unsigned irq_urb_pending:1;	/* irq_urb is in flight */
-	unsigned ctl_urb_pending:1;	/* ctl_urb is in flight */
-	unsigned buzzer_pending:1;	/* need to issue buzz command */
-	spinlock_t ctl_submit_lock;
-
-	unsigned char buzzer_state;	/* on/off */
-
-	/* flags */
-	unsigned open:1;
-	unsigned resetting:1;
-	unsigned shutdown:1;
-
-	/* This mutex protects writes to the above flags */
-	struct mutex pm_mutex;
-
-	unsigned short keymap[KEYMAP_SIZE];
-
-	char phys[64];		/* physical device path */
-	int key_code;		/* last reported key */
-	int keybit;		/* 0=new scan  1,2,4,8=scan columns  */
-	u8 gpi;			/* Cached value of GPI (high nibble) */
-};
-
-/******************************************************************************
- * CM109 key interface
- *****************************************************************************/
-
-static unsigned short special_keymap(int code)
-{
-	if (code > 0xff) {
-		switch (code - 0xff) {
-		case RECORD_MUTE:	return KEY_MICMUTE;
-		case PLAYBACK_MUTE:	return KEY_MUTE;
-		case VOLUME_DOWN:	return KEY_VOLUMEDOWN;
-		case VOLUME_UP:		return KEY_VOLUMEUP;
-		}
-	}
-	return KEY_RESERVED;
-}
-
-/* Map device buttons to internal key events.
- *
- * The "up" and "down" keys, are symbolised by arrows on the button.
- * The "pickup" and "hangup" keys are symbolised by a green and red phone
- * on the button.
-
- Komunikate KIP1000 Keyboard Matrix
-
-     -> -- 1 -- 2 -- 3  --> GPI pin 4 (0x10)
-      |    |    |    |
-     <- -- 4 -- 5 -- 6  --> GPI pin 5 (0x20)
-      |    |    |    |
-     END - 7 -- 8 -- 9  --> GPI pin 6 (0x40)
-      |    |    |    |
-     OK -- * -- 0 -- #  --> GPI pin 7 (0x80)
-      |    |    |    |
-
-     /|\  /|\  /|\  /|\
-      |    |    |    |
-GPO
-pin:  3    2    1    0
-     0x8  0x4  0x2  0x1
-
- */
-static unsigned short keymap_kip1000(int scancode)
-{
-	switch (scancode) {				/* phone key:   */
-	case 0x82: return KEY_NUMERIC_0;		/*   0          */
-	case 0x14: return KEY_NUMERIC_1;		/*   1          */
-	case 0x12: return KEY_NUMERIC_2;		/*   2          */
-	case 0x11: return KEY_NUMERIC_3;		/*   3          */
-	case 0x24: return KEY_NUMERIC_4;		/*   4          */
-	case 0x22: return KEY_NUMERIC_5;		/*   5          */
-	case 0x21: return KEY_NUMERIC_6;		/*   6          */
-	case 0x44: return KEY_NUMERIC_7;		/*   7          */
-	case 0x42: return KEY_NUMERIC_8;		/*   8          */
-	case 0x41: return KEY_NUMERIC_9;		/*   9          */
-	case 0x81: return KEY_NUMERIC_POUND;		/*   #          */
-	case 0x84: return KEY_NUMERIC_STAR;		/*   *          */
-	case 0x88: return KEY_ENTER;			/*   pickup     */
-	case 0x48: return KEY_ESC;			/*   hangup     */
-	case 0x28: return KEY_LEFT;			/*   IN         */
-	case 0x18: return KEY_RIGHT;			/*   OUT        */
-	default:   return special_keymap(scancode);
-	}
-}
-
-/*
-  Contributed by Shaun Jackman <sjackman@gmail.com>
-
-  Genius G-Talk keyboard matrix
-     0 1 2 3
-  4: 0 4 8 Talk
-  5: 1 5 9 End
-  6: 2 6 # Up
-  7: 3 7 * Down
-*/
-static unsigned short keymap_gtalk(int scancode)
-{
-	switch (scancode) {
-	case 0x11: return KEY_NUMERIC_0;
-	case 0x21: return KEY_NUMERIC_1;
-	case 0x41: return KEY_NUMERIC_2;
-	case 0x81: return KEY_NUMERIC_3;
-	case 0x12: return KEY_NUMERIC_4;
-	case 0x22: return KEY_NUMERIC_5;
-	case 0x42: return KEY_NUMERIC_6;
-	case 0x82: return KEY_NUMERIC_7;
-	case 0x14: return KEY_NUMERIC_8;
-	case 0x24: return KEY_NUMERIC_9;
-	case 0x44: return KEY_NUMERIC_POUND;	/* # */
-	case 0x84: return KEY_NUMERIC_STAR;	/* * */
-	case 0x18: return KEY_ENTER;		/* Talk (green handset) */
-	case 0x28: return KEY_ESC;		/* End (red handset) */
-	case 0x48: return KEY_UP;		/* Menu up (rocker switch) */
-	case 0x88: return KEY_DOWN;		/* Menu down (rocker switch) */
-	default:   return special_keymap(scancode);
-	}
-}
-
-/*
- * Keymap for Allied-Telesis Corega USBPH01
- * http://www.alliedtelesis-corega.com/2/1344/1437/1360/chprd.html
- *
- * Contributed by july@nat.bg
- */
-static unsigned short keymap_usbph01(int scancode)
-{
-	switch (scancode) {
-	case 0x11: return KEY_NUMERIC_0;		/*   0          */
-	case 0x21: return KEY_NUMERIC_1;		/*   1          */
-	case 0x41: return KEY_NUMERIC_2;		/*   2          */
-	case 0x81: return KEY_NUMERIC_3;		/*   3          */
-	case 0x12: return KEY_NUMERIC_4;		/*   4          */
-	case 0x22: return KEY_NUMERIC_5;		/*   5          */
-	case 0x42: return KEY_NUMERIC_6;		/*   6          */
-	case 0x82: return KEY_NUMERIC_7;		/*   7          */
-	case 0x14: return KEY_NUMERIC_8;		/*   8          */
-	case 0x24: return KEY_NUMERIC_9;		/*   9          */
-	case 0x44: return KEY_NUMERIC_POUND;		/*   #          */
-	case 0x84: return KEY_NUMERIC_STAR;		/*   *          */
-	case 0x18: return KEY_ENTER;			/*   pickup     */
-	case 0x28: return KEY_ESC;			/*   hangup     */
-	case 0x48: return KEY_LEFT;			/*   IN         */
-	case 0x88: return KEY_RIGHT;			/*   OUT        */
-	default:   return special_keymap(scancode);
-	}
-}
-
-/*
- * Keymap for ATCom AU-100
- * http://www.atcom.cn/products.html 
- * http://www.packetizer.com/products/au100/
- * http://www.voip-info.org/wiki/view/AU-100
- *
- * Contributed by daniel@gimpelevich.san-francisco.ca.us
- */
-static unsigned short keymap_atcom(int scancode)
-{
-	switch (scancode) {				/* phone key:   */
-	case 0x82: return KEY_NUMERIC_0;		/*   0          */
-	case 0x11: return KEY_NUMERIC_1;		/*   1          */
-	case 0x12: return KEY_NUMERIC_2;		/*   2          */
-	case 0x14: return KEY_NUMERIC_3;		/*   3          */
-	case 0x21: return KEY_NUMERIC_4;		/*   4          */
-	case 0x22: return KEY_NUMERIC_5;		/*   5          */
-	case 0x24: return KEY_NUMERIC_6;		/*   6          */
-	case 0x41: return KEY_NUMERIC_7;		/*   7          */
-	case 0x42: return KEY_NUMERIC_8;		/*   8          */
-	case 0x44: return KEY_NUMERIC_9;		/*   9          */
-	case 0x84: return KEY_NUMERIC_POUND;		/*   #          */
-	case 0x81: return KEY_NUMERIC_STAR;		/*   *          */
-	case 0x18: return KEY_ENTER;			/*   pickup     */
-	case 0x28: return KEY_ESC;			/*   hangup     */
-	case 0x48: return KEY_LEFT;			/* left arrow   */
-	case 0x88: return KEY_RIGHT;			/* right arrow  */
-	default:   return special_keymap(scancode);
-	}
-}
-
-static unsigned short (*keymap)(int) = keymap_kip1000;
-
-/*
- * Completes a request by converting the data into events for the
- * input subsystem.
- */
-static void report_key(struct cm109_dev *dev, int key)
-{
-	struct input_dev *idev = dev->idev;
-
-	if (dev->key_code >= 0) {
-		/* old key up */
-		input_report_key(idev, dev->key_code, 0);
-	}
-
-	dev->key_code = key;
-	if (key >= 0) {
-		/* new valid key */
-		input_report_key(idev, key, 1);
-	}
-
-	input_sync(idev);
-}
-
-/*
- * Converts data of special key presses (volume, mute) into events
- * for the input subsystem, sends press-n-release for mute keys.
- */
-static void cm109_report_special(struct cm109_dev *dev)
-{
-	static const u8 autorelease = RECORD_MUTE | PLAYBACK_MUTE;
-	struct input_dev *idev = dev->idev;
-	u8 data = dev->irq_data->byte[HID_IR0];
-	unsigned short keycode;
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		keycode = dev->keymap[0xff + BIT(i)];
-		if (keycode == KEY_RESERVED)
-			continue;
-
-		input_report_key(idev, keycode, data & BIT(i));
-		if (data & autorelease & BIT(i)) {
-			input_sync(idev);
-			input_report_key(idev, keycode, 0);
-		}
-	}
-	input_sync(idev);
-}
-
-/******************************************************************************
- * CM109 usb communication interface
- *****************************************************************************/
-
-static void cm109_submit_buzz_toggle(struct cm109_dev *dev)
-{
-	int error;
-
-	if (dev->buzzer_state)
-		dev->ctl_data->byte[HID_OR0] |= BUZZER_ON;
-	else
-		dev->ctl_data->byte[HID_OR0] &= ~BUZZER_ON;
-
-	error = usb_submit_urb(dev->urb_ctl, GFP_ATOMIC);
-	if (error)
-		dev_err(&dev->intf->dev,
-			"%s: usb_submit_urb (urb_ctl) failed %d\n",
-			__func__, error);
-}
-
-static void cm109_submit_ctl(struct cm109_dev *dev)
-{
-	int error;
-
-	guard(spinlock_irqsave)(&dev->ctl_submit_lock);
-
-	dev->irq_urb_pending = 0;
-
-	if (unlikely(dev->shutdown))
-		return;
-
-	if (dev->buzzer_state)
-		dev->ctl_data->byte[HID_OR0] |= BUZZER_ON;
-	else
-		dev->ctl_data->byte[HID_OR0] &= ~BUZZER_ON;
-
-	dev->ctl_data->byte[HID_OR1] = dev->keybit;
-	dev->ctl_data->byte[HID_OR2] = dev->keybit;
-
-	dev->buzzer_pending = 0;
-	dev->ctl_urb_pending = 1;
-
-	error = usb_submit_urb(dev->urb_ctl, GFP_ATOMIC);
-	if (error)
-		dev_err(&dev->intf->dev,
-			"%s: usb_submit_urb (urb_ctl) failed %d\n",
-			__func__, error);
-}
-
-/*
- * IRQ handler
- */
-static void cm109_urb_irq_callback(struct urb *urb)
-{
-	struct cm109_dev *dev = urb->context;
-	const int status = urb->status;
-
-	dev_dbg(&dev->intf->dev, "### URB IRQ: [0x%02x 0x%02x 0x%02x 0x%02x] keybit=0x%02x\n",
-	     dev->irq_data->byte[0],
-	     dev->irq_data->byte[1],
-	     dev->irq_data->byte[2],
-	     dev->irq_data->byte[3],
-	     dev->keybit);
-
-	if (status) {
-		if (status == -ESHUTDOWN)
-			return;
-		dev_err_ratelimited(&dev->intf->dev, "%s: urb status %d\n",
-				    __func__, status);
-		goto out;
-	}
-
-	/* Special keys */
-	cm109_report_special(dev);
-
-	/* Scan key column */
-	if (dev->keybit == 0xf) {
-
-		/* Any changes ? */
-		if ((dev->gpi & 0xf0) == (dev->irq_data->byte[HID_IR1] & 0xf0))
-			goto out;
-
-		dev->gpi = dev->irq_data->byte[HID_IR1] & 0xf0;
-		dev->keybit = 0x1;
-	} else {
-		report_key(dev, dev->keymap[dev->irq_data->byte[HID_IR1]]);
-
-		dev->keybit <<= 1;
-		if (dev->keybit > 0x8)
-			dev->keybit = 0xf;
-	}
-
- out:
-	cm109_submit_ctl(dev);
-}
-
-static void cm109_urb_ctl_callback(struct urb *urb)
-{
-	struct cm109_dev *dev = urb->context;
-	const int status = urb->status;
-	int error;
-
-	dev_dbg(&dev->intf->dev, "### URB CTL: [0x%02x 0x%02x 0x%02x 0x%02x]\n",
-	     dev->ctl_data->byte[0],
-	     dev->ctl_data->byte[1],
-	     dev->ctl_data->byte[2],
-	     dev->ctl_data->byte[3]);
-
-	if (status) {
-		if (status == -ESHUTDOWN)
-			return;
-		dev_err_ratelimited(&dev->intf->dev, "%s: urb status %d\n",
-				    __func__, status);
-	}
-
-	guard(spinlock_irqsave)(&dev->ctl_submit_lock);
-
-	dev->ctl_urb_pending = 0;
-
-	if (unlikely(dev->shutdown))
-		return;
-
-	if (dev->buzzer_pending || status) {
-		dev->buzzer_pending = 0;
-		dev->ctl_urb_pending = 1;
-		cm109_submit_buzz_toggle(dev);
-	} else if (likely(!dev->irq_urb_pending)) {
-		/* ask for key data */
-		dev->irq_urb_pending = 1;
-		error = usb_submit_urb(dev->urb_irq, GFP_ATOMIC);
-		if (error)
-			dev_err(&dev->intf->dev,
-				"%s: usb_submit_urb (urb_irq) failed %d\n",
-				__func__, error);
-	}
-}
-
-static void cm109_toggle_buzzer_async(struct cm109_dev *dev)
-{
-	guard(spinlock_irqsave)(&dev->ctl_submit_lock);
-
-	if (dev->ctl_urb_pending) {
-		/* URB completion will resubmit */
-		dev->buzzer_pending = 1;
-	} else {
-		dev->ctl_urb_pending = 1;
-		cm109_submit_buzz_toggle(dev);
-	}
-}
-
-static void cm109_toggle_buzzer_sync(struct cm109_dev *dev, int on)
-{
-	int error;
-
-	if (on)
-		dev->ctl_data->byte[HID_OR0] |= BUZZER_ON;
-	else
-		dev->ctl_data->byte[HID_OR0] &= ~BUZZER_ON;
-
-	error = usb_control_msg(dev->udev,
-				usb_sndctrlpipe(dev->udev, 0),
-				dev->ctl_req->bRequest,
-				dev->ctl_req->bRequestType,
-				le16_to_cpu(dev->ctl_req->wValue),
-				le16_to_cpu(dev->ctl_req->wIndex),
-				dev->ctl_data,
-				USB_PKT_LEN, USB_CTRL_SET_TIMEOUT);
-	if (error < 0 && error != -EINTR)
-		dev_err(&dev->intf->dev, "%s: usb_control_msg() failed %d\n",
-			__func__, error);
-}
-
-static void cm109_stop_traffic(struct cm109_dev *dev)
-{
-	dev->shutdown = 1;
-	/*
-	 * Make sure other CPUs see this
-	 */
-	smp_wmb();
-
-	usb_kill_urb(dev->urb_ctl);
-	usb_kill_urb(dev->urb_irq);
-
-	cm109_toggle_buzzer_sync(dev, 0);
-
-	dev->shutdown = 0;
-	smp_wmb();
-}
-
-static void cm109_restore_state(struct cm109_dev *dev)
-{
-	if (dev->open) {
-		/*
-		 * Restore buzzer state.
-		 * This will also kick regular URB submission
-		 */
-		cm109_toggle_buzzer_async(dev);
-	}
-}
-
-/******************************************************************************
- * input event interface
- *****************************************************************************/
-
-static int cm109_input_open(struct input_dev *idev)
-{
-	struct cm109_dev *dev = input_get_drvdata(idev);
-	int error;
-
-	error = usb_autopm_get_interface(dev->intf);
-	if (error < 0) {
-		dev_err(&idev->dev, "%s - cannot autoresume, result %d\n",
-			__func__, error);
-		return error;
-	}
-
-	scoped_guard(mutex, &dev->pm_mutex) {
-		dev->buzzer_state = 0;
-		dev->key_code = -1;	/* no keys pressed */
-		dev->keybit = 0xf;
-
-		/* issue INIT */
-		dev->ctl_data->byte[HID_OR0] = HID_OR_GPO_BUZ_SPDIF;
-		dev->ctl_data->byte[HID_OR1] = dev->keybit;
-		dev->ctl_data->byte[HID_OR2] = dev->keybit;
-		dev->ctl_data->byte[HID_OR3] = 0x00;
-
-		dev->ctl_urb_pending = 1;
-		error = usb_submit_urb(dev->urb_ctl, GFP_KERNEL);
-		if (!error) {
-			dev->open = 1;
-			return 0;
-		}
-	}
-
-	dev->ctl_urb_pending = 0;
-	usb_autopm_put_interface(dev->intf);
-
-	dev_err(&dev->intf->dev, "%s: usb_submit_urb (urb_ctl) failed %d\n",
-		__func__, error);
-
-	return error;
-}
-
-static void cm109_input_close(struct input_dev *idev)
-{
-	struct cm109_dev *dev = input_get_drvdata(idev);
-
-	scoped_guard(mutex, &dev->pm_mutex) {
-		/*
-		 * Once we are here event delivery is stopped so we
-		 * don't need to worry about someone starting buzzer
-		 * again
-		 */
-		cm109_stop_traffic(dev);
-		dev->open = 0;
-	}
-
-	usb_autopm_put_interface(dev->intf);
-}
-
-static int cm109_input_ev(struct input_dev *idev, unsigned int type,
-			  unsigned int code, int value)
-{
-	struct cm109_dev *dev = input_get_drvdata(idev);
-
-	dev_dbg(&dev->intf->dev,
-		"input_ev: type=%u code=%u value=%d\n", type, code, value);
-
-	if (type != EV_SND)
-		return -EINVAL;
-
-	switch (code) {
-	case SND_TONE:
-	case SND_BELL:
-		dev->buzzer_state = !!value;
-		if (!dev->resetting)
-			cm109_toggle_buzzer_async(dev);
-		return 0;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-
-/******************************************************************************
- * Linux interface and usb initialisation
- *****************************************************************************/
-
-struct driver_info {
-	char *name;
-};
-
-static const struct driver_info info_cm109 = {
-	.name = "CM109 USB driver",
-};
-
-enum {
-	VENDOR_ID        = 0x0d8c, /* C-Media Electronics */
-	PRODUCT_ID_CM109 = 0x000e, /* CM109 defines range 0x0008 - 0x000f */
-};
-
-/* table of devices that work with this driver */
-static const struct usb_device_id cm109_usb_table[] = {
-	{
-		.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-				USB_DEVICE_ID_MATCH_INT_INFO,
-		.idVendor = VENDOR_ID,
-		.idProduct = PRODUCT_ID_CM109,
-		.bInterfaceClass = USB_CLASS_HID,
-		.bInterfaceSubClass = 0,
-		.bInterfaceProtocol = 0,
-		.driver_info = (kernel_ulong_t) &info_cm109
-	},
-	/* you can add more devices here with product ID 0x0008 - 0x000f */
-	{ }
-};
-
-static void cm109_usb_cleanup(struct cm109_dev *dev)
-{
-	kfree(dev->ctl_req);
-	usb_free_coherent(dev->udev, USB_PKT_LEN, dev->ctl_data, dev->ctl_dma);
-	usb_free_coherent(dev->udev, USB_PKT_LEN, dev->irq_data, dev->irq_dma);
-
-	usb_free_urb(dev->urb_irq);	/* parameter validation in core/urb */
-	usb_free_urb(dev->urb_ctl);	/* parameter validation in core/urb */
-	kfree(dev);
-}
-
-static void cm109_usb_disconnect(struct usb_interface *interface)
-{
-	struct cm109_dev *dev = usb_get_intfdata(interface);
-
-	usb_set_intfdata(interface, NULL);
-	input_unregister_device(dev->idev);
-	cm109_usb_cleanup(dev);
-}
-
-static int cm109_usb_probe(struct usb_interface *intf,
-			   const struct usb_device_id *id)
-{
-	struct usb_device *udev = interface_to_usbdev(intf);
-	struct driver_info *nfo = (struct driver_info *)id->driver_info;
-	struct usb_host_interface *interface;
-	struct usb_endpoint_descriptor *endpoint;
-	struct cm109_dev *dev;
-	struct input_dev *input_dev = NULL;
-	int ret, pipe, i;
-	int error = -ENOMEM;
-
-	interface = intf->cur_altsetting;
-
-	if (interface->desc.bNumEndpoints < 1)
-		return -ENODEV;
-
-	endpoint = &interface->endpoint[0].desc;
-
-	if (!usb_endpoint_is_int_in(endpoint))
-		return -ENODEV;
-
-	dev = kzalloc_obj(*dev);
-	if (!dev)
-		return -ENOMEM;
-
-	spin_lock_init(&dev->ctl_submit_lock);
-	mutex_init(&dev->pm_mutex);
-
-	dev->udev = udev;
-	dev->intf = intf;
-
-	dev->idev = input_dev = input_allocate_device();
-	if (!input_dev)
-		goto err_out;
-
-	/* allocate usb buffers */
-	dev->irq_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_KERNEL, &dev->irq_dma);
-	if (!dev->irq_data)
-		goto err_out;
-
-	dev->ctl_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_KERNEL, &dev->ctl_dma);
-	if (!dev->ctl_data)
-		goto err_out;
-
-	dev->ctl_req = kmalloc_obj(*(dev->ctl_req));
-	if (!dev->ctl_req)
-		goto err_out;
-
-	/* allocate urb structures */
-	dev->urb_irq = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->urb_irq)
-		goto err_out;
-
-	dev->urb_ctl = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->urb_ctl)
-		goto err_out;
-
-	/* get a handle to the interrupt data pipe */
-	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	ret = usb_maxpacket(udev, pipe);
-	if (ret != USB_PKT_LEN)
-		dev_err(&intf->dev, "invalid payload size %d, expected %d\n",
-			ret, USB_PKT_LEN);
-
-	/* initialise irq urb */
-	usb_fill_int_urb(dev->urb_irq, udev, pipe, dev->irq_data,
-			 USB_PKT_LEN,
-			 cm109_urb_irq_callback, dev, endpoint->bInterval);
-	dev->urb_irq->transfer_dma = dev->irq_dma;
-	dev->urb_irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-	dev->urb_irq->dev = udev;
-
-	/* initialise ctl urb */
-	dev->ctl_req->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE |
-					USB_DIR_OUT;
-	dev->ctl_req->bRequest = USB_REQ_SET_CONFIGURATION;
-	dev->ctl_req->wValue = cpu_to_le16(0x200);
-	dev->ctl_req->wIndex = cpu_to_le16(interface->desc.bInterfaceNumber);
-	dev->ctl_req->wLength = cpu_to_le16(USB_PKT_LEN);
-
-	usb_fill_control_urb(dev->urb_ctl, udev, usb_sndctrlpipe(udev, 0),
-			     (void *)dev->ctl_req, dev->ctl_data, USB_PKT_LEN,
-			     cm109_urb_ctl_callback, dev);
-	dev->urb_ctl->transfer_dma = dev->ctl_dma;
-	dev->urb_ctl->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-	dev->urb_ctl->dev = udev;
-
-	/* find out the physical bus location */
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
-
-	/* register settings for the input device */
-	input_dev->name = nfo->name;
-	input_dev->phys = dev->phys;
-	usb_to_input_id(udev, &input_dev->id);
-	input_dev->dev.parent = &intf->dev;
-
-	input_set_drvdata(input_dev, dev);
-	input_dev->open = cm109_input_open;
-	input_dev->close = cm109_input_close;
-	input_dev->event = cm109_input_ev;
-
-	input_dev->keycode = dev->keymap;
-	input_dev->keycodesize = sizeof(unsigned char);
-	input_dev->keycodemax = ARRAY_SIZE(dev->keymap);
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_SND);
-	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
-
-	/* register available key events */
-	for (i = 0; i < KEYMAP_SIZE; i++) {
-		unsigned short k = keymap(i);
-		dev->keymap[i] = k;
-		__set_bit(k, input_dev->keybit);
-	}
-	__clear_bit(KEY_RESERVED, input_dev->keybit);
-
-	error = input_register_device(dev->idev);
-	if (error)
-		goto err_out;
-
-	usb_set_intfdata(intf, dev);
-
-	return 0;
-
- err_out:
-	input_free_device(input_dev);
-	cm109_usb_cleanup(dev);
-	return error;
-}
-
-static int cm109_usb_suspend(struct usb_interface *intf, pm_message_t message)
-{
-	struct cm109_dev *dev = usb_get_intfdata(intf);
-
-	dev_info(&intf->dev, "cm109: usb_suspend (event=%d)\n", message.event);
-
-	guard(mutex)(&dev->pm_mutex);
-
-	cm109_stop_traffic(dev);
-
-	return 0;
-}
-
-static int cm109_usb_resume(struct usb_interface *intf)
-{
-	struct cm109_dev *dev = usb_get_intfdata(intf);
-
-	dev_info(&intf->dev, "cm109: usb_resume\n");
-
-	guard(mutex)(&dev->pm_mutex);
-
-	cm109_restore_state(dev);
-
-	return 0;
-}
-
-static int cm109_usb_pre_reset(struct usb_interface *intf)
-{
-	struct cm109_dev *dev = usb_get_intfdata(intf);
-
-	mutex_lock(&dev->pm_mutex);
-
-	/*
-	 * Make sure input events don't try to toggle buzzer
-	 * while we are resetting
-	 */
-	dev->resetting = 1;
-	smp_wmb();
-
-	cm109_stop_traffic(dev);
-
-	return 0;
-}
-
-static int cm109_usb_post_reset(struct usb_interface *intf)
-{
-	struct cm109_dev *dev = usb_get_intfdata(intf);
-
-	dev->resetting = 0;
-	smp_wmb();
-
-	cm109_restore_state(dev);
-
-	mutex_unlock(&dev->pm_mutex);
-
-	return 0;
-}
-
-static struct usb_driver cm109_driver = {
-	.name		= "cm109",
-	.probe		= cm109_usb_probe,
-	.disconnect	= cm109_usb_disconnect,
-	.suspend	= cm109_usb_suspend,
-	.resume		= cm109_usb_resume,
-	.reset_resume	= cm109_usb_resume,
-	.pre_reset	= cm109_usb_pre_reset,
-	.post_reset	= cm109_usb_post_reset,
-	.id_table	= cm109_usb_table,
-	.supports_autosuspend = 1,
-};
-
-static int __init cm109_select_keymap(void)
-{
-	/* Load the phone keymap */
-	if (!strcasecmp(phone, "kip1000")) {
-		keymap = keymap_kip1000;
-		printk(KERN_INFO KBUILD_MODNAME ": "
-			"Keymap for Komunikate KIP1000 phone loaded\n");
-	} else if (!strcasecmp(phone, "gtalk")) {
-		keymap = keymap_gtalk;
-		printk(KERN_INFO KBUILD_MODNAME ": "
-			"Keymap for Genius G-talk phone loaded\n");
-	} else if (!strcasecmp(phone, "usbph01")) {
-		keymap = keymap_usbph01;
-		printk(KERN_INFO KBUILD_MODNAME ": "
-			"Keymap for Allied-Telesis Corega USBPH01 phone loaded\n");
-	} else if (!strcasecmp(phone, "atcom")) {
-		keymap = keymap_atcom;
-		printk(KERN_INFO KBUILD_MODNAME ": "
-			"Keymap for ATCom AU-100 phone loaded\n");
-	} else {
-		printk(KERN_ERR KBUILD_MODNAME ": "
-			"Unsupported phone: %s\n", phone);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init cm109_init(void)
-{
-	int err;
-
-	err = cm109_select_keymap();
-	if (err)
-		return err;
-
-	err = usb_register(&cm109_driver);
-	if (err)
-		return err;
-
-	printk(KERN_INFO KBUILD_MODNAME ": "
-		DRIVER_DESC ": " DRIVER_VERSION " (C) " DRIVER_AUTHOR "\n");
-
-	return 0;
-}
-
-static void __exit cm109_exit(void)
-{
-	usb_deregister(&cm109_driver);
-}
-
-module_init(cm109_init);
-module_exit(cm109_exit);
-
-MODULE_DEVICE_TABLE(usb, cm109_usb_table);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-- 
2.56.0.567.gdb80ae8cd5-goog



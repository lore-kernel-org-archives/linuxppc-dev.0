Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD560A5BC8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm4OquVV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPy7D0zX2z2xmk;
	Thu, 12 Nov 2026 08:57:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794434264;
	cv=none; b=a3X1e6i0xrtaNYxHCccVEfmpW+MNgoYDN7uvQcrLSrVB6UCyae3biMnU6TOb7hcKL0VaiOXe/Yx8s2Coun9cpjaoDTMmE9DFgqwaJwkO/KklQApa9e81ORWjWPchG6/yHHuWKzJwOUIeTpcL1IjQtpohxQRi3r2Zu0Lu/G6W4UR3DZ/4qo7jxRhGohnsuLcliPuioMu1ZIomHBfV0snJj+PHenMvrFxKfGG16C3LqOCTa0pXhzBbsmWCD3RvvairjE2/oW59ppoASz8tX8bAMn0IAgb1nUx1Dsbwl6gARfwIhjBjbmBeva746Dz9Gw0AAvemfPhAZMBnURrJVQ99hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794434264; c=relaxed/relaxed;
	bh=vbuWm3lTAGhh+K6FY+cTHEpXwjrOKJbhjdzTo0ymqM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQepPxoieqgSp9j93tD1jlHF1yw2v4WwuoRd+8OT+ZaB33LcouOYFys46j/CN9ajEG/AHd5SCUxD3GuHi6Qg0pp5J1f3hOb0QHw4+Yd+Uax3vjsieJL3v+u6JfQUYTL4xzvcDXDUdvzE8fCF8gYtXhXgejhQ4MT9pxMQZgcGJRa8zqvhUn5wvNCxX6PsBLp1wBA46I2Lqhdbb32e3AfynAOvoZDTVaF558bQpcYPsGSSIVszLsm3HyjwOzF77kPO2QODXbuurgMsm59t8Hhm1JeJrtVwiITmQXeFymtrpt9WrPKrY5+7XJSpSWBbOo/IdUnu/TqeKboLhp3z1Ah4Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm4OquVV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm4OquVV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPy793nYNz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:57:41 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so6493287eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 13:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434260; x=1795039060; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbuWm3lTAGhh+K6FY+cTHEpXwjrOKJbhjdzTo0ymqM4=;
        b=Cm4OquVVzDBWA11ekxzEgiY9Ue4uG8udmp4+THsvJUng2yQIcmGm5hpMEw2+fFhoT4
         D8mbDFkOhUTmckIOSJlDrDgn/fJyb7+TvBG75hJ6W9QScHWR43m8f/9r3LPyBHgf9uRh
         31V39/8iigdn/3ZjNeosnqwsos81R+b+lkuDtXsfiRhemBCIa42CXIv8BvQT6e1mDJlm
         muq7m8vFUADMG4CGbZ+ypWAY+ddJ5k7e9Rg1mhBSNsZTqayRe1gst7h/gClky4CPfZVA
         j5RDUzkefVCjte+XkAWZkSgYDxiOqQJV1HCzRJJQwajGzj6Wo9Y9pxCf7ooB8vnepFUM
         swBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434260; x=1795039060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbuWm3lTAGhh+K6FY+cTHEpXwjrOKJbhjdzTo0ymqM4=;
        b=s67XAF/Sjdq9bDRzNyA/tA8GpchIjcePSVNIEtljXitBcWSYjPza18pd4mgBATzP9T
         4Wcdf0Ws8roN2Ezg5aMVTpYeyoe5RZne+mEk6ApUAixOdfAMCVS8mQco6EjpRoXccjDy
         C0vgsUuz/m1mwwNoASAqcV+wDfAPBlEAgMIusCM0jpxQDHVUbJTdIjFVz8CvbF4GSwM3
         UECOVOaoj57LG86aLYRIutEs/9FMLkWQFG71tzWjiEgyCYCYWJJsxzxG5+QoULmkRJ9Y
         ri/L0QdlaeEvyF2oKf0fivPthxhEJF4vmNxeP+pu/3ldffxs5HgoiFTTvy/s7FSwazFO
         KhIw==
X-Forwarded-Encrypted: i=1; AL+hErHItLiwyBgGplc9r2mU65J3vCAsFncWevfhfaCVQTGvunbEfNC2d5XKM8/hDAkasIeOzY6rQH0WLNBhHZE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/DvbEr5jKhUwJWRQCmXLPDgrHErvO/E9W1uLP4cQsoE8s/Yv3j
	bypbca7bpDaL9DBTa0sBp34oaC1Fe/vngYzVVqdf8B50z63agp4O+KDq
X-Gm-Gg: AYBFou2AouU+YhWaimi6hyKP3YP/0l4c97n1rBZu4YLiMKjuShUbkUCsTE7nGdpkxmU
	/u3z2dtRR3lrHAxLgQC6BsUPP/GEt/CTuEABFGgBW1nWSFkk+hcinZtICoe0v9OS6U1GBJr7TqA
	5Ub6KPuMl+EgBz/jT0g+FQcPSD+fgBVZuw0nwX9aqoRccG1mP4wXReAmU9ZfinIqridBYTTrXfC
	uICvgSme/15d349PsJgU0KsRX7tM5Igo2SAHWVtiJYpdP1hb86hJ2K+Klzwk+KEiKlBhoak3oWh
	L9cHfcMgoP4JyhW3hEORCOJ9d8ukJe0ESJn+dbU0oCaQrZJ7zci888ixsEcuDCOPONfgdLMrqQZ
	4sT2/4Dt7DohZdAUztPNQOvAYCYa1gpucmEyoex55RYBxaVUpvixd+KMSr5LkYXgbQFtp4IcEzp
	Mej/mkguUyedZmxAdqdGsIFOeKnL/upWC0asZ+2V/vwiepBTsr5uZXD0KmhXLwnaHCb2Tw5iZ9A
	tLJUH2A68ajIQnTFw1eJzimSHryrLL5o9Im5p43+438NgrMJ0jo2xb/s2UI/jpqPjaUg0WIRW8N
	W3+/mmpFO1xplNseVj6K5I5LdwwcQWYO4JJwSUu46c0gkEz4nn3869/aYOVMuYOSU0LmdKjrRKq
	6oWQafnRUr/4OGHkl2g==
X-Received: by 2002:a05:693c:8201:b0:376:98e7:eeb0 with SMTP id 5a478bee46e88-37698e7ef92mr3812281eec.7.1794434259025;
        Wed, 11 Nov 2026 13:57:39 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:eb83:637b:7b26:8dfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm17823523eec.3.2026.11.11.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:57:37 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Martin Diehl <m-diehl@gmx.de>,
	"Alfred E . Heggestad" <aeh@db.org>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Slawomir Stepien <sst@poczta.fm>,
	Jie Wang <jie.wang@intel.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	usbb2k-api-dev@nongnu.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: yealink - remove driver
Date: Wed, 11 Nov 2026 13:57:23 -0800
Message-ID: <20261111215723.3802209-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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

The Yealink USB-P1K (0x6993:0xb001) is a mid-2000s USB 1.1 telephone
handset with a segmented LCD, keypad, and ringer marketed as a
"USB phone for Skype" and desktop VoIP/SIP softphones, where audio was
handled by snd-usb-audio and the yealink driver drove the keypad,
segmented LCD, and tones via custom sysfs attributes.

Operating the handset required dedicated userspace bridge software such
as usbb2k-api / kb2kskype (targeting the defunct legacy Skype desktop
API and KDE3/Qt3) or yeaphone (an archived 2000s liblinphone wrapper).
The entire userspace ecosystem has been unmaintained for over 15 years,
the legacy Skype API it was built around is gone, and modern USB
telephony devices rely on standard USB HID telephony usages instead of
custom sysfs display drivers.

The driver has had no functional changes, hardware testing, or new
device IDs since 2008, while continuing to generate syzbot USB fuzzing
reports and drive-by cleanup churn. Remove the driver, its
documentation, Kconfig and Makefile entries, the MAINTAINERS section,
and the HID ignore-list entry that only existed to prevent usbhid from
binding ahead of yealink.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/.renames.txt              |   1 -
 Documentation/input/devices/yealink.rst | 226 ------
 MAINTAINERS                             |   6 -
 drivers/hid/hid-ids.h                   |   3 -
 drivers/hid/hid-quirks.c                |   1 -
 drivers/input/misc/Kconfig              |  15 -
 drivers/input/misc/Makefile             |   1 -
 drivers/input/misc/yealink.c            | 950 ------------------------
 drivers/input/misc/yealink.h            | 206 -----
 9 files changed, 1409 deletions(-)
 delete mode 100644 Documentation/input/devices/yealink.rst
 delete mode 100644 drivers/input/misc/yealink.c
 delete mode 100644 drivers/input/misc/yealink.h

diff --git a/Documentation/.renames.txt b/Documentation/.renames.txt
index aa7e5aa4a81b..e24a8f0fa5d3 100644
--- a/Documentation/.renames.txt
+++ b/Documentation/.renames.txt
@@ -275,7 +275,6 @@ input/rotary-encoder input/devices/rotary-encoder
 input/sentelic input/devices/sentelic
 input/walkera0701 input/devices/walkera0701
 input/xpad input/devices/xpad
-input/yealink input/devices/yealink
 interconnect/interconnect driver-api/interconnect
 ioctl/botching-up-ioctls process/botching-up-ioctls
 ioctl/cdrom userspace-api/ioctl/cdrom
diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
deleted file mode 100644
index 53191a3c83ca..000000000000
--- a/Documentation/input/devices/yealink.rst
+++ /dev/null
@@ -1,226 +0,0 @@
-===============================================
-Driver documentation for yealink usb-p1k phones
-===============================================
-
-Status
-======
-
-The p1k is a relatively cheap usb 1.1 phone with:
-
-  - keyboard		full support, yealink.ko / input event API
-  - LCD			full support, yealink.ko / sysfs API
-  - LED			full support, yealink.ko / sysfs API
-  - dialtone		full support, yealink.ko / sysfs API
-  - ringtone		full support, yealink.ko / sysfs API
-  - audio playback   	full support, snd_usb_audio.ko / alsa API
-  - audio record     	full support, snd_usb_audio.ko / alsa API
-
-For vendor documentation see http://www.yealink.com
-
-
-keyboard features
-=================
-
-The current mapping in the kernel is provided by the map_p1k_to_key
-function::
-
-   Physical USB-P1K button layout	input events
-
-
-              up			     up
-        IN           OUT		left,	right
-             down			    down
-
-      pickup   C    hangup		enter, backspace, escape
-        1      2      3			1, 2, 3
-        4      5      6			4, 5, 6,
-        7      8      9			7, 8, 9,
-        *      0      #			*, 0, #,
-
-The "up" and "down" keys, are symbolised by arrows on the button.
-The "pickup" and "hangup" keys are symbolised by a green and red phone
-on the button.
-
-
-LCD features
-============
-
-The LCD is divided and organised as a 3 line display::
-
-    |[]   [][]   [][]   [][]   in   |[][]
-    |[] M [][] D [][] : [][]   out  |[][]
-                              store
-
-    NEW REP         SU MO TU WE TH FR SA
-
-    [] [] [] [] [] [] [] [] [] [] [] []
-    [] [] [] [] [] [] [] [] [] [] [] []
-
-
-  Line 1  Format (see below)	: 18.e8.M8.88...188
-	  Icon names		:   M  D  :  IN OUT STORE
-  Line 2  Format		: .........
-	  Icon name		: NEW REP SU MO TU WE TH FR SA
-  Line 3  Format		: 888888888888
-
-
-Format description:
-  From a userspace perspective the world is separated into "digits" and "icons".
-  A digit can have a character set, an icon can only be ON or OFF.
-
-  Format specifier::
-
-    '8' :  Generic 7 segment digit with individual addressable segments
-
-    Reduced capability 7 segment digit, when segments are hard wired together.
-    '1' : 2 segments digit only able to produce a 1.
-    'e' : Most significant day of the month digit,
-          able to produce at least 1 2 3.
-    'M' : Most significant minute digit,
-          able to produce at least 0 1 2 3 4 5.
-
-    Icons or pictograms:
-    '.' : For example like AM, PM, SU, a 'dot' .. or other single segment
-	  elements.
-
-
-Driver usage
-============
-
-For userland the following interfaces are available using the sysfs interface::
-
-  /sys/.../
-           line1	Read/Write, lcd line1
-           line2	Read/Write, lcd line2
-           line3	Read/Write, lcd line3
-
-	   get_icons    Read, returns a set of available icons.
-	   hide_icon    Write, hide the element by writing the icon name.
-	   show_icon    Write, display the element by writing the icon name.
-
-	   map_seg7	Read/Write, the 7 segments char set, common for all
-			yealink phones. (see map_to_7segment.h)
-
-	   ringtone	Write, upload binary representation of a ringtone,
-			see yealink.c. status EXPERIMENTAL due to potential
-			races between async. and sync usb calls.
-
-
-lineX
-~~~~~
-
-Reading /sys/../lineX will return the format string with its current value.
-
-  Example::
-
-    cat ./line3
-    888888888888
-    Linux Rocks!
-
-Writing to /sys/../lineX will set the corresponding LCD line.
-
- - Excess characters are ignored.
- - If fewer characters than allowed are written, the remaining digits are
-   unchanged.
- - The tab ``\t`` and newline ``\n`` characters do not overwrite the original
-   content.
- - Writing a space to an icon will always hide its content.
-
-  Example::
-
-    date +"%m.%e.%k:%M"  | sed 's/^0/ /' > ./line1
-
-  Will update the LCD with the current date & time.
-
-
-get_icons
-~~~~~~~~~
-
-Reading will return all available icon names and its current settings::
-
-  cat ./get_icons
-  on M
-  on D
-  on :
-     IN
-     OUT
-     STORE
-     NEW
-     REP
-     SU
-     MO
-     TU
-     WE
-     TH
-     FR
-     SA
-     LED
-     DIALTONE
-     RINGTONE
-
-
-show/hide icons
-~~~~~~~~~~~~~~~
-
-Writing to these files will update the state of the icon.
-Only one icon at a time can be updated.
-
-If an icon is also on a ./lineX the corresponding value is
-updated with the first letter of the icon.
-
-  Example - light up the store icon::
-
-    echo -n "STORE" > ./show_icon
-
-    cat ./line1
-    18.e8.M8.88...188
-		  S
-
-  Example - sound the ringtone for 10 seconds::
-
-    echo -n RINGTONE > /sys/..../show_icon
-    sleep 10
-    echo -n RINGTONE > /sys/..../hide_icon
-
-
-Sound features
-==============
-
-Sound is supported by the ALSA driver: snd_usb_audio
-
-One 16-bit channel with sample and playback rates of 8000 Hz is the practical
-limit of the device.
-
-  Example - recording test::
-
-    arecord -v -d 10 -r 8000 -f S16_LE -t wav  foobar.wav
-
-  Example - playback test::
-
-    aplay foobar.wav
-
-
-Troubleshooting
-===============
-
-:Q: Module yealink compiled and installed without any problem but phone
-    is not initialized and does not react to any actions.
-:A: If you see something like:
-    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone]
-    in dmesg, it means that the hid driver has grabbed the device first. Try to
-    load module yealink before any other usb hid driver. Please see the
-    instructions provided by your distribution on module configuration.
-
-:Q: Phone is working now (displays version and accepts keypad input) but I can't
-    find the sysfs files.
-:A: The sysfs files are located on the particular usb endpoint. On most
-    distributions you can do: "find /sys/ -name get_icons" for a hint.
-
-
-Credits & Acknowledgments
-=========================
-
-  - Olivier Vandorpe, for starting the usbb2k-api project doing much of
-    the reverse engineering.
-  - Martin Diehl, for pointing out how to handle USB memory allocation.
-  - Dmitry Torokhov, for the numerous code reviews and suggestions.
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..0ff81b2c674a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30893,12 +30893,6 @@ F:	Documentation/userspace-api/netlink/intro-specs.rst
 F:	Documentation/userspace-api/netlink/specs.rst
 F:	tools/net/ynl/
 
-YEALINK PHONE DRIVER
-M:	Henk Vergonet <Henk.Vergonet@gmail.com>
-S:	Maintained
-F:	Documentation/input/devices/yealink.rst
-F:	drivers/input/misc/yealink.*
-
 ZD1211RW WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..acfd6fafed73 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1649,9 +1649,6 @@
 #define USB_DEVICE_ID_XIROKU_CSR2	0x1025
 #define USB_DEVICE_ID_XIROKU_MPX2	0x1026
 
-#define USB_VENDOR_ID_YEALINK		0x6993
-#define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
-
 #define USB_VENDOR_ID_YJXCHIP		0xa8a5
 #define USB_DEVICE_ID_YJXCHIP_MOUSE	0x2255
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index f09bd59f366f..f4735b0f01ec 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -988,7 +988,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_WTP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
-	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
 };
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a2984c1048f3..955cca77e9fe 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -469,21 +469,6 @@ config INPUT_POWERMATE
 	  To compile this driver as a module, choose M here: the
 	  module will be called powermate.
 
-config INPUT_YEALINK
-	tristate "Yealink usb-p1k voip phone"
-	depends on USB_ARCH_HAS_HCD
-	select USB
-	help
-	  Say Y here if you want to enable keyboard and LCD functions of the
-	  Yealink usb-p1k usb phones. The audio part is enabled by the generic
-	  usb sound driver, so you might want to enable that as well.
-
-	  For information about how to use these additional functions, see
-	  <file:Documentation/input/devices/yealink.rst>.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called yealink.
-
 config INPUT_CM109
 	tristate "C-Media CM109 USB I/O Controller"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1339619f0769..d4576869aff9 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -95,5 +95,4 @@ obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
-obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
deleted file mode 100644
index 560f895a00cd..000000000000
--- a/drivers/input/misc/yealink.c
+++ /dev/null
@@ -1,950 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * drivers/usb/input/yealink.c
- *
- * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
- */
-/*
- * Description:
- *   Driver for the USB-P1K voip usb phone.
- *   This device is produced by Yealink Network Technology Co Ltd
- *   but may be branded under several names:
- *	- Yealink usb-p1k
- *	- Tiptel 115
- *	- ...
- *
- * This driver is based on:
- *   - the usbb2k-api	http://savannah.nongnu.org/projects/usbb2k-api/
- *   - information from	http://memeteau.free.fr/usbb2k
- *   - the xpad-driver	drivers/input/joystick/xpad.c
- *
- * Thanks to:
- *   - Olivier Vandorpe, for providing the usbb2k-api.
- *   - Martin Diehl, for spotting my memory allocation bug.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/usb/input.h>
-#include <linux/map_to_7segment.h>
-
-#include "yealink.h"
-
-#define DRIVER_VERSION "yld-20051230"
-
-#define YEALINK_POLLING_FREQUENCY	10	/* in [Hz] */
-
-struct yld_status {
-	u8	lcd[24];
-	u8	led;
-	u8	dialtone;
-	u8	ringtone;
-	u8	keynum;
-} __attribute__ ((packed));
-
-/*
- * Register the LCD segment and icon map
- */
-#define _LOC(k,l)	{ .a = (k), .m = (l) }
-#define _SEG(t, a, am, b, bm, c, cm, d, dm, e, em, f, fm, g, gm)	\
-	{ .type	= (t),							\
-	  .u = { .s = {	_LOC(a, am), _LOC(b, bm), _LOC(c, cm),		\
-		        _LOC(d, dm), _LOC(e, em), _LOC(g, gm),		\
-			_LOC(f, fm) } } }
-#define _PIC(t, h, hm, n)						\
-	{ .type	= (t),							\
- 	  .u = { .p = { .name = (n), .a = (h), .m = (hm) } } }
-
-static const struct lcd_segment_map {
-	char	type;
-	union {
-		struct pictogram_map {
-			u8	a,m;
-			char	name[10];
-		}	p;
-		struct segment_map {
-			u8	a,m;
-		} s[7];
-	} u;
-} lcdMap[] = {
-#include "yealink.h"
-};
-
-struct yealink_dev {
-	struct input_dev *idev;		/* input device */
-	struct usb_device *udev;	/* usb device */
-	struct usb_interface *intf;	/* usb interface */
-
-	/* irq input channel */
-	struct yld_ctl_packet	*irq_data;
-	dma_addr_t		irq_dma;
-	struct urb		*urb_irq;
-
-	/* control output channel */
-	struct yld_ctl_packet	*ctl_data;
-	dma_addr_t		ctl_dma;
-	struct usb_ctrlrequest	*ctl_req;
-	struct urb		*urb_ctl;
-
-	char phys[64];			/* physical device path */
-
-	u8 lcdMap[ARRAY_SIZE(lcdMap)];	/* state of LCD, LED ... */
-	int key_code;			/* last reported key	 */
-
-	struct mutex sysfs_mutex;
-
-	unsigned int shutdown:1;
-
-	int	stat_ix;
-	union {
-		struct yld_status s;
-		u8		  b[sizeof(struct yld_status)];
-	} master, copy;
-};
-
-
-/*******************************************************************************
- * Yealink lcd interface
- ******************************************************************************/
-
-/*
- * Register a default 7 segment character set
- */
-static SEG7_DEFAULT_MAP(map_seg7);
-
- /* Display a char,
-  * char '\9' and '\n' are placeholders and do not overwrite the original text.
-  * A space will always hide an icon.
-  */
-static int setChar(struct yealink_dev *yld, int el, int chr)
-{
-	int i, a, m, val;
-
-	if (el >= ARRAY_SIZE(lcdMap))
-		return -EINVAL;
-
-	if (chr == '\t' || chr == '\n')
-	    return 0;
-
-	yld->lcdMap[el] = chr;
-
-	if (lcdMap[el].type == '.') {
-		a = lcdMap[el].u.p.a;
-		m = lcdMap[el].u.p.m;
-		if (chr != ' ')
-			yld->master.b[a] |= m;
-		else
-			yld->master.b[a] &= ~m;
-		return 0;
-	}
-
-	val = map_to_seg7(&map_seg7, chr);
-	for (i = 0; i < ARRAY_SIZE(lcdMap[0].u.s); i++) {
-		m = lcdMap[el].u.s[i].m;
-
-		if (m == 0)
-			continue;
-
-		a = lcdMap[el].u.s[i].a;
-		if (val & 1)
-			yld->master.b[a] |= m;
-		else
-			yld->master.b[a] &= ~m;
-		val = val >> 1;
-	}
-	return 0;
-};
-
-/*******************************************************************************
- * Yealink key interface
- ******************************************************************************/
-
-/* Map device buttons to internal key events.
- *
- * USB-P1K button layout:
- *
- *             up
- *       IN           OUT
- *            down
- *
- *     pickup   C    hangup
- *       1      2      3
- *       4      5      6
- *       7      8      9
- *       *      0      #
- *
- * The "up" and "down" keys, are symbolised by arrows on the button.
- * The "pickup" and "hangup" keys are symbolised by a green and red phone
- * on the button.
- */
-static int map_p1k_to_key(int scancode)
-{
-	switch(scancode) {		/* phone key:	*/
-	case 0x23: return KEY_LEFT;	/*   IN		*/
-	case 0x33: return KEY_UP;	/*   up		*/
-	case 0x04: return KEY_RIGHT;	/*   OUT	*/
-	case 0x24: return KEY_DOWN;	/*   down	*/
-	case 0x03: return KEY_ENTER;	/*   pickup	*/
-	case 0x14: return KEY_BACKSPACE; /*  C		*/
-	case 0x13: return KEY_ESC;	/*   hangup	*/
-	case 0x00: return KEY_1;	/*   1		*/
-	case 0x01: return KEY_2;	/*   2 		*/
-	case 0x02: return KEY_3;	/*   3		*/
-	case 0x10: return KEY_4;	/*   4		*/
-	case 0x11: return KEY_5;	/*   5		*/
-	case 0x12: return KEY_6;	/*   6		*/
-	case 0x20: return KEY_7;	/*   7		*/
-	case 0x21: return KEY_8;	/*   8		*/
-	case 0x22: return KEY_9;	/*   9		*/
-	case 0x30: return KEY_KPASTERISK; /* *		*/
-	case 0x31: return KEY_0;	/*   0		*/
-	case 0x32: return KEY_LEFTSHIFT |
-			  KEY_3 << 8;	/*   #		*/
-	}
-	return -EINVAL;
-}
-
-/* Completes a request by converting the data into events for the
- * input subsystem.
- *
- * The key parameter can be cascaded: key2 << 8 | key1
- */
-static void report_key(struct yealink_dev *yld, int key)
-{
-	struct input_dev *idev = yld->idev;
-
-	if (yld->key_code >= 0) {
-		/* old key up */
-		input_report_key(idev, yld->key_code & 0xff, 0);
-		if (yld->key_code >> 8)
-			input_report_key(idev, yld->key_code >> 8, 0);
-	}
-
-	yld->key_code = key;
-	if (key >= 0) {
-		/* new valid key */
-		input_report_key(idev, key & 0xff, 1);
-		if (key >> 8)
-			input_report_key(idev, key >> 8, 1);
-	}
-	input_sync(idev);
-}
-
-/*******************************************************************************
- * Yealink usb communication interface
- ******************************************************************************/
-
-static int yealink_cmd(struct yealink_dev *yld, struct yld_ctl_packet *p)
-{
-	u8	*buf = (u8 *)p;
-	int	i;
-	u8	sum = 0;
-
-	for(i=0; i<USB_PKT_LEN-1; i++)
-		sum -= buf[i];
-	p->sum = sum;
-	return usb_control_msg(yld->udev,
-			usb_sndctrlpipe(yld->udev, 0),
-			USB_REQ_SET_CONFIGURATION,
-			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			0x200, 3,
-			p, sizeof(*p),
-			USB_CTRL_SET_TIMEOUT);
-}
-
-static u8 default_ringtone[] = {
-	0xEF,			/* volume [0-255] */
-	0xFB, 0x1E, 0x00, 0x0C,	/* 1250 [hz], 12/100 [s] */
-	0xFC, 0x18, 0x00, 0x0C,	/* 1000 [hz], 12/100 [s] */
-	0xFB, 0x1E, 0x00, 0x0C,
-	0xFC, 0x18, 0x00, 0x0C,
-	0xFB, 0x1E, 0x00, 0x0C,
-	0xFC, 0x18, 0x00, 0x0C,
-	0xFB, 0x1E, 0x00, 0x0C,
-	0xFC, 0x18, 0x00, 0x0C,
-	0xFF, 0xFF, 0x01, 0x90,	/* silent, 400/100 [s] */
-	0x00, 0x00		/* end of sequence */
-};
-
-static int yealink_set_ringtone(struct yealink_dev *yld, u8 *buf, size_t size)
-{
-	struct yld_ctl_packet *p = yld->ctl_data;
-	int	ix, len;
-
-	if (size <= 0)
-		return -EINVAL;
-
-	/* Set the ringtone volume */
-	memset(yld->ctl_data, 0, sizeof(*(yld->ctl_data)));
-	yld->ctl_data->cmd	= CMD_RING_VOLUME;
-	yld->ctl_data->size	= 1;
-	yld->ctl_data->data[0]	= buf[0];
-	yealink_cmd(yld, p);
-
-	buf++;
-	size--;
-
-	p->cmd = CMD_RING_NOTE;
-	ix = 0;
-	while (size != ix) {
-		len = size - ix;
-		if (len > sizeof(p->data))
-			len = sizeof(p->data);
-		p->size	  = len;
-		p->offset = cpu_to_be16(ix);
-		memcpy(p->data, &buf[ix], len);
-		yealink_cmd(yld, p);
-		ix += len;
-	}
-	return 0;
-}
-
-/* keep stat_master & stat_copy in sync.
- */
-static int yealink_do_idle_tasks(struct yealink_dev *yld)
-{
-	u8 val;
-	int i, ix, len;
-
-	ix = yld->stat_ix;
-
-	memset(yld->ctl_data, 0, sizeof(*(yld->ctl_data)));
-	yld->ctl_data->cmd  = CMD_KEYPRESS;
-	yld->ctl_data->size = 1;
-	yld->ctl_data->sum  = 0xff - CMD_KEYPRESS;
-
-	/* If state update pointer wraps do a KEYPRESS first. */
-	if (ix >= sizeof(yld->master)) {
-		yld->stat_ix = 0;
-		return 0;
-	}
-
-	/* find update candidates: copy != master */
-	do {
-		val = yld->master.b[ix];
-		if (val != yld->copy.b[ix])
-			goto send_update;
-	} while (++ix < sizeof(yld->master));
-
-	/* nothing todo, wait a bit and poll for a KEYPRESS */
-	yld->stat_ix = 0;
-	/* TODO how can we wait abit. ??
-	 * msleep_interruptible(1000 / YEALINK_POLLING_FREQUENCY);
-	 */
-	return 0;
-
-send_update:
-
-	/* Setup an appropriate update request */
-	yld->copy.b[ix] = val;
-	yld->ctl_data->data[0] = val;
-
-	switch(ix) {
-	case offsetof(struct yld_status, led):
-		yld->ctl_data->cmd	= CMD_LED;
-		yld->ctl_data->sum	= -1 - CMD_LED - val;
-		break;
-	case offsetof(struct yld_status, dialtone):
-		yld->ctl_data->cmd	= CMD_DIALTONE;
-		yld->ctl_data->sum	= -1 - CMD_DIALTONE - val;
-		break;
-	case offsetof(struct yld_status, ringtone):
-		yld->ctl_data->cmd	= CMD_RINGTONE;
-		yld->ctl_data->sum	= -1 - CMD_RINGTONE - val;
-		break;
-	case offsetof(struct yld_status, keynum):
-		val--;
-		val &= 0x1f;
-		yld->ctl_data->cmd	= CMD_SCANCODE;
-		yld->ctl_data->offset	= cpu_to_be16(val);
-		yld->ctl_data->data[0]	= 0;
-		yld->ctl_data->sum	= -1 - CMD_SCANCODE - val;
-		break;
-	default:
-		len = sizeof(yld->master.s.lcd) - ix;
-		if (len > sizeof(yld->ctl_data->data))
-			len = sizeof(yld->ctl_data->data);
-
-		/* Combine up to <len> consecutive LCD bytes in a single request
-		 */
-		yld->ctl_data->cmd	= CMD_LCD;
-		yld->ctl_data->offset	= cpu_to_be16(ix);
-		yld->ctl_data->size	= len;
-		yld->ctl_data->sum	= -CMD_LCD - ix - val - len;
-		for(i=1; i<len; i++) {
-			ix++;
-			val = yld->master.b[ix];
-			yld->copy.b[ix]		= val;
-			yld->ctl_data->data[i]	= val;
-			yld->ctl_data->sum     -= val;
-		}
-	}
-	yld->stat_ix = ix + 1;
-	return 1;
-}
-
-/* Decide on how to handle responses
- *
- * The state transition diagram is somethhing like:
- *
- *          syncState<--+
- *               |      |
- *               |    idle
- *              \|/     |
- * init --ok--> waitForKey --ok--> getKey
- *  ^               ^                |
- *  |               +-------ok-------+
- * error,start
- *
- */
-static void urb_irq_callback(struct urb *urb)
-{
-	struct yealink_dev *yld = urb->context;
-	int ret, status = urb->status;
-
-	if (status)
-		dev_err(&yld->intf->dev, "%s - urb status %d\n",
-			__func__, status);
-
-	switch (yld->irq_data->cmd) {
-	case CMD_KEYPRESS:
-
-		yld->master.s.keynum = yld->irq_data->data[0];
-		break;
-
-	case CMD_SCANCODE:
-		dev_dbg(&yld->intf->dev, "get scancode %x\n",
-			yld->irq_data->data[0]);
-
-		report_key(yld, map_p1k_to_key(yld->irq_data->data[0]));
-		break;
-
-	default:
-		dev_err(&yld->intf->dev, "unexpected response %x\n",
-			yld->irq_data->cmd);
-	}
-
-	yealink_do_idle_tasks(yld);
-
-	if (!yld->shutdown) {
-		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
-		if (ret && ret != -EPERM)
-			dev_err(&yld->intf->dev,
-				"%s - usb_submit_urb failed %d\n",
-				__func__, ret);
-	}
-}
-
-static void urb_ctl_callback(struct urb *urb)
-{
-	struct yealink_dev *yld = urb->context;
-	int ret = 0, status = urb->status;
-
-	if (status)
-		dev_err(&yld->intf->dev, "%s - urb status %d\n",
-			__func__, status);
-
-	switch (yld->ctl_data->cmd) {
-	case CMD_KEYPRESS:
-	case CMD_SCANCODE:
-		/* ask for a response */
-		if (!yld->shutdown)
-			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
-		break;
-	default:
-		/* send new command */
-		yealink_do_idle_tasks(yld);
-		if (!yld->shutdown)
-			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
-		break;
-	}
-
-	if (ret && ret != -EPERM)
-		dev_err(&yld->intf->dev, "%s - usb_submit_urb failed %d\n",
-			__func__, ret);
-}
-
-/*******************************************************************************
- * input event interface
- ******************************************************************************/
-
-/* TODO should we issue a ringtone on a SND_BELL event?
-static int input_ev(struct input_dev *dev, unsigned int type,
-		unsigned int code, int value)
-{
-
-	if (type != EV_SND)
-		return -EINVAL;
-
-	switch (code) {
-	case SND_BELL:
-	case SND_TONE:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-*/
-
-static int input_open(struct input_dev *dev)
-{
-	struct yealink_dev *yld = input_get_drvdata(dev);
-	int i, ret;
-
-	dev_dbg(&yld->intf->dev, "%s\n", __func__);
-
-	/* force updates to device */
-	for (i = 0; i<sizeof(yld->master); i++)
-		yld->copy.b[i] = ~yld->master.b[i];
-	yld->key_code = -1;	/* no keys pressed */
-
-        yealink_set_ringtone(yld, default_ringtone, sizeof(default_ringtone));
-
-	/* issue INIT */
-	memset(yld->ctl_data, 0, sizeof(*(yld->ctl_data)));
-	yld->ctl_data->cmd	= CMD_INIT;
-	yld->ctl_data->size	= 10;
-	yld->ctl_data->sum	= 0x100-CMD_INIT-10;
-	if ((ret = usb_submit_urb(yld->urb_ctl, GFP_KERNEL)) != 0) {
-		dev_dbg(&yld->intf->dev,
-			"%s - usb_submit_urb failed with result %d\n",
-			__func__, ret);
-		return ret;
-	}
-	return 0;
-}
-
-static void input_close(struct input_dev *dev)
-{
-	struct yealink_dev *yld = input_get_drvdata(dev);
-
-	yld->shutdown = 1;
-	/*
-	 * Make sure the flag is seen by other CPUs before we start
-	 * killing URBs so new URBs won't be submitted
-	 */
-	smp_wmb();
-
-	usb_kill_urb(yld->urb_ctl);
-	usb_kill_urb(yld->urb_irq);
-
-	yld->shutdown = 0;
-	smp_wmb();
-}
-
-/*******************************************************************************
- * sysfs interface
- ******************************************************************************/
-
-/* Interface to the 7-segments translation table aka. char set.
- */
-static ssize_t show_map(struct device *dev, struct device_attribute *attr,
-				char *buf)
-{
-	memcpy(buf, &map_seg7, sizeof(map_seg7));
-	return sizeof(map_seg7);
-}
-
-static ssize_t store_map(struct device *dev, struct device_attribute *attr,
-				const char *buf, size_t cnt)
-{
-	if (cnt != sizeof(map_seg7))
-		return -EINVAL;
-	memcpy(&map_seg7, buf, sizeof(map_seg7));
-	return sizeof(map_seg7);
-}
-
-/* Interface to the LCD.
- */
-
-/* Reading /sys/../lineX will return the format string with its settings:
- *
- * Example:
- * cat ./line3
- * 888888888888
- * Linux Rocks!
- */
-static ssize_t show_line(struct device *dev, char *buf, int a, int b)
-{
-	struct yealink_dev *yld = dev_get_drvdata(dev);
-	int i;
-
-	guard(mutex)(&yld->sysfs_mutex);
-
-	for (i = a; i < b; i++)
-		*buf++ = lcdMap[i].type;
-	*buf++ = '\n';
-	for (i = a; i < b; i++)
-		*buf++ = yld->lcdMap[i];
-	*buf++ = '\n';
-	*buf = 0;
-
-	return 3 + ((b - a) << 1);
-}
-
-static ssize_t show_line1(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	return show_line(dev, buf, LCD_LINE1_OFFSET, LCD_LINE2_OFFSET);
-}
-
-static ssize_t show_line2(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	return show_line(dev, buf, LCD_LINE2_OFFSET, LCD_LINE3_OFFSET);
-}
-
-static ssize_t show_line3(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	return show_line(dev, buf, LCD_LINE3_OFFSET, LCD_LINE4_OFFSET);
-}
-
-/* Writing to /sys/../lineX will set the corresponding LCD line.
- * - Excess characters are ignored.
- * - If less characters are written than allowed, the remaining digits are
- *   unchanged.
- * - The '\n' or '\t' char is a placeholder, it does not overwrite the
- *   original content.
- */
-static ssize_t store_line(struct device *dev, const char *buf, size_t count,
-		int el, size_t len)
-{
-	struct yealink_dev *yld = dev_get_drvdata(dev);
-	int i;
-
-	guard(mutex)(&yld->sysfs_mutex);
-
-	if (len > count)
-		len = count;
-	for (i = 0; i < len; i++)
-		setChar(yld, el++, buf[i]);
-
-	return count;
-}
-
-static ssize_t store_line1(struct device *dev, struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	return store_line(dev, buf, count, LCD_LINE1_OFFSET, LCD_LINE1_SIZE);
-}
-
-static ssize_t store_line2(struct device *dev, struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	return store_line(dev, buf, count, LCD_LINE2_OFFSET, LCD_LINE2_SIZE);
-}
-
-static ssize_t store_line3(struct device *dev, struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	return store_line(dev, buf, count, LCD_LINE3_OFFSET, LCD_LINE3_SIZE);
-}
-
-/* Interface to visible and audible "icons", these include:
- * pictures on the LCD, the LED, and the dialtone signal.
- */
-
-/* Get a list of "switchable elements" with their current state. */
-static ssize_t get_icons(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct yealink_dev *yld = dev_get_drvdata(dev);
-	int i, ret = 1;
-
-	guard(mutex)(&yld->sysfs_mutex);
-
-	for (i = 0; i < ARRAY_SIZE(lcdMap); i++) {
-		if (lcdMap[i].type != '.')
-			continue;
-		ret += sprintf(&buf[ret], "%s %s\n",
-				yld->lcdMap[i] == ' ' ? "  " : "on",
-				lcdMap[i].u.p.name);
-	}
-
-	return ret;
-}
-
-/* Change the visibility of a particular element. */
-static ssize_t set_icon(struct device *dev, const char *buf, size_t count,
-			int chr)
-{
-	struct yealink_dev *yld = dev_get_drvdata(dev);
-	int i;
-
-	guard(mutex)(&yld->sysfs_mutex);
-
-	for (i = 0; i < ARRAY_SIZE(lcdMap); i++) {
-		if (lcdMap[i].type != '.')
-			continue;
-		if (strncmp(buf, lcdMap[i].u.p.name, count) == 0) {
-			setChar(yld, i, chr);
-			break;
-		}
-	}
-
-	return count;
-}
-
-static ssize_t show_icon(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	return set_icon(dev, buf, count, buf[0]);
-}
-
-static ssize_t hide_icon(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	return set_icon(dev, buf, count, ' ');
-}
-
-/* Upload a ringtone to the device.
- */
-
-/* Stores raw ringtone data in the phone */
-static ssize_t store_ringtone(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct yealink_dev *yld = dev_get_drvdata(dev);
-
-	guard(mutex)(&yld->sysfs_mutex);
-
-	/* TODO locking with async usb control interface??? */
-	yealink_set_ringtone(yld, (char *)buf, count);
-
-	return count;
-}
-
-#define _M444	S_IRUGO
-#define _M664	S_IRUGO|S_IWUSR|S_IWGRP
-#define _M220	S_IWUSR|S_IWGRP
-
-static DEVICE_ATTR(map_seg7	, _M664, show_map	, store_map	);
-static DEVICE_ATTR(line1	, _M664, show_line1	, store_line1	);
-static DEVICE_ATTR(line2	, _M664, show_line2	, store_line2	);
-static DEVICE_ATTR(line3	, _M664, show_line3	, store_line3	);
-static DEVICE_ATTR(get_icons	, _M444, get_icons	, NULL		);
-static DEVICE_ATTR(show_icon	, _M220, NULL		, show_icon	);
-static DEVICE_ATTR(hide_icon	, _M220, NULL		, hide_icon	);
-static DEVICE_ATTR(ringtone	, _M220, NULL		, store_ringtone);
-
-static struct attribute *yld_attrs[] = {
-	&dev_attr_line1.attr,
-	&dev_attr_line2.attr,
-	&dev_attr_line3.attr,
-	&dev_attr_get_icons.attr,
-	&dev_attr_show_icon.attr,
-	&dev_attr_hide_icon.attr,
-	&dev_attr_map_seg7.attr,
-	&dev_attr_ringtone.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(yld);
-
-/*******************************************************************************
- * Linux interface and usb initialisation
- ******************************************************************************/
-
-struct driver_info {
-	char *name;
-};
-
-static const struct driver_info info_P1K = {
-	.name	= "Yealink usb-p1k",
-};
-
-static const struct usb_device_id usb_table [] = {
-	{
-		.match_flags		= USB_DEVICE_ID_MATCH_DEVICE |
-						USB_DEVICE_ID_MATCH_INT_INFO,
-		.idVendor		= 0x6993,
-		.idProduct		= 0xb001,
-		.bInterfaceClass	= USB_CLASS_HID,
-		.bInterfaceSubClass	= 0,
-		.bInterfaceProtocol	= 0,
-		.driver_info		= (kernel_ulong_t)&info_P1K
-	},
-	{ }
-};
-
-static int usb_cleanup(struct yealink_dev *yld, int err)
-{
-	if (yld == NULL)
-		return err;
-
-        if (yld->idev) {
-		if (err)
-			input_free_device(yld->idev);
-		else
-			input_unregister_device(yld->idev);
-	}
-
-	usb_free_urb(yld->urb_irq);
-	usb_free_urb(yld->urb_ctl);
-
-	kfree(yld->ctl_req);
-	usb_free_coherent(yld->udev, USB_PKT_LEN, yld->ctl_data, yld->ctl_dma);
-	usb_free_coherent(yld->udev, USB_PKT_LEN, yld->irq_data, yld->irq_dma);
-
-	kfree(yld);
-	return err;
-}
-
-static void usb_disconnect(struct usb_interface *intf)
-{
-	struct yealink_dev *yld = usb_get_intfdata(intf);
-
-	usb_cleanup(yld, 0);
-	usb_set_intfdata(intf, NULL);
-}
-
-static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
-{
-	struct usb_device *udev = interface_to_usbdev (intf);
-	struct driver_info *nfo = (struct driver_info *)id->driver_info;
-	struct usb_host_interface *interface;
-	struct usb_endpoint_descriptor *endpoint;
-	struct yealink_dev *yld;
-	struct input_dev *input_dev;
-	int ret, pipe, i;
-
-	interface = intf->cur_altsetting;
-
-	if (interface->desc.bNumEndpoints < 1)
-		return -ENODEV;
-
-	endpoint = &interface->endpoint[0].desc;
-	if (!usb_endpoint_is_int_in(endpoint))
-		return -ENODEV;
-
-	yld = kzalloc_obj(*yld);
-	if (!yld)
-		return -ENOMEM;
-
-	yld->udev = udev;
-	yld->intf = intf;
-	mutex_init(&yld->sysfs_mutex);
-
-	yld->idev = input_dev = input_allocate_device();
-	if (!input_dev)
-		return usb_cleanup(yld, -ENOMEM);
-
-	/* allocate usb buffers */
-	yld->irq_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_KERNEL, &yld->irq_dma);
-	if (yld->irq_data == NULL)
-		return usb_cleanup(yld, -ENOMEM);
-
-	yld->ctl_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_KERNEL, &yld->ctl_dma);
-	if (!yld->ctl_data)
-		return usb_cleanup(yld, -ENOMEM);
-
-	yld->ctl_req = kmalloc_obj(*(yld->ctl_req));
-	if (yld->ctl_req == NULL)
-		return usb_cleanup(yld, -ENOMEM);
-
-	/* allocate urb structures */
-	yld->urb_irq = usb_alloc_urb(0, GFP_KERNEL);
-        if (yld->urb_irq == NULL)
-		return usb_cleanup(yld, -ENOMEM);
-
-	yld->urb_ctl = usb_alloc_urb(0, GFP_KERNEL);
-        if (yld->urb_ctl == NULL)
-		return usb_cleanup(yld, -ENOMEM);
-
-	/* get a handle to the interrupt data pipe */
-	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	ret = usb_maxpacket(udev, pipe);
-	if (ret != USB_PKT_LEN)
-		dev_err(&intf->dev, "invalid payload size %d, expected %zd\n",
-			ret, USB_PKT_LEN);
-
-	/* initialise irq urb */
-	usb_fill_int_urb(yld->urb_irq, udev, pipe, yld->irq_data,
-			USB_PKT_LEN,
-			urb_irq_callback,
-			yld, endpoint->bInterval);
-	yld->urb_irq->transfer_dma = yld->irq_dma;
-	yld->urb_irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-	yld->urb_irq->dev = udev;
-
-	/* initialise ctl urb */
-	yld->ctl_req->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE |
-				      USB_DIR_OUT;
-	yld->ctl_req->bRequest	= USB_REQ_SET_CONFIGURATION;
-	yld->ctl_req->wValue	= cpu_to_le16(0x200);
-	yld->ctl_req->wIndex	= cpu_to_le16(interface->desc.bInterfaceNumber);
-	yld->ctl_req->wLength	= cpu_to_le16(USB_PKT_LEN);
-
-	usb_fill_control_urb(yld->urb_ctl, udev, usb_sndctrlpipe(udev, 0),
-			(void *)yld->ctl_req, yld->ctl_data, USB_PKT_LEN,
-			urb_ctl_callback, yld);
-	yld->urb_ctl->transfer_dma	= yld->ctl_dma;
-	yld->urb_ctl->transfer_flags	|= URB_NO_TRANSFER_DMA_MAP;
-	yld->urb_ctl->dev = udev;
-
-	/* find out the physical bus location */
-	usb_make_path(udev, yld->phys, sizeof(yld->phys));
-	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
-
-	/* register settings for the input device */
-	input_dev->name = nfo->name;
-	input_dev->phys = yld->phys;
-	usb_to_input_id(udev, &input_dev->id);
-	input_dev->dev.parent = &intf->dev;
-
-	input_set_drvdata(input_dev, yld);
-
-	input_dev->open = input_open;
-	input_dev->close = input_close;
-	/* input_dev->event = input_ev;	TODO */
-
-	/* register available key events */
-	input_dev->evbit[0] = BIT_MASK(EV_KEY);
-	for (i = 0; i < 256; i++) {
-		int k = map_p1k_to_key(i);
-		if (k >= 0) {
-			set_bit(k & 0xff, input_dev->keybit);
-			if (k >> 8)
-				set_bit(k >> 8, input_dev->keybit);
-		}
-	}
-
-	ret = input_register_device(yld->idev);
-	if (ret)
-		return usb_cleanup(yld, ret);
-
-	usb_set_intfdata(intf, yld);
-
-	/* clear visible elements */
-	for (i = 0; i < ARRAY_SIZE(lcdMap); i++)
-		setChar(yld, i, ' ');
-
-	/* display driver version on LCD line 3 */
-	store_line3(&intf->dev, NULL,
-			DRIVER_VERSION, sizeof(DRIVER_VERSION));
-
-	return 0;
-}
-
-static struct usb_driver yealink_driver = {
-	.name		= "yealink",
-	.probe		= usb_probe,
-	.disconnect	= usb_disconnect,
-	.id_table	= usb_table,
-	.dev_groups	= yld_groups,
-};
-
-module_usb_driver(yealink_driver);
-
-MODULE_DEVICE_TABLE (usb, usb_table);
-
-MODULE_AUTHOR("Henk Vergonet");
-MODULE_DESCRIPTION("Yealink phone driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/yealink.h b/drivers/input/misc/yealink.h
deleted file mode 100644
index 69f700431f2f..000000000000
--- a/drivers/input/misc/yealink.h
+++ /dev/null
@@ -1,206 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * drivers/usb/input/yealink.h
- *
- * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
- */
-#ifndef INPUT_YEALINK_H
-#define INPUT_YEALINK_H
-
-/* Using the control channel on interface 3 various aspects of the phone
- * can be controlled like LCD, LED, dialtone and the ringtone.
- */
-
-struct yld_ctl_packet {
-	u8	cmd;		/* command code, see below */
-	u8	size;		/* 1-11, size of used data bytes. */
-	__be16	offset;		/* internal packet offset */
-	u8	data[11];
-	s8	sum;		/* negative sum of 15 preceding bytes */
-} __attribute__ ((packed));
-
-#define USB_PKT_LEN	sizeof(struct yld_ctl_packet)
-
-/* The following yld_ctl_packet's are available: */
-
-/* Init registers
- *
- * cmd		0x8e
- * size		10
- * offset	0
- * data		0,0,0,0....
- */
-#define CMD_INIT		0x8e
-
-/* Request key scan
- *
- * cmd		0x80
- * size		1
- * offset	0
- * data[0]	on return returns the key number, if it changes there's a new
- * 		key pressed.
- */
-#define CMD_KEYPRESS		0x80
-
-/* Request scancode
- *
- * cmd		0x81
- * size		1
- * offset	key number [0-1f]
- * data[0]	on return returns the scancode
- */
-#define CMD_SCANCODE		0x81
-
-/* Set LCD
- *
- * cmd		0x04
- * size		1-11
- * offset	0-23
- * data		segment bits
- */
-#define CMD_LCD			0x04
-
-/* Set led
- *
- * cmd		0x05
- * size		1
- * offset	0
- * data[0]	0 OFF / 1 ON
- */
-#define CMD_LED			0x05
-
-/* Set ringtone volume
- *
- * cmd		0x11
- * size		1
- * offset	0
- * data[0]	0-0xff  volume
- */
-#define CMD_RING_VOLUME		0x11
-
-/* Set ringtone notes
- *
- * cmd		0x02
- * size		1-11
- * offset	0->
- * data		binary representation LE16(-freq), LE16(duration) ....
- */
-#define CMD_RING_NOTE		0x02
-
-/* Sound ringtone via the speaker on the back
- *
- * cmd		0x03
- * size		1
- * offset	0
- * data[0]	0 OFF / 0x24 ON
- */
-#define CMD_RINGTONE		0x03
-
-/* Sound dial tone via the ear speaker
- *
- * cmd		0x09
- * size		1
- * offset	0
- * data[0]	0 OFF / 1 ON
- */
-#define CMD_DIALTONE		0x09
-
-#endif /* INPUT_YEALINK_H */
-
-
-#if defined(_SEG) && defined(_PIC)
-/* This table maps the LCD segments onto individual bit positions in the
- * yld_status struct.
- */
-
-/* LCD, each segment must be driven separately.
- *
- * Layout:
- *
- *   |[]   [][]   [][]   [][]   in   |[][]
- *   |[] M [][] D [][] : [][]   out  |[][]
- *                             store
- *
- *    NEW REP         SU MO TU WE TH FR SA
- *
- *    [] [] [] [] [] [] [] [] [] [] [] []
- *    [] [] [] [] [] [] [] [] [] [] [] []
- */
-
-/* Line 1
- *	Format		: 18.e8.M8.88...188
- *	Icon names	: M D : IN OUT STORE
- */
-#define LCD_LINE1_OFFSET	0
-#define LCD_LINE1_SIZE		17
-
-/* Note: first g then f =>			       !      !      */
-/* _SEG(    type    a      b      c      d      e      g      f   )  */
-	_SEG('1',  0,0 , 22,2 , 22,2 ,  0,0 ,  0,0 ,  0,0 ,  0,0	),
-	_SEG('8', 20,1 , 20,2 , 20,4 , 20,8 , 21,4 , 21,2 , 21,1	),
-	_PIC('.', 22,1 , "M"						),
-	_SEG('e', 18,1 , 18,2 , 18,4 , 18,1 , 19,2 , 18,1 , 19,1	),
-	_SEG('8', 16,1 , 16,2 , 16,4 , 16,8 , 17,4 , 17,2 , 17,1	),
-	_PIC('.', 15,8 , "D"						),
-	_SEG('M', 14,1 , 14,2 , 14,4 , 14,1 , 15,4 , 15,2 , 15,1	),
-	_SEG('8', 12,1 , 12,2 , 12,4 , 12,8 , 13,4 , 13,2 , 13,1	),
-	_PIC('.', 11,8 , ":"						),
-	_SEG('8', 10,1 , 10,2 , 10,4 , 10,8 , 11,4 , 11,2 , 11,1	),
-	_SEG('8',  8,1 ,  8,2 ,  8,4 ,  8,8 ,  9,4 ,  9,2 ,  9,1	),
-	_PIC('.',  7,1 , "IN"						),
-	_PIC('.',  7,2 , "OUT"						),
-	_PIC('.',  7,4 , "STORE"					),
-	_SEG('1',  0,0 ,  5,1 ,  5,1 ,  0,0 ,  0,0 ,  0,0 ,  0,0	),
-	_SEG('8',  4,1 ,  4,2 ,  4,4 ,  4,8 ,  5,8 ,  5,4 ,  5,2	),
-	_SEG('8',  2,1 ,  2,2 ,  2,4 ,  2,8 ,  3,4 ,  3,2 ,  3,1	),
-
-/* Line 2
- *	Format		: .........
- *	Pict. name	: NEW REP SU MO TU WE TH FR SA
- */
-#define LCD_LINE2_OFFSET	LCD_LINE1_OFFSET + LCD_LINE1_SIZE
-#define LCD_LINE2_SIZE		9
-
-	_PIC('.', 23,2 , "NEW"	),
-	_PIC('.', 23,4 , "REP"	),
-	_PIC('.',  1,8 , "SU"	),
-	_PIC('.',  1,4 , "MO"	),
-	_PIC('.',  1,2 , "TU"	),
-	_PIC('.',  1,1 , "WE"	),
-	_PIC('.',  0,1 , "TH"	),
-	_PIC('.',  0,2 , "FR"	),
-	_PIC('.',  0,4 , "SA"	),
-
-/* Line 3
- *	Format		: 888888888888
- */
-#define LCD_LINE3_OFFSET	LCD_LINE2_OFFSET + LCD_LINE2_SIZE
-#define LCD_LINE3_SIZE		12
-
-	_SEG('8', 22,16, 22,32, 22,64, 22,128, 23,128, 23,64, 23,32  ),
-	_SEG('8', 20,16, 20,32, 20,64, 20,128, 21,128, 21,64, 21,32  ),
-	_SEG('8', 18,16, 18,32, 18,64, 18,128, 19,128, 19,64, 19,32  ),
-	_SEG('8', 16,16, 16,32, 16,64, 16,128, 17,128, 17,64, 17,32  ),
-	_SEG('8', 14,16, 14,32, 14,64, 14,128, 15,128, 15,64, 15,32  ),
-	_SEG('8', 12,16, 12,32, 12,64, 12,128, 13,128, 13,64, 13,32  ),
-	_SEG('8', 10,16, 10,32, 10,64, 10,128, 11,128, 11,64, 11,32  ),
-	_SEG('8',  8,16,  8,32,  8,64,  8,128,  9,128,  9,64,  9,32  ),
-	_SEG('8',  6,16,  6,32,  6,64,  6,128,  7,128,  7,64,  7,32  ),
-	_SEG('8',  4,16,  4,32,  4,64,  4,128,  5,128,  5,64,  5,32  ),
-	_SEG('8',  2,16,  2,32,  2,64,  2,128,  3,128,  3,64,  3,32  ),
-	_SEG('8',  0,16,  0,32,  0,64,  0,128,  1,128,  1,64,  1,32  ),
-
-/* Line 4
- *
- * The LED, DIALTONE and RINGTONE are implemented as icons and use the same
- * sysfs interface.
- */
-#define LCD_LINE4_OFFSET	LCD_LINE3_OFFSET + LCD_LINE3_SIZE
-
-	_PIC('.', offsetof(struct yld_status, led)	, 0x01, "LED" ),
-	_PIC('.', offsetof(struct yld_status, dialtone) , 0x01, "DIALTONE" ),
-	_PIC('.', offsetof(struct yld_status, ringtone) , 0x24, "RINGTONE" ),
-
-#undef _SEG
-#undef _PIC
-#endif /* _SEG && _PIC */
-- 
2.56.0.567.gdb80ae8cd5-goog



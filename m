Return-Path: <skrishnakar@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 72D79B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 01:03:38 +1100 (EST)
Received: by wyb32 with SMTP id 32so4974500wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 07:03:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <24020.1286940298@neuling.org>
References: <AANLkTikVdVkej7LNKXjrcNH2t2rJL=O=NhBDnw3j6N1v@mail.gmail.com>
	<24020.1286940298@neuling.org>
Date: Thu, 14 Oct 2010 19:33:35 +0530
Message-ID: <AANLkTi=8rUBg5DK0mz5ci9VbtkUzFMWQXm4rYceSkMmO@mail.gmail.com>
Subject: Re: RTC rtc-cmos.c : Fix warning on PowerPC
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 8435e5876fc3d629406c63b85bff82c25fc4bf75 Mon Sep 17 00:00:00 2001
From: Srikanth Krishnakar <skrishna@mvista.com>
Date: Fri, 8 Oct 2010 18:07:06 +0530
Subject: [PATCH] RTC: rtc-cmos.c: Fix warning on PowerPC

The following warning is seen while compilation of PowerPC kernel:

 CC      drivers/rtc/rtc-cmos.o
drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes
of RTC+NVRAM address space, not 64 bytes.

Fix it by adding defined(__powerpc__).

Signed-off-by: Srikanth Krishnakar <skrishna@mvista.com>
---
 drivers/rtc/rtc-cmos.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 5856167..7e6ce62 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -687,7 +687,8 @@ cmos_do_probe(struct device *dev, struct resource
*ports, int rtc_irq)
 #if    defined(CONFIG_ATARI)
        address_space = 64;
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
-                       || defined(__sparc__) || defined(__mips__)
+                       || defined(__sparc__) || defined(__mips__) \
+                       || defined(__powerpc__)
        address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
-- 
1.6.3.3.333.gdf68

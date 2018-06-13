Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f178.google.com (mail-ot0-f178.google.com
 [74.125.82.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415dWs0GnSzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 06:24:24 +1000 (AEST)
Received: by mail-ot0-f178.google.com with SMTP id c15-v6so4503435otl.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 13:24:24 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Jun 2018 22:24:10 +0200
Message-ID: <CA+7wUswNnhB3=_Z0cbeAzDrcHZr=xg_nE5uUZuPXEk2RKNaABA@mail.gmail.com>
Subject: powerpc: use time64_t in read_persistent_clock
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd,

In 5bfd643583b2e I can see that you changed:

$ git show 5bfd643583b2e -- arch/powerpc/platforms/powermac/time.c
[...]
 #ifdef CONFIG_ADB_PMU
-static unsigned long pmu_get_time(void)
+static time64_t pmu_get_time(void)
 {
        struct adb_request req;
-       unsigned int now;
+       time64_t now;

        if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
                return 0;
@@ -160,10 +151,10 @@ static unsigned long pmu_get_time(void)
                       req.reply_len);
        now = (req.reply[0] << 24) + (req.reply[1] << 16)
                + (req.reply[2] << 8) + req.reply[3];
-       return ((unsigned long)now) - RTC_OFFSET;
+       return now - RTC_OFFSET;
 }
[...]

As far as I can tell the old function would never return a negative
value and rely on unsigned long roll over. Now I am seeing negative
value being returned and it seems to break later on in the rtc
library.

Could you comment why you removed the cast to (unsigned long) in your commit ?

Thanks

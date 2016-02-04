Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6FEA1A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 08:00:52 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id w123so56079061pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 13:00:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Amitkumar Karwar <akarwar@marvell.com>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Kalle Valo <kvalo@codeaurora.org>, Steve French <sfrench@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] lib: add "on" and "off" to strtobool
Date: Thu,  4 Feb 2016 13:00:39 -0800
Message-Id: <1454619643-14444-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This consolidates logic for handling "on"/"off" parsing for bools into
the strtobool function, by way of moving it into kstrtobool (with helpers),
and updating various callers.

 arch/powerpc/kernel/rtasd.c                    |    9 ---
 arch/powerpc/platforms/pseries/hotplug-cpu.c   |   10 ----
 arch/s390/kernel/time.c                        |    8 ---
 arch/s390/kernel/topology.c                    |    7 ---
 arch/x86/kernel/aperture_64.c                  |   12 -----
 drivers/net/wireless/marvell/mwifiex/debugfs.c |   10 +---
 fs/cifs/cifs_debug.c                           |   58 ++++++-------------------
 fs/cifs/cifs_debug.h                           |    2 
 fs/cifs/cifsfs.c                               |    6 +-
 fs/cifs/cifsglob.h                             |    4 -
 include/linux/kernel.h                         |    3 +
 include/linux/string.h                         |    6 ++
 include/linux/tick.h                           |    2 
 kernel/time/hrtimer.c                          |   10 ----
 kernel/time/tick-sched.c                       |   10 ----
 lib/kstrtox.c                                  |   49 +++++++++++++++++++++
 lib/string.c                                   |   29 ------------
 17 files changed, 98 insertions(+), 137 deletions(-)

-Kees

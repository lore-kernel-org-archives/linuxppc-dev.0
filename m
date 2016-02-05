Return-Path: <keescook@chromium.org>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 860C51A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 08:12:56 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id yy13so39861693pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 13:12:56 -0800 (PST)
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
Subject: [PATCH v3 0/4] lib: add "on" and "off" to strtobool
Date: Fri,  5 Feb 2016 13:12:45 -0800
Message-Id: <1454706769-8729-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This consolidates logic for handling "on"/"off" parsing for bools into the
strtobool function, by way of moving it into kstrtobool (with helpers),
and updating various callers.

v3:
- removed unused "base" argument
- fixed missing description change
- retained inverted __setup return values
- removed needless extra buffer in cifs

v2:
- moved to kstroto* style

 arch/powerpc/kernel/rtasd.c                    |    7 --
 arch/powerpc/platforms/pseries/hotplug-cpu.c   |   10 ---
 arch/s390/kernel/time.c                        |    8 ---
 arch/s390/kernel/topology.c                    |    7 --
 arch/x86/kernel/aperture_64.c                  |   12 ----
 drivers/net/wireless/marvell/mwifiex/debugfs.c |   10 +--
 fs/cifs/cifs_debug.c                           |   56 +++++----------------
 fs/cifs/cifs_debug.h                           |    2 
 fs/cifs/cifsfs.c                               |    6 +-
 fs/cifs/cifsglob.h                             |    4 -
 include/linux/kernel.h                         |    2 
 include/linux/string.h                         |    6 +-
 include/linux/tick.h                           |    2 
 kernel/time/hrtimer.c                          |   10 ---
 kernel/time/tick-sched.c                       |   10 ---
 lib/kstrtox.c                                  |   64 +++++++++++++++++++++++++
 lib/string.c                                   |   29 -----------
 17 files changed, 110 insertions(+), 135 deletions(-)

-Kees

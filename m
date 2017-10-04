Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6sX24ppYzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 10:28:02 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id d2so3846355pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 16:28:02 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Harish Patil <harish.patil@cavium.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 John Stultz <john.stultz@linaro.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>,
 Kalle Valo <kvalo@qca.qualcomm.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <len.brown@intel.com>,
 Manish Chopra <manish.chopra@cavium.com>,
 Mark Gross <mark.gross@intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>,
 netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
 Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Ralf Baechle <ralf@linux-mips.org>, Sebastian Reichel <sre@kernel.org>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tejun Heo <tj@kernel.org>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
 linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] timer: Remove unused static initializer macros
Date: Wed,  4 Oct 2017 16:27:02 -0700
Message-Id: <1507159627-127660-9-git-send-email-keescook@chromium.org>
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the now unused TIMER_*INITIALIZER macros:

TIMER_INITIALIZER
TIMER_PINNED_INITIALIZER
TIMER_DEFERRED_INITIALIZER
TIMER_PINNED_DEFERRED_INITIALIZER

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/timer.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4f7476e4a727..a33220311361 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -73,18 +73,6 @@ struct timer_list {
 			__FILE__ ":" __stringify(__LINE__))	\
 	}
 
-#define TIMER_INITIALIZER(_function, _expires, _data)		\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), 0)
-
-#define TIMER_PINNED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_PINNED)
-
-#define TIMER_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE)
-
-#define TIMER_PINNED_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE | TIMER_PINNED)
-
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
 	struct timer_list _name =				\
 		__TIMER_INITIALIZER(_function, _expires, _data, 0)
-- 
2.7.4

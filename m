Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 40F1FDDEE3
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Feb 2009 06:06:53 +1100 (EST)
Date: Sat, 31 Jan 2009 22:06:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] ftrace: On PowerPC we don't need frame pointers for
	CALLER_ADDRs
Message-ID: <20090131190650.GA4284@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to this discussion:

http://lkml.org/lkml/2008/7/25/338
http://lkml.org/lkml/2008/7/26/72

Frame pointers do nothing useful on PowerPC, so lib/Kconfig.debug
makes CONFIG_FRAME_POINTER unselectable on PPC targets. But ftrace.h
requires CONFIG_FRAME_POINTER for CALLER_ADDR macros. Therefore
tracing is completely useless on PowerPC:

[...]
  <idle>-0       0X.h3    2us+:      0:140:R   + [000]  1733:120:S mvtsd
  <idle>-0       0X.h3    9us+: 0 (0)
  <idle>-0       0X..3   72us : 0 (0)
  <idle>-0       0X..3   73us :      0:140:R ==> [000]  1733:120:R mvtsd

On PPC we can safely use __builtin_return_address(1..6) w/o frame
pointers, and with this patch the trace output looks OK:

[...]
  <idle>-0       0X.h3    2us+:      0:140:R   + [000]  1740:120:S mvtsd
  <idle>-0       0X.h3    9us+: hrtimer_wakeup (__run_hrtimer)
  <idle>-0       0X..3   87us : cpu_idle (__got2_end)
  <idle>-0       0X..3   89us :      0:140:R ==> [000]  1740:120:R mvtsd

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Btw, on PowerPC tracing is also broken w/o "ring-buffer: fix alignment
problem" patch (currently collecting dust in the -tip tree, commit
082605de5f82eb692cc90f7fda071cc01bb5ac34). Any chance the fix go into
Linus' tree, to not waste other people's time bisecting and debugging
the problem? ;-)

For google: tracing, regression, "ring-buffer: move some metadata
into buffer page", commit abc9b56d66fbd4d93302ef4bf6fa726e1b8255f9,
answer is here.

 include/linux/ftrace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9c5bc6b..13eba02 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -146,7 +146,7 @@ static inline void __ftrace_enabled_restore(int enabled)
 #endif
 }
 
-#ifdef CONFIG_FRAME_POINTER
+#if defined(CONFIG_FRAME_POINTER) || defined(CONFIG_PPC)
 /* TODO: need to fix this for ARM */
 # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
 # define CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
-- 
1.5.6.5

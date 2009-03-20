Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 45E40DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 03:44:06 +1100 (EST)
Date: Fri, 20 Mar 2009 19:44:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v4 0/3] Tracers vs. CALLER_ADDR on PowerPC
Message-ID: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here is another approach to fixing tracers vs. CALLER_ADDR problem
on PowerPC.

Preface for those who don't know or forgot what the problem is:

Gcc frame pointers do nothing useful on PowerPC (they're harmful,
actually), and thus lib/Kconfig.debug makes CONFIG_FRAME_POINTER
unselectable on PPC targets, but CALLER_ADDR macros are available
only with CONFIG_FRAME_POINTER, therefore tracing is completely
useless on PowerPC:

[...]
  <idle>-0       0X.h3    2us+:      0:140:R   + [000]  1733:120:S mvtsd
  <idle>-0       0X.h3    9us+: 0 (0)
  <idle>-0       0X..3   72us : 0 (0)
  <idle>-0       0X..3   73us :      0:140:R ==> [000]  1733:120:R mvtsd

While it should look like this:

[...]
  <idle>-0       0X.h3    2us+:      0:140:R   + [000]  1740:120:S mvtsd
  <idle>-0       0X.h3    9us+: hrtimer_wakeup (__run_hrtimer)
  <idle>-0       0X..3   87us : cpu_idle (__got2_end)
  <idle>-0       0X..3   89us :      0:140:R ==> [000]  1740:120:R mvtsd

I've tried to fix the issue via expanding the #ifdef in the ftrace.h:
http://lkml.org/lkml/2009/1/31/141

Then Steven Rostedt suggested to implement something more generic,
i.e. HAVE_NORMAL_FRAME_POINTERS Kconfig symbol.

I found a way to solve the problem w/o additional symbols, but
with some Makefile magic (http://lkml.org/lkml/2009/2/4/273).
But because of top-level Makefile issues on other arches
(http://lkml.org/lkml/2009/2/14/89) I had to abandon the approach.


So, this patch set combines Steven Rostedt's idea and a small
Makefile change, so that now only top-level Makefile has to know
about the new symbol, and the rest of the kernel can stay with
using CONFIG_FRAME_POINTER.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

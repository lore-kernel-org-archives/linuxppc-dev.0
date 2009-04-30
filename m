Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDEA7DDF7E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 05:41:12 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/6] Add new INIT_TASK_DATA() linker script macro.
Date: Thu, 30 Apr 2009 15:32:34 -0400
Message-Id: <1241119956-31453-5-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241119956-31453-4-git-send-email-tabbott@mit.edu>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu>
	<1241119956-31453-2-git-send-email-tabbott@mit.edu>
	<1241119956-31453-3-git-send-email-tabbott@mit.edu>
	<1241119956-31453-4-git-send-email-tabbott@mit.edu>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Greg Ungerer <gerg@uclinux.org>, Jeff Arnold <jbarnold@mit.edu>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, Waseem Daher <wdaher@mit.edu>,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	microblaze-uclinux@itee.uq.edu.au,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jeff Dike <jdike@addtoit.com>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>,
	Tony Luck <tony.luck@intel.com>, Tim Abbott <tabbott@mit.edu>,
	Cyrill Gorcunov <gorcunov@openvz.org>, Michal Simek <monstr@monstr.eu>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Ralf Baechle <ralf@linux-mips.org>, Anders Kaseorg <andersk@mit.edu>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is preparation for replacing most ".data.init_task" in the
kernel with macros, so that the section name can later be changed
without having to touch a lot of the kernel.

The long-term goal here is to be able to change the kernel's magic
section names to those that are compatible with -ffunction-sections
-fdata-sections.  This requires renaming all magic sections with names
of the form ".data.foo".

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-generic/vmlinux.lds.h |    4 ++++
 include/linux/init_task.h         |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa7801b..4b020e8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -135,6 +135,10 @@
 	. = ALIGN(alignment);						\
 	*(.data.cacheline_aligned)
 
+#define INIT_TASK_DATA(alignment)					\
+	. = ALIGN(alignment);						\
+	*(.data.init_task)
+
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index d87247d..e555baa 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -184,5 +184,8 @@ extern struct cred init_cred;
 	LIST_HEAD_INIT(cpu_timers[2]),					\
 }
 
+/* Attach to the init_task data structure for proper alignment */
+#define __init_task_data __attribute__((__section__(".data.init_task")))
+
 
 #endif
-- 
1.6.2.1

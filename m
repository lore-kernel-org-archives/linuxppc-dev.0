Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 664D4DDF7E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 05:58:15 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 6/6] Add support for __read_mostly to linux/cache.h
Date: Thu, 30 Apr 2009 15:54:13 -0400
Message-Id: <1241121253-32341-7-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241121253-32341-6-git-send-email-tabbott@mit.edu>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
	<1241121253-32341-3-git-send-email-tabbott@mit.edu>
	<1241121253-32341-4-git-send-email-tabbott@mit.edu>
	<1241121253-32341-5-git-send-email-tabbott@mit.edu>
	<1241121253-32341-6-git-send-email-tabbott@mit.edu>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Greg Ungerer <gerg@uclinux.org>, Jeff Arnold <jbarnold@mit.edu>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Waseem Daher <wdaher@mit.edu>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	microblaze-uclinux@itee.uq.edu.au,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jeff Dike <jdike@addtoit.com>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Tim Abbott <tabbott@mit.edu>,
	Cyrill Gorcunov <gorcunov@openvz.org>, Michal Simek <monstr@monstr.eu>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
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

Signed-off-by: Tim Abbott <tabbott@mit.edu>
---
 include/linux/cache.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 97e2488..99d8a6f 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -13,7 +13,13 @@
 #endif
 
 #ifndef __read_mostly
+#ifdef CONFIG_HAVE_READ_MOSTLY_DATA
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#define __READ_MOSTLY .section ".data.read_mostly", "aw"
+#else
 #define __read_mostly
+#define __READ_MOSTLY
+#endif /* CONFIG_HAVE_READ_MOSTLY_DATA */
 #endif
 
 #ifndef ____cacheline_aligned
-- 
1.6.2.1

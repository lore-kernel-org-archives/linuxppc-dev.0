Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id D7B4F68AA6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2006 22:34:41 +1100 (EST)
Date: Wed, 25 Jan 2006 20:34:46 +0900
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] fix warning on test_ti_thread_flag()
Message-ID: <20060125113446.GF18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the arechitecture is
- BITS_PER_LONG == 64
- struct thread_info.flag 32 is bits
- second argument of test_bit() was void *

Then compiler print error message on test_ti_thread_flags()
in include/linux/thread_info.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/thread_info.h
===================================================================
--- 2.6-git.orig/include/linux/thread_info.h	2006-01-25 19:07:12.000000000 +0900
+++ 2.6-git/include/linux/thread_info.h	2006-01-25 19:14:26.000000000 +0900
@@ -49,7 +49,7 @@
 
 static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 {
-	return test_bit(flag,&ti->flags);
+	return test_bit(flag, (void *)&ti->flags);
 }
 
 #define set_thread_flag(flag) \

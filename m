Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id E9132681BD
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 12:27:38 +1100 (EST)
Date: Fri, 3 Feb 2006 10:27:35 +0900
To: Rune Torgersen <runet@innovsys.com>
Subject: [PATCH] fix generic_fls64()
Message-ID: <20060203012735.GA21567@miraclelinux.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Stephen Hemminger <shemminger@osdl.org>,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Noticed by Rune Torgersen.

fix generic_fls64().
tcp_cubic is using fls64().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/bitops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/bitops.h
===================================================================
--- 2.6-git.orig/include/linux/bitops.h
+++ 2.6-git/include/linux/bitops.h
@@ -81,7 +81,7 @@ static inline int generic_fls64(__u64 x)
 {
 	__u32 h = x >> 32;
 	if (h)
-		return fls(x) + 32;
+		return fls(h) + 32;
 	return fls(x);
 }
 

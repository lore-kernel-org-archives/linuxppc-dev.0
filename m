Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4B106B7155
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:24:12 +1000 (EST)
Date: Fri, 3 Sep 2010 13:24:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
	related)
Message-Id: <20100903132410.ede593ed.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the final tree, today's linux-next build
(powerpc64 allnoconfig) failed like this:

arch/powerpc/kernel/built-in.o: In function `.sys_call_table':
(.text+0x8d48): undefined reference to `.compat_sys_recv'

Caused by commit 86250b9d12caa1a3dee12a7cf638b7dd70eaadb6 ("powerpc: Wire
up direct socket system calls").

I have applied this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 3 Sep 2010 13:19:04 +1000
Subject: [PATCH] powerpc: define a compat_sys_recv cond_syscall

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sys_ni.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bad369e..c782fe9 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -50,6 +50,7 @@ cond_syscall(compat_sys_sendmsg);
 cond_syscall(sys_recvmsg);
 cond_syscall(sys_recvmmsg);
 cond_syscall(compat_sys_recvmsg);
+cond_syscall(compat_sys_recv);
 cond_syscall(compat_sys_recvfrom);
 cond_syscall(compat_sys_recvmmsg);
 cond_syscall(sys_socketcall);
-- 
1.7.1


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

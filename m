Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F111FB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 17:05:21 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o8H70jTv020321
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 17:00:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8H75K4j2277514
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 17:05:20 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8H75IPU030618
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 17:05:20 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: define a compat_sys_recv cond_syscall
Date: Fri, 17 Sep 2010 17:05:03 +1000
Message-Id: <1284707103-4097-1-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <20100903132410.ede593ed.sfr@canb.auug.org.au>
References: <20100903132410.ede593ed.sfr@canb.auug.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Since compat_sys_recv is an optionl syscall if the kernel is compiled
without networking we need a cond_syscall defined for it since it is now
wired up directly on PowerPC.

Other architectures that wire up the socket calls directly as syscalls
do not run into this issue either because they don't have to deal with
the 32bit compat versions of the syscalls or just don't wire up that
particular compat syscall directly.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
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

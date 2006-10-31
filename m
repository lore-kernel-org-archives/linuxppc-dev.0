Return-Path: <hugh_dickins@symantec.com>
Received: from excu-mxob-2.symantec.com (excu-mxob-2.symantec.com
	[198.6.49.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "excu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8278167B9B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 06:49:16 +1100 (EST)
Received: from excu-mxob-1.symantec.com (excu-mxob-1.symantec.com
	[198.6.49.12])
	by excu-mxob-2.symantec.com (8.13.7/8.13.7) with ESMTP id
	k9VIfibb018376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 10:41:45 -0800
Date: Tue, 31 Oct 2006 18:41:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/5] ppc64: make mmiowb's io_sync preempt safe
In-Reply-To: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0610311840450.26470@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If mmiowb() is always used prior to releasing spinlock as Doc suggests,
then it's safe against preemption; but I'm not convinced that's always
the case.  If preemption occurs between sync and get_paca()->io_sync = 0,
I believe there's no problem.  But in the unlikely event that gcc does
the store relative to another register than r13 (as it did with current),
then there's a small danger of setting another cpu's io_sync to 0, after
it had just set it to 1.  Rewrite ppc64 mmiowb to prevent that.

The remaining io_sync assignments in io.h all get_paca()->io_sync = 1,
which is harmless even if preempted to the wrong cpu (the context switch
itself syncs); and those in spinlock.h are while preemption is disabled.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
I'm clueless with powerpc and inline asm, this patch is likely to be
nonsense: more a placeholder to provoke whatever is the correct patch.
But I think the resulting patch should probably go into 2.6.19.

 include/asm-powerpc/io.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 2.6.19-rc4/include/asm-powerpc/io.h	2006-10-24 04:34:33.000000000 +0100
+++ linux/include/asm-powerpc/io.h	2006-10-30 19:27:05.000000000 +0000
@@ -163,8 +163,11 @@ extern void _outsl_ns(volatile u32 __iom
 
 static inline void mmiowb(void)
 {
-	__asm__ __volatile__ ("sync" : : : "memory");
-	get_paca()->io_sync = 0;
+	unsigned long tmp;
+
+	__asm__ __volatile__("sync; li %0,0; stb %0,%1(13)"
+	: "=&r" (tmp) : "i" (offsetof(struct paca_struct, io_sync))
+	: "memory");
 }
 
 /*

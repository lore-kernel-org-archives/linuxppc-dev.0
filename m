Return-Path: <hughd@google.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D1EFB2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jan 2014 19:46:52 +1100 (EST)
Received: by mail-pb0-f45.google.com with SMTP id rp16so6138721pbb.18
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jan 2014 00:46:49 -0800 (PST)
Date: Sun, 12 Jan 2014 00:46:20 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH mmotm/next] powerpc: fix powernv boot breakage on G5???
Message-ID: <alpine.LSU.2.11.1401120043210.1092@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My PowerMac G5 cannot boot mmotm these days: different symptoms
(starting /sbin/init failed? or ATA errors and hang?), with unrelated
bugs adding to the confusion; but a bisection led to b5ff4211a829
"powerpc/book3s: Queue up and process delayed MCE events".  Since that
series seems to be mostly about powernv, I tried changing BOOK3S_64
to POWERNV in entry_64.S, which has got it back to working for me.

Signed-off-by: Hugh Dickins <hughd@google.com>
just in case this happens to be right, but it's well beyond me!
---

 arch/powerpc/kernel/entry_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- mmotm/arch/powerpc/kernel/entry_64.S	2014-01-10 18:24:56.940448828 -0800
+++ linux/arch/powerpc/kernel/entry_64.S	2014-01-10 18:29:24.276455182 -0800
@@ -184,7 +184,7 @@ syscall_exit:
 	bl	.do_show_syscall_exit
 	ld	r3,RESULT(r1)
 #endif
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_POWERNV
 BEGIN_FTR_SECTION
 	bl	.machine_check_process_queued_event
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD400B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 12:13:25 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAB1DFAN032195
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2009 19:13:16 -0600
Subject: [Fwd: [PATCH] powerpc: _exception: kill the obsolete code under
	is_global_init()]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="=-eXxL8RwtJek+BPeOlPgS"
Date: Wed, 11 Nov 2009 12:13:15 +1100
Message-ID: <1257901995.2140.12.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-eXxL8RwtJek+BPeOlPgS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-eXxL8RwtJek+BPeOlPgS
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH] powerpc: _exception: kill
 the obsolete code under is_global_init()
Content-Type: message/rfc822

Return-Path: <linux-kernel-owner+benh=40kernel.crashing.org-S1755992AbZKJAaw@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00
 autolearn=unavailable version=3.1.9
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAA0Vrxg004548 for
 <benh@kernel.crashing.org>; Mon, 9 Nov 2009 18:31:55 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755992AbZKJAaw (ORCPT <rfc822;benh@kernel.crashing.org>); Mon, 9 Nov 2009
 19:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id
 S1755970AbZKJAau (ORCPT <rfc822;linux-kernel-outgoing>); Mon, 9 Nov 2009
 19:30:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62511 "EHLO mx1.redhat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1755828AbZKJAas
 (ORCPT <rfc822;linux-kernel@vger.kernel.org>); Mon, 9 Nov 2009 19:30:48
 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com
 (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18]) by mx1.redhat.com
 (8.13.8/8.13.8) with ESMTP id nAA0UfgD002472 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK); Mon, 9 Nov 2009 19:30:41
 -0500
Received: from tranklukator.englab.brq.redhat.com
 (tranklukator.englab.brq.redhat.com [10.34.32.241]) by
 int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id
 nAA0Ubce017260; Mon, 9 Nov 2009 19:30:38 -0500
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
 onestero@redhat.com; Tue, 10 Nov 2009 01:25:44 +0100 (CET)
Date: Tue, 10 Nov 2009 01:25:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Kumar Gala <galak@kernel.crashing.org>, Liu Yu <yu.liu@freescale.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: _exception: kill the obsolete code under
 is_global_init()
Message-ID: <20091110002542.GA1312@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit

The code under "if (is_global_init())" is bogus, and is_global_init()
itself is not right in mt case.

Contrary to what the comment says, nowadays force_sig_info() does kill
init even if the handler is SIG_DFL. Note that force_sig_info() clears
SIGNAL_UNKILLABLE exactly for this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 arch/powerpc/kernel/traps.c |   22 ----------------------
 1 file changed, 22 deletions(-)

--- TH/arch/powerpc/kernel/traps.c~PPC_EXCEPTION_DONT_CK_INIT	2009-11-10 01:03:23.000000000 +0100
+++ TH/arch/powerpc/kernel/traps.c	2009-11-10 01:06:41.000000000 +0100
@@ -198,28 +198,6 @@ void _exception(int signr, struct pt_reg
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
 	force_sig_info(signr, &info, current);
-
-	/*
-	 * Init gets no signals that it doesn't have a handler for.
-	 * That's all very well, but if it has caused a synchronous
-	 * exception and we ignore the resulting signal, it will just
-	 * generate the same exception over and over again and we get
-	 * nowhere.  Better to kill it and let the kernel panic.
-	 */
-	if (is_global_init(current)) {
-		__sighandler_t handler;
-
-		spin_lock_irq(&current->sighand->siglock);
-		handler = current->sighand->action[signr-1].sa.sa_handler;
-		spin_unlock_irq(&current->sighand->siglock);
-		if (handler == SIG_DFL) {
-			/* init has generated a synchronous exception
-			   and it doesn't have a handler for the signal */
-			printk(KERN_CRIT "init has generated signal %d "
-			       "but has no handler for it\n", signr);
-			do_exit(signr);
-		}
-	}
 }
 
 #ifdef CONFIG_PPC64

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-eXxL8RwtJek+BPeOlPgS--

Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E018DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 18:23:59 +1100 (EST)
Date: Tue, 21 Oct 2008 09:23:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] genirq: fix set_irq_type() when recording trigger type
Message-ID: <20081021072340.GA25136@elte.hu>
References: <200810202205.m9KM5une024759@hera.kernel.org>
	<1224570730.7654.242.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224570730.7654.242.camel@pasglop>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-10-20 at 22:05 +0000, Linux Kernel Mailing List wrote:
> > Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0c5d1eb77a8be917b638344a22afe1398236482b
> > Commit:     0c5d1eb77a8be917b638344a22afe1398236482b
> > Parent:     d6d5aeb661fc14655c417f3582ae7ec52985d2a8
> > Author:     David Brownell <dbrownell@users.sourceforge.net>
> > AuthorDate: Wed Oct 1 14:46:18 2008 -0700
> > Committer:  Ingo Molnar <mingo@elte.hu>
> > CommitDate: Thu Oct 2 10:24:09 2008 +0200
[...]
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> This one is obviously broken and breaks booting on a whole bunch of 
> machines (including powermac's and thus my G5, it's never good when my 
> own machine breaks !).
> 
> Nice to see 3 SOB's and one Ack and nobody caught the obvious bug :-)

that patch came from -mm towards us shortly before the merge window. 
Once we had it integrated Chris Friesen reported a boot hang on a G5, 
and there's a fix pending for the bug, see it below.

Will send it to Linus expressly. Fortunately only a minority of Linux 
users will ever run a box that uses set_irq_type() - but yes it needs to 
be fixed.

	Ingo

------------------------------>
>From aac4ddd11a8d0e402ddc3fbc75204cb64efa0aac Mon Sep 17 00:00:00 2001
From: Chris Friesen <cfriesen@nortel.com>
Date: Mon, 20 Oct 2008 12:41:58 -0600
Subject: [PATCH] genirq: fix set_irq_type() when recording trigger type

In set_irq_type() we want to pass the type rather than the current
interrupt state.

Signed-off-by: Chris Friesen <cfriesen@nortel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/chip.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 4895fde..3de6ea3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -127,7 +127,7 @@ int set_irq_type(unsigned int irq, unsigned int type)
 		return 0;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	ret = __irq_set_trigger(desc, irq, flags);
+	ret = __irq_set_trigger(desc, irq, type);
 	spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0343167A78
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jan 2005 12:27:41 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
In-Reply-To: <1106441036.5387.41.camel@gaston>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 12:25:35 +1100
Message-Id: <1106529935.5587.9.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:

> I know about this problem, I'm working on a proper fix. Thanks for your
> report.

Can you send me the PVR value for both of these CPUs
(cat /proc/cpuinfo) ? I can't find right now why they would lock up
unless the default idle loop is _not_ run properly, that is for some
reason, NAP or DOZE mode end up not beeing enabled. Can you send me
your .config as well ?

Finally, try that patch and tell me if it makes a difference. It makes
sure we re-enable interrupts in cpu_idle, and thus should only be a
workaround. I found _one_ actual code path where we fail to re-enable
them, and this is when neither DOZE nor NAP mode is enabled, which
should not happen on any G3 (they should all support DOZE mode), and
might happe non some G4s if the chipset doesn't support NAP or
powersave_nap is set to 0 in proc, but that shouldn't be the case of an
eMac neither...

--- linux-work.orig/arch/ppc/kernel/idle.c	2005-01-24 11:42:35.000000000 +1100
+++ linux-work/arch/ppc/kernel/idle.c	2005-01-24 12:19:41.114353760 +1100
@@ -39,17 +39,15 @@
 	powersave = ppc_md.power_save;
 
 	if (!need_resched()) {
+		local_irq_enable();
 		if (powersave != NULL)
 			powersave();
 		else {
 #ifdef CONFIG_SMP
 			set_thread_flag(TIF_POLLING_NRFLAG);
-			local_irq_enable();
 			while (!need_resched())
 				barrier();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
-#else
-			local_irq_enable();
 #endif
 		}
 	}
 
Ben.

Return-Path: <akpm@linux-foundation.org>
Received: from mail-qa0-f74.google.com (mail-qa0-f74.google.com
 [209.85.216.74])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 564E0B6EE7
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 09:21:01 +1100 (EST)
Received: by qabg24 with SMTP id g24so209739qab.3
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2012 15:20:58 -0700 (PDT)
Subject: [patch 2/2] arch/powerpc/platforms/pseries/eeh_event.c: slightly fix
 set_current_state() wart
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 28 Mar 2012 15:20:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Message-Id: <20120328222058.3FA2AA0624@akpm.mtv.corp.google.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrew Morton <akpm@linux-foundation.org>
Subject: arch/powerpc/platforms/pseries/eeh_event.c: slightly fix set_current_state() wart

That set_current_state() won't work very well: the subsequent mutex_lock()
might flip the task back into TASK_RUNNING.

Attempt to put it somewhere where it might have been meant to be, and
attempt to describe why it might have been added.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/eeh_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/pseries/eeh_event.c~arch-powerpc-platforms-pseries-eeh_eventc-slightly-fix-set_current_state-wart arch/powerpc/platforms/pseries/eeh_event.c
--- a/arch/powerpc/platforms/pseries/eeh_event.c~arch-powerpc-platforms-pseries-eeh_eventc-slightly-fix-set_current_state-wart
+++ a/arch/powerpc/platforms/pseries/eeh_event.c
@@ -60,7 +60,6 @@ static int eeh_event_handler(void * dumm
 	struct eeh_dev *edev;
 
 	set_task_comm(current, "eehd");
-	set_current_state(TASK_INTERRUPTIBLE);
 
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
 	event = NULL;
@@ -83,6 +82,7 @@ static int eeh_event_handler(void * dumm
 	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
 	       eeh_pci_name(edev->pdev));
 
+	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
 	edev = handle_eeh_events(event);
 
 	eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
_

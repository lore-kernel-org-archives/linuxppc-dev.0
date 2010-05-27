Return-Path: <markn@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1097B7D42
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 May 2010 16:51:59 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4R6ptR5031686
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 16:51:55 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R6prcU1335532
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 16:51:53 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R6pqO4008808
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 16:51:53 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: powerpc/pseries: Add WARN_ON() to request_event_sources_irqs() on irq
	allocation/request failure
Date: Thu, 27 May 2010 16:56:04 +1000
References: <201005172233.01183.markn@au1.ibm.com>
	<1274250954.7574.1.camel@concordia>
	<201005191654.42483.markn@au1.ibm.com>
In-Reply-To: <201005191654.42483.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005271656.04629.markn@au1.ibm.com>
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment if request_event_sources_irqs() can't allocate or request
the interrupt, it just does a KERN_ERR printk. This may be fine for the
existing RAS code where if we miss an EPOW event it just means that the
event won't be logged and if we miss one of the RAS errors then we could
miss an event that we perhaps should take action on.

But, for the upcoming IO events code that will use event-sources if we
can't allocate or request the interrupt it means we'd potentially miss
an interrupt from the device. So, let's add a WARN_ON() in this error
case so that we're a bit more vocal when something's amiss.

While we're at it, also use pr_err() to neaten the code up a bit.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/event_sources.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Index: upstream/arch/powerpc/platforms/pseries/event_sources.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/event_sources.c
+++ upstream/arch/powerpc/platforms/pseries/event_sources.c
@@ -41,9 +41,12 @@ void request_event_sources_irqs(struct d
 			if (count > 15)
 				break;
 			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
-			if (virqs[count] == NO_IRQ)
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       "number for %s\n", np->full_name);
+			if (virqs[count] == NO_IRQ) {
+				pr_err("event-sources: Unable to allocate "
+				       "interrupt number for %s\n",
+				       np->full_name);
+				WARN_ON(1);
+			}
 			else
 				count++;
 
@@ -59,9 +62,12 @@ void request_event_sources_irqs(struct d
 			virqs[count] = irq_create_of_mapping(oirq.controller,
 							    oirq.specifier,
 							    oirq.size);
-			if (virqs[count] == NO_IRQ)
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       "number for %s\n", np->full_name);
+			if (virqs[count] == NO_IRQ) {
+				pr_err("event-sources: Unable to allocate "
+				       "interrupt number for %s\n",
+				       np->full_name);
+				WARN_ON(1);
+			}
 			else
 				count++;
 		}
@@ -70,8 +76,9 @@ void request_event_sources_irqs(struct d
 	/* Now request them */
 	for (i = 0; i < count; i++) {
 		if (request_irq(virqs[i], handler, 0, name, NULL)) {
-			printk(KERN_ERR "Unable to request interrupt %d for "
-			       "%s\n", virqs[i], np->full_name);
+			pr_err("event-sources: Unable to request interrupt "
+			       "%d for %s\n", virqs[i], np->full_name);
+			WARN_ON(1);
 			return;
 		}
 	}

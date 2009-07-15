Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFF5EB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 07:43:10 +1000 (EST)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55609DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 07:43:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6FLdaWN027687
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 15:39:36 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6FLh5XS258338
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 15:43:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6FLh4qp008874
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 15:43:04 -0600
Message-ID: <4A5E4D68.6070909@us.ibm.com>
Date: Wed, 15 Jul 2009 14:43:04 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benh@kernel.crashing.org, linasvepstas@gmail.com
Subject: [PATCH] Hold reference to device_node during EEH event handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch increments the device_node reference counter when an EEH error occurs and decrements the counter when the event has been handled.  This is to prevent the device_node from being released until eeh_event_handler() has had a chance to deal with the event.  We've seen cases where the device_node is released too soon when an EEH event occurs during a dlpar remove, causing the event handler to attempt to access bad memory locations.

Please review and let me know of any concerns.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 

--- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00.000000000 -0700
@@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
 	if (event == NULL)
 		return 0;
 
+	/* EEH holds a reference to the device_node, so if it
+	 * equals 1 it's no longer valid and the event should
+	 * be ignored */
+	if (atomic_read(&event->dn->kref.refcount) == 1) {
+		of_node_put(event->dn);
+		return 0;
+	}
+
 	/* Serialize processing of EEH events */
 	mutex_lock(&eeh_event_mutex);
 	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
@@ -86,6 +94,7 @@ static int eeh_event_handler(void * dumm
 
 	eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
 	pci_dev_put(event->dev);
+	of_node_put(event->dn);
 	kfree(event);
 	mutex_unlock(&eeh_event_mutex);
 
@@ -140,7 +149,7 @@ int eeh_send_failure_event (struct devic
 	if (dev)
 		pci_dev_get(dev);
 
-	event->dn = dn;
+	event->dn = of_node_get(dn);
 	event->dev = dev;
 
 	/* We may or may not be called in an interrupt context */

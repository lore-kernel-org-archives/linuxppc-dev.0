Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE743B7BE6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:44:38 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LEdmQu012550
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:39:48 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9LEiO2p029228
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:44:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9LEiMb1009499
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:44:22 -0600
Message-ID: <4ADF1E42.3020907@austin.ibm.com>
Date: Wed, 21 Oct 2009 09:44:18 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5 v4] Export memory_sysdev_class
References: <4ADF1C49.2030201@austin.ibm.com>
In-Reply-To: <4ADF1C49.2030201@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the memory_sysdev_class structure.  This is needed so we can create
a 'release' file in sysfs in addition to the existing 'probe' file in
order to support DLPAR removal of memory on the powerpc/pseries platform.
The new 'release' file will be powerpc/pseries only.

Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
---

Index: powerpc/drivers/base/memory.c
===================================================================
--- powerpc.orig/drivers/base/memory.c	2009-10-19 11:56:51.000000000 -0500
+++ powerpc/drivers/base/memory.c	2009-10-19 11:59:36.000000000 -0500
@@ -28,9 +28,10 @@
 
 #define MEMORY_CLASS_NAME	"memory"
 
-static struct sysdev_class memory_sysdev_class = {
+struct sysdev_class memory_sysdev_class = {
 	.name = MEMORY_CLASS_NAME,
 };
+EXPORT_SYMBOL(memory_sysdev_class);
 
 static const char *memory_uevent_name(struct kset *kset, struct kobject *kobj)
 {
Index: powerpc/include/linux/memory_hotplug.h
===================================================================
--- powerpc.orig/include/linux/memory_hotplug.h	2009-10-19 11:58:43.000000000 -0500
+++ powerpc/include/linux/memory_hotplug.h	2009-10-19 11:59:36.000000000 -0500
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 
+extern struct sysdev_class memory_sysdev_class;
+
 /*
  * Types for free bootmem.
  * The normal smallest mapcount is -1. Here is smaller value than it.

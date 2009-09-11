Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 13C1FB7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 07:13:29 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84B4BDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 07:13:28 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8BL6vk7014846
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:06:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8BLDPpg237808
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:13:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8BLDPIg020378
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:13:25 -0400
Message-ID: <4AAABD6F.8020008@austin.ibm.com>
Date: Fri, 11 Sep 2009 16:13:19 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] Export memory_sysdev_class
References: <4AAABC55.4070207@austin.ibm.com>
In-Reply-To: <4AAABC55.4070207@austin.ibm.com>
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

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: powerpc/drivers/base/memory.c
===================================================================
--- powerpc.orig/drivers/base/memory.c	2009-09-11 12:43:40.000000000 -0500
+++ powerpc/drivers/base/memory.c	2009-09-11 12:52:26.000000000 -0500
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
--- powerpc.orig/include/linux/memory_hotplug.h	2009-09-11 12:43:44.000000000 -0500
+++ powerpc/include/linux/memory_hotplug.h	2009-09-11 12:52:26.000000000 -0500
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 
+extern struct sysdev_class memory_sysdev_class;
+
 /*
  * Types for free bootmem.
  * The normal smallest mapcount is -1. Here is smaller value than it.

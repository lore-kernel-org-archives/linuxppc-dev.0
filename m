Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99AF1DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:00:32 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1FJxsvM025350
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 14:59:54 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1FK0TJN541532
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 13:00:29 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1FK0Scc017245
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 13:00:29 -0700
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition and
	removal of adapters
From: John Rose <johnrose@austin.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702151755.13009.hnguyen@linux.vnet.ibm.com>
References: <200702151755.13009.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain
Message-Id: <1171569457.20758.76.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Thu, 15 Feb 2007 13:57:37 -0600
Cc: Paul Mackerras <pmac@au1.ibm.com>, fenkes@de.ibm.com,
	lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

Looks good.  Questions: how can the user space tools verify the success
of an add or remove?  

Also, will /sys/bus/ibmebus exist even if the system booted with no LHEA
nodes?

One more comment below.

@@ -161,7 +161,9 @@ static void __devinit ibmebus_dev_releas
 static ssize_t ibmebusdev_show_name(struct device *dev, 
 				    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", to_ibmebus_dev(dev)->name);
+	struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
+	char *name = (char*)get_property(ebus_dev->ofdev.node, "name", NULL);
+	return sprintf(buf, "%s\n", name);
 }
 static DEVICE_ATTR(name, S_IRUSR | S_IRGRP | S_IROTH, ibmebusdev_show_name, 
 		   NULL);


Can we also have an attribute "devspec" that communicates the open
firmware path through sysfs?  User space DLPAR tools need a way to make
this correlation.  This is consistent with other dynamic-capable sysfs
objects (cpus, etc).  I assume you could get this string with something
like ebus_dev->ofdev.node->full_name.  For example:

# cat /sys/bus/ibmebus/$ebus_device/devspec
/lhea@xxxxxxxxx/

Thanks-
John

Return-Path: <johnrose@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCBE9DDEE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 08:54:59 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l26Lsuel027007
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 16:54:56 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l26LsuGQ484294
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 14:54:56 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l26Lst4N017327
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 14:54:56 -0700
Subject: Re: [PATCH 1/2] ibmebus: dynamic addiiton/removal of adapters,
	uevent, root device based on struct device
From: John Rose <johnrose@austin.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702230137.24348.hnguyen@linux.vnet.ibm.com>
References: <200702230137.24348.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain
Message-Id: <1173217902.15589.33.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Tue, 06 Mar 2007 15:51:42 -0600
Cc: Paul Mackerras <pmac@au1.ibm.com>, stefan.roscher@de.ibm.com,
	Joaquim Fenkes <fenkes@de.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
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

> This adds two sysfs attributes to /sys/bus/ibmebus which can
> be used to notify the ebus driver of added / removed ebus
> devices in the OF device tree.

We are seeing several build errors when attempting to apply this to
2.6.21-rc2:

CC arch/powerpc/kernel/ibmebus.o
arch/powerpc/kernel/ibmebus.c: In function "ibmebus_register_device_common":
arch/powerpc/kernel/ibmebus.c:192: warning: ignoring return value of "device_create_file", declared with attribute warn_unused_result
arch/powerpc/kernel/ibmebus.c: At top level:
arch/powerpc/kernel/ibmebus.c:373: error: "of_device_uevent" undeclared here (not in a function)
arch/powerpc/kernel/ibmebus.c: In function "ibmebus_store_probe":
arch/powerpc/kernel/ibmebus.c:399: error: assignment of read-only location
arch/powerpc/kernel/ibmebus.c:401: error: assignment of read-only location
arch/powerpc/kernel/ibmebus.c: In function "ibmebus_store_remove":
arch/powerpc/kernel/ibmebus.c:434: error: assignment of read-only location
arch/powerpc/kernel/ibmebus.c:436: error: assignment of read-only location
arch/powerpc/kernel/ibmebus.c: In function "ibmebus_bus_init":
arch/powerpc/kernel/ibmebus.c:474: warning: ignoring return value of "bus_create_file", declared with attribute warn_unused_result
arch/powerpc/kernel/ibmebus.c:475: warning: ignoring return value of "bus_create_file", declared with attribute warn_unused_result
make[1]: *** [arch/powerpc/kernel/ibmebus.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
make: *** Waiting for unfinished jobs....
Here is a sample error from the patch referenced above:
+static ssize_t ibmebus_store_probe(struct bus_type *bus,
+                                  const char *buf, size_t count)
+{
+       struct device_node *dn = NULL;
+       struct ibmebus_dev *dev;
+       char *loc_code;
+
+       buf[count] = '\0';

The "buf" variable is declared const, and then immediately written to.

Thanks-
John

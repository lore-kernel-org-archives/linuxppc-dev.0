Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B750DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 23:49:35 +1000 (EST)
Message-ID: <464322F3.3010808@shadowen.org>
Date: Thu, 10 May 2007 14:49:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: 2.6.21-git5 -- powerpc link failure
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since 2.6.21-git5 we've been getting the following link failure on powerpc:

  CC      drivers/pci/hotplug/rpadlpar_core.o
  CC      drivers/pci/hotplug/rpadlpar_sysfs.o
drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field
‘subsys’ specified in initializer
drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from
incompatible pointer type
make[3]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
make[2]: *** [drivers/pci/hotplug] Error 2
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2


I would think this is caused by the changes in the commit below:

commit 823bccfc4002296ba88c3ad0f049e1abd8108d30
Author: Greg Kroah-Hartman <gregkh@suse.de>
Date:   Fri Apr 13 13:15:19 2007 -0700

    remove "struct subsystem" as it is no longer needed

-apw

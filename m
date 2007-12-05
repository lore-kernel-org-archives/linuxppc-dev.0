Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60AB3DDE03
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 20:32:42 +1100 (EST)
Date: Wed, 5 Dec 2007 01:30:54 -0800
From: Greg KH <greg@kroah.com>
To: "Kyle A. Lucke" <klucke@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
Subject: drivers/net/iseries_veth.c dubious sysfs usage
Message-ID: <20071205093054.GA23229@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In doing a massive kobject cleanup of the kernel tree, I ran across the
iseries_veth.c driver.

It looks like the driver is creating a number of subdirectories under
the driver sysfs directory.  This is odd and probably wrong.  You want
these virtual connections to show up in the main sysfs device tree, not
under the driver directory.

I'll be glad to totally guess and try to move it around in the sysfs
tree, but odds are I'll get it all wrong as I can't really test this
out :)

Any hints on what this driver is trying to do in this sysfs directories?

thanks,

greg k-h

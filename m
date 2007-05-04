Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3D10DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 05:04:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l44J0tUO021793
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 15:00:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44J48I5157488
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:04:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44J48YW014582
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:04:08 -0600
Date: Fri, 4 May 2007 14:04:08 -0500
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Re: 2.6.21-rc7-mm2 -- hvsi console driver registration
	failure
Message-ID: <20070504190408.GN6193@austin.ibm.com>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org>
	<4fe4528cb20beb569a8f2ac817c776e5@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4fe4528cb20beb569a8f2ac817c776e5@pinky>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 12:38:58PM +0100, Andy Whitcroft wrote:
> 
> Trying to get 2.6.21-rc7-mm2 to boot on large PPC64 seems to be a
> bit of a challenge.  We have been seeing panics on boot from the
> hvsi driver:
> 
> 	Couldn't register hvsi console driver
> 
> Tracking this back, this seems to come from hvsi driver trying to
> register itself via tty_register_driver() with a zero units.
> 
> The failure is triggered by a change in semantics for kmalloc()
> between SLAB and SLUB; kmalloc(0) now returns NULL rather than an
> allocation at the smallest size.  Looking at the code in question
> even when the allocation succeeds we will not actually use the
> memory when device->num is zero.
> 
> It is not clear to me if this is a bug in the hvsi driver in that
> it should specify some units.  It seems we will try and reserve zero
> devices in this case, which seems pointless.

Yes, it seems pointless to me ... 

> I have tested with the patch below which seems safe to me and stops
> the errors and even seems to make the console work.  But perhaps
> someone with more driver fu, could verify if driver->num of zero
> has any meaning and kick this to the hvsi people if not.

Hollis nominated me to be "hvsi people", although I'm near-totally
ignorant of the thing.

If hvsi_count is zero, then the device tree did not have any
"serial" nodes that speak "hvterm-protocol". The hvsi should not 
have even tried to register anything. The attached patch seems more 
to the point.

--linas


The hvsi driver is used whenever the device-tree contains
nodes for serial ports, and those serial ports speak the hvterm
protocol. However, if no such nodes are found, then the hvsi
driver should not even register. 

This patch avoids a kernel panic with "Couldn't register hvsi 
console driver". 

In addition, this patch makes tty_register_driver refuse
to do anything, if there are no actual tty ports to be 
registered.

Utterly & completely untested.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/char/hvsi.c   |    4 ++++
 drivers/char/tty_io.c |    3 +++
 2 files changed, 7 insertions(+)

Index: linux-2.6.21-rc7-mm2/drivers/char/hvsi.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/drivers/char/hvsi.c	2007-04-26 15:37:33.000000000 -0500
+++ linux-2.6.21-rc7-mm2/drivers/char/hvsi.c	2007-05-04 13:55:56.000000000 -0500
@@ -1148,6 +1148,10 @@ static int __init hvsi_init(void)
 {
 	int i;
 
+	/* No serial hvterm-protocol device-tree nodes found. */
+	if (hvsi_count == 0)
+		return 0;
+
 	hvsi_driver = alloc_tty_driver(hvsi_count);
 	if (!hvsi_driver)
 		return -ENOMEM;
Index: linux-2.6.21-rc7-mm2/drivers/char/tty_io.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/drivers/char/tty_io.c	2007-04-26 15:37:33.000000000 -0500
+++ linux-2.6.21-rc7-mm2/drivers/char/tty_io.c	2007-05-04 13:54:14.000000000 -0500
@@ -3724,6 +3724,9 @@ int tty_register_driver(struct tty_drive
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
+	if (driver->num == 0)
+		return -ENODEV;
+
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
 		p = kmalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
 		if (!p)

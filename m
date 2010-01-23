Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f184.google.com (mail-iw0-f184.google.com
	[209.85.223.184]) by ozlabs.org (Postfix) with ESMTP id 05006B7C8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jan 2010 00:53:48 +1100 (EST)
Received: by iwn14 with SMTP id 14so1627274iwn.18
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jan 2010 05:53:46 -0800 (PST)
Date: Sat, 23 Jan 2010 08:53:37 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: avorontsov@ru.mvista.com
Subject: FHCI fails to build in 2.6.33-rc5
Message-ID: <20100123135337.GD17561@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When trying to build the Fedora devel kernel, I get the build error
below.  The *_frame_Q members of the fhci endpoint structure are
indeed declared as 'struct kfifo' and not pointers to such.  The
NULL checks in the fhci_ep0_free function seem odd when you take
that into account.

Thoughts on a fix?  If it's not fixed soon, I'll have to disable
it in the .config.

josh

In file included from drivers/usb/host/fhci-hcd.c:33:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
In file included from drivers/usb/host/fhci-hub.c:28:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
In file included from drivers/usb/host/fhci-q.c:25:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
In file included from drivers/usb/host/fhci-mem.c:24:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
In file included from drivers/usb/host/fhci-tds.c:25:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
drivers/usb/host/fhci-tds.c: In function 'fhci_ep0_free':
drivers/usb/host/fhci-tds.c:108: error: used struct type value where scalar is required
drivers/usb/host/fhci-tds.c:118: error: used struct type value where scalar is required
drivers/usb/host/fhci-tds.c:128: error: used struct type value where scalar is required
make[3]: *** [drivers/usb/host/fhci-tds.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2

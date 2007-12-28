Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 32EC1DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 10:53:50 +1100 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JTS00CS9ABLPWA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:33 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JTS008L0ABLGJ10@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Dec 2007 16:52:34 -0700 (MST)
Received: from trillian.cg.shawcable.net ([70.72.177.167])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JTS00KRZABJOW30@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:32 -0700 (MST)
Date: Fri, 28 Dec 2007 16:52:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 0/4] Add C67x00 USB HCD driver.
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	jacmet@sunsite.dk, stern@rowland.harvard.edu
Message-id: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series is based on the c67x00 work done by Peter Korsgaard and
posted back in April this year.  I posted my first rework to the series
on Nov 23.  This version addresses the comments that I received then.

The Cypress c67x00 is an OTG controller so it can behave as either a host
or gadget controller.  This series implements the HCD behaviour.

The c67x00 is found on a number of the Xilinx MLxxx series of boards.
I've been performing my testing on a board derived from the ML403.

I'd like to get this driver queued up for inclusion in 2.6.25.  I think it
is ready.  This series can also be pulled from my git tree here:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-c67x00

For those who are interested in the progression from Peter's original series
to this one, the full history of my changes can be found in here:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-c67x00-historical

Thanks,
g.


Grant Likely (4):
      USB: add Cypress c67x00 low level interface code
      USB: add Cypress c67x00 OTG controller core driver
      USB: add Cypress c67x00 OTG controller HCD driver
      USB: add Cypress c67x00 OTG controller driver to Kconfig and Makefiles

 drivers/usb/Makefile               |    2 +
 drivers/usb/c67x00/Makefile        |   11 +
 drivers/usb/c67x00/c67x00-drv.c    |  278 +++++++++
 drivers/usb/c67x00/c67x00-hcd.c    |  392 ++++++++++++
 drivers/usb/c67x00/c67x00-hcd.h    |  137 ++++
 drivers/usb/c67x00/c67x00-ll-hpi.c |  516 +++++++++++++++
 drivers/usb/c67x00/c67x00-sched.c  | 1205 ++++++++++++++++++++++++++++++++++++
 drivers/usb/c67x00/c67x00.h        |  242 ++++++++
 drivers/usb/host/Kconfig           |   12 +
 include/linux/usb/c67x00.h         |   45 ++
 10 files changed, 2840 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/c67x00/Makefile
 create mode 100644 drivers/usb/c67x00/c67x00-drv.c
 create mode 100644 drivers/usb/c67x00/c67x00-hcd.c
 create mode 100644 drivers/usb/c67x00/c67x00-hcd.h
 create mode 100644 drivers/usb/c67x00/c67x00-ll-hpi.c
 create mode 100644 drivers/usb/c67x00/c67x00-sched.c
 create mode 100644 drivers/usb/c67x00/c67x00.h
 create mode 100644 include/linux/usb/c67x00.h

--

Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	by ozlabs.org (Postfix) with ESMTP id A01AFDE301
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 02:46:34 +1100 (EST)
Message-Id: <20080221153450.854136000@sunsite.dk>
Date: Thu, 21 Feb 2008 16:34:50 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca,
	stern@rowland.harvard.edu, greg@kroah.com
Subject: [patch v10 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
USB controllers. This patch series implements a HCD driver and shows the
work-in-progress status of a gadget driver.

I believe patch 1..3 are ready, and I would like to see them queued up for
mainline.

Changes since v9:
 - Put Kconfig in alphabetical order, use ccflags-$(CONFIG_USB_DEBUG)
   (feedback from David)

Changes since v8:
 - checkpatch.pl fixes (__FUNCTION__ -> __func__, indent)

Changes since v7:
 - Moved dummy hcd probe/remove functions for conditional hcd support into
   udc patch.
 - Moved usb_disabled() check into c67x00_hcd_probe().
 - Moved c67x00_get_comm_reg() to udc patch as it is only needed for gadget
   support.

Changes since v6:
 - Addressed David and Alan's comments (removed done list + tasklet)

Changes since v5:
 - Merged c67x00_ll_{get,set}_siemsg() into c67x00_ll_fetch_siemsg().
 - Fix for interrupt race condition at probe time (reported by Grant)

Changes since v4:
 - Addressed Grant's comments (c67x00_dev->c67x00_hcd_dev, label indent)
 - Moved c67x00_ll_set_ep_{ctrl,packet_size}_reg() to patch 4 as they are
   only needed for gadget support.

Changes since v3:
- Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
- The dummy platform_device's created per serial engine are gone.
- Gadget driver (WIP)

--
Bye, Peter Korsgaard

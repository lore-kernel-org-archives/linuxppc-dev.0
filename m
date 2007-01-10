Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id 864ABDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 02:05:15 +1100 (EST)
Date: 10 Jan 2007 15:05:11 -0000
Message-ID: <20070110150511.31047.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Problems with devices that use PCI shared memory on 2nd PCI bus (6
	slot powermac)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since Ben fixed the irq routing on 32 bit powermacs with changes to pci_32.c
and prom_parse.c I've been able to use all 6 slots with interrupt
driven devices however there appears to be a problem with devices that use
memory mapping. (this is on a S900 w/ 21052 second PCI controller)

A couple of examples:
When using a 21143 tulip ethernet card on the second PCI bus and with the 
"Use PCI shared mem for NIC registers" option turned on the driver
fails with incorrect status register reads. If I compile a kernel without
this option it works fine.

Also, if I put a rage 128 video board in one of the slots on the
second bus it cannot do DRM. If I turn DRM off it works ok or if I move the
card to the first bus it works fine with DRM.

drmOpenByBusid: Searching for BusID pci:0000:01:0f.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: drmOpenMinor returns 9
drmOpenByBusid: drmGetBusid reports pci:0000:01:0f.0
.
.
(EE) R128(0): R128CCEWaitForIdle: (DEBUG) CCE idle took i = 1025
(EE) R128(0): Idle timed out, resetting engine...
(II) AIGLX: Suspending AIGLX clients for VT switch
(EE) R128(0): R128CCEWaitForIdle: (DEBUG) CCE idle took i = 1025
(EE) R128(0): Idle timed out, resetting engine...
(II) Generic Mouse: ps2EnableDataReporting: succeeded
(II) R128(0): [drm] removed 1 reserved context for kernel
(II) R128(0): [drm] unmapping 8192 bytes of SAREA 0xe6107000 at 0x30020000

Bob

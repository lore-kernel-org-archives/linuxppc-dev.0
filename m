Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AAF4DC1.CAE5395B@vienna.at>
Date: Wed, 14 Mar 2001 11:53:53 +0100
From: Roman Weissgaerber <weissg@vienna.at>
Reply-To: weissg@vienna.at
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>
Cc: "linux-usb-devel@lists.sourceforge.net" <linux-usb-devel@lists.sourceforge.net>,
	dan@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: MPC823/850 USB host driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Brad,

now I have some USB bulk devices (USB-storage and pegasus.c (patched))
working with a modified version of your MPC850/823 USB host driver.
(BTW. The MPC850 has some serious hardware problems when used with some
tranceivers.)
As I am useing a TQ Board and there were some problems with bulk
transfers
I made the following modifications:

Patch 1: adds some more choices of resources for SOF and clock so it
  should also work with other boards (at least TQ boards)

Patch 2: replaces the 'old fashioned' roothub process with a
 virtual root hub and also uses the bus wires to detect new devices
 (this makes it more conform with how other Linux USB-host-driver
 like OHCI and UHCI manages the root-hub
 and the detection of devices is more USB spec. conform)

Patch 3,..: OHCI like URB-queueing, new SCC code ...


Patch 1 and 2 changes not very much of the architecture besides the
root hub.
But patches 3,.. changes a lot. So these patches could need some
discussion. (whether we use the OHCI like structure (smaller) or
I will try to extract the changes needed for bulk transfers)

Patches 1 and 2 follow immediately (on linux-usb-devel).
The other patches follow in the next days.


- Roman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

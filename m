Return-Path: <David_Antliff@stratexnet.com>
Received: from exchwenz03.wenz.global.vpn (unknown [202.27.34.1])
	by ozlabs.org (Postfix) with ESMTP id 21FF268926
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 14:33:16 +1100 (EST)
Subject: Common Flash Interface v1.4 and MTD support in Linux-2.4.4 kernel
From: David Antliff <David_Antliff@stratexnet.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 07 Feb 2006 16:33:15 +1300
Message-Id: <1139283195.26357.50.camel@theoden.middle_earth>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,


Just to be clear, this email is related to work that I do for a
commercial enterprise, however I am writing on behalf of myself.


I am working on an MPC852 embedded platform based on the Denx
Linux-2.4.4 port.

We have an existing device with a fixed-flash (AMD-type) conforming to
CFI (Common Flash Interface) version 1.2. Linux-2.4.4 supports this
device when used by the Memory Tech Device Driver (MTD). This device has
a single region ('plane'?) or at least constant geometry across the
device. MTD in 2.4.4 has no problems dividing this up into a bunch of
block devices (partitions for read-only filesystems).

A newer version has a different flash chip - an Intel P30 flash with
multiple regions - it has two types of geometries as it is configured
for 'boot' operation. It also conforms to CFI version 1.4. Unfortunately
the Linux-2.4.4 MTD driver rejects this as unsupported based on CFI
version and hard-coding it in "kinda" works - the partition devices are
readable but the driver complains bitterly about non-alignment with
erase blocks. I suspect the driver is picking up parameters from the
first region (which covers the first set of blocks) and trying to use
this across the device. One thing I don't understand yet - as the first
region uses block sizes that are an integer division of those in the
second region I'm not sure why the boundaries don't align when I am
using the 2nd-region block size to define the partition boundaries.


What I am looking for is some advice please - what do you think is the
best course of action in this situation? 

There will be others but so far I am considering:

1. back-port the CFI code from a newer 2.4 kernel to support CFI v1.4.
 - does anybody know the state of MTD in later versions? What would be a
good version to source from?

2. integrate code found here and try and understand how it works:
http://lists.infradead.org/pipermail/linux-mtd/2001-November/003645.html

3. unfortunately upgrading the entire kernel is not an option at this
stage, unless absolutely necessary.


What would you suggest? Yes, I am happy for a 'quick fix' but if there
isn't one or it's too risky I am willing to invest the time in doing it
right.


Thank you,

David Antliff
Stratex Networks Ltd.
New Zealand

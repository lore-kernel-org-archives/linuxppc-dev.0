Return-Path: <kmilligan@austin.polycom.com>
Received: from ausexch00.austin.polycom.com (unknown [216.54.148.81])
	by ozlabs.org (Postfix) with ESMTP id 906F02BEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 07:20:55 +1100 (EST)
Message-ID: <F3CF3D25A7F8F44BB59BC7A2CA83E30B02322252@ausexch00.austin.polycom.com>
From: "Milligan, Keath" <kmilligan@austin.polycom.com>
To: linuxppc-dev@ozlabs.org
Date: Thu, 18 Nov 2004 14:05:36 -0600
MIME-Version: 1.0
Content-Type: text/plain
Subject: Large PCI region mapping 8272
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am having trouble getting PCI devices mapped correctly under Linux 2.4.22
running on an MPC8272ADS evaluation board.

I have multiple PCI-attached devices with a total of 512MB of prefetchable
memory and about 200MB of non-prefetchable memory address spaces in various
block sizes. All of the devices are behind a PCI-to-PCI bridge that is
plugged into the ADS.

At this stage in my project, these devices are initializing themselves to
base addresses that need to be moved when Linux boots on the 8272. The
problem I am having is that Linux is trying to remap everything, but is
unable to allocate regions for everything, so I end up with most of the
devices mapped to the same (invalid) address.

I've tried hacking the kernel PCI initialization to manually set all the
base addresses, but it seems to be ignoring that for the most part.

Could someone point me in the right direction to getting everything
initialized and mapped correctly?

Thanks

Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 57E2EDE04A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:54:08 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id 513AC108102
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:53:30 +0100 (CET)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 29034-02 for <linuxppc-dev@ozlabs.org>;
	Wed,  9 Jan 2008 16:53:29 +0100 (CET)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id 2205C10804A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:53:29 +0100 (CET)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: PCI interrupt assignment on sequoia board
Date: Wed, 9 Jan 2008 16:53:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801091653.22478.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I noticed that Josh's 'for-2.5.25' does not assign PCI interrupts correctly:

bash-3.00# lspci -v
00:00.0 Class 0680: 1014:027f
        Subsystem: 10e8:cafe
        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [58] Power Management version 2

00:0a.0 Class 0b20: 1014:027f	(this is a PPC440EPx PCI target board in a sequoia PCI slot)
        Subsystem: 12fe:0441
        Flags: bus master, medium devsel, latency 128, IRQ 16
        Memory at 0000000180000000 (32-bit, prefetchable) [size=64M]
        Memory at 0000000184000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [58] Power Management version 2

00:0c.0 Class 0200: 168c:0013 (rev 01)
        Subsystem: 14b7:0a60
        Flags: bus master, medium devsel, latency 128, IRQ 16
        Memory at 0000000185000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2

bash-3.00# uname -a
Linux sequoia 2.6.24-rc6-g78994e24 #5 Wed Jan 9 16:22:31 CET 2008 ppc ppc ppc GNU/Linux


All interrupts are '16'. But I expected 67 as correctly stated in the device tree.
This test has been made with the uboot wrapper code.

Any idea?

Matthias

Message-ID: <3D8B1950.CE2DB9A1@corelatus.com>
Date: Fri, 20 Sep 2002 14:49:21 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Potential problem in fec.c for 8xx
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When using MII, the interrupt for link status changes
is enabled before the PHY type has been detected.

If a link status change happens before PHY is detected,
you will get kernel panic in mii_link_interrupt
because the MII functions are undefined.

The correct way to do this would be to move the
enabling of MII interrupts from fec_enet_init
to mii_discover_phy3.

I can prepare a patch if someone points me to
the correct version to patch.

/Thomas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

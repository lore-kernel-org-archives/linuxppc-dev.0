Date: Tue, 7 Sep 1999 01:44:38 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: ioremap (still?) broken
Message-ID: <Pine.LNX.4.04.9909070126490.14821-100000@narn.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am attempting to make an Alteon based Gigabit Ethernet card work in a
Yosemite G3, and it appears that either ioremap is not mapping memory
correctly, or the implementation of 'readl,writel' on PPC is not
consistent with the implementation on all other architectures.

The alteon driver does an 'ioremap' on the address provided by the kernel
PCI services, and then expects to be able to access the PCI card's memory
via accessing the memory returned using 'readl,writel'.

The first thing the driver does is check the card version by reading a
particular register. By using appropriate printf's, I have found that the
value returned is '0xffffffff'. (defininitely NOT the register it's
looking for)

Before I go on a wild chase again, could someone let me know whether the
2.2.12 kernel might have a better chance with this, or will I need to go
to the 2.3.x series? (I tried this on a 2.2.6 kernel).

Thanks.

--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

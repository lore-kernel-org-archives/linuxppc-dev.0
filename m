Message-Id: <4.2.2.20010818203738.028a6d60@mail.inkverse.com>
Date: Sat, 18 Aug 2001 20:46:05 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Jeremy Radlow <jtr@sourcerers.com>
Subject: Internal airport card works (was Re: Internal airport card not
  working? (2.4.6-benh))
In-Reply-To: <4.2.2.20010714123138.01d64dc0@mail.inkverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just following up on a month old problem...

As I discovered, the problem was that I had to explicitly turn off encryption
via iwconfig.  I don't know whether the problem is in the card's firmware
(which I haven't updated yet) or in the driver initialization, but the
airport card works great under 2.4.6, and of course under the latest kernel
- 2.4.9-benh0.

-Jeremy

p.s. from /etc/network/interfaces:

auto eth1
iface eth1 inet static
         address 192.168.1.13
         netmask 255.255.255.0
         network 192.168.1.0
         broadcast 192.168.1.255
         gateway 192.168.1.1
         up iwconfig eth1 key off
         up iwconfig eth1 essid "Apple Network xxxxxx"
         up iwconfig eth1 mode Managed


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

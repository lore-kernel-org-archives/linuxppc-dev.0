Date: Mon, 20 Aug 2001 09:38:15 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Airport driver sleep problem and solution
Message-ID: <Pine.LNX.4.33.0108200926520.27201-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently found that, if the Airport card in an iBook I've been running
Linux on was not brought "up" at the time the system was put to sleep (by
putting the lid down), after bringing it back out of sleep, it would no
longer correctly operate until the driver was removed and reloaded -
ifconfig would receive an ENODEV error, and iwconfig would report that the
device had no wireless extensions. I found that the problem is on line 179
of linux/drivers/net/wireless/airport.c (v0.06f, in 2.4.9-benh0), where
the driver only calls "netif_device_attach" if card->open is TRUE - but it
unconditionally calls "netif_device_detach" in the PBOOK_SLEEP_NOW case.
Line 179 should be changed from "else if (card->open)" to just "else", so
that the network device is "reattached" to the networking subsystem.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39681DFA.57D95536@wanadoo.fr>
Date: Sun, 09 Jul 2000 08:38:50 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: pmac-time.c bug in 2.4.0-test3
References: <200007071603.RAA18464@hyperion.valhalla.net> <3965F335.42ABEEFD@erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Symptom: Booting a recent 2.4.0-test3 kernel from bitkeeper gives me a
wrong system time. The corresponding boot message is, for example
Jul  7 06:54:51 chezmoi kernel: GMT Delta read from XPRAM: 0 minutes,
DST: off
This is 2 hours off.

Booting with  2.2.17pre10 gives me the correct message
Jul  8 12:10:05 chezmoi kernel: GMT Delta read from XPRAM: 120 minutes,
DST: on

Looking through my log files, I find that this has been the same
situation since the changes in pmac-time.c were introduced:

In Paul's pmac-stable 2.2.16 and then in 2.2.17-pre5 from bk (patch of
21 June, according to bk sccstool), this XPRAM stuff showed up and
worked correctly.

In the bk linuxppc_2_3 tree, this showed up in 2.4.0-test3 on 27/28 June
(according to my logs), and it did not work correctly. In addition to
the wrong reading of the initial system time, I get the following
message every 61 (!) seconds
Jun 29 01:27:31 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
Jun 29 01:28:32 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
Jun 29 01:29:33 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
and so on.

I tried to set CONFIG_PPC_RTC to y or n, but this didn't seem to have an
influence. Other ideas for debugging?

My system is still the old Pmac 6400.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

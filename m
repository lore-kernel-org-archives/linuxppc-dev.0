Mime-Version: 1.0
Message-Id: <p04330100b5d2e13f47a5@[10.0.1.12]>
Date: Wed, 30 Aug 2000 12:21:18 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Paul Schinder <schinder@pobox.com>
Subject: Re: pmac-time.c bug in 2.4.0-test3  (and still in -test8)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In
<http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00157.html>,
Martin Costabel wrote:

>
>In the bk linuxppc_2_3 tree, this showed up in 2.4.0-test3 on 27/28 June
>(according to my logs), and it did not work correctly. In addition to
>the wrong reading of the initial system time, I get the following
>message every 61 (!) seconds
>Jun 29 01:27:31 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
>Jun 29 01:28:32 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
>Jun 29 01:29:33 chezmoi kernel: pmac_set_rtc_time: got 3 byte reply
>and so on.
>
>I tried to set CONFIG_PPC_RTC to y or n, but this didn't seem to have an
>influence. Other ideas for debugging?
>
>My system is still the old Pmac 6400.
>
>--
>Martin

I just tried Bitkeeper's 2.4.0-test8 rsynced yesterday morning.  X
(still using XFree 3.3.6) locked up on me this morning so I moved
back to a kernel built with Paul's  2.4.0-test6, but I saw this exact
problem while I was running -test8 (and last week with -test7, which
also locked up on me):

Aug 30 09:50:01 c22234-c kernel: pmac_set_rtc_time: got 3 byte reply
Aug 30 09:51:00 c22234-c kernel: pmac_set_rtc_time: got 3 byte reply

etc., once per minute.

This is on a Performa 6400/180.  I don't see it in Paul's test6.  It
doesn't seem to be a real problem except for the excessive logging,
since the clock seemed accurate (xntpd is running).  Does anyone know
what's happening and how to shut it up?  CONFIG_PPC_RTC was n for all
of these kernels.
--
--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 17 Jul 2002 13:42:22 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: SMP + raid1 + squid spinlock deadlock?
Message-ID: <20020717134222.L9288@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, my old MTX (dual 604ev) has been locking up about once every two
weeks or so, so I recompiled to day with #define SPINLOCK_DEBUG, and about
20 minutes later got the following:

_spin_lock(d7e753f8) CPU#0 NIP c01a31c8 holder: cpu 1 pc C01A099C

According to the system.map, the functions are:

c019ff44 t evdev_read
c01a3150 t end_sync_write


I have also seen a previous crashes in 'add_timer' several times where I
got dropped to xmon.

Squid somehow seems to be triggering these things, as I have seen squid as
the process running when it has dropped to xmon.

Have we got a race condition somewhere here? Is anyone else running squid
and/or raid1 on an SMP PPC box?

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

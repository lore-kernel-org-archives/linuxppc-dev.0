Message-ID: <3BB0AF37.A2041B64@chinook.com>
Date: Tue, 25 Sep 2001 12:22:15 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Solutions for Fast Software Upgrade in Linux/PPC
References: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would give some serious thought to the fast reboot idea.

[a related anecdote - a former colleague who worked for Caymam back in
the days when people bought Appletalk routers complained how they were
perceived as much less reliable than the Shiva product, even though the
Shiva crashed much more frequently.  It turns out that the Shiva
rebooted faster than the AppleTalk timeout, while the Cayman box
didn't...]

You can probably separate it into two halves, kernel and application.  I
can boot a 50MHz MBX860 up to /sbin/init in 6 seconds with an NFS root,
so I think 1 or 2 second kernel boot is quite feasible on a faster
machine with data in flash or (already spun up) local disk.  (PCI
scanning will take time, but you should be able to trim it significantly
with knowledge of your hardware)

Application startup depends.  You might investigate having all your
applications use a "checkpoint" or "pre-digested" format for their
configuration files, so that they can load config quickly at boot, and
save configuration before reboot.  This includes whatever application is
going to configure the kernel after boot, which I assume won't be
init+init.d/network+ifconfig etc.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

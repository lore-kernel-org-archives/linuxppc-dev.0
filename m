Message-ID: <B4DFCB7CDE2DD4118F690008C78694160100B68C@tahoe.allegronetworks.com>
From: Bruce Korb <bkorb@allegronetworks.com>
To: "'bh40@calva.net'" <bh40@calva.net>,
	"'acme@conectiva.com.br'" <acme@conectiva.com.br>,
	"'port-macppc@netbsd.org'" <port-macppc@netbsd.org>,
	"'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'support@apple.com'" <support@apple.com>,
	"'support@broadcom.com'" <support@broadcom.com>
Cc: "'matt@netbsd.org'" <matt@netbsd.org>,
	"'tsubai@netbsd.org'" <tsubai@netbsd.org>,
	"'bkorb@gnu.org'" <bkorb@gnu.org>
Subject: What's wrong with with the G4's GMAC interface?
Date: Sat, 21 Apr 2001 11:59:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everyone,

There is a significant problem with the GMAC ethernet device
on Apple's G4 platform.  This note summarizes what I have
learned of the issue in the past couple of days, a workaround,
some strange things the Linux driver does that may be related,
and finally a solicitation for input so we Open Software folks
can come to a consensus on the "right" fix.

The signal processing chip is the Broadcom BCM5201.


1.  The symptom

When NetBSD is running on the Apple G4 PowerMac and the GM0
interface is under heavy load, the system will appear to stop
dead in its tracks.  Its behavior actually becomes bursty
and packets are seen out of order.  This was first reported
on the net as early as March, 2000, some 14 months ago.

2.  The Problem

Every once in a while when under heavy load, the MII layer
becomes confused about which entry is next in the circular
buffer descriptor list.  So, it uses the wrong buffer and
wakes up the driver.  The driver wakes up, looks at the current
buffer, sees there is nothing to do and returns.  This keeps
happening until MII actually fills in the buffer the driver is
waiting for.  Things then work normally for a little bit, then
the driver discovers all the old messages and processes them
in a big batch.  This bursty behavior by the driver also seems
to have a positive feedback to the MII causing the problem to
more readily recur.

3.  A Solution

This solution is based solely on looking at ping traces and
the NetBSD source code.

At the end of interrupt processing, I perform a test to see
if any work was done.  If no work was done, then I test for
anomalous behavior, thus:

    if (sc->sc_rxlast != i) {
        sc->sc_rxlast = i;
        return;
    }
    for (;;) {
        i = (i + 1) & (NRXBUF - 1);
        if (sc->sc_rxlast == i)
            return;
        cmd = le32toh(sc->sc_rxlist[i].cmd);
        if (cmd & GMAC_OWN)
            continue;
        log(LOG_ERR,"reset GMAC read hand from %d to %d for %s\n",
            sc->sc_rxlast, i, sc->sc_dev.dv_xname);
        sc->sc_rxlast = i;
        goto again;
    }

Last night, we put a system under heavy load whereby with the
original NetBSD running we would have expected the behavior within
a half hour or so.  Here is the syslog:

Apr 20 19:04:37 olive-30 /netbsd: reset GMAC read hand from 31 to 1 for gm0
Apr 20 19:20:49 olive-30 /netbsd: reset GMAC read hand from 13 to 15 for gm0
Apr 20 20:01:33 olive-30 inetd[1665]: connection from 10.1.5.197, service
telnet (tcp)
Apr 20 20:01:47 olive-30 /netbsd: reset GMAC read hand from 11 to 19 for gm0
Apr 20 21:03:29 olive-30 /netbsd: reset GMAC read hand from 23 to 28 for gm0
Apr 20 21:04:19 olive-30 inetd[18011]: connection from 10.1.5.197, service
telnet (tcp)
Apr 20 21:11:30 olive-30 /netbsd: reset GMAC read hand from 28 to 13 for gm0
Apr 20 21:22:28 olive-30 /netbsd: sprious interrupt
Apr 20 21:26:57 olive-30 /netbsd: sprious interrupt

The event occurred five times over a period of three hours (we started
around 18:30).  The problem did not recur nearly as quickly or often
as when the OS waited for the hardware to fill in the expected buffer.
The behavior (other than the syslog) seemed normal.


4.  What the Linux driver does:

    gm->next_rx = i;
    if (last >= 0) { /* test for any work done */
        mb();
        GM_OUT(GM_RX_KICK, last & 0xFFFFFFFC);
    }

The "mb()" macro maps to the "sync" instruction that flushes both the
data cache and the instruction pipeline.  The "KICK" is the kicker.
I don't understand it.  "last" is the last successfully processed buffer
number.  Thus, the "GM_OUT()" macro basically seems to be telling the
hardware to go back 1 to 4 buffer slots for storing the next
received transmission.  That seems like it simply cannot be correct,
but that is certainly the way the code reads!  Can anyone clarify?
I have no experience using this.


5.  What does OS X (FreeBSD deriviative) do?

Someone at Apple?  Anyone?


6.  Is there any way of querying the hardware itself to ask it
its thoughts on the subject at hand?

Regards,
	Bruce Korb

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

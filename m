Date: Tue, 17 Apr 2001 22:04:55 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Possible bug in serial.c?
Message-ID: <Pine.LNX.4.21.0104172202200.15007-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This isn't just for PowerPC, however I thought I'd post it on here since I'm a member
of the list, and figured maybe someone here could fix it and get it rolled into the
main source tree at some point.  That is, if its actually a bug.

In the function early_serial_setup() in drivers/char/serial.c, It sets 'i' to
req->line.  This 'i' value is used as an index into the rs_table[] array.  At the
top of the funnction, it has:

	if (i >= NR_IRQS)
		return(-ENOENT);

Since 'i' is an index into the rs_table[], shouldn't this be:

	if (i >= NR_PORTS)
		return(-ENOENT);

This would just seem more appropriate..  Is this a typo/bug?

-Paul


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

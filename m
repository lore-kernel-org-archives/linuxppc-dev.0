Message-ID: <20031121015449.28462.qmail@web40911.mail.yahoo.com>
Date: Thu, 20 Nov 2003 17:54:49 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: 440gx ethernet lockup
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone actively working with ethernet on the 440GX?
 I'm seeing TX lockups when stressing the 10/100 EMAC
with heavy NFS traffic:

find /nfs_mnt -type f |xargs grep blahblahblah

This is the only way I can make it happen, but it does
happen quickly.

The 'get_next_packet' bit is set but never clears.
The EMAC_ISR doesn't have any unusual errors (except
for some deferrals).  The 'dead_bit' is _not_
asserted.  The MAL channels are enabled, and so is the
EMAC.  No TXDE interrupts have occurred.  The BD ring
is filled with packets ready to send.  The same code
on a 440GP works fine.  This version of the CPU (PVR
0x51b21851) is supposed to have all the EMAC-related
errata fixed, but this smells like a silicon bug to
me.

I'm still waiting on a response from IBM...  Any
ideas?

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

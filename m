Message-ID: <01C28974.1A34BA30.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using sys_sendto() in Kernel instead of sendto() in app
Date: Mon, 11 Nov 2002 11:18:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MPC860T, QMC-mode on SCC2.

When QMC data is available to be read from a particular
QMC channel, the SCC2 interrupts, and I want to
immediately read and send that data out to a destination
unit on the LAN using sys_sendto(), from within the ISR.
I already know the destination IP addr and UDP port, but
not the dest MAC addr.  So ARP is needed.

Using a network sniffer, after executing the 1st sys_sendto(),
I see that the IP stack ARPs for the dest unit's MAC addr,
and receives the ARP response which contains the MAC addr.
But then the IP stack sends an ICMP msg stating
"Destination Unreachable", and does not send any pkts to the
dest unit after that.

When I do the above using the usual sendto() from within my
app, it works fine, and after receiving the ARP response, the
sendto()'s send recd QMC pkts out onto the LAN continuously,
as normal.

Could I have some guidance on using sendto()'s (sys_sendto()'s)
from within the kernel?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

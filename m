Message-ID: <3F17A7DD.4080607@dgt-lab.com.pl>
Date: Fri, 18 Jul 2003 09:55:09 +0200
From: Adam Kaczynski <kaczor@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Previous by DateDate IndexNext by Date List Index Previous by ThreadThread
 IndexNext by Thread
	Re: Re: looking for mpc8260 mcc driver example for
 linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a description how I understand the difference between net and
character drivers for HDLC:

The HDLC is basically a L2 protocol used to carry frames over a
synchronous channel like a timeslot/group of timeslots on a TDM
interface (it is used in modem protocols too but it is off-topic here).

The HDLC protocol can be used therefore as a lower sublayer for
synchronous-PPP or Cisco HDLC or Frame Relay (or X.25) protocol. A
specific hardware-based HDLC driver in Linux is connected then to a
generic upper-sublayer HDLC driver which takes care on frame headers,
service frames and timers. The sources of the generic driver and some
particular lower-level (HW-dependant) drivers are in /linux/drivers/net/wan/

The net driver for MPC860 is available from our web-site.

Additionally the HDLC protocol is widely used in telecommunication
protocols like ISDN, V5.1,V5.2, GR.303 and SS-7. It can be also used for
internal communication inside a phone switch etc. Usually the upper
layer is LAP-D. It can be easier to implement the processing of these
protocols in User Space than in kernel. The simpliest way of presenting
raw framed data to User Space (in Linux) is using read/write/(poll or
fasync) methods on a character device inode.

This is probably the reason why the driver
https://sourceforge.net/projects/mcc8260/
is a character one.

NB. I was not aware of this project and I've developed my own (very
simple) character-device driver for HDLC/transparent channels on 8260
MCC. Many thanks to mailto:omanakuttan@tataelxsi.co.in for his howto and
his help!

Now the driver is finished and will be released under GPL soon, after
passing tests. If someone wants to see the code now, please let me know.

If someone wants to wrap the driver to fit into the "net" domain, I can
advice how to do it.

Regards,

Adam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

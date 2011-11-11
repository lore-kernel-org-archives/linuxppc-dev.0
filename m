Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 6EE7C1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 02:32:09 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08970-08 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 11 Nov 2011 15:32:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Disabling TCP slow start after idle
Date: Fri, 11 Nov 2011 15:30:23 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEBA@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have some connections that suffer very badly from the TCP
'slow start' algorithm. These are connections that will
always be local - they may be MAC-Switch-MAC using RGMII
crossover, they might also be connected via an external
switch. In either case the RTT is most likely to be almost
zero, certainly below 1ms.

The traffic is single packets (carrying another protocol)
so we have Nagle disabled and the send and receive sides
run separately. So the traffic is neither bulk, nor
command/response.

This means that there is very rarely any unacked data,
so almost every packet is sent using 'slow start'.

If the external switch drops a packet (they do!) then
slow start stops more packets being sent, and nothing
progresses for about 1.5 seconds by which time there
is a significant amount of traffic queued and, in some
cases, data has to be discarded.

Similar issues happen if the receiving system decides
to defer the ack until a timer tick (instead of
sending one after every second packet). In this case
only 4 packets are sent. (We fixed this one be sending
a software ACK every 4 packets.)

Quite cleary the 'slow start' algorithm just doesn't
work in these cases.

I found this https://lkml.org/lkml/2010/4/9/427
discussion about a socket option to disable slow start.
But it seems that some people are completely against the idea.
I'd have thought that the global option would be more of a
problem - since that will affect ftp connections to remote
hosts where slow start is alomost certainly benefitial.

I'd have thought it would be sensible to allow one (or more)
of the following (either as a sysctl, socket option, or
code change):
1) Disable slow start for the local subnet.
2) Disable slow start for connections with very low RTT.
3) Disable slow start for a minimum period with no traffic
   (after the last packet is acked).

I'm not sure of the resolution used by the Linux RTT
calculations. I know NetBSD had a recent set of patches
to fix calculation errors with low RTT because the code
had been written when all RTT were much longer.

	David

(Copied to linuxppc-dev because I'm subscribed to it.)

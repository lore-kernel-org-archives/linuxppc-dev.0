Return-Path: <imrek@atomki.hu>
Received: from imrek.org (unknown [193.6.168.119])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F8A1DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 05:28:35 +1100 (EST)
Received: from localhost ([127.0.0.1]) by imrek.org with esmtp (Exim 4.54)
	id 1HGfbt-0007dQ-Vr
	for linuxppc-embedded@ozlabs.org; Mon, 12 Feb 2007 19:09:06 +0100
Date: Mon, 12 Feb 2007 19:09:05 +0100 (CET)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Speed of plb_temac 3.00 on ML403
In-Reply-To: <BAY110-F2794FF16F3A122FD2309AFB2920@phx.gbl>
Message-ID: <Pine.LNX.4.61.0702121803500.27337@imrek.org>
References: <BAY110-F2794FF16F3A122FD2309AFB2920@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 11 Feb 2007, Ming Liu wrote:

> In the end, it shows 996Mb/sec, which means the throughput is 996Mbps(almost 
> gigabit), right?

yes.. :)



> However I don't think this result is so meaningful because it bypass the 
> processing for TCP/UDP packets. In the practical implementation, that's not 
> possible. The TCP/UDP packets have to been processed, right?  In fact, this

on the contrary: our whole design is built on the principle that with UDP
you do not need too much handling/processing, and your data path can
bypass the IP stack, the CPU, and with some work even the main memory.

with TCP you (the os) have to take care of connection set up and tear
down, acknowledgements, packet retransmission (and for that you need to
save the packets until they are ack'ed!), etc. in return you get reliable
data transmission, which is a must in many applications.

however we don't need that. duplication or loss of a packet, or reordering
of packets (which could happen when using UDP) would not be a critical
problem for us. but these are mostly theoretical issues, they don't realy
happen on our dedicated daq network (except for packet losses that we
deliberately use as poor man's flow control).


but all theese might be off topic on this list..




> almost gigabit speed is just a representation of the Gigabit ethernet 
> capability while the bottleneck of the system is not there. So I still need 
> to solve my practical unsatisfying performance in my design. :(

at least it will probably help you narrowing the problem down.. good
luck!



-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------

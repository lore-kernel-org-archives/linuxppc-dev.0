Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s34.bay0.hotmail.com (bay0-omc3-s34.bay0.hotmail.com
	[65.54.246.234]) by ozlabs.org (Postfix) with ESMTP id 27966DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 06:18:07 +1100 (EST)
Message-ID: <BAY110-F266A0C4987983C9B579C76B2910@phx.gbl>
In-Reply-To: <Pine.LNX.4.61.0702121803500.27337@imrek.org>
From: "Ming Liu" <eemingliu@hotmail.com>
To: imrek@atomki.hu
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Mon, 12 Feb 2007 19:18:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Jozsef,

>on the contrary: our whole design is built on the principle that with UDP
>you do not need too much handling/processing, and your data path can
>bypass the IP stack, the CPU, and with some work even the main memory.
>
>with TCP you (the os) have to take care of connection set up and tear
>down, acknowledgements, packet retransmission (and for that you need to
>save the packets until they are ack'ed!), etc. in return you get reliable
>data transmission, which is a must in many applications.
>
>however we don't need that. duplication or loss of a packet, or reordering
>of packets (which could happen when using UDP) would not be a critical
>problem for us. but these are mostly theoretical issues, they don't realy
>happen on our dedicated daq network (except for packet losses that we
>deliberately use as poor man's flow control).

In fact, in our application we also use UDP. I know UDP need less CPU 
processing capability than TCP. However, just like what I measured, my UDP 
performance is around 350Mbps and TCP performance is 270Mbps when 
Jumbo-frame enabled. In my application, I have to use the CPU to process 
the UDP or TCP packets. Then this "need not too much processing"  results 
the much lower performance as I listed above. :(

You said in your application the data path can bypass the IP stack, the 
CPU, and with some work even the main memory. How can you achieve that? 
Then who will process the UDP packets? If you add the work of processing 
packets in, do you have some idea on how fast can your network achieve? I 
believe it will be much lowered, right? :)

Thanks for your discussion.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  

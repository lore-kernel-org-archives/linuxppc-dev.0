Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8176C67BA6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Sep 2006 08:56:11 +1000 (EST)
Received: from slip-12-65-222-48.mis.prserv.net ([12.65.222.48]:1141)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GKMsm-0004Pt-IF by authid <dhlii> with plain_server
	for <linuxppc-embedded@ozlabs.org>; Mon, 04 Sep 2006 18:25:36 -0400
Message-ID: <44FCA93E.1000009@dlasys.net>
Date: Mon, 04 Sep 2006 18:31:26 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MAC driver issues
References: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>
	<Pine.LNX.4.60.0609042336020.5921@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0609042336020.5921@poirot.grange>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to get a network driver working.

It sends - I can capture the output with Etherreal and it looks good.
It receives - I can dump the received packets when the come in and they 
look ok to me.


BUT,
    If I try to ping another host, first Linux sends and ARP broadcast, 
the appropriate client sends an ARP response.
    Etherreal is happy with both.
    My driver gets the response - The driver says the packet lenght is 
64 bytes, which includes something like 14 bytes of padding at the end.
    But the actual packet looks perfect exactly like what etherreal says 
it should (and what I get when I capture a received ARP packet in 
another driver).
    At the end of the recive interrupt the skb is passed to Linux with 
the netif_rc(ndev) function. This returns SUCCESS.

    However, the paket never gets handed of to the ARP protocol - I put 
some debugging in there and I never see it, while if I switch to a 
different  NIC
    driver nearly the identical ARP packet gets processed by arp inside 
Linux.

    I have tried to chase this down, but I can't  follow what is going 
on inside of all the /net/core/dev.c etc.

    Has anyone seen something similar to this ?

    Does anyone have a clue where I can find some info  on trying to 
follow something through netif_rx to see where things are going off the 
rails ?



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

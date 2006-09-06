Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 205A167B7E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 16:29:27 +1000 (EST)
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1648)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GKqkR-0001B2-9D by authid <dhlii> with plain_server
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Sep 2006 02:18:55 -0400
Message-ID: <44FE69F2.40409@dlasys.net>
Date: Wed, 06 Sep 2006 02:25:54 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MAC driver issue
References: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>
	<Pine.LNX.4.60.0609042336020.5921@poirot.grange>
	<44FCA93E.1000009@dlasys.net>
	<44FD3640.30208@cambridgebroadband.com>
In-Reply-To: <44FD3640.30208@cambridgebroadband.com>
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

Alex Zeffertt wrote:
> Hi David,
>
> I think in order to get any help from this list you need to be more 
> specific
> about how this problem relates to PowerPCs.
    The relationship is weak - the driver is for a NIC in an embedded 
PPC 405.
    I was just hoping that someone here might have experienced a similar 
problem and have an idea what the answer might be -
    rather than join another list - I am sure there must be something 
like a network drivers list


>
> You also need to say exactly what "never gets handed off to the ARP 
> protocol"
> means.

    I mean I put a printk into the ARP protocol handler and in the 
working case I get to the prink, and in the failing case I don't.

    I have tried inspecting  netif_rx - but  it just queues up received 
packets - and in both my cases returns success.

    I am basically tryng to figure out what is it that the inbound 
network stack is upset about - somewhere it must have decided to reject
    my data, if I knew what it did not like, I would have a clue what to 
fix.  

> FWIW, in my experience the hardware independent parts of the 
> networking stack are
> very stable and the problem is almost always with the drivers, or with 
> the IP
> configuration (e.g. two interfaces on the same subnet).
    I have no doubt it is with the driver.  I am somewhat fortunate in 
this instance that I have a nearly identical setup - this is an FPGA 
based system
    I can swap the FPGA firmware, get an almost identical kernel with a 
slightly different NIC, and everything works - same cables, same IP's,
    Same switch, The only things different are the NIC and its driver. 
Even the Linux kernels are identical - except the NIC driver.
   
    BUT so is the data received and passed on to the kernel (outside 
random differences in the padding of the ARP packet)
    One works the other doesn't.


   


But since everything looks perfect, I have no clue where to start looking.
>
> Alex
>
> David H. Lynch Jr. wrote:
>> I am trying to get a network driver working.
>>
>> It sends - I can capture the output with Etherreal and it looks good.
>> It receives - I can dump the received packets when the come in and 
>> they look ok to me.
>>
>>
>> BUT,
>>     If I try to ping another host, first Linux sends and ARP 
>> broadcast, the appropriate client sends an ARP response.
>>     Etherreal is happy with both.
>>     My driver gets the response - The driver says the packet lenght 
>> is 64 bytes, which includes something like 14 bytes of padding at the 
>> end.
>>     But the actual packet looks perfect exactly like what etherreal 
>> says it should (and what I get when I capture a received ARP packet 
>> in another driver).
>>     At the end of the recive interrupt the skb is passed to Linux 
>> with the netif_rc(ndev) function. This returns SUCCESS.
>>
>>     However, the paket never gets handed of to the ARP protocol - I 
>> put some debugging in there and I never see it, while if I switch to 
>> a different  NIC
>>     driver nearly the identical ARP packet gets processed by arp 
>> inside Linux.
>>
>>     I have tried to chase this down, but I can't  follow what is 
>> going on inside of all the /net/core/dev.c etc.
>>
>>     Has anyone seen something similar to this ?
>>
>>     Does anyone have a clue where I can find some info  on trying to 
>> follow something through netif_rx to see where things are going off 
>> the rails ?
>>
>>
>>
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

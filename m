Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AF0167B8C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Sep 2006 18:33:14 +1000 (EST)
Message-ID: <44FD3640.30208@cambridgebroadband.com>
Date: Tue, 05 Sep 2006 09:33:04 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: MAC driver issues
References: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>	<Pine.LNX.4.60.0609042336020.5921@poirot.grange>
	<44FCA93E.1000009@dlasys.net>
In-Reply-To: <44FCA93E.1000009@dlasys.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi David,

I think in order to get any help from this list you need to be more specific
about how this problem relates to PowerPCs.

You also need to say exactly what "never gets handed off to the ARP protocol"
means.

FWIW, in my experience the hardware independent parts of the networking stack are
very stable and the problem is almost always with the drivers, or with the IP
configuration (e.g. two interfaces on the same subnet).

Alex

David H. Lynch Jr. wrote:
> I am trying to get a network driver working.
> 
> It sends - I can capture the output with Etherreal and it looks good.
> It receives - I can dump the received packets when the come in and they 
> look ok to me.
> 
> 
> BUT,
>     If I try to ping another host, first Linux sends and ARP broadcast, 
> the appropriate client sends an ARP response.
>     Etherreal is happy with both.
>     My driver gets the response - The driver says the packet lenght is 
> 64 bytes, which includes something like 14 bytes of padding at the end.
>     But the actual packet looks perfect exactly like what etherreal says 
> it should (and what I get when I capture a received ARP packet in 
> another driver).
>     At the end of the recive interrupt the skb is passed to Linux with 
> the netif_rc(ndev) function. This returns SUCCESS.
> 
>     However, the paket never gets handed of to the ARP protocol - I put 
> some debugging in there and I never see it, while if I switch to a 
> different  NIC
>     driver nearly the identical ARP packet gets processed by arp inside 
> Linux.
> 
>     I have tried to chase this down, but I can't  follow what is going 
> on inside of all the /net/core/dev.c etc.
> 
>     Has anyone seen something similar to this ?
> 
>     Does anyone have a clue where I can find some info  on trying to 
> follow something through netif_rx to see where things are going off the 
> rails ?
> 
> 
> 

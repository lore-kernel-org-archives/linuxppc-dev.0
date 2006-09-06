Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AD3B67B8C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 18:25:47 +1000 (EST)
Message-ID: <44FE85FE.2010608@cambridgebroadband.com>
Date: Wed, 06 Sep 2006 09:25:34 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: MAC driver issue
References: <405ECA8A30557F439A723E52D50838F9D829C6@ZMY16EXM66.ds.mot.com>	<Pine.LNX.4.60.0609042336020.5921@poirot.grange>	<44FCA93E.1000009@dlasys.net>	<44FD3640.30208@cambridgebroadband.com>
	<44FE69F2.40409@dlasys.net>
In-Reply-To: <44FE69F2.40409@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

>> FWIW, in my experience the hardware independent parts of the 
>> networking stack are
>> very stable and the problem is almost always with the drivers, or with 
>> the IP
>> configuration (e.g. two interfaces on the same subnet).

>     I have no doubt it is with the driver.  I am somewhat fortunate in 
> this instance that I have a nearly identical setup - this is an FPGA 
> based system
>     I can swap the FPGA firmware, get an almost identical kernel with a 
> slightly different NIC, and everything works - same cables, same IP's,
>     Same switch, The only things different are the NIC and its driver. 
> Even the Linux kernels are identical - except the NIC driver.
>    
>     BUT so is the data received and passed on to the kernel (outside 
> random differences in the padding of the ARP packet)
>     One works the other doesn't.
> 

Well ethernet device drivers contain multiple arp supporting methods,
e.g. header_cache, header_cache_update, hard_header_parse, etc etc.
Generally driver writers don't need to concern themselves about these
as they are assigned to generic handlers by ether_setup().  However,
your problematic driver may do something different.

Given this problem appears to be driver specific rather than PPC
specific your best bet is to try and contact the author.  BTW, I don't
think you've said which driver you are using, a key piece of info....

Alex

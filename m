Return-Path: <shemminger@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B85AD67B22
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 11:31:52 +1000 (EST)
Message-ID: <44E7BB7F.7030204@osdl.org>
Date: Sat, 19 Aug 2006 18:31:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222657.GL26889@austin.ibm.com>
	<200608190103.05649.arnd@arndb.de>
	<200608190256.26373.arnd@arndb.de>
In-Reply-To: <200608190256.26373.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
	Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Saturday 19 August 2006 01:03, Arnd Bergmann wrote:
>   
>> Someone should probably document that in 
>> Documentation/networking/NAPI_HOWTO.txt, I might end up doing that
>> once we get it right for spidernet
>>     

The reason reclaim via poll() is efficient is because it avoid causing a 
softirq that is
necessary when skb_free_irq() is done. Instead it reuses the softirq 
from the poll()
routine. Like all Rx NAPI, using poll() for reclaim means:
    + aggregating multiple frames in one irq
    - increased overhead of twiddling with the IRQ mask
    - more ways to get driver stuck
   
Some drivers do all their irq work in the poll() routine (including PHY 
handling).
This is good if reading the IRQ status does an auto mask operation.

The whole NAPI documentation area is a mess and needs a good writer
to do some major restructuring. It should also be split into reference 
information,
tutorial and guide sections.

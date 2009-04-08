Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id D5486DDF71
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 10:07:56 +1000 (EST)
Message-ID: <49DBEB8F.2040307@embeddedarm.com>
Date: Tue, 07 Apr 2009 17:10:55 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: AMCC 440EP phy detection
References: <49DB8033.1090908@embeddedarm.com>
	<fa686aa40904071011n22084931wc8900606fd62f167@mail.gmail.com>
In-Reply-To: <fa686aa40904071011n22084931wc8900606fd62f167@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Thanks for the suggestions :)

I found the ibm_newemac driver(2.6.29) makes the assumption that the bootloader 
has already configured the tx enable pin as it is a multiplexed pin. 
Unfortuantley I am not using U-Boot and our minimal bootloader does not do this. 
  After finding tx enable was never asserting for Eth0 a quick user space 
program verified tx enable was configured as a GPIO pin.

> On Tue, Apr 7, 2009 at 9:32 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
>> Hello,
>>
>> I'm working on a board based on the Yosemite AMCC 440EP eval board. I'm
>> having some difficulty getting both network interfaces working. The first
>> problem I found is the ibm_newemac driver was detecting the two phys at
>> address 0 and 1 where we have them wired for addresses 1 and 3. As a result
>> I hardcoded the phy-address in the dts file. I then found I was able to
>> receive and send data on eth1(phy-address 3) without incident. Although I
>> found eth0 can receive data but I see no packets being transmitted(using a
>> packet sniffer) and I see no indication from a software standpoint of any
>> transmit failures. We are using Micrel KSZ8041FTL phys(RMII mode) where the
>> Yosemite board used Micrel KS8721BL phys.  I've reviewed the schematic and
>> it appears both phys are connected identically and I've seen this same
>> failure on multiple boards. I thought the fact that the driver detected a
>> phy at address 0 might be a clue, but I can't make much of the clue. So I
>> thought I'd post this info in the hopes someone else might have run into a
>> similar problem or have a suggestion.
> 
> Phy address 0 is the broadcast address.  All phys will usually respond
> to address 0 accesses.  Off the top of my head, It sounds like one PHY
> is responding to addresses 0 & 1, and the other phy isn't responding
> at all.
> 
> g.
> 


-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

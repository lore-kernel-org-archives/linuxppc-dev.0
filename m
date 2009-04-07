Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 352DADDE9E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 02:29:55 +1000 (EST)
Message-ID: <49DB8033.1090908@embeddedarm.com>
Date: Tue, 07 Apr 2009 09:32:51 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: AMCC 440EP phy detection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm working on a board based on the Yosemite AMCC 440EP eval board. I'm having 
some difficulty getting both network interfaces working. The first problem I 
found is the ibm_newemac driver was detecting the two phys at address 0 and 1 
where we have them wired for addresses 1 and 3. As a result I hardcoded the 
phy-address in the dts file. I then found I was able to receive and send data on 
eth1(phy-address 3) without incident. Although I found eth0 can receive data but 
I see no packets being transmitted(using a packet sniffer) and I see no 
indication from a software standpoint of any transmit failures. We are using 
Micrel KSZ8041FTL phys(RMII mode) where the Yosemite board used Micrel KS8721BL 
phys.  I've reviewed the schematic and it appears both phys are connected 
identically and I've seen this same failure on multiple boards. I thought the 
fact that the driver detected a phy at address 0 might be a clue, but I can't 
make much of the clue. So I thought I'd post this info in the hopes someone else 
might have run into a similar problem or have a suggestion.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

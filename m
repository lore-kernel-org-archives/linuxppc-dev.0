Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 251E3DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 21:21:18 +1000 (EST)
Message-ID: <46F79D6C.5070500@ru.mvista.com>
Date: Mon, 24 Sep 2007 15:20:12 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: AMCC yosemite 440ep PCI slot doesn't work.
References: <46F3A2C4.7000202@windriver.com> <46F3DFCA.1040700@ru.mvista.com>
	<46F784B0.1040600@windriver.com> <200709241314.18123.sr@denx.de>
In-Reply-To: <200709241314.18123.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Monday 24 September 2007, Andrew Liu wrote:
>> By default, it is IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE
> 
> And that should be correct for PCI interrupts.
> 
>>  I change it to IRQ_SENSE_EDGE | IRQ_POLARITY_NEGATIVE  or
>> IRQ_SENSE_EDGE | IRQ_POLARITY_POSITIVE.
>> It  displays:
>> eth2: link up, 100Mbps, full-duplex, lpa 0x45E1
>> eth2: no IPv6 routers present
>> NETDEV WATCHDOG: eth2: transmit timed out
>> eth2: Transmit timeout, status 0c 0005 c07f media 10.
>> eth2: Tx queue start entry 4  dirty entry 0.
>> eth2:  Tx descriptor 0 is 0008a05a. (queue head)
>> eth2:  Tx descriptor 1 is 0008a04e.
>> eth2:  Tx descriptor 2 is 0008a046.
>> eth2:  Tx descriptor 3 is 0008a05a.
>> eth2: link up, 100Mbps, full-duplex, lpa 0x45E1
>>
>> and
>> root@localhost:/root> ifconfig  eth2
>> eth2      Link encap:Ethernet  HWaddr 00:0E:2E:7E:F5:E6
>>           inet addr:128.224.149.13  Bcast:128.224.255.255  Mask:255.255.0.0
>>           inet6 addr: fe80::20e:2eff:fe7e:f5e6/64 Scope:Link
>>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>>           Interrupt:25 Base address:0x6f00
>>
>>
>> and
>> root@localhost:/root> cat /proc/interrupts
>>            CPU0
>>   2:          0  UIC0 Edge      IBM IIC
>>   7:          0  UIC0 Edge      IBM IIC
>>  10:      11961  UIC0 Edge      MAL TX EOB
>>  11:      18471  UIC0 Edge      MAL RX EOB
>>  25:          0  UIC0 Edge      eth2
>>  32:          0  UIC1 Edge      MAL SERR
>>  33:          0  UIC1 Edge      MAL TX DE
>>  34:          0  UIC1 Edge      MAL RX DE
>>  40:         32  UIC1 Edge      ohci_hcd:usb1
>>  60:          0  UIC1 Edge      EMAC
>> BAD:          0
>>
>>
>> Can PCI slot use level trigger?
>>
>> give me some advice.

This could be caused by misseting the IRQ_lEVEL flag in desc->status.
There have been a commit 4dc7b4b0405fd7320940849b6e31ea8ea68fd0df that 
fixes the problem.
Thanks,
Valentine.

> 
> Hmmm. Did you try an earlier Linux version too? For example 2.6.22 or even 
> earlier? Please give it a try and let us know if the same problem occurs.
> 
> Best regards,
> Stefan
> 
> =====================================================================
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
> =====================================================================

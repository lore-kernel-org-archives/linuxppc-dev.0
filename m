Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2DB7BDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 21:15:06 +1000 (EST)
Message-ID: <46F10478.1080506@ru.mvista.com>
Date: Wed, 19 Sep 2007 15:14:00 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] PowerPC: Fix Sequoia MAL0 and EMAC dts entries.
References: <20070918172510.GA30944@ru.mvista.com>
	<20070918172913.GA31098@ru.mvista.com>
	<20070919010526.GA23646@localhost.localdomain>
In-Reply-To: <20070919010526.GA23646@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Sep 18, 2007 at 09:29:13PM +0400, Valentine Barshak wrote:
>> According to PowerPC 440EPx documentation,
>> MAL0 is comprised of four channels (two transmit and two receive).
>> Each channel is dedicated to one of two EMAC cores.
>> This patch fixes Sequoia DTS MAL0 entry and EMAC entries,
>> assigning correct channel numbers to EMACs.
> 
> Hrm.. did they change the EMAC in 440EPx to only use one MAL
> tx-channel?  All the older ones could use two (for no readily apparent
> reason, IMO).
> 
Yes, they did.
Just 1 tx and 1 rx-channel per EMAC. Just 2 bits to select channels, 
while all other bits in MAL registers are reserved.
I'm not sure why they did it (possible bus bandwidth problems), but it's 
impossible to set more than 1 rx/tx channel for each EMAC in 440EPx.

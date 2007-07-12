Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8596BDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:55:27 +1000 (EST)
In-Reply-To: <0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
Date: Thu, 12 Jul 2007 02:55:25 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>>>> +             pci@a000 {
>>>> +                     interrupt-map-mask = <f800 0 0 7>;
>>>> +                     interrupt-map = <
>>>> +
>>>> +                             /* IDSEL 0x0 (PEX) */
>>>> +                             00000 0 0 1 &mpic 0 1
>>>> +                             00000 0 0 2 &mpic 1 0
>>>> +                             00000 0 0 3 &mpic 2 0
>>>> +                             00000 0 0 4 &mpic 3 0>;
>>>
>>> Why sense 0 for all but the first entry in this map?
>> Now, only the first entry is used.
>
> Sure, but the other three entries are incorrect.  Either
> provide correct entries, or just leave the unused entries
> out of the map; if those three interrupts aren't wired up,
> that is the right thing to do, too.

Yeah these should be sense 1 for irq b, c, d.  I'll fix that up when  
I apply the patch.

- k

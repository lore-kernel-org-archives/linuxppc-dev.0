Mime-Version: 1.0
Message-Id: <a05010406b7033c861041@[192.168.240.10]>
In-Reply-To: <20010418115224.25139@mailhost.mipsys.com>
References: <a05010404b703232d1b66@[192.168.240.10]>
 <20010418115224.25139@mailhost.mipsys.com>
Date: Wed, 18 Apr 2001 15:25:33 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Re: benh 2.4.4-pre3, Titanium and AirPort
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >I am currently using Benjamin Herrenschmidt 2.4.4-pre3 kernel on my
>>Titanium. The only problem I am currently experiencing is that the
>  >kernel PCMCIA i82365.c driver do not recognized the PCI cardbus
>>adaptator.
>
>Looks like I'll really have to find a PCMCIA card...

not needed for the test, what seems to be not functionning is the
loading of i82365 module (in the errorlog, it indicates he found no
adaptator). Under a pismo there is no such problem.

>
>>Is there any solution (patch) to get it recognized ?
>>
>>Also as the current airport driver is now based on the orinoco_cs
>>(and hermes) driver that depends on PCMCIA support, I am unable to
>>get airport working. Is there any solution to get it working without
>>PCMCIA ?
>
>The airport driver should work if you built PCMCIA in the kernel
>(no need to actually have a working PCMCIA).

I have built PCMCIA in the kernel, but the problem is that to load
orinico_cs, we must first load the PCMCIA support because it depends
on ds that depends on a working pcmcia adaptor driver (i82365 in
previous powerbooks).

The problem seems that i82365 seems not recognizing the cardbus on
titanium. lspci output is :

01:1a.0 CardBus bridge: Texas Instruments PCI1211
         Flags: bus master, medium devsel, latency 16, IRQ 58
         Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=01, secondary=02, subordinate=05, sec-latency=32
         I/O window 1: 00000000-00000003
         16-bit legacy interface ports at 1011

>
>I'm working on a separation of the airport and pcmcia stuffs so
>that the airport driver can be used without pcmcia, but it's not
>done yet.

Yes, probably we need a separate orinoco_cs and airport driver,
perhaps depending both on the same implementation module (hermes
driver ?).

>
>Ben.

Regards,
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

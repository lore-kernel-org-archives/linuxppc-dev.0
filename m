Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B32A679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 18:04:33 +1000 (EST)
In-Reply-To: <446141A2.9030000@am.sony.com>
References: <446141A2.9030000@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8C718CC-C7FF-4465-B159-5F3E48810171@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: pci_resource_end problem revisited
Date: Wed, 10 May 2006 10:04:19 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I still have this problem of OF reporting the serial port bar
> size as 16 instead of 8 on my G5.  Where would be a proper
> place to fix this?  BTW, I verified that it is OF that reports
> the size as 16.

Make fixup_device_tree() fix the dev tree itself?

> 0001:05:03.0 Serial controller: NetMos Technology PCI 9845 Multi-I/ 
> O Controller (rev 01) (prog-if 02 [16550])
>         Subsystem: LSI Logic / Symbios Logic 0P4S (4 port 16550A  
> serial card)
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-  
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 53
>         Region 0: I/O ports at f4000050 [size=16]
>         Region 1: I/O ports at f4000040 [size=16]
>         Region 2: I/O ports at f4000030 [size=16]
>         Region 3: I/O ports at f4000020 [size=16]
>         Region 4: I/O ports at f4000010 [size=16]
>         Region 5: I/O ports at f4000000 [size=16]

Also note that the last BAR is at legacy I/O address 0, various things
will break due to bogus assumptions... this BAR is not needed for the
UARTs though :-)


Segher

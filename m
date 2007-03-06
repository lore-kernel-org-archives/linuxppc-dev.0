Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61C06DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Mar 2007 01:55:29 +1100 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l26EtJUo006711
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Mar 2007 15:55:21 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45ED80AB.9010907@246tNt.com>
Date: Tue, 06 Mar 2007 15:54:35 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: Dereferencing phys addr IMMAP works even if it is not a virtual
	address. Strange?
References: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0B3A@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0B3A@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1
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

DI BACCO ANTONIO - technolabs wrote:
> Now I'm doing a ioremap_nocache of IMMAP and using the virtual pointer
> returned to access my 880 registers but also using the physical
> address it works, I can access the registers.
If the IMMAP base is high (like 0xf0000000 ) and therefore doesn't
collide with anything, it's quite common practice to map it statically
using a BAT somewhere in the setup code and often it's mapped such that
phys = virt ...

So a physical address in this zone is equal to a virtual addres ...

When that's the case, ioremap detects the BAT mapping and just does
nothing. But you should always use ioremap nonetheless ... because if at
some point some one decide to move the BAT mapping, if you didn't do
things properly your code will break.

Sylvain

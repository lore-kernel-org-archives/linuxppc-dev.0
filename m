Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 064F52BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 04:41:57 +1100 (EST)
Date: Wed, 5 Jan 2005 09:41:54 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Message-ID: <20050105174154.GB14485@gate.ebshome.net>
References: <000001c4f32b$cfe37470$5201a8c0@GEG2400>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c4f32b$cfe37470$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8260 strange virtual addresses returned by kmalloc()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 02:38:12PM +0100, Laurent Lagrange wrote:
> Hi and Happy New Year to all,
> 
> I use a Linux 2.4.25 kernel on a MPC8260 custom board with 128MB of RAM.
> PCI is activated and my drivers are loaded as modules.
> The RAM is mapped at 0xC0000000 as usual.
> 
> On MPC8XX I used kmalloc and iopa to get the physical addresses of the
> allocated buffers.
> On MPC82XX I used kmalloc and __pa for the same thing and it worked fine
> with previous kernel.
> 
> But now, when I want to use kmalloc, I get addresses like 0xC9xxxxxx.
> The __pa gives me physical addresses 0x09xxxxxx which are out of my physical
> RAM.
> I tried old iopa function and got some real physical addresses and the
> module works.
> The virt_to_bus gives me too addresses like  0x09xxxxxx
> (ie substract kernel base address 0xC0000000 as usual).
> 
> I don't understand why I get virtual addresses which seem to be out of my
> memory and why it runs.

Yeah, this looks strange, please, check that this address is really 
from kmalloc and not from vmalloc.

Also, check that PAGE_OFFSET is really 0xc000'0000.

> More, I have a global variable which is a little buffer. It is also mapped
> at a 0xC9xxxxxx address.

Is this global variable in the loaded module? If yes, this is normal, 
because modules are loaded into vmalloced space and you cannot use 
__pa for such addresses.

--
Eugene

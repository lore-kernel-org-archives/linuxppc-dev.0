Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D50A467BB6
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 09:58:20 +1000 (EST)
Message-ID: <44F4D458.7030707@am.sony.com>
Date: Tue, 29 Aug 2006 16:57:12 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: undefined reference to pci_io_base
References: <44F47ABE.7080602@am.sony.com>
	<17652.49904.419167.448821@cargo.ozlabs.ibm.com>
	<20060829232026.GC27372@austin.ibm.com>
In-Reply-To: <20060829232026.GC27372@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Wed, Aug 30, 2006 at 08:42:56AM +1000, Paul Mackerras wrote:
>> Geoff Levand writes:
>> 
>> > I'm trying to understand the intended design of the inb()
>> > and outb() macros in asm-powerpc/io.h. They are causing
>> > me some grief when I set CONFIG_PCI=n:
>> > 
>> >   drivers/built-in.o: undefined reference to `pci_io_base'
>> > 
>> > This is coming from drivers/char/mem.c, which is always
>> > built in, and is referencing pci_io_base through inb()
>> > and outb().
>> 
>> Hmmm.  inb and outb are designed for accessing PCI I/O space.  I guess
>> we could turn them into BUG() when CONFIG_PCI=n.
> 
> I just looked at drivers/char/mem.c and the code in question
> is surrounded by 
> 
> #if defined(CONFIG_ISA) || !defined(__mc68000__)
> 
> which seems just plain wrong.
> 
> It should probably be changed to 
> 
> #if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)
> 
> This code surrounds fileops to enale fileio on /dev/port
> which maps to inb/outb.  
> 
> Do we want to enable /dev/port for pci space ??

I found the same, but was thinking

#if defined(CONFIG_ISA) && !defined(__mc68000__)

So it is only built when CONFIG_ISA=y.  Is there any
reason to always have it whit PCI?

Paul, can I send you that fix, or should I send it to
someone else?

-Geoff

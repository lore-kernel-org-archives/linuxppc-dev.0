Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BD5667B22
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 09:20:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7TNKRJI015269
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 19:20:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7TNKQkb264092
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:20:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7TNKQwe032454
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:20:26 -0600
Date: Tue, 29 Aug 2006 18:20:26 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: undefined reference to pci_io_base
Message-ID: <20060829232026.GC27372@austin.ibm.com>
References: <44F47ABE.7080602@am.sony.com>
	<17652.49904.419167.448821@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17652.49904.419167.448821@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2006 at 08:42:56AM +1000, Paul Mackerras wrote:
> Geoff Levand writes:
> 
> > I'm trying to understand the intended design of the inb()
> > and outb() macros in asm-powerpc/io.h. They are causing
> > me some grief when I set CONFIG_PCI=n:
> > 
> >   drivers/built-in.o: undefined reference to `pci_io_base'
> > 
> > This is coming from drivers/char/mem.c, which is always
> > built in, and is referencing pci_io_base through inb()
> > and outb().
> 
> Hmmm.  inb and outb are designed for accessing PCI I/O space.  I guess
> we could turn them into BUG() when CONFIG_PCI=n.

I just looked at drivers/char/mem.c and the code in question
is surrounded by 

#if defined(CONFIG_ISA) || !defined(__mc68000__)

which seems just plain wrong.

It should probably be changed to 

#if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)

This code surrounds fileops to enale fileio on /dev/port
which maps to inb/outb.  

Do we want to enable /dev/port for pci space ??

--linas

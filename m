Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD92ADDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 06:41:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HKfB3k023811
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 16:41:11 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HKfBQC465076
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 14:41:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HKfBmA003448
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 14:41:11 -0600
Date: Wed, 17 Oct 2007 15:41:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Mock <jeff@mock.com>
Subject: Re: PPC440EPx GPIO control help
Message-ID: <20071017154109.0c6a826e@weaponx.rchland.ibm.com>
In-Reply-To: <47167002.7060202@mock.com>
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
	<47158C69.2070903@ovro.caltech.edu> <4715A9D9.6090308@mock.com>
	<1192618194.13993.25.camel@localhost.localdomain>
	<47167002.7060202@mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 Oct 2007 13:26:42 -0700
Jeff Mock <jeff@mock.com> wrote:

> 
> 
> Josh Boyer wrote:
> > On Tue, 2007-10-16 at 23:21 -0700, Jeff Mock wrote:
> >> David Hawkins wrote:
> >>>> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
> >>>> What I would want to do is to control (write and read values to) its 
> >>>> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
> >>>> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
> >>>> difficult to understand.
> >>>>
> >>>> Could anyone show me any tutorial or some sample codes?
> >>> I copied the code below from some test code I wrote for a TS7300
> >>> board (uses an ARM EP9302 processor). However, since its user-space
> >>> code it should work fine.
> >>>
> >> I might be a little out of date, but I think you must write your own 
> >> driver to wiggle the GPIO pins on a 440 processor.  I just finished a 
> >> project using a 440GX with a 2.6.15 kernel (we froze the code about 8 
> >> months ago).
> >>
> >> The 440 powerPC core is a 32-bit processor with 36-bit physical 
> >> addresses.  The physical address for the GPIO pins is someplace above 
> >> 4GB.  An mmap() of /dev/mem only lets you map the lower 4GB of the 
> >> address space, as a result you can't write a user space program on the 
> >> 440 to wiggle the GPIO pins.  (This was true with 2.6.15, I can't speak 
> >> for later kernels).
> > 
> > This depends on the 440 chip itself.  If I recall correctly, the
> > 440EP(x) chips don't have I/O above 4GB.
> > 
> 
> At first I thought you were right, I remember something about the 440GX 
> being the weird processor with I/O mapped above 4GB.  I just took a look 
> at the 440EPx datasheet on the AMCC website and it looks like the GPIO 
> registers are mapped above 4GB:
> 
>     GPIO0 controller       1 EF60 0B00
>     GPIO1 controller       1 EF60 0C00

Actually, it's 440EP that has the addresses below 4GB, not 440EPx.  My
apologies for the confusion.  As far as "weird" goes in the 44x world,
440EP is the oddball as I believe most all other 44x versions have some
if not all I/O above 4GB.

josh

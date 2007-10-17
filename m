Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36B09DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 21:02:12 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HB263S010941
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 07:02:06 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HB26bK408332
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 05:02:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HB25rb010304
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 Oct 2007 05:02:06 -0600
Subject: Re: PPC440EPx GPIO control help
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Mock <jeff@mock.com>
In-Reply-To: <4715A9D9.6090308@mock.com>
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
	<47158C69.2070903@ovro.caltech.edu>  <4715A9D9.6090308@mock.com>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 05:49:54 -0500
Message-Id: <1192618194.13993.25.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Tue, 2007-10-16 at 23:21 -0700, Jeff Mock wrote:
> David Hawkins wrote:
> >> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
> >> What I would want to do is to control (write and read values to) its 
> >> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
> >> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
> >> difficult to understand.
> >>
> >> Could anyone show me any tutorial or some sample codes?
> > 
> > I copied the code below from some test code I wrote for a TS7300
> > board (uses an ARM EP9302 processor). However, since its user-space
> > code it should work fine.
> > 
> 
> I might be a little out of date, but I think you must write your own 
> driver to wiggle the GPIO pins on a 440 processor.  I just finished a 
> project using a 440GX with a 2.6.15 kernel (we froze the code about 8 
> months ago).
> 
> The 440 powerPC core is a 32-bit processor with 36-bit physical 
> addresses.  The physical address for the GPIO pins is someplace above 
> 4GB.  An mmap() of /dev/mem only lets you map the lower 4GB of the 
> address space, as a result you can't write a user space program on the 
> 440 to wiggle the GPIO pins.  (This was true with 2.6.15, I can't speak 
> for later kernels).

This depends on the 440 chip itself.  If I recall correctly, the
440EP(x) chips don't have I/O above 4GB.

josh

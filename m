Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E741DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 22:17:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ii7q2-0000lf-JM
	for linuxppc-embedded@ozlabs.org; Wed, 17 Oct 2007 05:17:26 -0700
Message-ID: <13252501.post@talk.nabble.com>
Date: Wed, 17 Oct 2007 05:17:26 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440EPx GPIO control help
In-Reply-To: <1192618194.13993.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
	<47158C69.2070903@ovro.caltech.edu> <4715A9D9.6090308@mock.com>
	<1192618194.13993.25.camel@localhost.localdomain>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I Prefer that you write a coustem driver. map the GPIO address (Either make
use of mapped area of GPIO that u may find in the source for comercial
kernel or else map the physical address in the driver and access it ).

---Misbah


Josh Boyer-4 wrote:
> 
> On Tue, 2007-10-16 at 23:21 -0700, Jeff Mock wrote:
>> David Hawkins wrote:
>> >> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
>> >> What I would want to do is to control (write and read values to) its 
>> >> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
>> >> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
>> >> difficult to understand.
>> >>
>> >> Could anyone show me any tutorial or some sample codes?
>> > 
>> > I copied the code below from some test code I wrote for a TS7300
>> > board (uses an ARM EP9302 processor). However, since its user-space
>> > code it should work fine.
>> > 
>> 
>> I might be a little out of date, but I think you must write your own 
>> driver to wiggle the GPIO pins on a 440 processor.  I just finished a 
>> project using a 440GX with a 2.6.15 kernel (we froze the code about 8 
>> months ago).
>> 
>> The 440 powerPC core is a 32-bit processor with 36-bit physical 
>> addresses.  The physical address for the GPIO pins is someplace above 
>> 4GB.  An mmap() of /dev/mem only lets you map the lower 4GB of the 
>> address space, as a result you can't write a user space program on the 
>> 440 to wiggle the GPIO pins.  (This was true with 2.6.15, I can't speak 
>> for later kernels).
> 
> This depends on the 440 chip itself.  If I recall correctly, the
> 440EP(x) chips don't have I/O above 4GB.
> 
> josh
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/PPC440EPx-GPIO-control-help-tf4638058.html#a13252501
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

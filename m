Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1DFFDDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 06:26:47 +1000 (EST)
Message-ID: <47167002.7060202@mock.com>
Date: Wed, 17 Oct 2007 13:26:42 -0700
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: PPC440EPx GPIO control help
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>	
	<47158C69.2070903@ovro.caltech.edu> <4715A9D9.6090308@mock.com>
	<1192618194.13993.25.camel@localhost.localdomain>
In-Reply-To: <1192618194.13993.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



Josh Boyer wrote:
> On Tue, 2007-10-16 at 23:21 -0700, Jeff Mock wrote:
>> David Hawkins wrote:
>>>> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
>>>> What I would want to do is to control (write and read values to) its 
>>>> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
>>>> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
>>>> difficult to understand.
>>>>
>>>> Could anyone show me any tutorial or some sample codes?
>>> I copied the code below from some test code I wrote for a TS7300
>>> board (uses an ARM EP9302 processor). However, since its user-space
>>> code it should work fine.
>>>
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

At first I thought you were right, I remember something about the 440GX 
being the weird processor with I/O mapped above 4GB.  I just took a look 
at the 440EPx datasheet on the AMCC website and it looks like the GPIO 
registers are mapped above 4GB:

    GPIO0 controller       1 EF60 0B00
    GPIO1 controller       1 EF60 0C00

Someone has to do the ioremap() to get at these physical addresses, so I 
think you have to write a driver to get them mapped into user space. 
It's unfortunate, especially for someone just getting started with the 
processor that just wants to turn on an LED...

jeff

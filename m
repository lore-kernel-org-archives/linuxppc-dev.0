Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 279DBDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 16:21:19 +1000 (EST)
Message-ID: <4715A9D9.6090308@mock.com>
Date: Tue, 16 Oct 2007 23:21:13 -0700
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: PPC440EPx GPIO control help
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
	<47158C69.2070903@ovro.caltech.edu>
In-Reply-To: <47158C69.2070903@ovro.caltech.edu>
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


David Hawkins wrote:
>> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
>> What I would want to do is to control (write and read values to) its 
>> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
>> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
>> difficult to understand.
>>
>> Could anyone show me any tutorial or some sample codes?
> 
> I copied the code below from some test code I wrote for a TS7300
> board (uses an ARM EP9302 processor). However, since its user-space
> code it should work fine.
> 

I might be a little out of date, but I think you must write your own 
driver to wiggle the GPIO pins on a 440 processor.  I just finished a 
project using a 440GX with a 2.6.15 kernel (we froze the code about 8 
months ago).

The 440 powerPC core is a 32-bit processor with 36-bit physical 
addresses.  The physical address for the GPIO pins is someplace above 
4GB.  An mmap() of /dev/mem only lets you map the lower 4GB of the 
address space, as a result you can't write a user space program on the 
440 to wiggle the GPIO pins.  (This was true with 2.6.15, I can't speak 
for later kernels).

This tossed me into writing device drivers, which turned out to be not 
nearly as scary as I imagined.  The Linux Device Drivers book is fabulous:

    http://lwn.net/Kernel/LDD3/

Here is a driver for the 440GX that controls an LED on one of the GPIO 
pins you can use as an example.  The device /dev/pdev-led has a 
read/write interface so you can do something like this:

    # echo "1" > /dev/pdev-led      # turn on LED
    # echo "0" > /dev/pdev-led      # turn off LED

It also has a /proc interface so you can cat /proc/pdev-led to read the 
status of the LED.  There are several other drivers there that probably 
won't be interesting, but pdev-led.c is probably a good starting point:
 
http://www.mock.com/wsvn/listing.php?repname=mock.pdev&path=/trunk/sw/driver/

jeff

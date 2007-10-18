Return-Path: <dell.query@yahoo.com>
Received: from n5.bullet.ukl.yahoo.com (n5.bullet.ukl.yahoo.com
	[217.146.182.182]) by ozlabs.org (Postfix) with SMTP id 70964DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 12:00:58 +1000 (EST)
Date: Wed, 17 Oct 2007 19:00:55 -0700 (PDT)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: PPC440EPx GPIO control help
To: Jeff Mock <jeff@mock.com>
In-Reply-To: <4715A9D9.6090308@mock.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-213878717-1192672855=:31425"
Message-ID: <65478.31425.qm@web45611.mail.sp1.yahoo.com>
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

--0-213878717-1192672855=:31425
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Jeff,

I read the device drivers part of the LDD3, it's really difficult as I expected. Thanks for the sample codes. I'll develop my own driver basing from your samples. Regarding reading the status of the LED, is it really necessary to use proc?

Regards,
dell

Jeff Mock <jeff@mock.com> wrote: 
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




 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-213878717-1192672855=:31425
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Jeff,<br><br>I read the device drivers part of the LDD3, it's really difficult as I expected. Thanks for the sample codes. I'll develop my own driver basing from your samples. Regarding reading the status of the LED, is it really necessary to use proc?<br><br>Regards,<br>dell<br><br><b><i>Jeff Mock &lt;jeff@mock.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <br>David Hawkins wrote:<br>&gt;&gt; I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. <br>&gt;&gt; What I would want to do is to control (write and read values to) its <br>&gt;&gt; GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and <br>&gt;&gt; inportb(0x378) to read. I read the PPC440EPx manual but I find it <br>&gt;&gt; difficult to understand.<br>&gt;&gt;<br>&gt;&gt; Could anyone show me any tutorial or some sample codes?<br>&gt; <br>&gt; I copied the code below from some test code I
 wrote for a TS7300<br>&gt; board (uses an ARM EP9302 processor). However, since its user-space<br>&gt; code it should work fine.<br>&gt; <br><br>I might be a little out of date, but I think you must write your own <br>driver to wiggle the GPIO pins on a 440 processor.  I just finished a <br>project using a 440GX with a 2.6.15 kernel (we froze the code about 8 <br>months ago).<br><br>The 440 powerPC core is a 32-bit processor with 36-bit physical <br>addresses.  The physical address for the GPIO pins is someplace above <br>4GB.  An mmap() of /dev/mem only lets you map the lower 4GB of the <br>address space, as a result you can't write a user space program on the <br>440 to wiggle the GPIO pins.  (This was true with 2.6.15, I can't speak <br>for later kernels).<br><br>This tossed me into writing device drivers, which turned out to be not <br>nearly as scary as I imagined.  The Linux Device Drivers book is fabulous:<br><br>    http://lwn.net/Kernel/LDD3/<br><br>Here is a
 driver for the 440GX that controls an LED on one of the GPIO <br>pins you can use as an example.  The device /dev/pdev-led has a <br>read/write interface so you can do something like this:<br><br>    # echo "1" &gt; /dev/pdev-led      # turn on LED<br>    # echo "0" &gt; /dev/pdev-led      # turn off LED<br><br>It also has a /proc interface so you can cat /proc/pdev-led to read the <br>status of the LED.  There are several other drivers there that probably <br>won't be interesting, but pdev-led.c is probably a good starting point:<br> <br>http://www.mock.com/wsvn/listing.php?repname=mock.pdev&amp;path=/trunk/sw/driver/<br><br>jeff<br><br><br></blockquote><br><p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-213878717-1192672855=:31425--

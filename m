Return-Path: <felix@allot.com>
Received: from exg.allot.com (mail.allot.com [199.203.223.202])
	by ozlabs.org (Postfix) with ESMTP id 454F42BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 07:24:24 +1100 (EST)
Message-ID: <41925FDC.1060308@allot.com>
Date: Wed, 10 Nov 2004 20:37:16 +0200
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <4190FDED.3080605@allot.com> <20041109111707.A14471@home.com>
In-Reply-To: <20041109111707.A14471@home.com>
Content-Type: multipart/alternative;
	boundary="------------090101040903040904090800"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 405GPr ioremap problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090101040903040904090800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Matt

Thanks a lot for replying, your help is very much
appreciated. I've followed your suggestion and now
ioremap works as expected. I've removed ivocation
of m4xx_map_io() replacing it by normal ioremaps
for serial ports, RTC and ethernet adapter.

It would be great to see this stuff cleaned up in 2.6.

Felix.


Matt Porter wrote:

>On Tue, Nov 09, 2004 at 07:27:09PM +0200, Felix Radensky wrote:
>  
>
>>Hi, folks
>>
>>I have a 405GPr based board with 512M of RAM.
>>My kernel is 2.4.17 from Monta Vista Linux 2.1.
>>I'm  trying to reserve 64M on boot using mem=448M
>>and map it later by
>>
>>ioremap(__pa(high_memory), 64*(1<<20));
>>
>>This worked fine when system had 256M of RAM,
>>but now ioremap fails. If I understand the kernel
>>code correctly, by adding more RAM I've reduced
>>the vmalloc/ioremap space. I can also see that this
>>space is reduced dramatically on boot by mappings
>>done in arch/ppc/kernel/ppc4xx_setup.c:m4xx_map_io()
>>
>>Is there any way to fix problem ? Is it necessary to have
>>a 1:1 virtual to physical mappings as its done in m4xx_map_io()
>>or maybe higher virtual addresses can be used, thus
>>allowing to save some precious ioremap space.
>>    
>>
>
>This is exactly why the PPC44x ports don't use io_block_map()...
>it can interfere with dynamic mappings.  It is not necessary to
>have 1:1 virtual to physical mappings nor is it necessary to
>have m4xx_map_io() at all. One can use ioremap() to map any
>space and let the kernel place things intelligently. In order
>to use serial console you'll have to use early_serial_setup()
>after you've ioremapped the UART...once you've removed the
>io_block_map() call. Look at other ports to see how this is
>done.
>
>Someday I might get down my list to cleaning up 40x stuff in 2.6.
>
>-Matt
>
>  
>

--------------090101040903040904090800
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, Matt<br>
<br>
Thanks a lot for replying, your help is very much<br>
appreciated. I've followed your suggestion and now<br>
ioremap works as expected. I've removed ivocation<br>
of m4xx_map_io() replacing it by normal ioremaps<br>
for serial ports, RTC and ethernet adapter. <br>
<br>
It would be great to see this stuff cleaned up in 2.6.<br>
<br>
Felix.<br>
<br>
<br>
Matt Porter wrote:
<blockquote cite="mid20041109111707.A14471@home.com" type="cite">
  <pre wrap="">On Tue, Nov 09, 2004 at 07:27:09PM +0200, Felix Radensky wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi, folks

I have a 405GPr based board with 512M of RAM.
My kernel is 2.4.17 from Monta Vista Linux 2.1.
I'm  trying to reserve 64M on boot using mem=448M
and map it later by

ioremap(__pa(high_memory), 64*(1&lt;&lt;20));

This worked fine when system had 256M of RAM,
but now ioremap fails. If I understand the kernel
code correctly, by adding more RAM I've reduced
the vmalloc/ioremap space. I can also see that this
space is reduced dramatically on boot by mappings
done in arch/ppc/kernel/ppc4xx_setup.c:m4xx_map_io()

Is there any way to fix problem ? Is it necessary to have
a 1:1 virtual to physical mappings as its done in m4xx_map_io()
or maybe higher virtual addresses can be used, thus
allowing to save some precious ioremap space.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is exactly why the PPC44x ports don't use io_block_map()...
it can interfere with dynamic mappings.  It is not necessary to
have 1:1 virtual to physical mappings nor is it necessary to
have m4xx_map_io() at all. One can use ioremap() to map any
space and let the kernel place things intelligently. In order
to use serial console you'll have to use early_serial_setup()
after you've ioremapped the UART...once you've removed the
io_block_map() call. Look at other ports to see how this is
done.

Someday I might get down my list to cleaning up 40x stuff in 2.6.

-Matt

  </pre>
</blockquote>
</body>
</html>

--------------090101040903040904090800--

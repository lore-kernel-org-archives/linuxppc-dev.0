Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3410667C32
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 07:59:59 +1000 (EST)
Message-ID: <4532AE34.3010801@dlasys.net>
Date: Sun, 15 Oct 2006 17:55:00 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
Subject: Re: which driver for uartlite with 2.6.17?
References: <20061013155908.4944.qmail@web56302.mail.re3.yahoo.com>
	<609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com>
In-Reply-To: <609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------090800060108010602050509"
Cc: Robert Corley <rcorley@aegis-inc.net>,
	linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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
--------------090800060108010602050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Bolcsfoldi wrote:
> Hi :-)
>
> Good question. Well I was unaware of the fact that there were other
> uartlite drivers so you should take mine off that list. Peter's driver
> is slated for inclusion in the mainline and I am currently in the
> process of adding a few things to it.
>
> For 2.6.17 support you should probably just remove the IRQF_DISABLED
> flag and change IRQF_SAMPLE_RANDOM to SA_SAMPLE_RANDOM in the
> request_irq call and it should work. I am unaware of any other
> important differences between the two releases affecting this driver.
>
> Cheers,
> David
>
> On 10/13/06, Robert Corley <rcorley@aegis-inc.net> wrote:
>   
>> All,
>>
>> Based on what was posted recently, it appears that there is more than one uartlite driver
>> floating about.
>>
>> Can someone please inform me of which driver works for which kernel?
>>
>> Here is what I see
>>
>> D. Lynch    2.6.15    polled, (Pico E12 board specific?)
>>     
    My driver supports polled and/or interrupt driven use - if you want 
polled you set the IRQ to -1.
    It should not be Pico E12 specific - I just have never tested it on 
anything but the Pico E12 and E14 boards.
    I do not think I have posted a patch that ONLY includes the 
UartLite. At the moment it seems like it would just confuse things.
    Peter and I uses fairly different Platform device initiallization. 
Mine is based on the 8250 code which makes it much easier to impliment
    early boot text support.
    You can actually diff my driver against the 8250 driver and mostly 
will find it is a subset.

    My driver also has boot-bash support.
    supports regshift values other than 2.
   
    I recently patched my driver to use the major and minor nodes Peter 
obtained through lanana.org as well as use his ttyUl0 naming.

    I am not sure which version of the kernel the patch supports,  but I 
have been running my driver from 2.6.13-2.6.18.
    But aside of patch issues, all of the drivers below should work 
across many versions.




  Yoshio Kashiwagi -Nissin Systems - Late January 2006.
    Also provided a UartLite driver that was a drop in replacement for 
the version I posted in January.
    Yoshio's version uses DCR. His should also provide early boot text 
support.

    I am not sure if he posted his version but he provided me with a 
copy with a GPL license so I can
    post it or email it if someone wanted.


>> P. Korsgaard    2.6.18    interrupt driven, official lanana.org nodes
>>     
    Is only interrupt driven, only supports a regshift of 2.
    Does not work for me, but aparently does for some others.
    Does not have early boot text support - Davd Bolcsfoldi has provided 
patches for that - though it would also be trivial to
    use my driver and replace my uartlite.c with Peter's and get early 
boot text support - aside from initialization issues - which appear to 
be ignorable,
    early boot text and the driver are very independent.

    David Bolcsfoldi appears to have a few other quality related patches 
to Peter's drivers which I have not had a chance to try.
>> D. Bolcsfoldi    2.6.18    interrupt driven
>>     
    David's also has early boot text support.
    David also provided early boot text support as a patch to Peter's 
driver.
>> patch locations:
>> D. Lynch    http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021592.html
>> P. Korsgaard    http://lkml.org/lkml/2006/9/13/71
>> D. Bolcsfoldi    http://ozlabs.org/pipermail/linuxppc-embedded/2006-October/024697.html
>>
>> Comments?
>>     
    Yes, I think including anything in the Kernel at the moment is 
premature. While I wish Peter would have started from something that 
already existed.
    He did do the work to register the major and minor numbers and run 
his through linux-serial - though I think his submission was premature.
  

    I know my driver has a few failure cases - none of which matter in 
my environment. I also know it has not been tested on other uartlite 
implimentations.
    The same is true of all the other UartLite drivers listed.

    Peter's and mine diverge in design almost as much as you can diverge 
while still following the Linux serial driver model.
    I deliberately patterned mine after the 8250 - there are pro and con 
arguments for that, but atleast you know.
    I am very familiar with serial hardware - I have written serial code 
for the past 25 years. I am less familiar with Linux
    Serial drivers. I deliberately patterened mine on an existing driver 
I knew to be well supported, robust, and tolerant of
    disparate and flakey hardware - partly because of my lack of depth 
of Linux Serial Driver knowledge and partly because
    I knew that anything that worked well for 8250's would likely work 
well with other uarts.
    I do not know what Peter's is based on.

    I have tried to reconcile my patches with Peter's driver - basically 
implimenting the functionality I have Peter is missing.
    But Peter's driver does not work on my boards. I have spent a great 
deal of time trying to fix that, and come to the unhappy realization
    it will probably take a great deal more to solve that - much more 
than it took to write my own driver in the first place.

    David Bilosfoldi has posted a patch to Peter's driver that looks 
like it impliments Early Boot Text support. There are minor differences 
between
    What David did and what I did, but on inspection he seems to have 
made all the necescary patches.


    Right now if one of the posted drivers does not work on your 
hardware or configuration, then you are going to have to pick a driver 
and try to fix it.
    Peter appears to be fairly willing to provide assistance with his 
driver. I am equally willing to provide help with mine.
    Aparently Peter's is likely to get accepted. At least that will 
provide a baseline for the rest of us to post fixes.

    I am not having the problems compiling Peter's you are. That is 
something you may have to take up with Peter.
    But until I can get Peter's to work on my hardware, I am not posting 
untested patches.
    And as I have something that works for me, and as Peter's driver 
seriously diverges from mine, I have a strong disincentive to  put time 
into it
    when I have something that works.
   


>> And, lastly, I need a driver for 2.6.17.  Can someone point me in the right direction?
>> I have tried Peter's driver but it fails to compile, showing this:
>>
>> CC      drivers/serial/serial_core.o
>> CC      drivers/serial/uartlite.o
>> drivers/serial/uartlite.c: In function `ulite_startup':
>> drivers/serial/uartlite.c:199: error: `IRQF_DISABLED' undeclared (first use in this function)
>> drivers/serial/uartlite.c:199: error: (Each undeclared identifier is reported only once
>> drivers/serial/uartlite.c:199: error: for each function it appears in.)
>> drivers/serial/uartlite.c:199: error: `IRQF_SAMPLE_RANDOM' undeclared (first use in this function)
>> make[2]: *** [drivers/serial/uartlite.o] Error 1
>> make[1]: *** [drivers/serial] Error 2
>> make: *** [drivers] Error 2
>>     

    I have been able to successfully compile Peter's driver with 2.6.18.
>>
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>     
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------090800060108010602050509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
David Bolcsfoldi wrote:
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <pre wrap="">Hi :-)

Good question. Well I was unaware of the fact that there were other
uartlite drivers so you should take mine off that list. Peter's driver
is slated for inclusion in the mainline and I am currently in the
process of adding a few things to it.

For 2.6.17 support you should probably just remove the IRQF_DISABLED
flag and change IRQF_SAMPLE_RANDOM to SA_SAMPLE_RANDOM in the
request_irq call and it should work. I am unaware of any other
important differences between the two releases affecting this driver.

Cheers,
David

On 10/13/06, Robert Corley <a class="moz-txt-link-rfc2396E" href="mailto:rcorley@aegis-inc.net">&lt;rcorley@aegis-inc.net&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">All,

Based on what was posted recently, it appears that there is more than one uartlite driver
floating about.

Can someone please inform me of which driver works for which kernel?

Here is what I see

D. Lynch    2.6.15    polled, (Pico E12 board specific?)
    </pre>
  </blockquote>
</blockquote>
&nbsp;&nbsp;&nbsp; My driver supports polled and/or interrupt driven use - if you want
polled you set the IRQ to -1.<br>
&nbsp;&nbsp;&nbsp; It should not be Pico E12 specific - I just have never tested it on
anything but the Pico E12 and E14 boards.<br>
&nbsp;&nbsp;&nbsp; I do not think I have posted a patch that ONLY includes the
UartLite. At the moment it seems like it would just confuse things.<br>
&nbsp;&nbsp;&nbsp; Peter and I uses fairly different Platform device initiallization.
Mine is based on the 8250 code which makes it much easier to impliment <br>
&nbsp;&nbsp;&nbsp; early boot text support.<br>
&nbsp;&nbsp;&nbsp; You can actually diff my driver against the 8250 driver and mostly
will find it is a subset. <br>
<br>
&nbsp;&nbsp;&nbsp; My driver also has boot-bash support.<br>
&nbsp;&nbsp;&nbsp; supports regshift values other than 2.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; I recently patched my driver to use the major and minor nodes Peter
obtained through lanana.org as well as use his ttyUl0 naming.<br>
<br>
&nbsp;&nbsp;&nbsp; I am not sure which version of the kernel the patch supports,&nbsp; but
I have been running my driver from 2.6.13-2.6.18.<br>
&nbsp;&nbsp;&nbsp; But aside of patch issues, all of the drivers below should work
across many versions.<br>
<br>
<br>
<br>
<br>
&nbsp; Yoshio Kashiwagi -Nissin Systems - Late January 2006.<br>
&nbsp;&nbsp;&nbsp; Also provided a UartLite driver that was a drop in replacement for
the version I posted in January.<br>
&nbsp;&nbsp;&nbsp; Yoshio's version uses DCR. His should also provide early boot text
support.<br>
<br>
&nbsp;&nbsp;&nbsp; I am not sure if he posted his version but he provided me with a
copy with a GPL license so I can <br>
&nbsp;&nbsp;&nbsp; post it or email it if someone wanted.<br>
<br>
<br>
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">P. Korsgaard    2.6.18    interrupt driven, official lanana.org nodes
    </pre>
  </blockquote>
</blockquote>
&nbsp;&nbsp;&nbsp; Is only interrupt driven, only supports a regshift of 2. <br>
&nbsp;&nbsp;&nbsp; Does not work for me, but aparently does for some others.<br>
&nbsp;&nbsp;&nbsp; Does not have early boot text support - Davd Bolcsfoldi has
provided patches for that - though it would also be trivial to <br>
&nbsp;&nbsp;&nbsp; use my driver and replace my uartlite.c with Peter's and get early
boot text support - aside from initialization issues - which appear to
be ignorable,<br>
&nbsp;&nbsp;&nbsp; early boot text and the driver are very independent.<br>
<br>
&nbsp;&nbsp;&nbsp; David Bolcsfoldi appears to have a few other quality related
patches to Peter's drivers which I have not had a chance to try.<br>
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">D. Bolcsfoldi    2.6.18    interrupt driven
    </pre>
  </blockquote>
</blockquote>
&nbsp;&nbsp;&nbsp; David's also has early boot text support.<br>
&nbsp;&nbsp;&nbsp; David also provided early boot text support as a patch to Peter's
driver.<br>
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">
patch locations:
D. Lynch    <a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021592.html">http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021592.html</a>
P. Korsgaard    <a class="moz-txt-link-freetext" href="http://lkml.org/lkml/2006/9/13/71">http://lkml.org/lkml/2006/9/13/71</a>
D. Bolcsfoldi    <a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-embedded/2006-October/024697.html">http://ozlabs.org/pipermail/linuxppc-embedded/2006-October/024697.html</a>

Comments?
    </pre>
  </blockquote>
</blockquote>
&nbsp;&nbsp;&nbsp; Yes, I think including anything in the Kernel at the moment is
premature. While I wish Peter would have started from something that
already existed.<br>
&nbsp;&nbsp;&nbsp; He did do the work to register the major and minor numbers and run
his through linux-serial - though I think his submission was premature.<br>
&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; I know my driver has a few failure cases - none of which matter in
my environment. I also know it has not been tested on other uartlite
implimentations.<br>
&nbsp;&nbsp;&nbsp; The same is true of all the other UartLite drivers listed.<br>
<br>
&nbsp;&nbsp;&nbsp; Peter's and mine diverge in design almost as much as you can
diverge while still following the Linux serial driver model.<br>
&nbsp;&nbsp;&nbsp; I deliberately patterned mine after the 8250 - there are pro and
con arguments for that, but atleast you know.<br>
&nbsp;&nbsp;&nbsp; I am very familiar with serial hardware - I have written serial
code for the past 25 years. I am less familiar with Linux <br>
&nbsp;&nbsp;&nbsp; Serial drivers. I deliberately patterened mine on an existing
driver I knew to be well supported, robust, and tolerant of <br>
&nbsp;&nbsp;&nbsp; disparate and flakey hardware - partly because of my lack of depth
of Linux Serial Driver knowledge and partly because<br>
&nbsp;&nbsp;&nbsp; I knew that anything that worked well for 8250's would likely work
well with other uarts.<br>
&nbsp;&nbsp;&nbsp; I do not know what Peter's is based on.<br>
<br>
&nbsp;&nbsp;&nbsp; I have tried to reconcile my patches with Peter's driver -
basically implimenting the functionality I have Peter is missing.<br>
&nbsp;&nbsp;&nbsp; But Peter's driver does not work on my boards. I have spent a great
deal of time trying to fix that, and come to the unhappy realization<br>
&nbsp;&nbsp;&nbsp; it will probably take a great deal more to solve that - much more
than it took to write my own driver in the first place.<br>
<br>
&nbsp;&nbsp;&nbsp; David Bilosfoldi has posted a patch to Peter's driver that looks
like it impliments Early Boot Text support. There are minor differences
between<br>
&nbsp;&nbsp;&nbsp; What David did and what I did, but on inspection he seems to have
made all the necescary patches.<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; Right now if one of the posted drivers does not work on your
hardware or configuration, then you are going to have to pick a driver
and try to fix it.<br>
&nbsp;&nbsp;&nbsp; Peter appears to be fairly willing to provide assistance with his
driver. I am equally willing to provide help with mine.<br>
&nbsp;&nbsp;&nbsp; Aparently Peter's is likely to get accepted. At least that will
provide a baseline for the rest of us to post fixes.<br>
<br>
&nbsp;&nbsp;&nbsp; I am not having the problems compiling Peter's you are. That is
something you may have to take up with Peter.<br>
&nbsp;&nbsp;&nbsp; But until I can get Peter's to work on my hardware, I am not
posting untested patches.<br>
&nbsp;&nbsp;&nbsp; And as I have something that works for me, and as Peter's driver
seriously diverges from mine, I have a strong disincentive to&nbsp; put time
into it <br>
&nbsp;&nbsp;&nbsp; when I have something that works.<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">
And, lastly, I need a driver for 2.6.17.  Can someone point me in the right direction?
I have tried Peter's driver but it fails to compile, showing this:

CC      drivers/serial/serial_core.o
CC      drivers/serial/uartlite.o
drivers/serial/uartlite.c: In function `ulite_startup':
drivers/serial/uartlite.c:199: error: `IRQF_DISABLED' undeclared (first use in this function)
drivers/serial/uartlite.c:199: error: (Each undeclared identifier is reported only once
drivers/serial/uartlite.c:199: error: for each function it appears in.)
drivers/serial/uartlite.c:199: error: `IRQF_SAMPLE_RANDOM' undeclared (first use in this function)
make[2]: *** [drivers/serial/uartlite.o] Error 1
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2
    </pre>
  </blockquote>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; I have been able to successfully compile Peter's driver with 2.6.18.<br>
<blockquote
 cite="mid:609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">



_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------090800060108010602050509--

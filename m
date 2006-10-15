Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA92A67C2C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 08:04:53 +1000 (EST)
Message-ID: <4532AF9A.50303@dlasys.net>
Date: Sun, 15 Oct 2006 18:00:58 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Michael Galassi <mgalassi@c-cor.com>
Subject: Re: uartlite with 2.6.17 kernel and kernel early text messages
References: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
	<200610132226.k9DMQ0xg050310@penguin.ncube.com>
In-Reply-To: <200610132226.k9DMQ0xg050310@penguin.ncube.com>
Content-Type: multipart/alternative;
	boundary="------------090209060603050604080506"
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
--------------090209060603050604080506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Galassi wrote:
>> In an effort to get past the "Rebooting to System ACE Configuration
>> Address 6..." message, I have selected "support for early boot texts
>> over serial port" in kernel debugging.
>>     
>
> This will not work.  Unfortunately linux here shows its roots as PS OS,
> there is a vast amount of hardcoded NS8250/NS16550 knowledge in there.
> I'd started modularizing this so we could use a UART lite but the more I
> dug the lower my motivation.  This is really ugly code in an area that
> is of virtually no interest.  For now get rid of support for early boot
> texts over serial port" and use your JTAG to read the buffers if you
> panic before the console is up and running.
>   
   UartLite early boot text support is fairly trivial. It is also fairly 
standalone.
    You basically need about 5 lines  of code to output a character.
   
    David Bolcsfoldi has posted patches to Peter's driver that should work.
    I have had working early boot text support long before I even had a 
working driver.
    There is atleast one other Uart family besides the 8250 with early 
boot text support.
     You can also fairly trivially fold my early boot text code into 
Peter's driver.
   
    The most disconcerting problem is the #ifdef that results with 
something like 4 or cases.

    The non-8250 support could be more modularized - but it still not a 
major pain.



> -michael
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


--------------090209060603050604080506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Michael Galassi wrote:
<blockquote cite="mid:200610132226.k9DMQ0xg050310@penguin.ncube.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">In an effort to get past the "Rebooting to System ACE Configuration
Address 6..." message, I have selected "support for early boot texts
over serial port" in kernel debugging.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This will not work.  Unfortunately linux here shows its roots as PS OS,
there is a vast amount of hardcoded NS8250/NS16550 knowledge in there.
I'd started modularizing this so we could use a UART lite but the more I
dug the lower my motivation.  This is really ugly code in an area that
is of virtually no interest.  For now get rid of support for early boot
texts over serial port" and use your JTAG to read the buffers if you
panic before the console is up and running.
  </pre>
</blockquote>
&nbsp;&nbsp; UartLite early boot text support is fairly trivial. It is also
fairly standalone.<br>
&nbsp;&nbsp;&nbsp; You basically need about 5 lines&nbsp; of code to output a character.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; David Bolcsfoldi has posted patches to Peter's driver that should
work.<br>
&nbsp;&nbsp;&nbsp; I have had working early boot text support long before I even had a
working driver.<br>
&nbsp;&nbsp;&nbsp; There is atleast one other Uart family besides the 8250 with early
boot text support.<br>
&nbsp;&nbsp;&nbsp;&nbsp; You can also fairly trivially fold my early boot text code into
Peter's driver.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; The most disconcerting problem is the #ifdef that results with
something like 4 or cases.<br>
<br>
&nbsp;&nbsp;&nbsp; The non-8250 support could be more modularized - but it still not a
major pain.<br>
<br>
<br>
<br>
<blockquote cite="mid:200610132226.k9DMQ0xg050310@penguin.ncube.com"
 type="cite">
  <pre wrap="">
-michael
_______________________________________________
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

--------------090209060603050604080506--

Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc15.comcast.net (sccrmhc15.comcast.net [204.127.200.85])
	by ozlabs.org (Postfix) with ESMTP id A8DFB67BDD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 18:53:43 +1000 (EST)
Message-ID: <44EAC607.7010500@dlasys.net>
Date: Tue, 22 Aug 2006 04:53:27 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Wade Maxfield <wmaxfield@gmail.com>
Subject: Re: PPC beginner questions
References: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
In-Reply-To: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------080408020501070404060901"
Cc: ppc <linuxppc-embedded@ozlabs.org>
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
--------------080408020501070404060901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Wade Maxfield wrote:
>
>   I'm new to the PPC and I have a few questions.  I have written a 
> driver in the past for the X86 family, using i/o ports, but it was
> kernel 2.0 and i/o ports are not mmu handled.
>   I've been looking through the archive and I am slowly growing more
> confused.
    The PPC MMU is pretty simple compared to the x86.
    Basically the MMU unit is a peice of hardware that maps "virtual"
addresses to "physical" addresses.
    Its use is enabled/disabled by two bits in the PPC Machine Status
register - 1 for instructions, 1 for data.
    The MMU itself is basically a 64 entry lookup table. Virtual address
X corresponds to physical address Y.
    When a request is made for an address that is not in the 64 entry
MMU table things become more complex
     - an exception is generated and code inside Linux searches its
tables to find the correct entry to stuff into the MMU.
    NORMALLY there is no correspondence between physical addresses and
virtual ones. But it is possible (and might be useful for debugging) to
stuff an entry
    where physical=virtual. If you look inside head_4xx.S for
CONFIG_SERIAL_TEXT_DEBUG or something like that you should see how to do it.
    However manually stuffed entries in the MMU will eventually get
blown away. I spent a week trying to trace a problem caused by that down.


>
>   We are using Xilinx with PPC built in.
>
>    The PPC has a memory management unit.  All of the IP we've added is
> mapped to physical addresses.
>
>    1. Can I access the memory the peripherasl are mapped to directly
> within the driver without going through functions?
>        if NOT, then Do I use
>           1. ioremap(),
    Once you have done the ioremap(), you can use the address returned
exactly the way you would have used the physical address previously.


>           2. request_mem_region(),
>           3. request_region()
>           4. something else?
>
>    2.  Are there any gotcha's with the ppc 405 that Xilinx uses that I
> should know about?
    Are you doing board bringup ?
    If you are not bringing up a new board - then the big gotcha's
should already be covered.
    If you are doing board bringup - I would recommend following the
existing xilinx packages closely.
>
>
> thanks,
> wade
>
>  
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------080408020501070404060901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Wade Maxfield wrote:
<blockquote
 cite="mid45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com"
 type="cite"><br>
&nbsp; I'm new to the PPC and I have a few questions.&nbsp; I have written a&nbsp;
driver in the past for the X86 family, using i/o ports, but it was
kernel 2.0 and i/o ports are not mmu handled.<br>
&nbsp; I've been looking through the archive and I am slowly growing more
confused. <br>
</blockquote>
&nbsp;&nbsp;&nbsp; The PPC MMU is pretty simple compared to the x86.<br>
&nbsp;&nbsp;&nbsp; Basically the MMU unit is a peice of hardware that maps "virtual"
addresses to "physical" addresses.<br>
&nbsp;&nbsp;&nbsp; Its use is enabled/disabled by two bits in the PPC Machine Status
register - 1 for instructions, 1 for data.<br>
&nbsp;&nbsp;&nbsp; The MMU itself is basically a 64 entry lookup table. Virtual
address X corresponds to physical address Y.<br>
&nbsp;&nbsp;&nbsp; When a request is made for an address that is not in the 64 entry
MMU table things become more complex<br>
&nbsp;&nbsp;&nbsp;&nbsp; - an exception is generated and code inside Linux searches its
tables to find the correct entry to stuff into the MMU.<br>
&nbsp;&nbsp;&nbsp; NORMALLY there is no correspondence between physical addresses and
virtual ones. But it is possible (and might be useful for debugging) to
stuff an entry <br>
&nbsp;&nbsp;&nbsp; where physical=virtual. If you look inside head_4xx.S for
CONFIG_SERIAL_TEXT_DEBUG or something like that you should see how to
do it.<br>
&nbsp;&nbsp;&nbsp; However manually stuffed entries in the MMU will eventually get
blown away. I spent a week trying to trace a problem caused by that
down.<br>
<br>
<br>
<blockquote
 cite="mid45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com"
 type="cite"><br>
&nbsp; We are using Xilinx with PPC built in.<br>
  <br>
&nbsp;&nbsp; The PPC has a memory management unit.&nbsp; All of the IP we've added is
mapped to physical addresses.<br>
  <br>
&nbsp;&nbsp; 1. Can I access the memory the peripherasl are mapped to directly
within the driver without going through functions? <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if NOT, then Do I use <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. ioremap(), <br>
</blockquote>
&nbsp;&nbsp;&nbsp; Once you have done the ioremap(), you can use the address returned
exactly the way you would have used the physical address previously.<br>
<br>
<br>
<blockquote
 cite="mid45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com"
 type="cite">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; 2. request_mem_region(), <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. request_region()<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4. something else?<br>
  <br>
&nbsp;&nbsp; 2.&nbsp; Are there any gotcha's with the ppc 405 that Xilinx uses that I
should know about?
  <br>
</blockquote>
&nbsp;&nbsp;&nbsp; Are you doing board bringup ? <br>
&nbsp;&nbsp;&nbsp; If you are not bringing up a new board - then the big gotcha's
should already be covered.<br>
&nbsp;&nbsp;&nbsp; If you are doing board bringup - I would recommend following the
existing xilinx packages closely. <br>
<blockquote
 cite="mid45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com"
 type="cite"><br>
  <br>
thanks,<br>
wade<br>
  <br>
&nbsp;<br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
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

--------------080408020501070404060901--

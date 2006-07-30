Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [204.127.200.83])
	by ozlabs.org (Postfix) with ESMTP id 880BF679A6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Jul 2006 11:08:53 +1000 (EST)
Message-ID: <44CC069A.3070105@dlasys.net>
Date: Sat, 29 Jul 2006 21:08:42 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Rick Moleres <rick.moleres@xilinx.com>
Subject: Re: Xilinx hard TEMAC
References: <689CB232690D8D4E97DA6C76DA098E6C029DC9E5@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C029DC9E5@XCO-EXCHVS1.xlnx.xilinx.com>
Content-Type: multipart/alternative;
	boundary="------------070708040602050409030107"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: dhlii@comcast.net
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
--------------070708040602050409030107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rick Moleres wrote:
> That is the correct distinction between "soft" and "hard".  Just know
> that in this case the "soft" TEMAC (whether LL TEMAC or PLB TEMAC) uses
> the "hard" TEMAC, and the "hard" TEMAC by itself is not that useful.
>   
    First, thanks, your remarks have been enormously helpful.

    I have successfully put together a Driver for the TEMAC currently
used in the Pico E-12.
   
    I am still having some difficulty corresponding this TEMAC
implimentation to any of Xilinx's documentation.
    It is Exactly the TEMAC supported by the Xilinx uCOSII Treck Web
Server application.
    It seems to be extremely minimal. Basically a DCR interface for most
things that closely matches the GSRD documents.
    and TX and RX FIFO's that I can't seem to find documented anywhere,
but I have working based on the Treck WebServer code.

    I am have two remaining problems and then I am done.
   
       The first is I am currently doing polled I/O. The transmits
happen as they are requested and the receives are picked up ona a timer
interrupt.
    But I am dropping about 50% or more of the receives. I will work
that out myself eventually.

       The second is that this driver will serve as the basis for a
driver in other Pico supported OS's. Some of which have no means of
doing Polled Receives.
       And I can not get interrupts working. Since my hardware does nto
match anything perfectly - except that Treck Webserver application and
that does not do interrupts.
    I am reading all the Xilinx TEMAC Documents and the GSRD documents
reference an IRENABLE register and an IRSTATUS register, I cobbled
something together
    assuming that they were access much as the other DCR registers in
that block and I assumed the bits in IRSTATUS and IRENABLE matched the
definitions of those
    in larger TEMAC implimentations. It appeared after I enabled TX and
RX complete interrupts that when I have received data available the
IRSTATUS register has the
    Bit set for an Rx interrupt. All fine - except that no interrupt
actually occurs.
    I can force interrupts from the PHY using the same IRQ so the IRQ is
connected correctly and programmed correctly. Other TEMAC
implimentations seem to have a GIE - Global Interrupt enable
    Bit, but I do not have a clue where to look here. What I could get
out of the Xilinx Webset GSRD seems to be a Linux driver that uses the
DMA unit and that generates its own interrupts.
    I don't think I have the DMA in my bit image.

    Anyway any clues as to where I can find some useful docs on
Interrupt handling for the LL_TEMAC that is used by the uCOSII WebServer
application ?











> Thereis a Linux driver for the LL_TEMAC that comes with GSRD, but my
>   
> group's efforts go toward the PLB_TEMAC as that is the EDK IP we want to
>   
> promote and whose drivers we'd like to see in kernel.org.
>
> You should be able to go to http://www.xilinx.com/gsrd to get the GSRD
> design, and inside of that design somewhere you'll find a Linux 2.4
> driver for the LL TEMAC.
>   
>
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


--------------070708040602050409030107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Rick Moleres wrote:
<blockquote
 cite="mid689CB232690D8D4E97DA6C76DA098E6C029DC9E5@XCO-EXCHVS1.xlnx.xilinx.com"
 type="cite">
  <pre wrap="">
That is the correct distinction between "soft" and "hard".  Just know
that in this case the "soft" TEMAC (whether LL TEMAC or PLB TEMAC) uses
the "hard" TEMAC, and the "hard" TEMAC by itself is not that useful.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; First, thanks, your remarks have been enormously helpful.<br>
<br>
&nbsp;&nbsp;&nbsp; I have successfully put together a Driver for the TEMAC currently
used in the Pico E-12.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; I am still having some difficulty corresponding this TEMAC
implimentation to any of Xilinx's documentation.<br>
&nbsp;&nbsp;&nbsp; It is Exactly the TEMAC supported by the Xilinx uCOSII Treck Web
Server application.<br>
&nbsp;&nbsp;&nbsp; It seems to be extremely minimal. Basically a DCR interface for
most things that closely matches the GSRD documents.<br>
&nbsp;&nbsp;&nbsp; and TX and RX FIFO's that I can't seem to find documented anywhere,
but I have working based on the Treck WebServer code.<br>
<br>
&nbsp;&nbsp;&nbsp; I am have two remaining problems and then I am done.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The first is I am currently doing polled I/O. The transmits
happen as they are requested and the receives are picked up ona a timer
interrupt.<br>
&nbsp;&nbsp;&nbsp; But I am dropping about 50% or more of the receives. I will work
that out myself eventually.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The second is that this driver will serve as the basis for a
driver in other Pico supported OS's. Some of which have no means of
doing Polled Receives.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; And I can not get interrupts working. Since my hardware does nto
match anything perfectly - except that Treck Webserver application and
that does not do interrupts.<br>
&nbsp;&nbsp;&nbsp; I am reading all the Xilinx TEMAC Documents and the GSRD documents
reference an IRENABLE register and an IRSTATUS register, I cobbled
something together <br>
&nbsp;&nbsp;&nbsp; assuming that they were access much as the other DCR registers in
that block and I assumed the bits in IRSTATUS and IRENABLE matched the
definitions of those <br>
&nbsp;&nbsp;&nbsp; in larger TEMAC implimentations. It appeared after I enabled TX and
RX complete interrupts that when I have received data available the
IRSTATUS register has the <br>
&nbsp;&nbsp;&nbsp; Bit set for an Rx interrupt. All fine - except that no interrupt
actually occurs.<br>
&nbsp;&nbsp;&nbsp; I can force interrupts from the PHY using the same IRQ so the IRQ
is connected correctly and programmed correctly. Other TEMAC
implimentations seem to have a GIE - Global Interrupt enable<br>
&nbsp;&nbsp;&nbsp; Bit, but I do not have a clue where to look here. What I could get
out of the Xilinx Webset GSRD seems to be a Linux driver that uses the
DMA unit and that generates its own interrupts.<br>
&nbsp;&nbsp;&nbsp; I don't think I have the DMA in my bit image.<br>
<br>
&nbsp;&nbsp;&nbsp; Anyway any clues as to where I can find some useful docs on
Interrupt handling for the LL_TEMAC that is used by the uCOSII
WebServer application ?<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<blockquote
 cite="mid689CB232690D8D4E97DA6C76DA098E6C029DC9E5@XCO-EXCHVS1.xlnx.xilinx.com"
 type="cite">
  <pre wrap=""><!---->Thereis a Linux driver for the LL_TEMAC that comes with GSRD, but my
  </pre>
  <pre wrap=""><!---->group's efforts go toward the PLB_TEMAC as that is the EDK IP we want to
  </pre>
  <pre wrap=""><!---->promote and whose drivers we'd like to see in kernel.org.
<!---->
You should be able to go to <a class="moz-txt-link-freetext" href="http://www.xilinx.com/gsrd">http://www.xilinx.com/gsrd</a> to get the GSRD
design, and inside of that design somewhere you'll find a Linux 2.4
driver for the LL TEMAC.
  </pre>
  <pre wrap=""><!---->
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

--------------070708040602050409030107--

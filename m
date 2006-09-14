Return-Path: <dhlii@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.200.81])
	by ozlabs.org (Postfix) with ESMTP id 1537467B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 05:11:50 +1000 (EST)
Message-ID: <4509A837.7050902@comcast.net>
Date: Thu, 14 Sep 2006 15:06:31 -0400
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: Aleck Lin <aleck@gdatech.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: help on finding xilinx_enet for 2.6
References: <001601c6d82d$675af520$800101df@monstertop>
In-Reply-To: <001601c6d82d$675af520$800101df@monstertop>
Content-Type: multipart/alternative;
	boundary="------------040703040106080908040807"
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
--------------040703040106080908040807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aleck Lin wrote:
>
> David,
>
>  
>
> I saw your post from last year 
> (http://ozlabs.org/pipermail/linuxppc-embedded/2005-November/021090.html)
>
>  
>
> And I have a couple of questions.
>
>    1. Were you able to use the Xilinx_enet from 2.4 tree for kernel 2.6??
>    2. I'm assuming that you've probably have made it work by now. Can
>       I get some hints on making the ethernet driver for 2.6?
>
>  
>
> Thanks!
>
>  
>
> Aleck
>
Aleck;

    I have been doing board bringup for the Pico E1x series of boards. 
They are Xilinx V4 boards.
    I started with the Linux 2.6 kernel.org tree before there was any 
Xilinx V4 support - I have subsequently conformed
    my code to Grant's patches.
    I looked at the MV xilinx_edk stuff for UartLite and Ethernet and 
decided their code just looked too gnarly.
    I wrote a UartLite driver of my own from scratch. It was fairly 
simple and I have Uartlite support from the early boot code on.

    I started the TEMAC much later. Pico had me work with the LocalLink 
TEMAC at first. That was an almost from scratch driver.
    It was just barely working when they switched gears and decided to 
use the PLB FIFO TEMAC.
    I pulled the MV 2.6 TEMAC driver from the patches posted on this 
list - NOT from the 2.4 tree - though there is an obvious common heritage.
    That driver works fine - given the caveat I listed - it does NOT 
have PHY/MII autonegotiation support. It is not difficult to hardcode 
for whatever
    fixed speed you want, but the caveat is still there. Purportedly, 
proper support is complete or nearly complete - but I have not seen it 
posted.

    In the interim I started a from scratch PLB FIFO TEMAC driver. It 
does NOT support SG DMA - I think Xilinx is now insisting you build the
    PLB TEMAC one way or the other, but you can't build it both. As such 
I do not beleive the driver should be designed to be able to dynamic 
mode switching
    on a condition that can not change dynamically - byt the 
MV/Xilinx_EDK driver does.

    I also had another motive for doing a from scratch driver - I had a 
contract to write basically the same driver for GHS Integrity.
    I basically took the Linux driver gutted the Linux specific 
interfaces, added the GHS interfaces and created a Linux like sk_buff 
shim for GHS and had the thing working in fairly
    short order. In fact the GHS driver works better than the Linux 
driver at the moment. It was also a higher priority.
    I am only just getting back to cleaning up and fixing the Linux 
driver - so it still has a few minor problems and I need to pick up some 
improvements that occured as it
    moved forward to GHS.

    My from scratch driver very loosely used the EDK code as a starting 
point. It drew atleast as much from my LL TEMAC. Right now it sends 
fine. Autonegotiates
    10/100/1000 FD. It appears to receive fine, but Linux silently 
dropps the received packets without reporting an error.
    Whatever the problem is - it is with my driver. It is almost 
certainly trivial. It is also almost certainly going to be a bear to find.
    I had hoped someone with a similar problem (on any driver) might 
have given me a clue how they fixed it. But so far no joy.
    I only recently got back to work on the Linux driver. I do expect it 
will be complete soon.

    In the meantime the posted MV Xilinx_edk based driver works - within 
its limits.
   
   
   



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040703040106080908040807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Aleck Lin wrote:
<blockquote cite="mid001601c6d82d$675af520$800101df@monstertop"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator" content="Microsoft Word 11 (filtered medium)">
  <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1031611971;
	mso-list-type:hybrid;
	mso-list-template-ids:1609235542 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
  </style>
  <div class="Section1">
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">David, <o:p></o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">I saw your post from last
year (<a moz-do-not-send="true"
 href="http://ozlabs.org/pipermail/linuxppc-embedded/2005-November/021090.html">http://ozlabs.org/pipermail/linuxppc-embedded/2005-November/021090.html</a>)<o:p></o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">And I have a couple of
questions. <o:p></o:p></span></font></p>
  <ol style="margin-top: 0in;" start="1" type="1">
    <li class="MsoNormal" style=""><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">Were you able to use the
Xilinx_enet from 2.4 tree for kernel 2.6?? <o:p></o:p></span></font></li>
    <li class="MsoNormal" style=""><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">I&#8217;m assuming that you&#8217;ve
probably have made it work by now. Can I get some hints on making the
ethernet driver for 2.6?<o:p></o:p></span></font></li>
  </ol>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">Thanks!<o:p></o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;"><o:p>&nbsp;</o:p></span></font></p>
  <p class="MsoNormal"><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;">Aleck<o:p></o:p></span></font></p>
  </div>
</blockquote>
Aleck;<br>
<br>
&nbsp;&nbsp;&nbsp; I have been doing board bringup for the Pico E1x series of boards.
They are Xilinx V4 boards.<br>
&nbsp;&nbsp;&nbsp; I started with the Linux 2.6 kernel.org tree before there was any
Xilinx V4 support - I have subsequently conformed<br>
&nbsp;&nbsp;&nbsp; my code to Grant's patches.<br>
&nbsp;&nbsp;&nbsp; I looked at the MV xilinx_edk stuff for UartLite and Ethernet and
decided their code just looked too gnarly.<br>
&nbsp;&nbsp;&nbsp; I wrote a UartLite driver of my own from scratch. It was fairly
simple and I have Uartlite support from the early boot code on.<br>
<br>
&nbsp;&nbsp;&nbsp; I started the TEMAC much later. Pico had me work with the LocalLink
TEMAC at first. That was an almost from scratch driver.<br>
&nbsp;&nbsp;&nbsp; It was just barely working when they switched gears and decided to
use the PLB FIFO TEMAC.<br>
&nbsp;&nbsp;&nbsp; I pulled the MV 2.6 TEMAC driver from the patches posted on this
list - NOT from the 2.4 tree - though there is an obvious common
heritage.<br>
&nbsp;&nbsp;&nbsp; That driver works fine - given the caveat I listed - it does NOT
have PHY/MII autonegotiation support. It is not difficult to hardcode
for whatever <br>
&nbsp;&nbsp;&nbsp; fixed speed you want, but the caveat is still there. Purportedly,
proper support is complete or nearly complete - but I have not seen it
posted.<br>
<br>
&nbsp;&nbsp;&nbsp; In the interim I started a from scratch PLB FIFO TEMAC driver. It
does NOT support SG DMA - I think Xilinx is now insisting you build the
<br>
&nbsp;&nbsp;&nbsp; PLB TEMAC one way or the other, but you can't build it both. As
such I do not beleive the driver should be designed to be able to
dynamic mode switching <br>
&nbsp;&nbsp;&nbsp; on a condition that can not change dynamically - byt the
MV/Xilinx_EDK driver does.<br>
<br>
&nbsp;&nbsp;&nbsp; I also had another motive for doing a from scratch driver - I had a
contract to write basically the same driver for GHS Integrity.<br>
&nbsp;&nbsp;&nbsp; I basically took the Linux driver gutted the Linux specific
interfaces, added the GHS interfaces and created a Linux like sk_buff
shim for GHS and had the thing working in fairly <br>
&nbsp;&nbsp;&nbsp; short order. In fact the GHS driver works better than the Linux
driver at the moment. It was also a higher priority.<br>
&nbsp;&nbsp;&nbsp; I am only just getting back to cleaning up and fixing the Linux
driver - so it still has a few minor problems and I need to pick up
some improvements that occured as it <br>
&nbsp;&nbsp;&nbsp; moved forward to GHS.<br>
<br>
&nbsp;&nbsp;&nbsp; My from scratch driver very loosely used the EDK code as a starting
point. It drew atleast as much from my LL TEMAC. Right now it sends
fine. Autonegotiates <br>
&nbsp;&nbsp;&nbsp; 10/100/1000 FD. It appears to receive fine, but Linux silently
dropps the received packets without reporting an error.<br>
&nbsp;&nbsp;&nbsp; Whatever the problem is - it is with my driver. It is almost
certainly trivial. It is also almost certainly going to be a bear to
find.<br>
&nbsp;&nbsp;&nbsp; I had hoped someone with a similar problem (on any driver) might
have given me a clue how they fixed it. But so far no joy.<br>
&nbsp;&nbsp;&nbsp; I only recently got back to work on the Linux driver. I do expect
it will be complete soon. <br>
<br>
&nbsp;&nbsp;&nbsp; In the meantime the posted MV Xilinx_edk based driver works -
within its limits.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
<br>
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

--------------040703040106080908040807--

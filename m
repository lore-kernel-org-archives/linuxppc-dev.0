Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 4C2B6DDEFE
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:14:38 +1100 (EST)
Message-ID: <47DFDC5B.90304@matrix-vision.de>
Date: Tue, 18 Mar 2008 16:14:35 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: simple MPC5200B system
References: <47DD71D0.2010203@matrix-vision.de>	
	<fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>	
	<47DF821B.6090600@matrix-vision.de>	
	<47DF9ABB.2020607@matrix-vision.de>
	<fa686aa40803180731g3892e737h29db0cb917946588@mail.gmail.com>
In-Reply-To: <fa686aa40803180731g3892e737h29db0cb917946588@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------050204010202090600000405"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050204010202090600000405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely schrieb:
> On Tue, Mar 18, 2008 at 4:34 AM, Andre Schwarz
> <andre.schwarz@matrix-vision.de> wrote:
>   
>>  Grant,
>>
>>  sorry for having troubled you. Looks like the build system has been in an
>> invalid state...
>>
>>  After doing a git-pull and "make distclean" + "make mpc5200_defconfig" the
>> system is finally up and running.
>>     
>
> Heh; I hate it when that happens.  :-)
>
> Congratulations.
>
> g.
>
>
>   
Grant,

this leads to the next questions ... :-)

I've read some discussions about the "interrupt-map" attribute of the 
pci node. I tried to follow Ben and David in their explanations - 
obviously I didn't really get it.
Looks like there are a lot of people outside who need some enlightenment 
... including me, of course.

Maybe you can clarify this ?

Taken from motionpro.dts ...

    interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
                                 c000 0 0 2 &mpc5200_pic 1 1 3
                                 c000 0 0 3 &mpc5200_pic 1 2 3
                                 c000 0 0 4 &mpc5200_pic 1 3 3

                                 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
                                 c800 0 0 2 &mpc5200_pic 1 2 3
                                 c800 0 0 3 &mpc5200_pic 1 3 3
                                 c800 0 0 4 &mpc5200_pic 0 0 3>;


First parameter seems to be the slot number, i.e. IDSEL line of the PCI 
device.
How is this value coded ? Are these the bits 15..11 of the configuration 
address ?

2nd + 3rd paramter : no clue ! can you explain ?

4th : seem to be INT_A ... _D of a PCI device. Usually a device uses 
only INT_A. Do we need 4 entries in any case ?

5th : ok - parent pic

6th ... 8th  : IRQ representation of the parent pic, which gives :

    6th : 0=CRIT for irq0 pin, 1=MAIN for irq1..3 pins
    7th : irq number. 1 for the irq0 pin inside CRIT level. irq1..3 have 
number 1..3 inside MAIN level.
    8th : should be 3 = "level low" which is default for PCI.




regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------050204010202090600000405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Grant Likely schrieb:
<blockquote
 cite="mid:fa686aa40803180731g3892e737h29db0cb917946588@mail.gmail.com"
 type="cite">
  <pre wrap="">On Tue, Mar 18, 2008 at 4:34 AM, Andre Schwarz
<a class="moz-txt-link-rfc2396E" href="mailto:andre.schwarz@matrix-vision.de">&lt;andre.schwarz@matrix-vision.de&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> Grant,

 sorry for having troubled you. Looks like the build system has been in an
invalid state...

 After doing a git-pull and "make distclean" + "make mpc5200_defconfig" the
system is finally up and running.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Heh; I hate it when that happens.  :-)

Congratulations.

g.


  </pre>
</blockquote>
Grant,<br>
<br>
this leads to the next questions ... :-)<br>
<br>
I've read some discussions about the "interrupt-map" attribute of the
pci node. I tried to follow Ben and David in their explanations -
obviously I didn't really get it.<br>
Looks like there are a lot of people outside who need some
enlightenment ... including me, of course.<br>
<br>
Maybe you can clarify this ?<br>
<br>
Taken from motionpro.dts ...<br>
<br>
&nbsp;&nbsp;&nbsp; interrupt-map = &lt;c000 0 0 1 &amp;mpc5200_pic 0 0 3 // 1st slot<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c000 0 0 2 &amp;mpc5200_pic 1 1 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c000 0 0 3 &amp;mpc5200_pic 1 2 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c000 0 0 4 &amp;mpc5200_pic 1 3 3<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c800 0 0 1 &amp;mpc5200_pic 1 1 3 //
2nd slot<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c800 0 0 2 &amp;mpc5200_pic 1 2 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c800 0 0 3 &amp;mpc5200_pic 1 3 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c800 0 0 4 &amp;mpc5200_pic 0 0 3&gt;;<br>
<br>
<br>
First parameter seems to be the slot number, i.e. IDSEL line of the PCI
device. <br>
How is this value coded ? Are these the bits 15..11 of the
configuration address ?<br>
<br>
2nd + 3rd paramter : no clue ! can you explain ?<br>
<br>
4th : seem to be INT_A ... _D of a PCI device. Usually a device uses
only INT_A. Do we need 4 entries in any case ?<br>
<br>
5th : ok - parent pic <br>
<br>
6th ... 8th&nbsp; : IRQ representation of the parent pic, which gives :<br>
<br>
&nbsp;&nbsp;&nbsp; 6th : 0=CRIT for irq0 pin, 1=MAIN for irq1..3 pins<br>
&nbsp;&nbsp;&nbsp; 7th : irq number. 1 for the irq0 pin inside CRIT level. irq1..3
have number 1..3 inside MAIN level.<br>
&nbsp;&nbsp;&nbsp; 8th : should be 3 = "level low" which is default for PCI.<br>
<br>
<br>
<br>
<br>
regards,<br>
Andre<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------050204010202090600000405--

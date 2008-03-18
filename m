Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 62ACEDDFB6
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:44:29 +1100 (EST)
Message-ID: <47DFF160.4060600@matrix-vision.de>
Date: Tue, 18 Mar 2008 17:44:16 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: simple MPC5200B system
References: <47DD71D0.2010203@matrix-vision.de>	<fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>	<47DF821B.6090600@matrix-vision.de>	<47DF9ABB.2020607@matrix-vision.de>	<fa686aa40803180731g3892e737h29db0cb917946588@mail.gmail.com>	<47DFDC5B.90304@matrix-vision.de>
	<fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com>
In-Reply-To: <fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------080501050401080003000307"
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
--------------080501050401080003000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely schrieb:
> On Tue, Mar 18, 2008 at 9:14 AM, Andre Schwarz
> <andre.schwarz@matrix-vision.de> wrote:
>   
>>  I've read some discussions about the "interrupt-map" attribute of the pci
>> node. I tried to follow Ben and David in their explanations - obviously I
>> didn't really get it.
>>  Looks like there are a lot of people outside who need some enlightenment
>> ... including me, of course.
>>
>>  Maybe you can clarify this ?
>>
>>  Taken from motionpro.dts ...
>>
>>     
>
> First, you also need to look at interrupt-map-mask to interpret these
> values; from motionpro.dts:
>
> interrupt-map-mask = <f800 0 0 7>;
>
> which is applied to the unit interrupt specifier to figure out how to
> map onto the interrupt controller.  The /size/ of this field is
> obtained by adding #address-cells with #interrupt-cells. (3+1=4).
>
> 'f8' refers to the upper 5 bits of the interrupt identifier which is a
> number from 0-31 which relates to the IDSEL line as you guessed.  The
> '7' covers the lower 3 bits of the interrupt specifier which can be 1,
> 2, 3 or 4.
>
> The 120 bits in the middle are irrelevant, so interrupt-map-mask
> leaves them as zeros.
>
>   

ok.
>>      interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
>>                                   c000 0 0 2 &mpc5200_pic 1 1 3
>>                                   c000 0 0 3 &mpc5200_pic 1 2 3
>>                                   c000 0 0 4 &mpc5200_pic 1 3 3
>>
>>                                   c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
>>                                   c800 0 0 2 &mpc5200_pic 1 2 3
>>                                   c800 0 0 3 &mpc5200_pic 1 3 3
>>                                   c800 0 0 4 &mpc5200_pic 0 0 3>;
>>
>>
>>  First parameter seems to be the slot number, i.e. IDSEL line of the PCI
>> device.
>>  How is this value coded ? Are these the bits 15..11 of the configuration
>> address ?
>>     
>
> I don't remember how this is encoded.  On the lite5200, idsel is wired
> to d0 and d1 for slots 1 and 2 respectively, yet these values suggest
> slots 24 and 25.  I'll need to look at this again later.
>
>   
"pci info" from u-boot shows both devices (e1000 NIC + FPGA)
       00  0a  4d56  1000  ff00  03    -> bus "0" , slot "0a", "irq 3"
       00  0b  8086  1078  0200  02   -> bus "0" , slot "0b", "irq 2"

IDSEL mapping of MPC5200 is "0b0_1011" for slot 0xb and "0b0_1010" for 
slot 0xa.
Using those 5 bits <<= 3  for the first cell gives "5800" and "5000"

>>  2nd + 3rd paramter : no clue ! can you explain ?
>>     
>
> first 3 cells are the unit address and is #address-cells large.  Only
> the first cell contains real data.
>
>   
ok.
>>  4th : seem to be INT_A ... _D of a PCI device. Usually a device uses only
>> INT_A. Do we need 4 entries in any case ?
>>     
>
> you only need entries for irq lines that are wired up.  If your board
> does not wire up _B, _C and _D, then don't have an entry for them.
> However, if they are wired up then you should describe them.
>
>   
ok. I only have INT_A.
>>  5th : ok - parent pic
>>     
>
> Correct.
>
>   
>>  6th ... 8th  : IRQ representation of the parent pic, which gives :
>>
>>      6th : 0=CRIT for irq0 pin, 1=MAIN for irq1..3 pins
>>      7th : irq number. 1 for the irq0 pin inside CRIT level. irq1..3 have
>> number 1..3 inside MAIN level.
>>      8th : should be 3 = "level low" which is default for PCI.
>>     
>
> Correct.
>
> There is also some good information here:
> http://playground.sun.com/1275/practice/imap/imap0_9d.pdf
>
> Cheers,
> g.
>
>   
using the following "interrupt-map" give me two working PCI devices with 
working interrupts ... :-)

interrupt-map = <5800 0 0 1 &mpc5200_pic 1 2 3  // e1000
                             5000 0 0 1 &mpc5200_pic 1 3 3>;// FPGA


Thanks for your explanations !


regards,
Andre



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------080501050401080003000307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Grant Likely schrieb:
<blockquote
 cite="mid:fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com"
 type="cite">
  <pre wrap="">On Tue, Mar 18, 2008 at 9:14 AM, Andre Schwarz
<a class="moz-txt-link-rfc2396E" href="mailto:andre.schwarz@matrix-vision.de">&lt;andre.schwarz@matrix-vision.de&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> I've read some discussions about the "interrupt-map" attribute of the pci
node. I tried to follow Ben and David in their explanations - obviously I
didn't really get it.
 Looks like there are a lot of people outside who need some enlightenment
... including me, of course.

 Maybe you can clarify this ?

 Taken from motionpro.dts ...

    </pre>
  </blockquote>
  <pre wrap=""><!---->
First, you also need to look at interrupt-map-mask to interpret these
values; from motionpro.dts:

interrupt-map-mask = &lt;f800 0 0 7&gt;;

which is applied to the unit interrupt specifier to figure out how to
map onto the interrupt controller.  The /size/ of this field is
obtained by adding #address-cells with #interrupt-cells. (3+1=4).

'f8' refers to the upper 5 bits of the interrupt identifier which is a
number from 0-31 which relates to the IDSEL line as you guessed.  The
'7' covers the lower 3 bits of the interrupt specifier which can be 1,
2, 3 or 4.

The 120 bits in the middle are irrelevant, so interrupt-map-mask
leaves them as zeros.

  </pre>
</blockquote>
<br>
ok.<br>
<blockquote
 cite="mid:fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">     interrupt-map = &lt;c000 0 0 1 &amp;mpc5200_pic 0 0 3 // 1st slot
                                  c000 0 0 2 &amp;mpc5200_pic 1 1 3
                                  c000 0 0 3 &amp;mpc5200_pic 1 2 3
                                  c000 0 0 4 &amp;mpc5200_pic 1 3 3

                                  c800 0 0 1 &amp;mpc5200_pic 1 1 3 // 2nd slot
                                  c800 0 0 2 &amp;mpc5200_pic 1 2 3
                                  c800 0 0 3 &amp;mpc5200_pic 1 3 3
                                  c800 0 0 4 &amp;mpc5200_pic 0 0 3&gt;;


 First parameter seems to be the slot number, i.e. IDSEL line of the PCI
device.
 How is this value coded ? Are these the bits 15..11 of the configuration
address ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't remember how this is encoded.  On the lite5200, idsel is wired
to d0 and d1 for slots 1 and 2 respectively, yet these values suggest
slots 24 and 25.  I'll need to look at this again later.

  </pre>
</blockquote>
"pci info" from u-boot shows both devices (e1000 NIC + FPGA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0a&nbsp; 4d56&nbsp; 1000&nbsp; ff00&nbsp; 03&nbsp;&nbsp;&nbsp; -&gt; bus "0" , slot "0a", "irq
3"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0b&nbsp; 8086&nbsp; 1078&nbsp; 0200&nbsp; 02&nbsp;&nbsp; -&gt; bus "0" , slot "0b", "irq 2"<br>
<br>
IDSEL mapping of MPC5200 is "0b0_1011" for slot 0xb and "0b0_1010" for
slot 0xa.<br>
Using those 5 bits &lt;&lt;= 3&nbsp; for the first cell gives "5800" and
"5000"<br>
<br>
<blockquote
 cite="mid:fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 2nd + 3rd paramter : no clue ! can you explain ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
first 3 cells are the unit address and is #address-cells large.  Only
the first cell contains real data.

  </pre>
</blockquote>
ok.<br>
<blockquote
 cite="mid:fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 4th : seem to be INT_A ... _D of a PCI device. Usually a device uses only
INT_A. Do we need 4 entries in any case ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
you only need entries for irq lines that are wired up.  If your board
does not wire up _B, _C and _D, then don't have an entry for them.
However, if they are wired up then you should describe them.

  </pre>
</blockquote>
ok. I only have INT_A.<br>
<blockquote
 cite="mid:fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 5th : ok - parent pic
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Correct.

  </pre>
  <blockquote type="cite">
    <pre wrap=""> 6th ... 8th  : IRQ representation of the parent pic, which gives :

     6th : 0=CRIT for irq0 pin, 1=MAIN for irq1..3 pins
     7th : irq number. 1 for the irq0 pin inside CRIT level. irq1..3 have
number 1..3 inside MAIN level.
     8th : should be 3 = "level low" which is default for PCI.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Correct.

There is also some good information here:
<a class="moz-txt-link-freetext" href="http://playground.sun.com/1275/practice/imap/imap0_9d.pdf">http://playground.sun.com/1275/practice/imap/imap0_9d.pdf</a>

Cheers,
g.

  </pre>
</blockquote>
using the following "interrupt-map" give me two working PCI devices
with working interrupts ... :-)<br>
<br>
interrupt-map = &lt;5800 0 0 1 &amp;mpc5200_pic 1 2 3&nbsp; // e1000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5000 0 0 1 &amp;mpc5200_pic 1 3 3&gt;;//
FPGA<br>
<br>
<br>
Thanks for your explanations !<br>
<br>
<br>
regards,<br>
Andre<br>
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------080501050401080003000307--

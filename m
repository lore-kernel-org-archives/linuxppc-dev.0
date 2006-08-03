Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc15.comcast.net (sccrmhc15.comcast.net [204.127.200.85])
	by ozlabs.org (Postfix) with ESMTP id 64C1A67B70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 02:40:12 +1000 (EST)
Message-ID: <44D226DF.1050800@dlasys.net>
Date: Thu, 03 Aug 2006 12:39:59 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: edb@datadesigncorp.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [Fwd: [PATCH][RFC] ppc32: TEMAC driver for ML403]
Content-Type: multipart/mixed; boundary="------------050904090902070905010704"
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
--------------050904090902070905010704
Content-Type: multipart/alternative;
 boundary="------------060108020302010306090604"


--------------060108020302010306090604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Edward Bockhoefer wrote:
> Thank you for the reply David,
> I have started the montavista 10/100 enet port from the xilinx edk
> generated 2.4 driver to the 2.6 driver. Unfortunately, I can't post
> the driver port publicly because it's not GLP'd, as far as I know. We
> only needed a 10/100 mac, so we didn't bother with a TEMAC. I will
> work on this more today. If you want to send me your TEMAC code,
> please do so. I can always use the reference.

    The original message for the GB TEMAC 2.6 patch is below. It is from
Andrei Konovalov.
   
      I think it is just a newer version of the 2.4 Driver. Regardless
it just worked for me. I had to make a very minor change - I added an
"u32 spd" to the private data structure, initialized it to 10 (I am on a
10Mhz Net), and found every reference to 1000Mhz replaced it with
lp->spd; There was one place I needed a switch statement to load the
appropriate value. I think there were only 3 really trivial changes. I
would post my changes but I am not setup to post them as a patch right
now. If you really want them I will just send my adaptor.c and you can
use everything else from the patch referenced below.

    I have also attached my Local Link TEMAC code. That is basically a
single file driver. Again I am not able to provide it as a patch at the
moment. It (much like the PLB TEMAC driver) requires a platform data
entry for the LL TEMAC in your Board support code. Though it could be
fairly trivially changed to work from defines. I beleive there are only
2 critical values - the DCR base address, the TEMAC memory address.
There is an IRQ value, but I can only get the LL TEMAC to generate PHY
interupts, so the driver is polled. It does work albeit with lots of
dropped packets, but that is probably debugging code and optimizing the
poll rate.
    The driver is solely my own work based loosely on several other
drivers, and is GPL'd. According to my client LL TEMAC performance has
tested abysmally in comparision to the PLB TEMAC, however the kicker was
the inability to generate rx interupts. We are working on other OS
ports, and some do not have strictly polled options, so for  now the LL
TEMAC is on the back burner.
   
    Of course I have learned an incredible amount about Linux Network
Drivers as well as now having a reasonable understanding of the
differences between the assorted Xilinx TEMAC's



-------- Original Message --------
Return-Path: 	<linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org>
Received: 	from colinux.fixit1.net (colinux.fixit1.com [216.37.233.220])
by xm.dlasys.net (Cyrus v2.2.12-Debian-2.2.12-4) with LMTPA; Tue, 14 Mar
2006 00:34:38 -0500
X-Sieve: 	CMU Sieve 2.2
Received: 	from ozlabs.org ([203.10.76.45]:45331) by colinux.fixit1.net
with esmtp (Exim 4.50 #1 (Debian)) id 1FIny3-0002KK-J4 for
<dhlii@dlasys.net>; Mon, 13 Mar 2006 09:24:16 -0500
Received: 	from ozlabs.org (localhost [127.0.0.1]) by ozlabs.org
(Postfix) with ESMTP id 628F067B23 for <dhlii@dlasys.net>; Tue, 14 Mar
2006 01:17:33 +1100 (EST)
X-Original-To: 	linuxppc-embedded@ozlabs.org
Delivered-To: 	linuxppc-embedded@ozlabs.org
Received: 	from mail.dev.rtsoft.ru (unknown [85.21.88.2]) by ozlabs.org
(Postfix) with SMTP id A94B7679E2 for <linuxppc-embedded@ozlabs.org>;
Tue, 14 Mar 2006 01:17:21 +1100 (EST)
Received: 	(qmail 31931 invoked from network); 13 Mar 2006 14:17:16 -0000
Received: 	from unknown (HELO ?192.168.1.108?) (192.168.1.108) by
mail.dev.rtsoft.ru with SMTP; 13 Mar 2006 14:17:16 -0000
Message-ID: 	<44157EEF.5000900@ru.mvista.com>
Date: 	Mon, 13 Mar 2006 17:17:19 +0300
From: 	Andrei Konovalov <akonovalov@ru.mvista.com>
User-Agent: 	Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: 	en-us, en
MIME-Version: 	1.0
To: 	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: 	[PATCH][RFC] ppc32: TEMAC driver for ML403
X-BeenThere: 	linuxppc-embedded@ozlabs.org
X-Mailman-Version: 	2.1.7
Precedence: 	list
List-Id: 	Linux on Embedded PowerPC Developers Mail List
<linuxppc-embedded.ozlabs.org>
List-Unsubscribe:
<https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: 	<http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: 	<mailto:linuxppc-embedded@ozlabs.org>
List-Help: 	<mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe:
<https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Content-Type: 	text/plain; charset="us-ascii"
Content-Transfer-Encoding: 	7bit
Sender: 	linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org
Errors-To: 	linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org



Here:
   http://source.mvista.com/~ank/paulus-powerpc/20060309/
is an StGIT patchset against
   516450179454de9e689e0a53ed8f34b896e8651c
   branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc

virtex-ppc_sys_devices-fix.patch - is the same fix posted by Grant Likely few days ago (only formatting is different),
ppc32_xilinx_edk_temac.patch - the low level code from EDK-7.1i used by the this driver
ppc32_xilinx_edk_temac_mods.patch - few modifications to EDK-7.1i code to get rid of compiling the xparameters.h
   #defines into the driver. These mods should not be needed after EDK-8.1 SP2 is released.
ppc32_xilinx_temac.patch - the linux driver itself
ppc32_xilinx_ml403_temac.patch - modifications to the ML403 platform code to add TEMAC.
temac.paulus-powerpc.20060309.tgz - all the patches put together into a tarball (just in case).
temac.config - .config used.

This is not the final version yet (no MII support; SGDMA is operational, but seems to need some additional work).
And I would probably wait for EDK-8.1 SP2 (up to one month or so) where both the TEMAC IP and the EDK code
should be updated.

But it would be nice to know if there is anything to rework in the current code to get the driver
accepted into linux/kernel/git/paulus/powerpc.git or linux/kernel/git/torvalds/linux-2.6.git tree.

And probably someone could start playing with the current driver now. At least I was able to mount
the root over NFS and to run several netperf tests.


Thanks,
Andrei
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------060108020302010306090604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Edward Bockhoefer wrote:
<blockquote cite="mid44D20980.3030702@datadesigncorp.net" type="cite">Thank
you for the reply David, <br>
I have started the montavista 10/100 enet port from the xilinx edk
generated 2.4 driver to the 2.6 driver. Unfortunately, I can't post the
driver port publicly because it's not GLP'd, as far as I know. We only
needed a 10/100 mac, so we didn't bother with a TEMAC. I will work on
this more today. If you want to send me your TEMAC code, please do so.
I can always use the reference.<br>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; The original message for the GB TEMAC 2.6 patch is below. It is
from Andrei Konovalov.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; &nbsp;&nbsp; I think it is just a newer version of the 2.4 Driver. Regardless
it just worked for me. I had to make a very minor change - I added an
"u32 spd" to the private data structure, initialized it to 10 (I am on
a 10Mhz Net), and found every reference to 1000Mhz replaced it with
lp-&gt;spd; There was one place I needed a switch statement to load the
appropriate value. I think there were only 3 really trivial changes. I
would post my changes but I am not setup to post them as a patch right
now. If you really want them I will just send my adaptor.c and you can
use everything else from the patch referenced below.<br>
<br>
&nbsp;&nbsp;&nbsp; I have also attached my Local Link TEMAC code. That is basically a
single file driver. Again I am not able to provide it as a patch at the
moment. It (much like the PLB TEMAC driver) requires a platform data
entry for the LL TEMAC in your Board support code. Though it could be
fairly trivially changed to work from defines. I beleive there are only
2 critical values - the DCR base address, the TEMAC memory address.
There is an IRQ value, but I can only get the LL TEMAC to generate PHY
interupts, so the driver is polled. It does work albeit with lots of
dropped packets, but that is probably debugging code and optimizing the
poll rate.<br>
&nbsp;&nbsp;&nbsp; The driver is solely my own work based loosely on several other
drivers, and is GPL'd. According to my client LL TEMAC performance has
tested abysmally in comparision to the PLB TEMAC, however the kicker
was the inability to generate rx interupts. We are working on other OS
ports, and some do not have strictly polled options, so for&nbsp; now the LL
TEMAC is on the back burner.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Of course I have learned an incredible amount about Linux Network
Drivers as well as now having a reasonable understanding of the
differences between the assorted Xilinx TEMAC's<br>
<br>
<br>
<br>
-------- Original Message --------
<table class="moz-email-headers-table" border="0" cellpadding="0"
 cellspacing="0">
  <tbody>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Return-Path: </th>
      <td><a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org">&lt;linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>from colinux.fixit1.net (colinux.fixit1.com [216.37.233.220])
by xm.dlasys.net (Cyrus v2.2.12-Debian-2.2.12-4) with LMTPA; Tue, 14
Mar 2006 00:34:38 -0500</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">X-Sieve: </th>
      <td>CMU Sieve 2.2</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>from ozlabs.org ([203.10.76.45]:45331) by colinux.fixit1.net
with esmtp (Exim 4.50 #1 (Debian)) id 1FIny3-0002KK-J4 for
<a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a>; Mon, 13 Mar 2006 09:24:16 -0500</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>from ozlabs.org (localhost [127.0.0.1]) by ozlabs.org
(Postfix) with ESMTP id 628F067B23 for <a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a>; Tue,
14 Mar 2006 01:17:33 +1100 (EST)</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">X-Original-To:
      </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Delivered-To:
      </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>from mail.dev.rtsoft.ru (unknown [85.21.88.2]) by ozlabs.org
(Postfix) with SMTP id A94B7679E2 for
<a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded@ozlabs.org">&lt;linuxppc-embedded@ozlabs.org&gt;</a>; Tue, 14 Mar 2006 01:17:21 +1100
(EST)</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>(qmail 31931 invoked from network); 13 Mar 2006 14:17:16 -0000</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Received: </th>
      <td>from unknown (HELO ?192.168.1.108?) (192.168.1.108) by
mail.dev.rtsoft.ru with SMTP; 13 Mar 2006 14:17:16 -0000</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Message-ID: </th>
      <td><a class="moz-txt-link-rfc2396E" href="mailto:44157EEF.5000900@ru.mvista.com">&lt;44157EEF.5000900@ru.mvista.com&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Date: </th>
      <td>Mon, 13 Mar 2006 17:17:19 +0300</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">From: </th>
      <td>Andrei Konovalov <a class="moz-txt-link-rfc2396E" href="mailto:akonovalov@ru.mvista.com">&lt;akonovalov@ru.mvista.com&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">User-Agent: </th>
      <td>Mozilla Thunderbird 1.0.2-6 (X11/20050513)</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">X-Accept-Language:
      </th>
      <td>en-us, en</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">MIME-Version:
      </th>
      <td>1.0</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">To: </th>
      <td>linuxppc-embedded list <a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded@ozlabs.org">&lt;linuxppc-embedded@ozlabs.org&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Subject: </th>
      <td>[PATCH][RFC] ppc32: TEMAC driver for ML403</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">X-BeenThere: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">X-Mailman-Version:
      </th>
      <td>2.1.7</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Precedence: </th>
      <td>list</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Id: </th>
      <td>Linux on Embedded PowerPC Developers Mail List
&lt;linuxppc-embedded.ozlabs.org&gt;</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Unsubscribe:
      </th>
      <td><a class="moz-txt-link-rfc2396E" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">&lt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded&gt;</a>,
<a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe">&lt;mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Archive:
      </th>
      <td><a class="moz-txt-link-rfc2396E" href="http://ozlabs.org/pipermail/linuxppc-embedded">&lt;http://ozlabs.org/pipermail/linuxppc-embedded&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Post: </th>
      <td><a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded@ozlabs.org">&lt;mailto:linuxppc-embedded@ozlabs.org&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Help: </th>
      <td><a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded-request@ozlabs.org?subject=help">&lt;mailto:linuxppc-embedded-request@ozlabs.org?subject=help&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">List-Subscribe:
      </th>
      <td><a class="moz-txt-link-rfc2396E" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">&lt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded&gt;</a>,
<a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe">&lt;mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe&gt;</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Content-Type:
      </th>
      <td>text/plain; charset="us-ascii"</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Content-Transfer-Encoding:
      </th>
      <td>7bit</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Sender: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org">linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Errors-To: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org">linuxppc-embedded-bounces+dhlii=dlasys.net@ozlabs.org</a></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<pre>Here:
   <a class="moz-txt-link-freetext" href="http://source.mvista.com/~ank/paulus-powerpc/20060309/">http://source.mvista.com/~ank/paulus-powerpc/20060309/</a>
is an StGIT patchset against
   516450179454de9e689e0a53ed8f34b896e8651c
   branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc

virtex-ppc_sys_devices-fix.patch - is the same fix posted by Grant Likely few days ago (only formatting is different),
ppc32_xilinx_edk_temac.patch - the low level code from EDK-7.1i used by the this driver
ppc32_xilinx_edk_temac_mods.patch - few modifications to EDK-7.1i code to get rid of compiling the xparameters.h
   #defines into the driver. These mods should not be needed after EDK-8.1 SP2 is released.
ppc32_xilinx_temac.patch - the linux driver itself
ppc32_xilinx_ml403_temac.patch - modifications to the ML403 platform code to add TEMAC.
temac.paulus-powerpc.20060309.tgz - all the patches put together into a tarball (just in case).
temac.config - .config used.

This is not the final version yet (no MII support; SGDMA is operational, but seems to need some additional work).
And I would probably wait for EDK-8.1 SP2 (up to one month or so) where both the TEMAC IP and the EDK code
should be updated.

But it would be nice to know if there is anything to rework in the current code to get the driver
accepted into linux/kernel/git/paulus/powerpc.git or linux/kernel/git/torvalds/linux-2.6.git tree.

And probably someone could start playing with the current driver now. At least I was able to mount
the root over NFS and to run several netperf tests.


Thanks,
Andrei
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
</pre>
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

--------------060108020302010306090604--

--------------050904090902070905010704
Content-Type: text/plain;
 name="temac.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="temac.c"

/*
 linux/drivers/net/temac.c
 *
 Driver for Xilinx hard temac ethernet NIC's
 *
 Author: David H. Lynch Jr. <dhlii@dlasys.net>
 Copyright (C) 2005 DLA Systems
  The author may be reached as dhlii@sdlasys.net, or C/O
 *	DLA Systems
 *	354 Rudy Dam rd.
 *	Lititz PA 17543
 *
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
 *
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
 *
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA=

 *
 $Id: temac.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
 *
 */
#define DRV_NAME	"temac"
#define DRV_CARDNAME    "Xilinx hard temac"
#define DRV_DESCRIPTION	"Xilinx hard Tri-Mode Eth MAC driver"
#define DRV_VERSION	"0.10a"
#define DRV_RELDATE	"07/10/2006"

static const char version[] =3D DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDA=
TE "  David H. Lynch Jr. (dhlii@dlasys.net)\n";

#include <linux/module.h>
#include <linux/ioport.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/init.h>
#include <linux/skbuff.h>
#include <linux/spinlock.h>
#include <linux/crc32.h>

#include <linux/mii.h>
#include <linux/delay.h>
#include <linux/platform_device.h>
#include <linux/ethtool.h>
#include <asm/delay.h>
#include <asm/irq.h>
#include <asm/io.h>


// #define XGP_CON_REG_PERIPH_RESET          	(1 << 31)
#define XGP_CON_REG_PERIPH_RESET          	(1 << 31)
#define XGP_CON_REG_TEMAC_RESET          	(1 << 30)
#define XGP_CON_REG_PHY_RESET 	         	(1 << 29)

#define MII_ANI					0x10
// B0 Interrupt Enabled
// B1 Interrupt Asserted

#define MII_SSR 				0x11
/* MARVELL 88E1111 PHY status registers masks*/
#define MII_SSR_SPDMASK          		0xC000
#define MII_SSR_FD         			(1 << 13)
#define MII_SSR_LINK           			(1 << 10)

/* MARVELL 88E1111 PHY status registers value masks*/
#define MII_SSR_SPD1000         		(1 << 15)
#define MII_SSR_SPD100          		(1 << 14)
#define MII_SSR_SPD10           		0
#define MII_SSR_FD    				(1 << 13)
#define MII_ISR 	    			0x13

/* Emac Config word masks */
#define XGP_E0_MODECONFIG_SPD1000     		(1 << 31)
#define XGP_E0_MODECONFIG_SPD100      		(1 << 30)
#define XGP_E0_MODECONFIG_SPD10       		0
#define PHY_NUM 0

#define XGP_HIF_BASEADDR   			0x10C	/* DCR Host Interface address */
#define XGP_HIFMSW     				0	/* data most significant word */
#define XGP_HIFLSW     				1	/* data least significant word */
#define XGP_HIFCON         			2	/* control */
#define XGP_HIFCON_DCR_WRITE 			(1 << 15)	/* Write enable */
#define XGP_HIFRDY       			3	/* rdy status */
#define XGP_HIFRDY_DCR_SRR 			(1 << 0)
#define XGP_HIFRDY_DCR_MRR 			(1 << 1)
#define XGP_HIFRDY_DCR_MWR 			(1 << 2)
#define XGP_HIFRDY_DCR_ARR 			(1 << 3)
#define XGP_HIFRDY_DCR_AWR 			(1 << 4)
#define XGP_HIFRDY_DCR_GRR 			(1 << 5)
#define XGP_HIFRDY_DCR_GWR 			(1 << 6)
#define XGP_CON					4	/* unimplimented */
#define XGP_STAT				5	/* unimplimented */
#define XGP_ROV					6	/* read errors and overflows */
#define XGP_PTIME				7	/* Pause Time */



#define XGP_MDIO_ENABLE_MASK  			(1 << 6)	/* enable MII bit */
#define XGP_MDIO_CLOCK_DIV_100MHz  		0x28	/* 100 MHz host clock */

#define XGP_E0_RxCW0 				0x200	/* Receiver configuration word 0 - pause f=
ram MAC address */
#define XGP_E0_RxCW1 				0x240	/* Receiver configuration word 1 */
// Why is Rx_RESET unused ?
#define XGP_E0_RxCW1_RESET               	(1 << 31)	/* B31 */
//#define XGP_E0_RxCW1_JUMBO               	(1 << 30)	/* B30 */
//#define XGP_E0_RxCW1_INB_FCS                  (1 << 29)	/* B29 */
#define XGP_E0_RxCW1_ENABLE  			(1 << 28)	/* B28 Receiver enable */
//#define XGP_E0_RxCW1_VLAN                	(1 << 27)
#define XGP_E0_RxCW1_HD        			(1 << 26)

#define XGP_E0_TxCW 				0x280	/* Transmitter configuration */
#define XGP_E0_TxCW_RESET               	(1 << 31)	/* B31 */
// #define XGP_E0_TxCW_JUMBO               	(1 << 30)
//#define XGP_E0_TxCW_INB_FCS                   (1 << 29)	/* B29 */
#define XGP_E0_TxCW_ENABLE 			(1 << 28)
// #define XGP_E0_TxCW_VLAN                	(1 << 27)
#define XGP_E0_TxCW_HD       			(1 << 26)

#define XGP_E0_FLOW 				0x2c0	/* Flow */
// B30 Tx enable
// B29 Rx enable
#define XGP_E0_MODECONFIG 			0x300	/* Emac configuration */
#define XGP_E0_ECFG_SPD				0xc000000 /* 10 =3D 1000 01 =3D 100 00 =3D 10
// B24 RX16
// B25 TX16
// B26 HOST_EN
// B27 1000BASE-X
// B28 SGMII_ENABLE
// B29 RGMII_ENABLE
// B30:31 SPEED
// 10 =3D> 1000
// 01 =3D> 100
// 00 =3D> 10
// 11 =3D> NA
//
// #define XGP_E0_RGMIISGMII                    0x320   /* RGMII/SGMII st=
atus */
// B0 RGMII Link
// B1 RGMII HD
// B2:3 RGMII_SPD
// B30:31 SGMII_SPD
#define XGP_E0_MGMTCONFIG 			0x340	/* Management configuration */
// B0:5 clock divisor
// B6 MDIO enable
#define XGP_E0_UNICAST0 			0x380	/* Unicast Address [31:0] */
#define XGP_E0_UNICAST1 			0x384	/* Unicast Address [47:32] */
#define XGP_E0_ATCW0 				0x388	/* Address Table Address [31:0] */
#define XGP_E0_ATCW1 				0x38c	/* Address Table Address [47:32] */
// B16:17 are the address index being read/written
// B23 RNW 1=3D READ 0 =3D WRITE
#define XGP_E0_ATCAF 				0x390	/* Address Table AF */
// *B31 promiscuous
#define XGP_E0_ISR 				0x3a0=09
// B0 STATRST0
// B1 MIIMRST0
// B2 MIIMWST0
// B3 AFRST0
// B4 AFWST0
// B5 CFGRST0
// B6 CGFWST0
#define XGP_E0_IER 				0x3a4=09
// B0 STATREN0
// B1 MIIMREN0
// B2 MIIMWEN0
// B3 AFREN0
// B4 AFWEN0
// B5 CFGREN0
// B6 CGFWEN0
#define XGP_E0_MIIM_WR 				0x3b0	/* MIIM write data */
#define XGP_E0_MIIM_ADDR 			0x3b4	/* Decode address for MIIM address outp=
ut */


#define LL_REM_MASK         			0x0000000F
#define LL_EOP_MASK         			(1 << 5)
#define LL_SOP_MASK         			(1 << 6)
#define LL_EOF_MASK         			(1 << 7)
#define LL_SOF_MASK         			(1 << 8)

#define LL_TX_DATA				0x00
#define LL_TX_CTRL				0x08
#define LL_TX_RDY				0x10
#define LL_RX_DATA				0x20
#define LL_RX_CTRL				0x28
#define LL_RX_RDY				0x30

#define LL_RX_SRC_RDY_MASK  			(1 << 4)



// ISR RO 0x0
// B25 Tx
// B26 Rx
// B27 DMA/SG Tx
// B28 DMA/SG Rx
// B29 IPISC Interupts
// IPISC ISR 0x20
// B10 RAE		Recieve alignment error
// B11 RLE		receive long error=20
// B12 RSE		receive short error
// B13 RLFE		receive length field error
// B14 RFCS		receive FCS error
// B15 RCE		receive collision error
// B16 RMFE		receive missed frame error
// B17 RDFO		receive data fifo overrun=20
// B18 TPPR		tx pause packet received
// B19 TLFU		tx length FIFO underrun
// B20 TLFO		tx length FIFO overrun
// B21 TFSU		tx status FIFO underrun
// B22 TSFO		tx status FIFO overrun
// B23 RSVD	=09
// B24 RSVD
// B25 TLFF		tx length FIFO full
// B26 RLFE		rx length FIFO empty
// B27 TSFE		tx Status FIFO empty
// B28 RERR		rx error
// B29 TERR		tx error
// B30 RXCP		rx complete
// B31 TXCP		tx complete
// IPISC IER 0x28
// IER RW 0x8
// IPR RO 0x4
// IID RO 0x18
// Global Interrupt enable  0x1c
//
// IPIF registers
// TxDMA_Sg_Reset 	W	Base+0x2300
// TxDMA_Sg_MID ID 	R	Base+0x2300
// TxDMA_Sg_CTRL 	RW	Base+0x2304
// TxDMA_Sg_SRC 	RW	Base+0x2308
// TxDMA_Sg_DST 	RW	Base+0x230c
// TxDMA_Sg_Start_len 	RW	Base+0x2310
// TxDMA_Sg_Status 	R	Base+0x2314
// TxDMA_Sg_BDA 	RW	Base+0x2318
// TxDMA_Software CTRL 	RW	Base+0x231c
// TxDMA_Sg_UThesh 	RW	Base+0x2320
// TxDMA_Sg_PCThesh 	RW	Base+0x2324
// TxDMA_Sg_PWThesh 	RW	Base+0x2328
// TxDMA_Sg_ISR 	RW	Base+0x232c
// TxDMA_Sg_IER 	RW	Base+0x2330
// RxDMA_Sg_RESET 	W	Base+0x2340
// RxDMA_Sg_MID 	R	Base+0x2340
// RxDMA_Sg_CTRL 	RW	Base+0x2344
// RxDMA_Sg_SRC 	RW	Base+0x2348
// RxDMA_Sg_DST 	RW	Base+0x234c
// RxDMA_Sg_Start_len 	RW	Base+0x2350
// RxDMA_Sg_Status 	RW	Base+0x2354
// RxDMA_Sg_BDA 	RW	Base+0x2358
// RxDMA_Software CTRL 	RW	Base+0x235c
// RxDMA_Sg_UPC 	RW	Base+0x2360
// TxDMA_Sg_PCThesh 	RW	Base+0x2364
// TxDMA_Sg_PWThesh 	RW	Base+0x2368
// TxDMA_Sg_ISR 	RW	Base+0x236c
// TxDMA_Sg_IER 	RW	Base+0x2370
// WP_FIFO_RESET 	W	Base+0x2000
// WP_FIFO_MID 		R	Base+0x2000
// WP_FIFO_Vacancy	R	Base+0x2004
// WP_FIFO_Push		W	Base+0x2008
// WP_FIFO_Data		W	Base+0x2100-28ff
// RP_FIFO_RESET 	W	Base+0x2010
// RP_FIFO_MID 		R	Base+0x2010
// RP_FIFO_Vacancy	R	Base+0x2014
// RP_FIFO_Push		W	Base+0x2018
// RP_FIFO_Data		W	Base+0x2200-29ff
// DEVICE_ISR		R	Base+0x0
// DEVICE_IPR		R	Base+0x4
// DEVICE_IER		RW	Base+0x8
// DEVICE_IIR		R	Base+0x18
// DEVICE_GLB_IE	W	Base+0x1c
// IP_ISR		RW	Base+0x20
// IP_IER		RW	Base+0x28
// DEVICE_RESET		W	Base+0x40
// DEVICE_ID		W	Base+0x40
// EMAC registers
// EMAC_MID		R	Base+0x1100
// [0-3]MJRV[4-10]MNRV[11-15]REVL[16-23]BLID[24-31]BTYPE
// EMAC_CTRL		RW	Base+0x1104
// B0 FD		fULL dUPLEX
// B1 RSTTX		Reset Transmitter
// B2 ENTX		Enable Transmitter
// B3 RSTRX		reset receiver
// B4 ENRX		enable receiver
// B5 ENPHY		enable PHY
// B6 TXPAD		enable TX pad insertion
// B7 TXFCS		enable TX FCS insertion
// B8 TXSA		enable TX source insertion
// B9 TXERR		enable TX error insertion
// B10 SAOE		enable source address overwrite
// B11 ILBE		internal loopback enable
// B12 STRP		enabble RX FCS/Pad strip
// B13 RSVD
// B14 UA		enable Unicast address=20
// B15 MA		enable multicast address
// M16 BA		enable broadcast address
// B17 PA		enable promiscuous
// B18 REO		receive error override
// B19 RXJB		enable receive jumbo frams
// B20 CAME		enable receive CAM
// B21 IPPE		enable Pause Packets
// B22 RSVD=09
// B23 CAMW		Receive CAM write
// EMAC_IFGP		RW	Base+0x1108
// EMAC_SAH		RW	Base+0x110c	// Mac Address
// EMAC_SAL		RW	Base+0x1110
// EMAC_MII_MGTCR	RW	Base+0x1114
// B0 SB			Start/Busy
// B1 RWN			0=3DWrite 1=3DRead
// 2-6 PHYAD Phy Address
// 7-11 REGAD Register address
// B12 IE 			enable MII
// B13 MIIRE	Reade error
// EMAC_MII_MGTDR	RW	Base+0x1118
// B16-31 MII Data register
// EMAC_RxPLR		R	Base+0x111c	// fifo
// EMAC_TxPLR		RW	Base+0x1120	// fifo
// EMAC_TxSTAT		R	Base+0x1124	// fifo
// B0 TXED Transmit Excess Deferral Error
// B1 PFIFOU	Packet FIFO underrun
// B2-6 TxA     # of attempts
// B7 	TXLC    Late collision error
// B31 TPCF
// EMAC_RxMFC		R	Base+0x1128
// EMAC_RxCC		R	Base+0x112c
// EMAC_RxFCS_EC	R	Base+0x1130
// EMAC_RxRAEC		R	Base+0x1134
// EMAC_TxEDC		R	Base+0x1138
// B31 Received Packet Complete
// EMAC_RxSTAT		R	Base+0x113c	// fifo
// EMAC_RxCAMH		R	Base+0x1140
// B10-15 CAM address 0-63
// B16-31 MAC Address High
// EMAC_RxCAML		R	Base+0x1144
//
//
// TeMAC Lite
// Txdata starts at Base+0x0
//
// Base+7f8 GIE Glocal interupt enable
// Base+7f4 Length of Tx Data
// Base+7fc
// B28 Transmit Interrupt enable
// B30 P
// B31 S Send enable - 1 to Send 0 to load data
// IF Ping Pong separate Tx at 0x800
// MAC defaults to 00-00-5e-00-fa-ce
// receive at 0x1000
// base+17fc B31 Data ready
// B28 Rx Interrupt Enable
//
// Receive PingPong 0x1800
//
#define XTE_MTU             			1500	/* max MTU size of Ethernet frame */
#define XTE_HDR_SIZE        			14	/* size of Ethernet header */
#define XTE_TRL_SIZE        			4	/* size of Ethernet trailer (FCS) */
#define XTE_MAX_FRAME_SIZE       		(XTE_MTU + XTE_HDR_SIZE + XTE_TRL_SIZE=
)

#define SRC_RDY_TIMEOUT_ERROR         		-2
#define SOF_TIMEOUT_ERROR             		-3

/* Board/System/Debug information/definition ---------------- */

#define TRUE					1
#define FALSE					0

#define PFX DRV_CARDNAME ": "


#define IS_DBG 1		/* enable debugging */

#if IS_DBG
#define DEBUG_FUNC   printk("\n" DRV_CARDNAME ": %s()",__FUNCTION__);
#else
#define DEBUG_FUNC   do { } while(0);
#endif

#if IS_DBG
#define DEBUG_PRINTL(args...)   printk("\n" DRV_CARDNAME ": " args)
#else
#define DEBUG_PRINTL(args...)  do { } while(0)
#endif

#if IS_DBG
#define DEBUG_PRINTK(args...)   printk( args)
#else
#define DEBUG_PRINTK(args...)  do { } while(0)
#endif
/* use 0 for production, 1 for verification, >1 for debug */
#if IS_DBG
static unsigned int temac_debug =3D IS_DBG;
#else
static unsigned int temac_debug =3D 1;
#endif

#define TEMAC_RX_TIMEOUT 			(jiffies + ((1 * HZ)/5))
#define TEMAC_TX_TIMEOUT 			(jiffies + (2 * HZ))
#define TEMAC_MII_TIMEOUT  			(jiffies + (2 * HZ))	/* timer wakeup time :=
 2 second */

/*
Transmit timeout, default 5 seconds.
 */
static int watchdog =3D 5000;
module_param(watchdog, int, 0400);
MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");

static struct platform_device *temac_device;

/* for exclusion of all program flows (processes, ISRs and BHs) */
DEFINE_SPINLOCK(XTE_spinlock);


/* Structure/enum declaration ------------------------------- */
// ndev->mem_start should be the FIFO address
//	unsigned char		perm_addr[MAX_ADDR_LEN]; /* permanent hw address */
//	struct dev_mc_list	*mc_list;	/* Multicast mac addresses	*/
//	int			mc_count;	/* Number of installed mcasts	*/
//	int			promiscuity;
//	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address, (before bcast be=
cause most packets are unicast) */
typedef struct temac_local {
	struct list_head rcv;
	struct list_head xmit;
	spinlock_t lock;
	struct net_device_stats stats;

	void __iomem 		*nic_vaddr;		/* Register I/O base address */
	u16 			phy_addr;
	u32 			phy_status;
	u8  			regshift;
	u32 			msg_enable;		/* debug message level */

	struct resource 	*nic_addr_res;		/* resources found */
	struct resource 	*phy_addr_res;
	struct resource 	*nic_addr_req;		/* resources requested */
	struct resource 	*phy_addr_req;
	// struct resource 	*irq_res;

	unsigned int 		poll:1;
	unsigned int 		mii:1;			/* mii port available */
	struct mii_if_info 	mii_if;

	struct timer_list 	rx_timer;
	struct timer_list 	mii_timer;
} temac_local_t;

static void dump_skb(struct sk_buff *skb, char *str)
{
	int ii;
	u8 *cp =3D skb->data ;

	DEBUG_PRINTL("%s %d bytes", str, skb->len);
	for (ii =3D 0; ii < skb->len; ii++) {
		if (( ii % 16) =3D=3D 0) DEBUG_PRINTK("\n");
		if (( ii % 8) =3D=3D 0) DEBUG_PRINTK(" ");
		DEBUG_PRINTK("%02x ", cp[ii]);
	}
	DEBUG_PRINTK("\n");
}
static u32=20
ior(struct net_device *ndev, int offset)
{
	u32 value;
	// struct temac_local *lp =3D ndev->priv;
	// offset <<=3D lp->regshift;

	value =3D (*(volatile u32 *) ( ndev->base_addr + offset));=20
	__asm__ __volatile__("eieio");
	return value;
}

static void
iow(struct net_device *ndev, int offset, u32 value)
{
	// struct temac_local *lp =3D ndev->priv;
	// offset <<=3D lp->regshift;

	(*(volatile u32 *)( ndev->base_addr + offset) =3D value);=20
 	__asm__ __volatile__("eieio");
}
/*
  Read a word from phyxcer
 */
static u32 mdio_read(struct net_device *ndev, int phy_id, int reg_num)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	u32 ret =3D 0;
	// DEBUG_PRINTL("%s(%d,%d)",__FUNCTION__,phy_id, reg_num);

	if (lp->mii) {
		// DEBUG_PRINTK(" phy_addr=3D%x",lp->phy_addr);
		spin_lock_irqsave(&lp->lock, flags);
		mtdcr(lp->phy_addr + XGP_HIFLSW, ((phy_id << 5) | (reg_num)));
		mtdcr(lp->phy_addr + XGP_HIFCON, XGP_E0_MIIM_ADDR);
		while (!(mfdcr(lp->phy_addr + XGP_HIFRDY) & XGP_HIFRDY_DCR_MRR));

		ret =3D mfdcr(lp->phy_addr + XGP_HIFLSW);
		spin_unlock_irqrestore(&lp->lock, flags);
	}
	// DEBUG_PRINTK("=3D%x",ret);

	return ret;
}

/*
  Write a word to phyxcer
 */
static void mdio_write(struct net_device *ndev, int phy_id, int reg_num, =
u32 val)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	int EmacNum =3D 0;
	// DEBUG_FUNC;

	if (lp->mii) {
		spin_lock_irqsave(&lp->lock, flags);
		mtdcr(lp->phy_addr + XGP_HIFLSW, (val));
		mtdcr(lp->phy_addr + XGP_HIFCON, XGP_HIFCON_DCR_WRITE | XGP_E0_MIIM_WR)=
;
		mtdcr(lp->phy_addr + XGP_HIFLSW, ((phy_id << 5) | (reg_num)));
		mtdcr(lp->phy_addr + XGP_HIFCON, XGP_HIFCON_DCR_WRITE | ((EmacNum) << 1=
0) | XGP_E0_MIIM_ADDR);
		while (!(mfdcr(lp->phy_addr + XGP_HIFRDY) & XGP_HIFRDY_DCR_MWR));
		spin_unlock_irqrestore(&lp->lock, flags);
	}
}

static u32 emac_cfg_read(struct net_device *ndev, int phy_id, int reg_num=
)
{
	struct temac_local *lp =3D ndev->priv;
	int EmacNum =3D 0;
	u32 ret =3D 0;

	if (lp->mii) {
		mtdcr(lp->phy_addr + XGP_HIFCON, (EmacNum << 10) | (reg_num));
		while (!(mfdcr(lp->phy_addr + XGP_HIFRDY) & (XGP_HIFRDY_DCR_GRR << (8 *=
 (EmacNum)))));
		ret =3D mfdcr(lp->phy_addr + XGP_HIFLSW);
	}

	return ret;
}

static u32 emac_AF_read(struct net_device *ndev, int reg_num)
{
	struct temac_local *lp =3D ndev->priv;
	int EmacNum =3D 0;
        mtdcr((lp->phy_addr) + XGP_HIFCON, (EmacNum << 10) | (reg_num)); =

        while ( !(mfdcr(lp->phy_addr + XGP_HIFRDY )  & (XGP_HIFRDY_DCR_AR=
R << (8*(EmacNum)))));=20
        mfdcr((lp->phy_addr) + XGP_HIFLSW) ;=20
}

static void emac_AF_write(struct net_device *ndev, int reg_num, u32 val)
{
	struct temac_local *lp =3D ndev->priv;
	int EmacNum =3D 0;

	if (lp->mii) {
		mtdcr(lp->phy_addr + XGP_HIFLSW, (val));
		mtdcr(lp->phy_addr + XGP_HIFCON, XGP_HIFCON_DCR_WRITE | ((EmacNum) << 1=
0) | (reg_num));
		while (!(mfdcr(lp->phy_addr + XGP_HIFRDY) & XGP_HIFRDY_DCR_AWR));
	}
}

u32 emac_AFM_read(struct net_device *ndev, int reg_num, int MultAddrReg, =
u32 *mult_addr_msw, u32 *mult_addr_lsw) =20
{
	struct temac_local *lp =3D ndev->priv;
	int EmacNum =3D 0;
        mtdcr((lp->phy_addr) + XGP_HIFLSW, MultAddrReg );=20
        mtdcr((lp->phy_addr) + XGP_HIFCON, XGP_HIFCON_DCR_WRITE | (EmacNu=
m << 10) | reg_num);=20
        while ( !(mfdcr(lp->phy_addr + XGP_HIFRDY )  & (XGP_HIFRDY_DCR_AR=
R << (8*EmacNum))));=20
        *mult_addr_lsw =3D mfdcr((lp->phy_addr) + XGP_HIFLSW);=20
        *mult_addr_msw =3D mfdcr((lp->phy_addr) + XGP_HIFMSW);=20
}

static void emac_AFM_write(struct net_device *ndev, int reg_num, u32 mult=
_addr_msw, u32 mult_addr_lsw) =20
{
        emac_AF_write(ndev, XGP_E0_ATCW0, (((mult_addr_msw << 24) & 0xff0=
00000) | ((mult_addr_msw << 8) & 0x00ff0000) | ((mult_addr_msw >> 8) &  0=
x0000ff00) | ((mult_addr_msw >> 24) & 0x000000ff)));=20
        emac_AF_write(ndev, XGP_E0_ATCW1, (reg_num << 16) | ((mult_addr_l=
sw<<8) & 0xff00) | ((mult_addr_lsw >>8 ) & 0x00ff)) ;

}

static void emac_cfg_write(struct net_device *ndev, int phy_id, int reg_n=
um, u32 val)
{
	struct temac_local *lp =3D ndev->priv;
	int EmacNum =3D 0;

	if (lp->mii) {
		mtdcr(lp->phy_addr + XGP_HIFLSW, (val));
		mtdcr(lp->phy_addr + XGP_HIFCON, XGP_HIFCON_DCR_WRITE | (EmacNum << 10)=
 | (reg_num));
		while (!(mfdcr(lp->phy_addr + XGP_HIFRDY) & XGP_HIFRDY_DCR_GWR));
	}
}

void disp_emac_cfg(struct net_device *ndev, char *rname, int  regnum, int=
 idx)
{
	u32 ret;
	int ii;

	if ((idx % 4) =3D=3D 0) DEBUG_PRINTK("\n\t");
	ret =3D emac_cfg_read(ndev, 0, regnum); 	=09
	if (rname) {
		DEBUG_PRINTK("%s:", rname);
		for(ii=3Dstrlen(rname);ii<10;ii++) DEBUG_PRINTK(" ");
		DEBUG_PRINTK("0x%08x  ", ret);
	} else=20
		DEBUG_PRINTK("R%03d:      0x%08x  ",  regnum, ret);
}

void disp_mii(struct net_device *ndev, char *rname, int  regnum)
{
	u32 ret;
	int ii;
	if ((regnum % 4) =3D=3D 0) DEBUG_PRINTK("\n\t");
	ret =3D  mdio_read(ndev, PHY_NUM, regnum);
	if (rname) {
		DEBUG_PRINTK("%s:", rname);
		for(ii=3Dstrlen(rname);ii<10;ii++) DEBUG_PRINTK(" ");
		DEBUG_PRINTK("0x%08x  ", ret);
	} else=20
		DEBUG_PRINTK("R%02d:       0x%08x  ",  regnum, ret);
}

#define res_size(_r) (((_r)->end - (_r)->start) + 1)
static void temac_dump(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	u32 ret;
	char * name;
	int ii, jj;

	DEBUG_PRINTK("\nresources:\n\tirq=3D%d", ndev->irq);
	DEBUG_PRINTK("\n\tnic  physical address =3D%x ", lp->nic_addr_res->start=
);
	DEBUG_PRINTK("size %x ", res_size(lp->nic_addr_res));
	DEBUG_PRINTK("virtual address %lx", ndev->base_addr);
	DEBUG_PRINTK("\n\t irq=3D%d mem=3D%lx phy=3D%x", ndev->irq, ndev->base_a=
ddr, lp->phy_addr);

	DEBUG_PRINTK("\n\t");
	ret =3D mdio_read(ndev, PHY_NUM, MII_SSR) ;
	switch (ret & MII_SSR_SPDMASK) {
		case MII_SSR_SPD1000:
			DEBUG_PRINTK("1000");
			break;
		case MII_SSR_SPD100:
			DEBUG_PRINTK("100");
			break;
		case MII_SSR_SPD10:
			DEBUG_PRINTK("10");
			break;
		default:
			DEBUG_PRINTK("Error : invalid PHY mode/speed");
	};
	DEBUG_PRINTK("BASE-T, ");
	if ((ret & MII_SSR_FD) =3D=3D MII_SSR_FD) {
		DEBUG_PRINTK("FD");
	} else {
		DEBUG_PRINTK("HD");
	}
	if ((ret & MII_SSR_LINK)  =3D=3D 0) {
		DEBUG_PRINTK(" Ethernet Link Down");
	}
	/* read mii phy registers */
	DEBUG_PRINTK("\nReading PHY Regs through DCR:\n\t");
	for (ii =3D 0; ii < 32; ii++) {
		switch (ii) {
			case MII_ANI:
				disp_mii(ndev, "ANI", ii);
				break;
			case MII_SSR:
				disp_mii(ndev, "SSR", ii);
				break;
			case MII_ISR:
				disp_mii(ndev, "ISR", ii);
				break;
			case MII_BMCR:
				disp_mii(ndev, "MCR", ii);
				break;
			case MII_BMSR:
				disp_mii(ndev, "MSR", ii);
				break;
			case MII_PHYSID1:
				disp_mii(ndev,"PHYSID1",ii);
				break;
			case MII_PHYSID2:
				disp_mii(ndev,"PHYSID2",ii);
				break;
			case MII_ADVERTISE:
				disp_mii(ndev,"ADV", ii);
				break;
			case MII_LPA:
				disp_mii(ndev,"LPA", ii);
				break;
			case MII_EXPANSION:
				disp_mii(ndev,"EXPANSION", ii);
				break;
			case MII_CTRL1000:
				disp_mii(ndev,"CTRL1000", ii);
				break;
			case MII_STAT1000:
				disp_mii(ndev,"STAT1000", ii);
				break;
			case MII_ESTATUS:
				disp_mii(ndev,"ESTATUS", ii);
				break;
			case MII_DCOUNTER:
				disp_mii(ndev,"DCOUNTER", ii);
				break;
			case MII_NWAYTEST:
				disp_mii(ndev,"NWAYTEST", ii);
				break;
			case MII_RERRCOUNTER:
				disp_mii(ndev,"RERRCOUNT", ii);
				break;
			case MII_SREVISION:
				disp_mii(ndev,"SREVISION",ii);
				break;
			case MII_RESV1:
				disp_mii(ndev,"RESV1",ii);
				break;
			case MII_LBRERROR:
				disp_mii(ndev,"LBERROR",ii);
				break;
			case MII_PHYADDR:
				disp_mii(ndev,"PHYADDR",ii);
				break;
			case MII_RESV2:
				disp_mii(ndev,"RESV2",ii);
				break;
			case MII_TPISTATUS:
				disp_mii(ndev,"TPISTATUS",ii);
				break;
			case MII_NCONFIG:
				disp_mii(ndev,"NCONFIG",ii);
				break;
#if 0
			case MII_FCSCOUNTER:
				disp_mii(ndev,"FCSCOUNTER",ii);
				break;
#endif
			default:
				disp_mii(ndev,0, ii);
				break;
		}
	}
	/*
	Print TEMAC Receiver and Transmitter configuration=20
	*/
	DEBUG_PRINTK("\nReading TEMAC Regs:\n");

	for (ii =3D 0x200,jj =3D 0; ii <=3D 0x3a4; ii +=3D 4) {
		switch (ii) {
			case XGP_E0_RxCW0:
				disp_emac_cfg(ndev, "RxCW0", ii, jj++);
				break;
			case XGP_E0_RxCW1:
				disp_emac_cfg(ndev, "RxCW1", ii, jj++);
				break;
			case XGP_E0_TxCW:
				disp_emac_cfg(ndev, "TxCW", ii, jj++);
				break;
			case XGP_E0_FLOW:
				disp_emac_cfg(ndev, "Flow", ii, jj++);
				break;
			case XGP_E0_MODECONFIG:
				disp_emac_cfg(ndev, "ModeCfg", ii, jj++);
				break;
			case XGP_E0_MGMTCONFIG:
				disp_emac_cfg(ndev, "MgmtCfg", ii, jj++);
				break;
			case XGP_E0_UNICAST0:
				disp_emac_cfg(ndev, "MacAddr0", ii, jj++);
				break;
			case XGP_E0_UNICAST1:
				disp_emac_cfg(ndev, "MacAddr1", ii, jj++);
				break;
			case XGP_E0_ATCW0:
				disp_emac_cfg(ndev, "AtAddr0", ii, jj++);
				break;
			case XGP_E0_ATCW1:
				disp_emac_cfg(ndev, "AtAddr1", ii, jj++);
				break;
			case XGP_E0_ATCAF:
				disp_emac_cfg(ndev, "AtCAF", ii, jj++);
				break;
			case XGP_E0_ISR:
				disp_emac_cfg(ndev, "ISR", ii, jj++);
				break;
			case XGP_E0_IER:
				disp_emac_cfg(ndev, "IER", ii, jj++);
				break;
			default:
				break;
		}
	}
}

/*
OPTIONAL
void (*set_multicast_list)(struct net_device *dev);=20
Method called when the multicast list for the device changes and when the=
=20
flags change. See the section Multicast for further details and a sample =

implementation.=20
*/
static void temac_set_multicast_list(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	struct dev_mc_list *mcptr =3D ndev->mc_list;
	int mc_cnt =3D ndev->mc_count;
	u32 hash_val;
	u16 i, oft, hash_table[4];
	unsigned long flags;

	// DEBUG_FUNC;

	spin_lock_irqsave(&lp->lock, flags);
#if 0
	for (i =3D 0, oft =3D 0x10; i < 6; i++, oft++)
		iow(lp, oft, ndev->dev_addr[i]);

	/* Clear Hash Table */
	for (i =3D 0; i < 4; i++)
		hash_table[i] =3D 0x0;

	/* broadcast address */
	hash_table[3] =3D (1 << 15);

	/* the multicast address in Hash Table : 64 bits */
	for (i =3D 0; i < mc_cnt; i++, mcptr =3D mcptr->next) {
		hash_val =3D cal_CRC((char *) mcptr->dmi_addr, 6, 0) & 0x3f;
		hash_table[hash_val / 16] |=3D (u16) 1 << (hash_val % 16);
	}

	/* Write the hash table to MAC MD table */
	for (i =3D 0, oft =3D 0x16; i < 4; i++) {
		iow(lp, oft++, hash_table[i] & 0xff);
		iow(lp, oft++, (hash_table[i] >> 8) & 0xff);
	}
#endif
	spin_unlock_irqrestore(&lp->lock, flags);
}
/*=20
Changes the mac address if the controller is not running.=20

int (*set_mac_address)(struct net_device *dev, void *addr);=20
Function that can be implemented if the interface supports the ability to=
 change its=20
hardware address. Many interfaces don't support this ability at all. Othe=
rs use the=20
default eth_mac_addr implementation (from drivers/net/net_init.c). eth_ma=
c_addr=20
only copies the new address into dev->dev_addr, and it does so only if th=
e interface=20
is not running. Drivers that use eth_mac_addr should set the hardware MAC=
=20
address from dev->dev_addr in their open method.=20

*/
u32 temac_set_mac_address(struct net_device *ndev, void *addr)
{
	u32 ret;

	// DEBUG_FUNC;
	if (addr)=20
		memcpy(ndev->dev_addr, addr, ETH_ALEN);

	if (!is_valid_ether_addr(ndev->dev_addr)) {
		printk("%s: Invalid ethernet MAC address.  Please set using ifconfig\n"=
, ndev->name);
		return -EIO;
	}

#if 0
	{
	int ii;
	DEBUG_PRINTK(" MAC: ");
		for (ii =3D 0; ii < 5; ii++)
			printk("%02x:", ndev->dev_addr[ii]);
		printk("%02x", ndev->dev_addr[5]);
	}
#endif

	/* set up unicast MAC address filter */
	ret =3D ((ndev->dev_addr[3] << 24) | (ndev->dev_addr[2] << 16) | (ndev->=
dev_addr[1] << 8) | (ndev->dev_addr[0]));
	// printk("%08x", ret);
	emac_AF_write(ndev, XGP_E0_UNICAST0, ret);

	ret =3D (ndev->dev_addr[5] << 8) | ndev->dev_addr[4];
	// printk("%08x", ret);
	emac_AF_write(ndev, XGP_E0_UNICAST1, ret);

	/* enable address filter */
	emac_AF_write(ndev, XGP_E0_ATCAF, 0);
	return 0;
}
/*
Initilize temac board
 */
static void
temac_reset(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	u32 ret;
	int i;

	// DEBUG_FUNC;
	/*=20
	   Hold the PHY in reset=20
	 */
	mtdcr(XPAR_LL_TEMAC_0_DCR_BASEADDR, XGP_CON_REG_PHY_RESET);
	mdelay(40);
	/*=20
	   reset the peripheral and the emac
	   hold the temac in reset since this bit is not self-clearing
	 */
	mtdcr(XPAR_LL_TEMAC_0_DCR_BASEADDR, XGP_CON_REG_TEMAC_RESET);
	mdelay(40);

	/*=20
	   reset the peripheral. This is self-clearing. This will also kick=20
	   the temac and PHY out of reset. =20
	   Note that this may enable the Tx/Rx of the=20
	   temac if tied-off that way in hardware, but that should be OK.=20
	 */
	mtdcr(XPAR_LL_TEMAC_0_DCR_BASEADDR, XGP_CON_REG_PERIPH_RESET);
	mdelay(40);

	mtdcr(XPAR_LL_TEMAC_0_DCR_BASEADDR, 0);
	mdelay(40);

	/* disable the Tx/Rx first */
	ret =3D emac_cfg_read(ndev, 0, XGP_E0_TxCW);
	emac_cfg_write(ndev, 0, XGP_E0_TxCW, (ret & (~XGP_E0_TxCW_ENABLE)));
	ret =3D emac_cfg_read(ndev, 0, XGP_E0_RxCW1);
	emac_cfg_write(ndev, 0, XGP_E0_RxCW1, (ret & (~XGP_E0_RxCW1_ENABLE)));

	/* Set up MII management registers to write to PHY  */
	emac_cfg_write(ndev, 0, XGP_E0_MGMTCONFIG, XGP_MDIO_ENABLE_MASK | XGP_MD=
IO_CLOCK_DIV_100MHz);
	/*=20
	Set A-N Advertisement Regs for Full Duplex modes ONLY
	address 4 =3D Autonegotiate Advertise Register
	Disable 1000 Mbps for negotiation if not built for GEth
	*/
	ret =3D mdio_read(ndev, PHY_NUM, MII_ADVERTISE);
	// mdio_write(ndev, PHY_NUM, MII_ADVERTISE, ((ret & (~(ADVERTISE_1000XFU=
LL | ADVERTISE_1000XHALF)) | (ADVERTISE_100FULL | ADVERTISE_10FULL))));
	mdio_write(ndev, PHY_NUM, MII_ADVERTISE, (ret | ADVERTISE_CSMA | ADVERTI=
SE_100FULL));
	mdio_write(ndev, PHY_NUM, MII_CTRL1000, 0);
	// ret =3D mdio_read(ndev, PHY_NUM, MII_CTRL1000);=20
	// mdio_write(ndev, PHY_NUM, MII_CTRL1000, ((ret & 0x0000FEFF) | ADVERTI=
SE_1000FULL));
	/*
	Soft reset the PHY
	address 0 =3D Basic Mode Control Register
	*/
	ret =3D mdio_read(ndev, PHY_NUM, MII_BMCR);
	mdio_write(ndev, PHY_NUM, MII_BMCR, (ret | BMCR_RESET | BMCR_ANENABLE | =
BMCR_ANRESTART));


	if (lp->poll =3D=3D 0) {
		/*=20
		uncomment these lines if you need to set up interrupt from the PHY
		to notify the CPU of link status changes
		*/
		/*=20
		set up interrupt from the PHY
		Speed change                 	(14)
		Duplex                       	(13)
		Autoneg Complete     		(11)
		Link Status          		(10)
		*/
		mdio_write(ndev, PHY_NUM, MII_DCOUNTER, 0x6c00);
		/*=20
		at this point, the PHY interrupts the CPU when link is established. The=
 Phy interrupt
		handler will have to call ltemac_Reset to set the MAC appropriately
		*/
	}


	/*
	Wait for a PHY Link (auto-negotiation to complete)...
	*/
	// DEBUG_PRINTK("\nWaiting for ethernet link..");
	ret =3D mdio_read(ndev, PHY_NUM, MII_BMSR);
	i =3D 64;
	while (((ret & BMSR_LSTATUS) !=3D BMSR_LSTATUS) && i--) {
		DEBUG_PRINTK(".");
		mdelay(500);
		ret =3D mdio_read(ndev, PHY_NUM, MII_BMSR);
	}

	ret =3D mdio_read(ndev, PHY_NUM, MII_SSR) ;
	switch (ret & MII_SSR_SPDMASK) {
		case MII_SSR_SPD1000: 				/* 1000Base-T */
			emac_cfg_write(ndev, 0, XGP_E0_MODECONFIG, XGP_E0_MODECONFIG_SPD1000);=

			break;
		case MII_SSR_SPD100: 				/* 100Base-T */
			emac_cfg_write(ndev, 0, XGP_E0_MODECONFIG, XGP_E0_MODECONFIG_SPD100);
			break;
		case MII_SSR_SPD10: 				/* 10Base-T */
			emac_cfg_write(ndev, 0, XGP_E0_MODECONFIG, XGP_E0_MODECONFIG_SPD10);
			break;
	};
	if ((ret & MII_SSR_FD) !=3D (MII_SSR_FD)) {
			/* set up Tx/Rx config reg for half duplex */
			ret =3D emac_cfg_read(ndev, 0, XGP_E0_TxCW);
			emac_cfg_write(ndev, 0, XGP_E0_TxCW, ret | XGP_E0_TxCW_HD);
			ret =3D emac_cfg_read(ndev, 0, XGP_E0_RxCW1);
			emac_cfg_write(ndev, 0, XGP_E0_RxCW1, ret | XGP_E0_RxCW1_HD);
	}
	temac_set_mac_address(ndev,0);
	/* Set address filter table */
	temac_set_multicast_list(ndev);
	/*
	 Enable EMAC TX and RX
	*/
	ret =3D emac_cfg_read(ndev, 0, XGP_E0_TxCW);
	emac_cfg_write(ndev, 0, XGP_E0_TxCW, ret | XGP_E0_TxCW_ENABLE);

	ret =3D emac_cfg_read(ndev, 0, XGP_E0_RxCW1);
	emac_cfg_write(ndev, 0, XGP_E0_RxCW1, ret | XGP_E0_RxCW1_ENABLE);


#define XTE_IPISR_OFFSET 0x00000020  /**< IP interrupt status */
#define XTE_IPIER_OFFSET 0x00000028  /**< IP interrupt enable */
#define XTE_IPXR_XMIT_DONE_MASK         0x00000001 /**< Tx complete */
#define XTE_IPXR_RECV_DONE_MASK         0x00000002 /**< Rx complete */

	/* Get contents of IPIER register */
	// ret =3D ior(ndev, XTE_IPIER_OFFSET);
	ret =3D emac_cfg_read(ndev, 0, XGP_E0_IER);

	DEBUG_PRINTK("\nIER: =3D %08x ", ret);
	ret |=3D XTE_IPXR_XMIT_DONE_MASK;
	ret |=3D XTE_IPXR_RECV_DONE_MASK;
	DEBUG_PRINTK("\t%08x", ret);
	/* Update IPIER with new setting */
	emac_cfg_write(ndev, 0, XGP_E0_IER, ret);
	// iow(ndev, XTE_IPIER_OFFSET, ret);
	// ret =3D ior(ndev, XTE_IPIER_OFFSET);
	ret =3D emac_cfg_read(ndev, 0, XGP_E0_IER);
	DEBUG_PRINTK("\t%08x", ret);



	/*
 	Print PHY regs so that we can see if they are configured correctly
 	*/
	// temac_dump(ndev);

	/* Init Driver variable */
	ndev->trans_start =3D 0;
	spin_lock_init(&lp->lock);
}

#define C_IDLE    (1)
#define C_HEADER  (2)
#define C_PAYLOAD (3)
#define C_FOOTER  (4)

int recvFrame(struct net_device *ndev, struct sk_buff *skb, u8 *bd)
{
	u32 cw;
	u32 dw;
	u32 src_rdy_counter =3D 0;
	u32 sof_counter =3D 0;
	enum { S_IDLE=3D1, S_HEADER, S_PAYLOAD, S_FOOTER } state =3D S_IDLE;
	const u32 src_rdy_counter_max =3D 10;
	const u32 sof_counter_max =3D 10;
	u8 *b ;
	// DEBUG_FUNC;
	// skb->data SHOULD =3D=3D skb-->tail;=20
	b =3D skb->tail ;
	skb->len =3D 0;
	while (1) {

		/*  read the control word to see if the source ready bit is active (low=
) */
		while (((cw =3D ior(ndev,LL_RX_CTRL)) & LL_RX_SRC_RDY_MASK) =3D=3D LL_R=
X_SRC_RDY_MASK) {

			/* only hang around for some amount of time waiting for data to be pre=
sent */
			// DEBUG_PRINTK("00 cw=3D%08x )", cw);
			if (++src_rdy_counter =3D=3D src_rdy_counter_max) {
				skb->len =3D 0;
				//DEBUG_PRINTK(" SRC_RDY_TIMEOUT_ERROR");
				return SRC_RDY_TIMEOUT_ERROR;
			}
		}

		/* reset watchdog counter */
		src_rdy_counter =3D 0;
		/*=20
		IDLE STATE
		*/
		if (state =3D=3D S_IDLE) {
			// DEBUG_PRINTK("S_IDLE");

			/*
			haven't reached the SOF yet
			only hang around for so long awaiting an SOF before returning
			*/
			if ((cw & LL_SOF_MASK)) {
				if (++sof_counter =3D=3D sof_counter_max) {
					skb->len =3D 0;
					// DEBUG_PRINTK(" SOF_TIMEOUT_ERROR");
					return SOF_TIMEOUT_ERROR;
				}
			}

			else {

				/*
				reset watchdog counter
				*/
				sof_counter =3D 0;
				/*=20
				ensure we record the start of a frame
				*/
				state =3D S_HEADER;
			}

			/* ignore the LocalLink Header Words */
			dw =3D ior(ndev,LL_RX_DATA);
			// DEBUG_PRINTK(" %08x",dw);
		}
		/*
		HEADER STATE
		*/
		else if (state =3D=3D S_HEADER) {
			// DEBUG_PRINTK("S_HEADER");
			dw =3D ior(ndev, LL_RX_DATA);
			if (!(cw & LL_SOP_MASK)) {
				state =3D S_PAYLOAD;
				// DEBUG_PRINTK(" %08x",dw);
				*((u32 *) b) =3D dw;
				b +=3D 4;
				skb->len +=3D 4;
				skb->tail +=3D 4;
			}
		}
		/* PAYLOAD STATE */
		else if (state =3D=3D S_PAYLOAD) {
			// DEBUG_PRINTK("S_PAYLOAD");
			*((u32 *) b) =3D ior(ndev,LL_RX_DATA);
			// DEBUG_PRINTK(" %08x",dw);
			b +=3D 4;
			skb->len +=3D 4;
			skb->tail +=3D 4;
			if (!(cw & LL_EOP_MASK))
				state =3D S_FOOTER;
		}
		/* FOOTER STATE */
		else if (state =3D=3D S_FOOTER) {
			// DEBUG_PRINTK("S_FOOTER");
			*((u32 *) bd) =3D ior(ndev,LL_RX_DATA);
			// DEBUG_PRINTK(" %08x",dw);
			bd +=3D 4;
			if (!(cw & LL_EOF_MASK)) {

				/* we've got the last data word */
				cw =3D ~cw & LL_REM_MASK;
				/* update the payload count according to the (masked) rem value */
				while (cw) {
					if (cw & 1)
						skb->len++;
					cw >>=3D 1;
				}

				/* return success */
				// DEBUG_PRINTK("SUCCESS");
				return 0;
			}
		}
	}
}

u8 recvBd[] =3D {
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00,=20
	0x00, 0x00, 0x00, 0x00,=20
	0x00, 0x00, 0x00, 0x00,=20
	0x00, 0x00, 0x00, 0x00,=20
	0x00, 0x00, 0x00, 0x00
};
/*
 Received a packet and pass to upper layer
 */
static void temac_rx(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	struct sk_buff *skb;
	u32 ret =3D 0;

	// DEBUG_FUNC;
	skb =3D dev_alloc_skb(XTE_MAX_FRAME_SIZE);
	if (!skb) {
		if (printk_ratelimit())
			printk(KERN_NOTICE "temac: low on memory - packet dropped\n");
		lp->stats.rx_dropped++;
		return;
	}
	if ((ret =3D recvFrame(ndev, skb, recvBd)) =3D=3D 0) {
		// dump_skb(skb, "Recv");
		/* Pass to upper layer */
		skb->dev =3D ndev;
		skb->protocol =3D eth_type_trans(skb, ndev);
		lp->stats.rx_bytes +=3D skb->len;
		lp->stats.rx_packets++;
		netif_rx(skb);
	} else {
		//DEBUG_PRINTK("\nwhoops=3D%x",ret);
	}
}
static irqreturn_t temac_interrupt(int irq, void *ndev_id, struct pt_regs=
 *regs)
{
	struct net_device *ndev =3D ndev_id;
	struct temac_local *lp =3D ndev->priv;
	int ret ;
	// DEBUG_FUNC;
	if (!ndev) {
		DEBUG_PRINTK("temac_interrupt() without DEVICE arg\n");
		return IRQ_HANDLED;
	}
	switch (irq) {
		case -1:
			DEBUG_PRINTK("temac_interrupt() NET_POLL\n");
			break;
		case -2:
			// DEBUG_PRINTK("temac_interrupt() temac_rx_timeout()\n");
			break;
		case 0:
			DEBUG_PRINTK("temac_interrupt() INT\n");
			break;
		default:
			DEBUG_PRINTK("temac_interrupt() IRQ=3D%d\n",irq);
			break;
	}
	disp_emac_cfg(ndev, "ISR", XGP_E0_ISR,0); 	=09
	disp_emac_cfg(ndev, "IER", XGP_E0_IER,0); 	=09

	/* A real interrupt coming */
	spin_lock(&lp->lock);
	/*  read the control word to see if the source ready bit is active (low)=
 */
	while ((ior(ndev, LL_RX_CTRL) & LL_RX_SRC_RDY_MASK) !=3D LL_RX_SRC_RDY_M=
ASK)=20
		temac_rx(ndev);


	/* read from PHY status register */
	ret =3D mdio_read(ndev, PHY_NUM, MII_FCSCOUNTER);
	if (lp->phy_status !=3D ret) {
		lp->phy_status =3D ret;
		DEBUG_PRINTK("\nPHY interrupt status register %08x", ret);
		if ((ret & 0x00000c00) =3D=3D (0x00000c00)) {
			DEBUG_PRINTK("\nautoneg complete , link up");
		} else if (ret & 0x00000400) {
			DEBUG_PRINTK("\nlink down");
		}
	}

	spin_unlock(&lp->lock);
	return IRQ_HANDLED;
}
/*=20
OPTIONAL
void (*poll_controller)(struct net_device *dev);=20
Function that asks the driver to check for events on the interface in sit=
uations=20
where interrupts are disabled. It is used for specific in-kernel networki=
ng tasks,=20
such as remote consoles and kernel debugging over the network.=20

*/
#ifdef CONFIG_NET_POLL_CONTROLLER
static void temac_poll_controller(struct net_device *ndev)
{
	DEBUG_FUNC;
	disable_irq(ndev->irq);
	temac_interrupt(-1, ndev, NULL);
	enable_irq(ndev->irq);
}
#endif

/*
 * This function is used to handle ports that do not have an interrupt.
 */
static void=20
temac_rx_timeout(unsigned long data)
{
	struct net_device *ndev =3D (struct net_device *) data;
	struct temac_local *lp =3D ndev->priv;

	// DEBUG_FUNC;
	disable_irq(ndev->irq);
	temac_interrupt(-2, ndev, NULL);
	enable_irq(ndev->irq);

	mod_timer(&lp->rx_timer, TEMAC_RX_TIMEOUT);
}
/*
 A periodic timer routine
 Dynamic media sense, allocated Rx buffer...
 */
static void temac_mii_timeout(unsigned long data)
{
	struct net_device *ndev =3D (struct net_device *) data;
	struct temac_local *lp =3D ndev->priv;

	// DEBUG_PRINTL("temac_mii_timer()");
	mii_check_media(&lp->mii_if, netif_msg_link(lp), 0);
	/* Set timer again */
	mod_timer(&lp->mii_timer, TEMAC_MII_TIMEOUT);
}

/*

Open the interface.

The interface is opened whenever "ifconfig" actives it.
The open method should register any system resource it needs (I/O ports, =
IRQ,=20
DMA, etc.), turn on the hardware, and perform any other setup your device=
=20
requires.=20

First, the hardware (MAC) address needs to be copied from the hardware de=
vice to=20
dev->dev_addr before the interface can communicate with the outside world=
=2E The=20
hardware address can then be copied to the device at open time. The snull=
 software=20
interface assigns it from within open; it just fakes a hardware number us=
ing an ASCII=20
string of length ETH_ALEN, the length of Ethernet hardware addresses.=20

The open method should also start the interfaces transmit queue (allowing=
 it to=20
accept packets for transmission) once it is ready to start sending data. =
The kernel=20
provides a function to start the queue:=20

void netif_start_queue(struct net_device *dev);=20

The open code for snull looks like the following:=20

int snull_open(struct net_device *dev)=20

{

request_region(), request_irq(), .... (like fops->open)=20


Assign the hardware address of the board: use "\0SNULx", where=20
x is 0 or 1. The first byte is '\0' to avoid being a multicast=20
address (the first byte of multicast addrs is odd).=20


;=20
if (dev =3D=3D snull_devs[1]
)




 */
static int
temac_open(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;

	// DEBUG_FUNC;

	/*
	 * Just to be safe, stop TX queue and the ndevice first. If the ndevice =
is
	 * already stopped, an error will be returned. In this case, we don't
	 * really care,.
	 */
	netif_stop_queue(ndev);
	spin_lock_irqsave(&XTE_spinlock, flags);

	if (ndev->mtu > XTE_MTU)
		ndev->mtu =3D XTE_MTU;

	/*
	Enable interrupts if not in polled mode=20
	*/
	if (ndev->irq < 0) {
		lp->poll =3D 1;
	} else if (request_irq(ndev->irq, &temac_interrupt, SA_SHIRQ, ndev->name=
, ndev)) {
			printk(KERN_ERR "%s: XTemac could not allocate interrupt %d. reverting=
 to polled IO\n", ndev->name, ndev->irq);
			lp->poll =3D 1;
			// spin_unlock_irqrestore(&XTE_spinlock, flags);
			// return -EAGAIN;
	}
=09
	/* Initialize TEMAC board */
	temac_reset(ndev);

	/* set and active a timer process */
	lp->mii_timer.data     =3D (unsigned long) ndev;
	lp->mii_timer.function =3D &temac_mii_timeout;
	init_timer(&lp->mii_timer);
	mod_timer(&lp->mii_timer, TEMAC_MII_TIMEOUT);



	lp->rx_timer.data     =3D (unsigned long) ndev;
	lp->rx_timer.function =3D &temac_rx_timeout;
	init_timer(&lp->rx_timer);
	mod_timer(&lp->rx_timer, TEMAC_RX_TIMEOUT);


	mii_check_media(&lp->mii_if, netif_msg_link(lp), 1);
	// netif_carrier_on(ndev);
	/* We're ready to go. */
	netif_start_queue(ndev);
	spin_unlock_irqrestore(&XTE_spinlock, flags);

	return 0;
}

static int temac_ethtool_get_settings(struct net_device *ndev, struct eth=
tool_cmd *cmd)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	int r =3D -EOPNOTSUPP;

	if (lp->mii) {
		spin_lock_irqsave(&lp->lock, flags);
		mii_ethtool_gset(&lp->mii_if, cmd);
		spin_unlock_irqrestore(&lp->lock, flags);
		r =3D 0;
	}
	return r;
}

static int
temac_ethtool_set_settings(struct net_device *ndev,
			   struct ethtool_cmd *cmd)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	int r =3D -EOPNOTSUPP;

	if (lp->mii) {
		spin_lock_irqsave(&lp->lock, flags);
		r =3D mii_ethtool_sset(&lp->mii_if, cmd);
		spin_unlock_irqrestore(&lp->lock, flags);
	}
	return r;
}

static void
temac_ethtool_get_drvinfo(struct net_device *ndev,
			  struct ethtool_drvinfo *info)
{

	memset(info, 0, sizeof(struct ethtool_drvinfo));
	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
	/* Also tell how much memory is neinfoinfo for dumping register values *=
/
	info->regdump_len =3D 0;
}

static u32 temac_ethtool_get_link(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	int r;

	spin_lock_irqsave(&lp->lock, flags);
	r =3D mii_link_ok(&lp->mii_if);
	spin_unlock_irqrestore(&lp->lock, flags);

	return r;
}

static u32 temac_ethtool_get_msglevel(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	return lp->msg_enable;
}

static void temac_ethtool_set_msglevel(struct net_device *ndev, u32 value=
)
{
	struct temac_local *lp =3D ndev->priv;
	lp->msg_enable =3D value;
}

static int temac_ethtool_nway_reset(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	int r =3D -EOPNOTSUPP;

	if (lp->mii) {
		spin_lock_irqsave(&lp->lock, flags);
		r =3D mii_nway_restart(&lp->mii_if);
		spin_unlock_irqrestore(&lp->lock, flags);
	}
	return r;
}

static struct ethtool_ops temac_ethtool_ops =3D {
	.get_settings =3D temac_ethtool_get_settings,
	.set_settings =3D temac_ethtool_set_settings,
	.get_drvinfo =3D temac_ethtool_get_drvinfo,
	.get_msglevel =3D temac_ethtool_get_msglevel,
	.set_msglevel =3D temac_ethtool_set_msglevel,
	.nway_reset =3D temac_ethtool_nway_reset,
	.get_link =3D temac_ethtool_get_link,
	.get_tx_csum =3D ethtool_op_get_tx_csum,
	.get_sg =3D ethtool_op_get_sg,
	.get_tso =3D ethtool_op_get_tso,
	.get_perm_addr =3D ethtool_op_get_perm_addr,
};
/* TEMAC network board routine ---------------------------- */



/*=20
OPTIONAL

int (*change_mtu)(struct net_device *dev, int new_mtu);=20
Function that takes action if there is a change in the maximum transfer u=
nit (MTU)=20
for the interface. If the driver needs to do anything particular when the=
 MTU is=20
changed by the user, it should declare its own function; otherwise, the d=
efault does=20
the right thing. snull has a template for the function if you are interes=
ted.=20
*/
int temac_change_mtu(struct net_device *dev, int new_mtu)=20
{
	return 0;
}


/*=20
Our watchdog timed out. Called by the networking layer=20
Method called by the networking code when a packet transmission fails to =
complete within a reasonable period, on the assumption that an interrupt =
has been=20
missed or the interface has locked up. It should handle the problem and r=
esume packet transmission.=20
*/
static void=20
temac_tx_timeout(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;

	DEBUG_FUNC;
	spin_lock_irqsave(&lp->lock, flags);

	netif_stop_queue(ndev);
	printk(KERN_ERR "%s: XTemac exceeded transmit timeout of %lu ms.  Resett=
ing emac.\n", ndev->name, TEMAC_TX_TIMEOUT * 1000UL / HZ);
	lp->stats.tx_errors++;
	temac_reset(ndev);
	/* We can accept TX packets again */
	ndev->trans_start =3D jiffies;
	netif_wake_queue(ndev);

	spin_unlock_irqrestore(&lp->lock, flags);
}




/*
OPTIONAL
int (*do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);=20
Performs interface-specific ioctl commands. (Implementation of those comm=
ands is described in the section =93Custom ioctl Commands.=94)=20
The corresponding field in structnet_device can be left as NULL if the in=
terface doesn=92t need any=20
interface-specific commands.=20
 */
static int temac_do_ioctl(struct net_device *ndev, struct ifreq *rq, int =
cmd)
{
	struct temac_local *lp =3D ndev->priv;
	int rc;
	unsigned long flags;

	/* SIOC[GS]MIIxxx ioctls */
	if (lp->mii) {
		spin_lock_irqsave(&lp->lock, flags);
		rc =3D generic_mii_ioctl(&lp->mii_if, if_mii(rq), cmd, NULL);
		spin_unlock_irqrestore(&lp->lock, flags);
	} else {
		rc =3D -EOPNOTSUPP;
	}

	return rc;
}

u32 rem_table[] =3D {
	0x0000000F, 0x00000008, 0x0000000C, 0x0000000E,
};
int sendFrame(struct net_device *ndev, struct sk_buff *skb, u8 *bd)
{
	int i;
	u32 cw;
	u32 *bp =3D (u32 *) skb->data;
	u32 *bdesc =3D (u32 *) bd;

	// DEBUG_FUNC;
	/*
	Send Buffer Descriptor as LocalLink Header
	*/

	iow(ndev, LL_TX_DATA, bdesc[0]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & (LL_SOF_MASK | LL_REM_MASK)));
	iow(ndev, LL_TX_DATA, bdesc[1]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[2]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[3]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[4]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[5]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[6]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
	iow(ndev, LL_TX_DATA, bdesc[7]);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));

	/*
	Send Ethernet Frame in LocalLink payload
	*/
	for (i =3D 0; i < skb->len / 4; i++) {

		/* Assume caches are off */
		iow(ndev, LL_TX_DATA, bp[i]);
		cw =3D 0;
		/* Detect End of Packet */
		if (i =3D=3D (skb->len / 4 - 1)) {
			if (skb->len % 4) {
				cw |=3D LL_REM_MASK;
			} else {
				cw |=3D LL_EOP_MASK | LL_REM_MASK;
			}
		}
		/* Detect Start of Packet */
		if (i =3D=3D 0)
			cw |=3D LL_SOP_MASK | LL_REM_MASK;
		if (i > 0 && i < (skb->len / 4 - 1))
			cw |=3D LL_REM_MASK;
		iow(ndev, LL_TX_CTRL, ~(0xffffffff & cw));
	}

	/*  If skb->len is not a multiple of 4, then send last 1, 2, or 3 bytes.=
=2E. */
	if (skb->len % 4) {
		iow(ndev, LL_TX_DATA, bp[i]);
		cw =3D LL_EOP_MASK | rem_table[skb->len % 4];
		iow(ndev, LL_TX_CTRL, ~(0xffffffff & cw));
	}
	/*
	Send Dummy LocalLink Footer
	*/
	iow(ndev, LL_TX_DATA, 0);
	iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_EOF_MASK));
	return 0;
}
u8 bDescriptor[] =3D {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 0, 0, 0
};

/*
Hardware start transmission.
Send a packet to media from the upper layer.
Method that initiates the transmission of a packet.=20
The full packet (protocol headers and all) is contained in a socket buffe=
r (sk_buff) structure.=20
Socket buffers are introduced later in this chapter.=20
skb->data points to the packet
skb->len is its length
 */
static int temac_hard_start_xmit(struct sk_buff *skb, struct net_device *=
ndev)
{
	struct temac_local *lp =3D ndev->priv;
	// DEBUG_FUNC;
	netif_stop_queue(ndev);
	lp->stats.tx_bytes +=3D skb->len;
=09
	ndev->trans_start =3D jiffies;	/* save the time stamp */

	sendFrame(ndev,skb, bDescriptor);
	// dump_skb(skb, "Send");
	/* free this SKB */
	dev_kfree_skb(skb);
	netif_wake_queue(ndev);
	return 0;
}
static void temac_shutdown(struct net_device *ndev)
{
	// struct temac_local *lp =3D ndev->priv;
	DEBUG_FUNC;
	/* RESET device */
	mdio_write(ndev, 0, MII_BMCR, BMCR_RESET);	/* PHY RESET */
	/* Power-Down PHY */
	/* Disable all interrupt */
	/* Disable RX */
}
/*
Stop the interface.
Stops the interface. The interface is stopped when it is brought down.=20
This function should reverse operations performed at open time.=20
*/
static int temac_stop(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	unsigned long flags;
	DEBUG_PRINTL("temac_stop()");
	DEBUG_FUNC;
	spin_lock_irqsave(&XTE_spinlock, flags);

	del_timer(&lp->rx_timer);
	del_timer(&lp->mii_timer);

	/* Stop Send queue */
	netif_stop_queue(ndev);
	/* Now we could stop the ndevice */
	netif_carrier_off(ndev);
	/*
	 * If not in polled mode, free the interrupt.  Currently, there
	 * isn't any code to set polled mode, so this check is probably
	 * superfluous.
	 */
	free_irq(ndev->irq, ndev);
	temac_shutdown(ndev);
	return 0;
}

/* temac_release_board
 *
release a board, and any mapped resources
 */

static void temac_release_board(struct platform_device *pdev, struct net_=
device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	DEBUG_FUNC;
	/* unmap our resources */

	iounmap((void *) ndev->base_addr);

	/* release the resources */

	if (lp->phy_addr_req !=3D NULL) {
		release_resource(lp->phy_addr_req);
		kfree(lp->phy_addr_req);
	}

	if (lp->nic_addr_res !=3D NULL) {
		release_resource(lp->nic_addr_res);
		kfree(lp->nic_addr_req);
	}
}
/*
Whenever an application needs to get statistics for the interface, this m=
ethod is=20
called. This happens, for example, when ifconfig or netstat -i is run. A =
sample=20
implementation for snull is introduced in the section =93Statistical Info=
rmation.=94=20
 */
static struct net_device_stats=20
*temac_get_stats(struct net_device *ndev)
{
	struct temac_local *lp =3D ndev->priv;
	// DEBUG_PRINTL("temac_get_stats()");
	return &lp->stats;
}

/*
Search TEMAC board, allocate space and register it
 */
static int temac_device_probe(struct platform_device *pdev)
{
	struct net_device *ndev;
	struct xhtemac_platform_data *pdata =3D pdev->dev.platform_data;
	struct temac_local *lp;	/* Point a board information structure */
	int i;
	int ret =3D 0;
	int nic_size;
	// DEBUG_FUNC;
	printk(version);
	/* Init network device */
	ndev =3D alloc_etherdev(sizeof(struct temac_local));
	if (!ndev) {
		printk("%s: could not allocate device.\n", DRV_CARDNAME);
		return -ENOMEM;
	}

	SET_MODULE_OWNER(ndev);
	SET_NETDEV_DEV(ndev, &pdev->dev);
	/* setup board info structure */
	lp =3D (struct temac_local *) ndev->priv;
	// lp->einfo =3D einfo;
	/* Clear memory */
	memset(lp, 0, sizeof(*lp));
	spin_lock_init(&lp->lock);
/* 	get device configuration from platform Device */
	ndev->irq =3D platform_get_irq(pdev, 0);

	if (pdev->num_resources < 2) {
		printk("%s: insufficient resources %d.\n", DRV_CARDNAME, pdev->num_reso=
urces);
		ret =3D -ENODEV;
		goto out;
	}
	lp->phy_addr =3D XGP_HIF_BASEADDR;					/* set default address of PHY */
	ndev->base_addr  =3D XPAR_PLB_LL_IF_0_BASEADDR ;
	ndev->irq =3D XPAR_INTC_0_TEMAC_0_VEC_ID;
	// lp->irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);	/*  I=
RQ */
	lp->nic_addr_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);	/* =
address of NIC */
	if (lp->nic_addr_res =3D=3D NULL) {
		printk(KERN_ERR PFX "insufficient resources\n");
		ret =3D -ENOENT;
		goto out;
	}
	nic_size =3D res_size(lp->nic_addr_res);
	lp->nic_addr_req =3D request_mem_region(lp->nic_addr_res->start, nic_siz=
e, pdev->name);
	if (lp->nic_addr_req =3D=3D NULL) {
		printk(KERN_ERR PFX "cannot claim address reg area\n");
		ret =3D -EIO;
		goto out;
	}

	ndev->base_addr =3D (u32) ioremap(lp->nic_addr_res->start, nic_size);
	if (ndev->base_addr =3D=3D NULL) {
		printk(KERN_ERR "failed to ioremap address reg\n");
		ret =3D -EINVAL;
		goto out;
	}

	/* fill in parameters for net-dev structure */

	// ndev->irq =3D lp->irq_res->start;
	// lp->phy_addr    =3D lp->phy_addr_res->start;
/*      done getting platform_device parameters start initializine device=
 */
	/* Set all handlers to stub values, let user configure this data */
	lp->mii =3D 1;		/*  really important can't read/write anyting until set =
*/
	lp->regshift =3D 3;=09

	lp->mii_if.full_duplex =3D 1;
	lp->mii_if.phy_id_mask =3D 0x1f;
	lp->mii_if.reg_num_mask =3D 0x1f;
	lp->mii =3D 1;
	lp->msg_enable =3D temac_debug;
	lp->mii_if.dev =3D ndev;
	lp->mii_if.mdio_read =3D mdio_read;
	lp->mii_if.mdio_write =3D mdio_write;
	/* Set the mii phy_id so that we can query the link state */
	//  if (lp->mii)
	//      lp->mii_if.phy_id =3D ((lp->a.read_bcr (ioaddr, 33)) >> 5) & 0x1=
f;
	memcpy(ndev->dev_addr, "\0\1\2345", ETH_ALEN);

	temac_set_mac_address(ndev,pdata->mac_addr);
	/* from this point we assume that we have found a TEMAC */
	/* driver system function */
	ether_setup(ndev);
	/* The TEMAC-specific entries in the device structure. */
	ndev->open =3D &temac_open;
	ndev->stop =3D &temac_stop;
	ndev->get_stats =3D &temac_get_stats;
	ndev->do_ioctl =3D &temac_do_ioctl;
	ndev->tx_timeout =3D &temac_tx_timeout;
	ndev->watchdog_timeo =3D msecs_to_jiffies(watchdog);
	ndev->hard_start_xmit =3D &temac_hard_start_xmit;
	ndev->set_multicast_list =3D &temac_set_multicast_list;
	ndev->ethtool_ops =3D &temac_ethtool_ops;
#ifdef CONFIG_NET_POLL_CONTROLLER
	ndev->poll_controller =3D temac_poll_controller;
#endif
	ndev->flags &=3D ~IFF_MULTICAST;			/* clear multicast */
	ndev->change_mtu =3D temac_change_mtu;
	platform_set_drvdata(pdev, ndev);
	ret =3D register_netdev(ndev);
	if (ret =3D=3D 0) {
		printk("%s: temac at %lx,%x IRQ %d MAC: ", ndev->name, ndev->base_addr,=
 lp->phy_addr, ndev->irq);
		for (i =3D 0; i < 5; i++)
			printk("%02x:", ndev->dev_addr[i]);
		printk("%02x", ndev->dev_addr[5]);
#ifdef CONFIG_NET_POLL_CONTROLLER
		printk(" NET_POLL");
#endif
		printk("\n");

	}
	return 0;
//  release:
    out:
	printk("%s: not found (%d).\n", DRV_CARDNAME, ret);
	temac_release_board(pdev, ndev);
	kfree(ndev);
	return ret;
}


static int temac_device_suspend(struct platform_device *pdev, pm_message_=
t state)
{
	struct net_device *ndev =3D platform_get_drvdata(pdev);
	DEBUG_PRINTL("temac_device_suspend()");
	if (ndev) {
		if (netif_running(ndev)) {
			netif_device_detach(ndev);
			temac_shutdown(ndev);
		}
	}
	return 0;
}

static int temac_device_resume(struct platform_device *pdev)
{
	struct net_device *ndev =3D platform_get_drvdata(pdev);
	DEBUG_FUNC;
	if (ndev) {

		if (netif_running(ndev)) {
			temac_reset(ndev);
			netif_device_attach(ndev);
		}
	}
	return 0;
}

static int __devexit temac_device_remove(struct platform_device *pdev)
{
	struct net_device *ndev =3D platform_get_drvdata(pdev);
	DEBUG_FUNC;
	platform_set_drvdata(pdev, NULL);
	unregister_netdev(ndev);
	temac_release_board(pdev, ndev);
	free_netdev(ndev);	/* free device structure */
	DEBUG_PRINTL("%s() exit", __FUNCTION__);
	return 0;
}

static struct platform_driver temac_driver =3D {
	.probe =3D temac_device_probe,
	.remove =3D temac_device_remove,
	.suspend =3D temac_device_suspend,
	.resume =3D temac_device_resume,.driver =3D {
		.name =3D DRV_NAME,
	},
};

static int __init temac_init_module(void)
{
	int err;
	if ((err =3D platform_driver_register(&temac_driver))) {	/* search board=
 and register */
		printk(KERN_ERR "Driver registration failed\n");
		return err;
	}
#if 0
	temac_device =3D platform_device_alloc(DRV_NAME, 0);
	if (!temac_device) {
		goto out_unregister;
	}

	if (platform_device_add(temac_device)) {
		platform_device_put(temac_device);
		temac_device =3D NULL;
	}
#endif
	return 0;
      out_unregister:
	driver_unregister(&temac_driver);
	return -ENOMEM;
}

static void __exit temac_cleanup_module(void)
{
	platform_driver_unregister(&temac_driver);
	if (temac_device) {
		platform_device_unregister(temac_device);
		temac_device =3D NULL;
	}
}

module_init(temac_init_module);
module_exit(temac_cleanup_module);
MODULE_DESCRIPTION(DRV_DESCRIPTION);
module_param(temac_debug, int, 0);
MODULE_PARM_DESC(temac_debug, "temac debug level (1-4)");
MODULE_AUTHOR("David H. Lynch Jr. <dhlii@dlasys.net>");
MODULE_LICENSE("GPL");

/*

OPTIONAL functions

Function (called before hard_start_xmit) that builds the hardware header =
from=20
the source and destination hardware addresses that were previously retrie=
ved; its=20
job is to organize the information passed to it as arguments into an appr=
opriate,=20
device-specific hardware header. eth_header is the default function for E=
thernet-
like interfaces, and ether_setup assigns this field accordingly.=20
int (*hard_header) (struct sk_buff *skb, struct net_device *dev, unsigned=
 short type, void *daddr, void *saddr, unsigned len);=20

Function used to rebuild the hardware header after ARP resolution complet=
es=20
but before a packet is transmitted. The default function used by Ethernet=
 devices=20
uses the ARP support code to fill the packet with missing information.=20
int (*rebuild_header)(struct sk_buff *skb);=20

Changes the interface configuration. This method is the entry point for c=
onfiguring the driver. The I/O address for the device and its interrupt n=
umber can be=20
changed at runtime using set_config. This capability can be used by the s=
ystem=20
administrator if the interface cannot be probed for. Drivers for modern h=
ardware normally do not need to implement this method.=20
int (*set_config)(struct net_device *dev, struct ifmap *map);=20

Method provided by NAPI-compliant drivers to operate the interface in a p=
olled=20
mode, with interrupts disabled. NAPI (and the weight field) are covered i=
n the=20
section Receive Interrupt Mitigation.=20
int (*poll)(struct net_device *dev; int *quota) L

header_cache is called to fill in the hh_cache structure with the results=
 of an ARP=20
query. Almost all Ethernet-like drivers can use the default eth_header_ca=
che=20
implementation.=20
int (*header_cache) (struct neighbour *neigh, struct hh_cache *hh);=20

Method that updates the destination address in the hh_cache structure in =

response to a change. Ethernet devices use eth_header_cache_update.=20
int (*header_cache_update) (struct hh_cache *hh, struct net_device *dev, =
unsigned char *haddr);=20

The hard_header_parse method extracts the source address from the packet =
contained in skb,=20
copying it into the buffer at haddr. The return value from the function i=
s the length of that address. Ethernet devices normally use eth_header_pa=
rse.=20
int (*hard_header_parse) (struct sk_buff *skb, unsigned char *haddr);=20

Utility Fields=20

The remaining struct net_device data fields are used by the interface to =
hold useful=20
status information. Some of the fields are used by ifconfig and netstat t=
o provide the=20
user with information about the current configuration. Therefore, an inte=
rface=20
should assign values to these fields:=20

unsigned long trans_start;=20
unsigned long last_rx;=20

Fields that hold a jiffies value. The driver is responsible for updating =
these values when transmission begins and when a packet is received, resp=
ectively. The=20
trans_start value is used by the networking subsystem to detect transmitt=
er=20
lockups. last_rx is currently unused, but the driver should maintain this=
 field=20
anyway to be prepared for future use.=20

int watchdog_timeo;=20

The minimum time (in jiffies) that should pass before the networking laye=
r=20
decides that a transmission timeout has occurred and calls the drivers tx=
_timeout function.=20

void *priv;=20
The equivalent of filp->private_data. In modern drivers, this field is se=
t by=20
alloc_netdev and should not be accessed directly; use netdev_priv instead=
=2E=20

struct dev_mc_list *mc_list;=20

int mc_count;=20
Fields that handle multicast transmission. mc_count is the count of items=
 in mc_list.=20
See the section Multicast for further details.=20

spinlock_t xmit_lock;=20

int xmit_lock_owner;=20
The xmit_lock is used to avoid multiple simultaneous calls to the drivers=
=20
hard_start_xmit function. xmit_lock_owner is the number of the CPU that h=
as=20
obtained xmit_lock. The driver should make no changes to these fields.=20

*/
#if 0
	} else {		/* FIFO interrupt mode */
		xlltemac_IntrFifoEnable(&lp->Emac, XTE_RECV | XTE_SEND);
	}


----------------------------------

	/* Register interrupt handler */
	if ((Options & XTE_POLLED_OPTION) =3D=3D 0) {
		int retval;
		/* Grab the IRQ */
		retval =3D
		    request_irq(dev->irq, &xtenet_interrupt, 0, dev->name, dev);
		if (retval) {
			printk(KERN_ERR
			       "%s: xlltemac could not allocate interrupt %d.\n",
			       dev->name, dev->irq);
			spin_unlock_irqrestore(&XTE_spinlock, flags);
			return retval;
		}
	}

	/* Enable interrupts if not in polled mode */
	if ((Options & XTE_POLLED_OPTION) =3D=3D 0) {
		if (!xlltemac_mIsSgDma(&lp->Emac))	/*fifo direct interrupt driver mode =
*/
			xlltemac_IntrFifoEnable(&lp->Emac, XTE_RECV | XTE_SEND);
		else		/* SG DMA mode */
			xlltemac_IntrSgEnable(&lp->Emac, XTE_SEND | XTE_RECV);
	}



static int xtenet_FifoSend(struct sk_buff *skb, struct net_device *dev)
{
	struct net_local *lp;
	unsigned int len;
	XStatus result;
	unsigned long flags, fifo_free_bytes;

	/* The following lock is used to protect GetFreeBytes, FifoWrite
	 * and FifoSend sequence which could happen from FifoSendHandler
	 * or other processor in SMP case.
	 */
	spin_lock_irqsave(&XTE_spinlock, flags);
	lp =3D (struct net_local *)dev->priv;
	len =3D skb->len;

	fifo_free_bytes =3D xlltemac_FifoGetFreeBytes(&lp->Emac, XTE_SEND);
	if (fifo_free_bytes < len) {
		netif_stop_queue(dev);	/* stop send queue */
		lp->deferred_skb =3D skb;	/* buffer the sk_buffer and will send
					   it in interrupt context */
		spin_unlock_irqrestore(&XTE_spinlock, flags);
		return 0;
	}

	/* Write frame data to FIFO */
	result =3D
	    xlltemac_FifoWrite(&lp->Emac, (void *)skb->data, len,
			     XTE_END_OF_PACKET);
	if (result !=3D XST_SUCCESS) {
		reset(dev, __LINE__);
		lp->stats.tx_errors++;
		spin_unlock_irqrestore(&XTE_spinlock, flags);
		return -EIO;
	}

	/* Initiate transmit */
	if ((result =3D xlltemac_FifoSend(&lp->Emac, len)) !=3D XST_SUCCESS) {
		reset(dev, __LINE__);
		lp->stats.tx_errors++;
		spin_unlock_irqrestore(&XTE_spinlock, flags);
		return -EIO;
	}
	lp->stats.tx_bytes +=3D len;
	spin_unlock_irqrestore(&XTE_spinlock, flags);

	dev_kfree_skb(skb);	/* free skb */
	dev->trans_start =3D jiffies;
	return 0;
}

/* Callback function for completed frames sent in FIFO interrupt driven m=
ode */
static void FifoSendHandler(void *CallbackRef)
{
	struct net_device *dev;
	struct net_local *lp;
	XStatus result;
	struct sk_buff *skb;

	spin_lock(&XTE_spinlock);
	dev =3D (struct net_device *)CallbackRef;
	lp =3D (struct net_local *)dev->priv;
	lp->stats.tx_packets++;

	/*Send out the deferred skb and wake up send queue if a deferred skb exi=
sts */
	if (lp->deferred_skb) {

		skb =3D lp->deferred_skb;
		/* If no room for the deferred packet, return */
		if (xlltemac_FifoGetFreeBytes(&lp->Emac, XTE_SEND) < skb->len) {
			spin_unlock(&XTE_spinlock);
			return;
		}

		/* Write frame data to FIFO */
		result =3D xlltemac_FifoWrite(&lp->Emac, (void *)skb->data,
					  skb->len, XTE_END_OF_PACKET);
		if (result !=3D XST_SUCCESS) {
			reset(dev, __LINE__);
			lp->stats.tx_errors++;
			spin_unlock(&XTE_spinlock);
			return;
		}

		/* Initiate transmit */
		if ((result =3D
		     xlltemac_FifoSend(&lp->Emac, skb->len)) !=3D XST_SUCCESS) {
			reset(dev, __LINE__);
			lp->stats.tx_errors++;
			spin_unlock(&XTE_spinlock);
			return;
		}

		dev_kfree_skb_irq(skb);
		lp->deferred_skb =3D NULL;
		lp->stats.tx_packets++;
		lp->stats.tx_bytes +=3D skb->len;
		dev->trans_start =3D jiffies;
		netif_wake_queue(dev);	/* wake up send queue */
	}
	spin_unlock(&XTE_spinlock);
}
/* The callback function for frames received when in FIFO mode. */

#define XTE_RX_SINK_BUFFER_SIZE 1024

static void FifoRecvHandler(void *CallbackRef)
{
	struct net_device *ndev;
	struct net_local *lp;
	struct sk_buff *skb;
	u32 len;
	XStatus Result;
	static u32 rx_buffer_sink[XTE_RX_SINK_BUFFER_SIZE / sizeof(u32)];

	spin_lock(&XTE_spinlock);
	ndev =3D (struct net_device *)CallbackRef;
	lp =3D netdev_priv(ndev);

	Result =3D xlltemac_FifoRecv(&lp->Emac, &len);
	if (Result !=3D XST_SUCCESS) {
		printk(KERN_ERR
		       "%s: xlltemac could not read received packet length, error=3D%d.=
\n",
		       ndev->name, Result);
		lp->stats.rx_errors++;
		reset(ndev, __LINE__);
		spin_unlock(&XTE_spinlock);
		return;
	}

	if (!(skb =3D dev_alloc_skb(len + ALIGNMENT_RECV))) {
		/* Couldn't get memory. */
		lp->stats.rx_dropped++;
		printk(KERN_ERR
		       "%s: xlltemac could not allocate receive buffer.\n",
		       ndev->name);

		/* consume data in Xilinx TEMAC RX data fifo so it is sync with RX leng=
th fifo */
		for (; len > XTE_RX_SINK_BUFFER_SIZE;
		     len -=3D XTE_RX_SINK_BUFFER_SIZE) {
			xlltemac_FifoRead(&lp->Emac, rx_buffer_sink,
					XTE_RX_SINK_BUFFER_SIZE,
					XTE_PARTIAL_PACKET);
		}
		xlltemac_FifoRead(&lp->Emac, rx_buffer_sink, len,
				XTE_END_OF_PACKET);

		spin_unlock(&XTE_spinlock);
		return;
	}

	/* Read the packet data */
	Result =3D xlltemac_FifoRead(&lp->Emac, skb->data, len, XTE_END_OF_PACKE=
T);
	if (Result !=3D XST_SUCCESS) {
		lp->stats.rx_errors++;
		dev_kfree_skb_irq(skb);
		printk(KERN_ERR "%s: xlltemac could not receive buffer, error=3D%d.\n",=
 ndev->name, Result);
		reset(ndev, __LINE__);
		spin_unlock(&XTE_spinlock);
		return;
	}
	lp->stats.rx_packets++;
	lp->stats.rx_bytes +=3D len;
	spin_unlock(&XTE_spinlock);

	skb_put(skb, len);	/* Tell the skb how much data we got. */
	skb->dev =3D ndev;	/* Fill out required meta-data. */
	skb->protocol =3D eth_type_trans(skb, ndev);
	/* skb->ip_summed =3D CHECKSUM_NONE; */
	netif_rx(skb);		/* Send the packet upstream. */
}

	lp->Config.RxPktFifoDepth =3D pdata->rx_pkt_fifo_depth;
	lp->Config.TxPktFifoDepth =3D pdata->tx_pkt_fifo_depth;
	lp->Config.MacFifoDepth =3D pdata->mac_fifo_depth;
	} else {
		DEBUG_PRINTK("xtenet_probe(07)\n");
		printk(KERN_INFO "%s: xlltemac using fifo direct interrupt driven mode.=
\n", ndev->name);
		xlltemac_SetHandler(&lp->Emac, XTE_HANDLER_FIFORECV, FifoRecvHandler, n=
dev);
		xlltemac_SetHandler(&lp->Emac, XTE_HANDLER_FIFOSEND, FifoSendHandler, n=
dev);
		ndev->hard_start_xmit =3D xtenet_FifoSend;
		lp->Isr =3D xlltemac_IntrFifoHandler;
	}

/************************************************************************=
*****/
/**
 *
 * Disable FIFO related interrupts for FIFO direct frame transfer mode. D=
ma
 * interrupts are not affected.
 *
 * Do not use this function when using SG DMA frame transfer mode.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param Direction specifies whether the transmit related (XTE_SEND) or
 *        receive related (XTE_RECV) interrupts should be affected, or
 *        both (XTE_SEND | XTE_RECV).
 *
 * @return None
 *
 * @note The state of the transmitter and receiver are not modified by th=
is
 *       function.
 *
 * @note If the device is configured for SGDMA, then this function has no=

 *       effect. Use XTemac_IntrSgDmaDisable() instead.
 *
 ************************************************************************=
******/
void XTemac_IntrFifoDisable(XTemac * InstancePtr, u32 Direction)
{
	u32 RegIPIER;

	XASSERT_VOID(InstancePtr !=3D NULL);
	XASSERT_VOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_VOID(!(Direction & ~(XTE_SEND | XTE_RECV)));

	/* Don't allow if device is configured for SGDMA */
	if (XTemac_mIsSgDma(InstancePtr)) {
		return;
	}

	/* Get contents of IPIER register */
	RegIPIER =3D GetIpIfReg(XTE_IPIER_OFFSET);

	/* Handle send direction */
	if (Direction & XTE_SEND) {
		RegIPIER &=3D
		    ~(XTE_IPXR_XMIT_ERROR_MASK | XTE_IPXR_XMIT_DONE_MASK);
		InstancePtr->Flags &=3D ~XTE_FLAGS_SEND_FIFO_INT_ENABLE;
	}

	/* Handle receive direction */
	if (Direction & XTE_RECV) {
		RegIPIER &=3D
		    ~(XTE_IPXR_RECV_ERROR_MASK | XTE_IPXR_RECV_DONE_MASK);
		InstancePtr->Flags &=3D ~XTE_FLAGS_RECV_FIFO_INT_ENABLE;
	}

	/* Update IPIER with new setting */
	XTemac_mSetIpifReg(XTE_IPIER_OFFSET, RegIPIER);
}
/**
 *
 * Master interrupt handler for FIFO direct frame transfer mode. This rou=
tine
 * will query the status of the device, bump statistics, and invoke user
 * callbacks in the following priority:
 *
 * This routine must be connected to an interrupt controller using OS/BSP=

 * specific methods.
 *
 * @param InstancePtr is a pointer to the TEMAC instance that has caused =
the
 *        interrupt.
 *
 * @return None
 *
 ************************************************************************=
******/
void XTemac_IntrFifoHandler(void *TemacPtr)
{
	u32 RegDISR;
	u32 CorePending;
	u32 RegMisc;
	unsigned Cnt;
	XTemac *InstancePtr =3D (XTemac *) TemacPtr;

	XASSERT_VOID(InstancePtr !=3D NULL);

	/* This ISR will try to handle as many interrupts as it can in a single
	 * call. However, in most of the places where the user's error handler i=
s
	 * called, this ISR exits because it is expected that the user will rese=
t
	 * the device most of the time.
	 */

	/* Log interrupt */
	XTemac_mBumpStats(Interrupts, 1);

	/* Get top level interrupt status. The status is self clearing when the
	 * interrupt source is cleared
	 */
	RegDISR =3D GetIpIfReg(XTE_DISR_OFFSET);

	/* Handle IPIF and packet FIFO errors */
	if (RegDISR & (XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK |
		       XTE_DXR_RECV_FIFO_MASK | XTE_DXR_SEND_FIFO_MASK)) {
		/* IPIF transaction or data phase error */
		if (RegDISR & (XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK)) {
			XTemac_mBumpStats(IpifErrors, 1);
			ERR_HANDLER(XST_IPIF_ERROR, RegDISR, 0);
			return;
		}

		/* Receive packet FIFO is deadlocked */
		if (RegDISR & XTE_DXR_RECV_FIFO_MASK) {
			XTemac_mBumpStats(RxPktFifoErrors, 1);
			ERR_HANDLER(XST_PFIFO_DEADLOCK, XTE_RECV, 0);
			return;
		}

		/* Transmit packet FIFO is deadlocked */
		if (RegDISR & XTE_DXR_SEND_FIFO_MASK) {
			XTemac_mBumpStats(TxPktFifoErrors, 1);
			ERR_HANDLER(XST_PFIFO_DEADLOCK, XTE_SEND, 0);
			return;
		}
	}

	/* Handle core interrupts */
	if (RegDISR & XTE_DXR_CORE_MASK) {
		/* Calculate which enabled interrupts have been asserted */
		CorePending =3D GetIpIfReg(XTE_IPIER_OFFSET) &
		    GetIpIfReg(XTE_IPISR_OFFSET);

		/* Check for fatal status/length FIFO errors. These errors can't be
		 * cleared
		 */
		if (CorePending & XTE_IPXR_FIFO_FATAL_ERROR_MASK) {
			XTemac_mBumpStats(FifoErrors, 1);
			ERR_HANDLER(XST_FIFO_ERROR, CorePending &
				    XTE_IPXR_FIFO_FATAL_ERROR_MASK, 0);
			return;
		}

		/* A receive packet has arrived. Call the receive handler.
		 *
		 * Acking this interrupt is not done here. The handler has a choice:
		 * 1) Call XTemac_FifoRecv() which will ack this interrupt source, or
		 * 2) Call XTemac_IntrFifoDisable() and defer XTEmac_FifoRecv() to a
		 * later time. Failure to do one of these actions will leave this
		 * interupt still pending resulting in an exception loop.
		 */
		if (CorePending & XTE_IPXR_RECV_DONE_MASK) {
			FIFORECV_HANDLER();
		}

		/* A transmit has completed. Pull off all statuses that are available.
		 * For each status that contains a non-fatal error, the error handler
		 * is invoked. For fatal errors, the error handler is invoked once and
		 * assumes the callback will reset the device.
		 *
		 * Unless there was a fatal error, then call the send handler since
		 * resources in the packet FIFO, transmit length FIFO, and transmit
		 * status FIFO have been freed up. This gives the handler a chance
		 * to enqueue new frame(s).
		 */
		if (CorePending & XTE_IPXR_XMIT_DONE_MASK) {
			Cnt =3D 0;

			/* While XMIT_DONE persists */
			do {
				/* Get TSR, try to clear XMIT_DONE */
				RegMisc =3D
				    GetIpIfReg(XTE_TSR_OFFSET);
				XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
						   XTE_IPXR_XMIT_DONE_MASK);

				Cnt++;

				/* Read IPISR and test XMIT_DONE again */
				RegMisc =3D
				    GetIpIfReg(XTE_IPISR_OFFSET);
			} while (RegMisc & XTE_IPXR_XMIT_DONE_MASK);

			FIFOSEND_HANDLER(Cnt);
		}

		/* Auto negotiation interrupt */
		if (CorePending & XTE_IPXR_AUTO_NEG_MASK) {
			ANEG_HANDLER();
		}

		/* Check for dropped receive frame. Ack the interupt then call the
		 * error handler
		 */
		if (CorePending & XTE_IPXR_RECV_DROPPED_MASK) {
			XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
					   CorePending &
					   XTE_IPXR_RECV_DROPPED_MASK);

			XTemac_mBumpStats(RxRejectErrors, 1);
			ERR_HANDLER(XST_RECV_ERROR,
				    CorePending &
				    XTE_IPXR_RECV_DROPPED_MASK, 0);

			/* no return here, nonfatal error */
		}
	}
}
/************************************************************************=
******
*
*     Author: Xilinx, Inc.
*
*
*     This program is free software; you can redistribute it and/or modif=
y it
*     under the terms of the GNU General Public License as published by t=
he
*     Free Software Foundation; either version 2 of the License, or (at y=
our
*     option) any later version.
*
*
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
*     COURTESY TO YOU. BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
*     ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDAR=
D,
*     XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE=

*     FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAIN=
ING
*     ANY THIRD PARTY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
*     XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
*     THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO AN=
Y
*     WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM=

*     CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND
*     FITNESS FOR A PARTICULAR PURPOSE.
*
*
*     Xilinx hardware products are not intended for use in life support
*     appliances, devices, or systems. Use in such applications is
*     expressly prohibited.
*
*
*     (c) Copyright 2005 Xilinx Inc.
*     All rights reserved.
*
*
*     You should have received a copy of the GNU General Public License a=
long
*     with this program; if not, write to the Free Software Foundation, I=
nc.,
*     675 Mass Ave, Cambridge, MA 02139, USA.
*
*************************************************************************=
*****/
/************************************************************************=
*****/
/**
*
* @file xtemac_fifo.c
*
* Functions in this file implement FIFO direct and Simple DMA frame trans=
fer
* mode. See xtemac.h for a detailed description of the driver.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- ---------------------------------------------------=
----
* 1.00a rmm  06/01/05 First release
* 1.00b rmm  09/23/05 Fixed void* arithmetic usage, added XST_FIFO_ERROR =

*                     return code to send/recv query functions.
* 2.00a rmm  11/21/05 Removed XST_FAILURE return code for XTemac_FifoQuer=
y-
*                     SendStatus, removed simple dma code
* </pre>
*************************************************************************=
*****/

/***************************** Include Files ****************************=
*****/

#include "xtemac.h"
#include "xtemac_i.h"
#include "xio.h"

/************************** Constant Definitions ************************=
*****/

#define PFIFO_64BIT_WIDTH_BYTES 8

/**************************** Type Definitions **************************=
*****/

/***************** Macros (Inline Functions) Definitions ****************=
*****/

/************************************************************************=
*******
 * Primitives that modify the hold structure for XTemac_PacketFifo. All F=

 * parameters refer to a pointer to XTemac_PacketFifo.
 *
 * mHold_GetIndex(F) - Get the ByteIndex of Hold
 * mHold_SetIndex(F,D) - Set the ByteIndex of Hold to D
 * mHold_Advance(F,D) - Advance the ByteIndex of Hold by D bytes
 * mHold_CopyIn(F,I,D) - Set Hold[I] to D
 * mHold_CopyOut(F,I,D) - Set D to Hold[I]
 * mHoldS_IsFull(F) - Is a write channel Hold full of data
 * mHoldS_IsEmpty(F) - Is a write channel Hold empty
 * mHoldS_SetEmpty(F) - Set a write channel Hold empty
 * mHoldR_IsFull(F) - Is a read channel Hold full of data
 * mHoldR_IsEmpty(F) - Is a read channel Hold empty
 * mHoldR_SetEmpty(F) - Set a read channel Hold empty
 *
 * @param F - Address to a XTemac_PacketFifo structure
 * @param SrcPtr - Source data address aligned on 4 byte boundary
 *
 ************************************************************************=
******/
#define mHold_GetIndex(F)      ((F)->ByteIndex)
#define mHold_SetIndex(F, D)   ((F)->ByteIndex =3D (D))
#define mHold_Advance(F, D)    ((F)->ByteIndex +=3D (D))
#define mHold_CopyIn(F, I, D)  (*(u8*)(((u8*)(&(F)->Hold[0])) + (I)) =3D =
(D))
#define mHold_CopyOut(F, I, D) ((D) =3D (*(u8*)(((u8*)(&(F)->Hold[0])) + =
(I))))

#define mHoldS_IsFull(F)    ((F)->ByteIndex >=3D (F)->Width)
#define mHoldS_IsEmpty(F)   ((F)->ByteIndex =3D=3D 0)
#define mHoldS_SetEmpty(F)  ((F)->ByteIndex =3D 0)

#define mHoldR_IsFull(F)    ((F)->ByteIndex =3D=3D 0)
#define mHoldR_IsEmpty(F)   ((F)->ByteIndex >=3D (F)->Width)
#define mHoldR_SetEmpty(F)  ((F)->ByteIndex =3D (F)->Width)

/************************************************************************=
*******
 * Primitive write to 64 bit FIFO. Use two 32-bit wide I/O accesses.
 *
 * @param F - Address to a XTemac_PacketFifo structure
 * @param SrcPtr - Source data address aligned on 4 byte boundary
 *
 ************************************************************************=
******/
#define mWriteFifo64(F, SrcPtr)                                \
    {                                                          \
        register u32 Faddr =3D F->Fifo.DataBaseAddress;      \
        XIo_Out32(Faddr, (SrcPtr)[0]);                         \
        XIo_Out32(Faddr + 4, (SrcPtr)[1]);                     \
    }

/************************************************************************=
*******
 * Primitive read from 64 bit FIFO. Use two 32-bit wide I/O accesses.
 *
 * @param F - Address to a XTemac_PacketFifo structure
 * @param DestPtr - Destination data address aligned on 4 byte boundary
 *
 ************************************************************************=
******/
#define mReadFifo64(F, DestPtr)                                \
    (DestPtr)[0] =3D XIo_In32(F->Fifo.DataBaseAddress);          \
    (DestPtr)[1] =3D XIo_In32(F->Fifo.DataBaseAddress + 4);

/************************************************************************=
*******
 * Primitive to transfer the holding data to the FIFO 64 bits at a time
 *
 * @param F - Address to a XTemac_PacketFifo structure
 *
 ************************************************************************=
******/
#define mPush64(F) mWriteFifo64(F, &F->Hold[0])

/************************************************************************=
*******
 * Primitive to tranfer FIFO contents into the holding data 64 bits at a =
time
 *
 * @param F - Address to a XTemac_PacketFifo structure
 *
 ************************************************************************=
******/
#define mPop64(F) mReadFifo64(F, &F->Hold[0])

/************************** Function Prototypes *************************=
*****/

/* The following functions will be attached to the FifoRead and FifoWrite=

 * attribute of an instance by XTemac_ConfigureFifoAccess
 */
static XStatus Write_64(XTemac_PacketFifo * Fptr, void *BufPtr,
			u32 ByteCount, int Eop);
static XStatus Read_64(XTemac_PacketFifo * Fptr, void *BufPtr,
		       u32 ByteCount, int Eop);

/* 64 bit wide FIFO support functions */
static void Write64_Unaligned(XTemac_PacketFifo * F, void *BufPtr,
			      u32 ByteCount);
static void Write64_Aligned(XTemac_PacketFifo * F, u32 * BufPtr,
			    u32 ByteCount);
static void Read64_Unaligned(XTemac_PacketFifo * F, void *BufPtr,
			     u32 ByteCount);
static void Read64_Aligned(XTemac_PacketFifo * F, u32 * BufPtr,
			   u32 ByteCount);

/************************************************************************=
*******
 * Select the best method for accessing the read and write FIFOs for FIFO=
 direct
 * frame transfer mode. On the write (transmit) side, the choices are DRE=
 or via
 * the holding structure. Both methods allow unaligned transfers. On the =
read
 * (receive) side, the only choice is the holding structure.
 *
 * This function should be called only from XTemac_Initialize().
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 *
 * @return XST_SUCCESS or XST_FAILURE if an error was detected
 *
 ************************************************************************=
******/
XStatus XTemac_ConfigureFifoAccess(XTemac * InstancePtr)
{
	XStatus Result;

	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(00)\n");
	/* Initialize the packet FIFOs */
	Result =3D
	    XPacketFifoV200a_Initialize(&InstancePtr->RecvFifo.Fifo,
					InstancePtr->BaseAddress +
					XTE_PFIFO_RXREG_OFFSET,
					InstancePtr->BaseAddress +
					XTE_PFIFO_RXDATA_OFFSET);
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(01)\n");
	if (Result !=3D XST_SUCCESS) {
		return (XST_FAILURE);
	}
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(02)\n");

	Result =3D
	    XPacketFifoV200a_Initialize(&InstancePtr->SendFifo.Fifo,
					InstancePtr->BaseAddress +
					XTE_PFIFO_TXREG_OFFSET,
					InstancePtr->BaseAddress +
					XTE_PFIFO_TXDATA_OFFSET);

	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(03)\n");
	if (Result !=3D XST_SUCCESS) {
		return (XST_FAILURE);
	}
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(04)\n");

	/* Choose an access algorithm.
	 * Note: 64-bit wide FIFO is the only width supported at this time
	 */
	InstancePtr->RecvFifo.Width =3D PFIFO_64BIT_WIDTH_BYTES;
	InstancePtr->RecvFifo.XferFn =3D Read_64;
	InstancePtr->SendFifo.Width =3D PFIFO_64BIT_WIDTH_BYTES;
	InstancePtr->SendFifo.XferFn =3D Write_64;
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(05)\n");

	/* Initialize the holds */
	mHoldS_SetEmpty(&InstancePtr->SendFifo);
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(06)\n");
	mHoldR_SetEmpty(&InstancePtr->RecvFifo);
	DEBUG_PRINTK("XTemac_ConfigureFifoAccess(07)\n");

	return (XST_SUCCESS);
}

/************************************************************************=
******/
/**
 * Copy data from a user buffer to the transmit packet FIFO. The data cop=
ied
 * may comprise of single, multiple, or partial packets. The data is not
 * transmitted until XTemac_FifoSend() is called.
 *
 * If the user buffer contains multiple packets, then extra care must be =
taken.
 * In this special situation, the end of one packet and the beginning of =
a new
 * packet is specified within the user buffer. The beginning of each NEW =
packet
 * must begin on a 4 byte alignment. The user is responsible for adding f=
iller
 * data between packets to acheive this alignment. The amount of filler d=
ata
 * depends on what byte the end of the previous packet falls on. When cal=
ling
 * XTemac_FifoSend() to transmit the packets, DO NOT specify the filler b=
ytes
 * in the TxByteCount parameter. For example, if a user buffer contains t=
wo
 * complete packets of 15 bytes each with 1 byte of filler between them, =
then
 * XTemac_FifoWrite() is called once to write all 31 bytes to the FIFO.
 * XTemac_FifoSend() is called twice specifying 15 bytes each time to tra=
nsmit
 * the packets (the 1 byte of filler data is ignored by the TEMAC). Of co=
urse
 * you could also just call XTemac_FifoWrite() once for each packet. This=
 way,
 * the driver will manage the filler data.
 *
 * If the user's buffer is not aligned on a 4 byte boundary, then the tra=
nsfer
 * may take longer to complete.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param BufPtr is the buffer containing user data that will be transfer=
red
 *        into the transmit FIFO. The buffer may be on any alignment.
 * @param ByteCount is the number of bytes to transfer from 1 to the numb=
er
 *        of bytes available in the FIFO at the time of invocation. See u=
sage
 *        note for situations when a value of 0 is legal.
 * @param Eop specifies whether the last byte of BufPtr marks the End Of =
Packet.
 *        If set to XTE_END_OF_PACKET, then any partial bytes being buffe=
red by
 *        the driver are flushed into the packet FIFO. If set to
 *        XTE_PARTIAL_PACKET, then more packet data is expected to be wri=
tten
 *        through more calls to this function. Failure to use XTE_END_OF_=
PACKET
 *        prior to calling XTemac_FifoSend() may cause a packet FIFO unde=
rrun.
 *
 * @return
 * - XST_SUCCESS if the data was transferred to the FIFO.
 * - XST_DEVICE_IS_STOPPED if the device has not been started.
 * - XST_PFIFO_ERROR if there was a packet FIFO overflow during the trans=
fer.
 *   This is a fatal condition. If this value is returned in polled mode,=
 then
 *   the device must be reset. For interrupt driven modes, an interrupt w=
ill be
 *   asserted resulting in a call to the registered error handler which s=
hould
 *   handle reset of the device.
 * - XST_IPIF_ERROR if a data or bus error occurred within the TEMAC's IP=
IF.
 *   Like the PFIFO error, this is a fatal condition and should be handle=
d
 *   in the same manner.
 *
 * @note
 * Calling this function with ByteCount =3D 0 will not result in the tran=
sfer of
 * data from BufPtr to the FIFO. However, if at the same time Eop is set =
to
 * XTE_END_OF_PACKET, then all data previously written with this function=
 is
 * guaranteed to be flushed into the packet FIFO and available for transm=
ission
 * with XTemac_FifoSend().
 ************************************************************************=
******/
XStatus XTemac_FifoWrite(XTemac * InstancePtr, void *BufPtr, u32 ByteCoun=
t,
			 int Eop)
{
	u32 RegDISR;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(!((Eop !=3D XTE_END_OF_PACKET)
			 && (Eop !=3D XTE_PARTIAL_PACKET)));

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* Transfer the data using the best/fastest method */
	InstancePtr->SendFifo.XferFn(&InstancePtr->SendFifo, BufPtr,
				     ByteCount, Eop);

	/* Make sure the packet FIFO didn't report an error */
	RegDISR =3D GetIpIfReg(XTE_DISR_OFFSET);
	if (RegDISR & XTE_DXR_SEND_FIFO_MASK) {
		/* Only bump stats in polled mode. For interrupt driven mode, this stat=

		 * is bumped in XTemac_IntrFifoHandler()
		 */
		if (InstancePtr->Options & XTE_POLLED_OPTION) {
			XTemac_mBumpStats(TxPktFifoErrors, 1);
		}
		return (XST_PFIFO_ERROR);
	}

	/* Verify no IPIF errors */
	if (RegDISR & (XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK)) {
		/* Only bump stats in polled mode. For interrupt driven mode, this stat=

		 * is bumped in XTemac_IntrFifoHandler()
		 */
		if (InstancePtr->Options & XTE_POLLED_OPTION) {
			XTemac_mBumpStats(IpifErrors, 1);
		}
		return (XST_IPIF_ERROR);
	}

	return (XST_SUCCESS);
}


/************************************************************************=
******/
/**
 * Initiate a transmit of one packet of data previously written with
 * XTemac_FifoWrite(). The given length in bytes is written to the transm=
it
 * length FIFO. There should be at least this many bytes in the packet FI=
FO
 * ready for transmit.
 *
 * If FIFO interrupts are enabled (see XTemac_IntrFifoEnable()), then upo=
n
 * completion of the transmit, the registered XTemac_FifoSendHandler() is=

 * invoked.
 *
 * If more bytes that are in the packet FIFO are specified in the TxByteC=
ount
 * parameter, then a packet FIFO underrun error will result.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param TxByteCount is the number of bytes to transmit. Range is 1 to t=
he
 *        total number of bytes available in the packet FIFO to be transm=
itted.
 *
 * @return
 * - XST_SUCCESS if transmit was initiated.
 * - XST_DEVICE_IS_STOPPED if the device has not been started.
 * - XST_FIFO_NO_ROOM if the transmit was not initiated because the trans=
mit
 *   length FIFO was full. This is not a fatal condition. The user may ne=
ed to
 *   wait for other packets to transmit before this condition clears itse=
lf.
 *
 ************************************************************************=
******/
XStatus XTemac_FifoSend(XTemac * InstancePtr, u32 TxByteCount)
{
	u32 RegIPISR;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(TxByteCount !=3D 0);

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* See if transmit length FIFO is full. If it is, try to clear the
	 * status. If it the status remains, then return an error
	 */
	RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);
	if (RegIPISR & XTE_IPXR_XMIT_LFIFO_FULL_MASK) {
		XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
				   XTE_IPXR_XMIT_LFIFO_FULL_MASK);

		RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);
		if (RegIPISR & XTE_IPXR_XMIT_LFIFO_FULL_MASK) {
			XTemac_mBumpStats(FifoErrors, 1);
			return (XST_FIFO_NO_ROOM);
		}
	}

	/* Start transmit */
	XTemac_mSetIpifReg(XTE_TPLR_OFFSET, TxByteCount);

	/* Return sucess */
	return (XST_SUCCESS);
}

/************************************************************************=
******/
/**
 * Return the length of a received packet. If a packet is waiting in the
 * receive packet FIFO, then it may be copied to a user buffer with
 * XTemac_FifoRead().
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param ByteCountPtr is the length of the next received packet if the r=
eturn
 *        status is XST_SUCCESS.=20
 *
 * @return
 * - XST_SUCCESS if a packet has been received and a value has been writt=
en to
 *   ByteCountPtr.
 * - XST_DEVICE_IS_STOPPED if the device has been stopped.
 * - XST_NO_DATA if no packet length is available. ByteCountPtr is not mo=
dified.
 *
 ************************************************************************=
******/
XStatus XTemac_FifoRecv(XTemac * InstancePtr, u32 * ByteCountPtr)
{
	u32 RegIPISR;
	volatile u32 RegRSR;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(ByteCountPtr !=3D NULL);

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* If the receive length FIFO is empty, then there's no packet waiting *=
/
	RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);
	if (!(RegIPISR & XTE_IPXR_RECV_DONE_MASK)) {
		return (XST_NO_DATA);
	}

	/* Get the length */
	*ByteCountPtr =3D GetIpIfReg(XTE_RPLR_OFFSET);

	/* The IPXR_RECV_DONE_MASK status bit is tied to the RSR register. To cl=
ear
	 * this condition, read from the RSR (which has no information) then wri=
te
	 * to the IPISR register to ack the status.
	 */
	RegRSR =3D GetIpIfReg(XTE_RSR_OFFSET);
	XTemac_mSetIpifReg(XTE_IPISR_OFFSET, XTE_IPXR_RECV_DONE_MASK);

	/* Return sucess */
	return (XST_SUCCESS);
}

/************************************************************************=
******/
/**
 * Copy data from the receive packet FIFO into a user buffer. The number =
of
 * bytes to copy is derived from XTemac_FifoRecv(). The packet data may b=
e
 * copied out of the FIFO all at once or with multiple calls to this func=
tion.
 * The latter method supports systems that keep packet data in non-contig=
uous
 * memory regions. For example:
 * <pre>
 *    if (XTemac_FifoRecv(Tptr, &PacketLength) =3D=3D XST_SUCCESS)
 *    {
 *       if (PacketLength > 14)
 *       {
 *          HeaderLength =3D 14;
 *          PayloadLength =3D PacketLength - HeaderLength;
 *
 *          Status =3D  XTemac_FifoRead(Tptr, UserHeaderBuf, HeaderLength=
,
 *                                    XTE_PARTIAL_PACKET);
 *          Status |=3D XTemac_FifoRead(Tptr, UserPayloadBuf, PayloadLeng=
th,
 *                                    XTE_END_OF_PACKET);
 *
 *          if (Status !=3D XST_SUCCESS)
 *          {
 *             // handle error
 *          }
 *       }
 *    }
 * </pre>
 *
 * If the user's buffer is not aligned on a 4 byte boundary, then the tra=
nsfer
 * may take longer to complete.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param BufPtr is the user buffer that will recieve packet data from th=
e FIFO.
 *        The buffer may be on any alignment.
 * @param ByteCount is the number of bytes to transfer
 * @param Eop specifies whether the last byte read is the last byte of a =
packet.
 *        If set to XTE_END_OF_PACKET, then any partial bytes being buffe=
red by
 *        the driver at the end of the transfer are discarded. These disc=
arded
 *        bytes are filler provided by the hardware and have no meaning. =
If set
 *        to XTE_PARTIAL_PACKET, then more packet data is expected to be =
read
 *        through more calls to this function. Failure to use this parame=
ter
 *        properly will result in undefined filler bytes being copied int=
o
 *        BufPtr.
 *
 * @return
 * - XST_SUCCESS if the data was transferred to the user buffer
 * - XST_DEVICE_IS_STOPPED if the device has not been started.
 * - XST_NO_DATA if there was not enough data in the packet FIFO to satis=
fy the
 *   request.
 *
 * @note
 * Do not attempt to read more than one packets worth of data at a time w=
ith
 * this function.
 ************************************************************************=
******/
XStatus XTemac_FifoRead(XTemac * InstancePtr, void *BufPtr, u32 ByteCount=
,
			int Eop)
{
	XStatus Status;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(!((Eop !=3D XTE_END_OF_PACKET)
			 && (Eop !=3D XTE_PARTIAL_PACKET)));

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* Transfer the data using the best/fastest method */
	Status =3D
	    InstancePtr->RecvFifo.XferFn(&InstancePtr->RecvFifo, BufPtr,
					 ByteCount, Eop);

	/* Return correct status */
	if (Status =3D=3D XST_NO_DATA) {
		return (XST_NO_DATA);
	} else {
		return (XST_SUCCESS);
	}
}


/************************************************************************=
******/
/**
 * Retrieve the number of free bytes in the packet FIFOs.
 *
 * For the transmit packet FIFO, the number returned is the number of byt=
es
 * that can be written by XTemac_FifoWrite(). If a non-zero number is ret=
urned,
 * then at least 1 packet of that size can be transmitted.
 *
 * For the receive packet FIFO, the number returned is the number of byte=
s that
 * can arrive from an external Ethernet device. This number does not refl=
ect
 * the state of the receive length FIFO. If this FIFO is full, then arriv=
ing
 * packets will get dropped by the HW if there is no place to store the l=
ength.
 *=20
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param Direction selects which packet FIFO to examine. If XTE_SEND, th=
en
 *        the transmit packet FIFO is selected. If XTE_RECV, then the rec=
eive
 *        packet FIFO is selected.
 *
 * @return
 * Number of bytes available in the selected packet FIFO.
 *
 ************************************************************************=
******/
u32 XTemac_FifoGetFreeBytes(XTemac * InstancePtr, u32 Direction)
{
	u32 RegIPISR;
	u32 Count;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(!(Direction & ~(XTE_SEND | XTE_RECV)));

	/* For the send direction, even though there may be room in the
	 * packet FIFO, the length FIFO may be full. When this is the case,
	 * another packet cannot be transmiited so return 0.
	 */
	if (Direction =3D=3D XTE_SEND) {
		/* Check length FIFO */
		RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);
		if (RegIPISR & XTE_IPXR_XMIT_LFIFO_FULL_MASK) {
			return (0);
		}

		/* Get FIFO entries */
		Count =3D XPF_V200A_GET_COUNT(&InstancePtr->SendFifo.Fifo);
	}

	/* Handle receive direction */
	else {
		Count =3D XPF_V200A_COUNT_MASK -
		    XPF_V200A_GET_COUNT(&InstancePtr->RecvFifo.Fifo);
	}

	/* Multiply free entries by the width of the packet FIFO to arrive at
	 * bytes
	 */
	return (Count * InstancePtr->RecvFifo.Width);
}

/************************************************************************=
******/
/**
 * Query the device for the latest transmit status for FIFO direct frame
 * transfer mode. This function should be used for polled mode operation =
only.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 * @param SendStatusPtr is the contents of the XTE_TSR_OFFSET register wh=
en the
 *        return code is XST_FAILURE. Otherwise 0 is returned.
 *
 * @return
 * - XST_NO_DATA if a transmit status is not currently available.
 * - XST_DEVICE_IS_STOPPED if the device has not been started.
 * - XST_NOT_POLLED if the device has not been set to polled mode.
 * - XST_SUCCESS if a transmit status was found and indicates that there =
was
 *   no error.
 * - XST_FIFO_ERROR if the transmit length or transmit status FIFOs error=
 has
 *   been detected. If this error is returned, then the device must be re=
set
 *   before this function will return a valid transmit status indication.=

 * - XST_PFIFO_ERROR if the transmit packet FIFO is deadlocked. If this e=
rror
 *   is returned, then the device must be reset before this function will=

 *   return a valid transmit status indication
 * - XST_IPIF_ERROR if there has been a data phase timeout or transaction=
 error
 *   in the IPIF. This is a fatal error.
 *
 * @note
 * When XST_FAILURE is returned with the XTE_TSR_PFIFOU_MASK bit set in t=
he
 * SendStatusPtr parameter, then an attempt was made to transmit more dat=
a than
 * was present in the packet FIFO. No reset is required in this situation=
=2E
 *
 ************************************************************************=
******/
XStatus XTemac_FifoQuerySendStatus(XTemac * InstancePtr,
				   u32 * SendStatusPtr)
{
	u32 RegDISR;
	u32 RegIPISR;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
	XASSERT_NONVOID(SendStatusPtr !=3D NULL);

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* Have to be in polled mode to use this function */
	if (!(InstancePtr->Options & XTE_POLLED_OPTION)) {
		return (XST_NOT_POLLED);
	}

	/* Make sure send packet FIFO isn't deadlocked */
	RegDISR =3D GetIpIfReg(XTE_DISR_OFFSET);
	if (RegDISR & XTE_DXR_SEND_FIFO_MASK) {
		XTemac_mBumpStats(TxPktFifoErrors, 1);
		return (XST_PFIFO_ERROR);
	}

	/* Make sure no IPIF errors are present */
	if (RegDISR & (XTE_DXR_TERR_MASK | XTE_DXR_DPTO_MASK)) {
		XTemac_mBumpStats(IpifErrors, 1);
		return (XST_IPIF_ERROR);
	}

	/* Read the IPISR
	 * If any errors are detetected, try to clear and return error
	 */
	RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);
	if (RegIPISR & XTE_IPXR_XMIT_ERROR_MASK) {
		XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
				   RegIPISR & XTE_IPXR_XMIT_ERROR_MASK);
		XTemac_mBumpStats(FifoErrors, 1);
		return (XST_FIFO_ERROR);
	}

	/* No FIFO errors, so see of a transmit has completed */
	if (!(RegIPISR & XTE_IPXR_XMIT_DONE_MASK)) {
		return (XST_NO_DATA);
	}

	/* Transmit has completed, get the status, ack the condition */
	*SendStatusPtr =3D GetIpIfReg(XTE_TSR_OFFSET);
	XTemac_mSetIpifReg(XTE_IPISR_OFFSET, XTE_IPXR_XMIT_DONE_MASK);

	/* no errors to report */
	return (XST_SUCCESS);
}

/************************************************************************=
******/
/**
 * Query the device for the latest receive status for FIFO direct frame
 * transfer mode. This function should be used for polled mode operation =
only.
 *
 * @param InstancePtr is a pointer to the instance to be worked on.
 *
 * @return
 * - XST_SUCCESS if a frame has been received and no receive error was de=
tected.
 * - XST_DEVICE_IS_STOPPED if the device has not been started.
 * - XST_NO_DATA if no frame has been received and no receive related err=
or has
 *   been detected.
 * - XST_NOT_POLLED if the device has not been set to polled mode.
 * - XST_DATA_LOST if the device reports that it dropped a receive frame.=
 This
 *   is not a serious problem but may indicate that frames are arriving f=
aster
 *   than the system can process them.
 * - XST_FIFO_ERROR if an error was detected with the receive length FIFO=
=2E If
 *   this error is returned, then the device must be reset before any new=
 frame
 *   can be received.
 * - XST_PFIFO_ERROR if the receive packet FIFO is deadlocked. If this er=
ror is
 *   returned, then the device must be reset before any new frame can be
 *   received.
 * - XST_IPIF_ERROR if there has been a data phase timeout or transaction=
 error
 *   in the IPIF. This is a fatal error.
 *
 * @note
 * In situations where simultaneously a frame has been received for which=
 an
 * XST_SUCCESS can be returned and a dropped frame for which an XST_DATA_=
LOST
 * can be returned, then this function will give priority to XST_SUCCESS =
so the
 * user can receive the frame.
 ************************************************************************=
******/
XStatus XTemac_FifoQueryRecvStatus(XTemac * InstancePtr)
{
	u32 RegDISR;
	u32 RegIPISR;

	XASSERT_NONVOID(InstancePtr !=3D NULL);
	XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);

	/* Make sure device is ready for this operation */
	if (InstancePtr->IsStarted !=3D XCOMPONENT_IS_STARTED) {
		return (XST_DEVICE_IS_STOPPED);
	}

	/* Have to be in polled mode to use this function */
	if (!(InstancePtr->Options & XTE_POLLED_OPTION)) {
		return (XST_NOT_POLLED);
	}

	/* Read the DISR */
	RegDISR =3D GetIpIfReg(XTE_DISR_OFFSET);

	/* Make sure recv packet FIFO isn't deadlocked */
	if (RegDISR & XTE_DXR_RECV_FIFO_MASK) {
		XTemac_mBumpStats(RxPktFifoErrors, 1);
		return (XST_PFIFO_ERROR);
	}

	/* Make sure no IPIF errors are present */
	if (RegDISR & (XTE_DXR_TERR_MASK | XTE_DXR_DPTO_MASK)) {
		XTemac_mBumpStats(IpifErrors, 1);
		return (XST_IPIF_ERROR);
	}

	/* Read the IPISR */
	RegIPISR =3D GetIpIfReg(XTE_IPISR_OFFSET);

	/* Check for other recv related FIFO errors */
	if (RegIPISR &
	    (XTE_IPXR_RECV_ERROR_MASK - XTE_IPXR_RECV_DROPPED_MASK)) {
		XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
				   RegIPISR & XTE_IPXR_RECV_ERROR_MASK);
		XTemac_mBumpStats(FifoErrors, 1);
		return (XST_FIFO_ERROR);
	}

	/* See if a frame has been received */
	if (RegIPISR & XTE_IPXR_RECV_DONE_MASK) {
		return (XST_SUCCESS);
	}

	/* If option to detect recv reject errors is set, check for rejected
	 * receive frames. If one is detected, clear it and return error.
	 */
	if (InstancePtr->Options & XTE_REPORT_RXERR_OPTION) {
		if (RegIPISR & XTE_IPXR_RECV_DROPPED_MASK) {
			XTemac_mSetIpifReg(XTE_IPISR_OFFSET,
					   RegIPISR &
					   XTE_IPXR_RECV_DROPPED_MASK);
			return (XST_DATA_LOST);
		}
	}

	/* No frame has been received and no errors detected */
	return (XST_NO_DATA);
}

/************************************************************************=
*******
* Algorithm to write to a 64 bit wide transmit packet FIFO through the ho=
lding
* buffer.
*
* @param FPtr is a pointer to a Temac FIFO instance to worked on.
* @param BufPtr is the source buffer address on any alignment
* @param ByteCount is the number of bytes to transfer
* @param Eop specifies whether the last byte written is the last byte of =
the
*        packet.
*
* @return XST_SUCCESS
*************************************************************************=
******/
static XStatus Write_64(XTemac_PacketFifo * Fptr, void *BufPtr,
			u32 ByteCount, int Eop)
{
	unsigned BufAlignment =3D (unsigned) BufPtr & 3;
	unsigned PartialBytes;
	int HoldAlignment =3D mHold_GetIndex(Fptr);

	/* Case 1: Buffer aligned on 4-byte boundary and Hold is empty
	 *
	 *   1. Write all bytes using the fastest transfer method
	 */
	if ((BufAlignment =3D=3D 0) && (mHoldS_IsEmpty(Fptr))) {
		Write64_Aligned(Fptr, (u32 *) BufPtr, ByteCount);
	}

	/* Case 2: Buffer and Hold are byte aligned with each other
	 *
	 *   1. Transfer enough bytes from the buffer to the Hold to trigger a f=
lush
	 *      to the FIFO.
	 *
	 *   2. The state of the buffer and Hold are as described by Case 1 so
	 *      write remaining bytes using the fastest transfer method
	 */
	else if (BufAlignment =3D=3D (HoldAlignment % PFIFO_64BIT_WIDTH_BYTES)) =
{
		PartialBytes =3D PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;

		if (ByteCount < PartialBytes) {
			PartialBytes =3D ByteCount;
		}

		Write64_Unaligned(Fptr, BufPtr, PartialBytes);
		Write64_Aligned(Fptr, (u32 *) ((u32) BufPtr + PartialBytes),
				ByteCount - PartialBytes);
	}

	/* Case 3: No alignment to take advantage of
	 *
	 *    1. Read FIFOs using the slower method.
	 */
	else {
		Write64_Unaligned(Fptr, BufPtr, ByteCount);
	}

	/* If TxBytes is non-zero then the caller wants to transmit data from th=
e
	 * FIFO
	 */
	if (Eop =3D=3D XTE_END_OF_PACKET) {
		/* Push the hold to the FIFO if data is present */
		if (!mHoldS_IsEmpty(Fptr)) {
			mPush64(Fptr);
			mHoldS_SetEmpty(Fptr);
		}
	}

	return (XST_SUCCESS);
}

/************************************************************************=
*******
* Algorithm to read from a 64 bit wide receive packet FIFO with through t=
he
* holding buffer.
*
* @param Fptr is a pointer to a Temac FIFO instance to worked on.
* @param BufPtr is the destination address on any alignment
* @param ByteCount is the number of bytes to transfer
*
* @return XST_SUCCESS if transfer completed or XST_NO_DATA if the amount =
of
*         data being buffered by the driver plus the amount of data in th=
e
*         packet FIFO is not enough to satisfy the number of bytes reques=
ted
*         by the ByteCount parameter.
*************************************************************************=
******/
static XStatus Read_64(XTemac_PacketFifo * Fptr, void *BufPtr,
		       u32 ByteCount, int Eop)
{
	unsigned BufAlignment =3D (unsigned) BufPtr & 3;
	unsigned PartialBytes;
	unsigned MaxBytes;
	int HoldAlignment =3D mHold_GetIndex(Fptr);

	/* Determine how many bytes can be read from the packet FIFO */
	MaxBytes =3D XPF_V200A_COUNT_MASK & XPF_V200A_GET_COUNT(&Fptr->Fifo);
	MaxBytes *=3D PFIFO_64BIT_WIDTH_BYTES;

	/* Case 1: Buffer aligned on 4-byte boundary and Hold is empty
	 *
	 *   1. Read all bytes using the fastest transfer method
	 */
	if ((BufAlignment =3D=3D 0) && (mHoldR_IsEmpty(Fptr))) {
		/* Enough data in fifo? */
		if (ByteCount > MaxBytes) {
			return (XST_NO_DATA);
		}

		Read64_Aligned(Fptr, (u32 *) BufPtr, ByteCount);
	}

	/* Case 2: Buffer and Hold are byte aligned with each other
	 *
	 *   1. Transfer enough bytes from the Hold to the buffer to trigger a
	 *      read from the FIFO.
	 *
	 *   2. The state of the buffer and Hold are now as described by Case 1 =
so
	 *      read remaining bytes using the fastest transfer method
	 */
	else if (BufAlignment =3D=3D (HoldAlignment % PFIFO_64BIT_WIDTH_BYTES)) =
{
		PartialBytes =3D PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;

		if (ByteCount < PartialBytes) {
			PartialBytes =3D ByteCount;
		}

		/* Enough data in fifo? Must account for the number of bytes the driver=

		 * is currently buffering
		 */
		if (ByteCount > (MaxBytes + PartialBytes)) {
			return (XST_NO_DATA);
		}

		Read64_Unaligned(Fptr, BufPtr, PartialBytes);
		Read64_Aligned(Fptr, (u32 *) ((u32) BufPtr + PartialBytes),
			       ByteCount - PartialBytes);
	}

	/* Case 3: No alignment to take advantage of
	 *
	 *    1. Read FIFOs using the slower method.
	 */
	else {
		/* Enough data in fifo? Must account for the number of bytes the driver=

		 * is currently buffering
		 */
		PartialBytes =3D PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;
		if (ByteCount > (MaxBytes + PartialBytes)) {
			return (XST_NO_DATA);
		}

		Read64_Unaligned(Fptr, BufPtr, ByteCount);
	}

	/* If this marks the end of packet, then dump any remaining data in the
	 * hold. The dumped data in this context is meaningless.
	 */
	if (Eop =3D=3D XTE_END_OF_PACKET) {
		mHoldR_SetEmpty(Fptr);
	}

	return (XST_SUCCESS);
}

/************************************************************************=
*******
* Write to the 64 bit holding buffer. Each time it becomes full, then it =
is
* pushed to the transmit FIFO.
*
* @param F is a pointer to the packet FIFO instance to be worked on.
* @param BufPtr is the source buffer address on any alignment
* @param ByteCount is the number of bytes to transfer
*
*************************************************************************=
******/
static void Write64_Unaligned(XTemac_PacketFifo * F,
			      void *BufPtr, u32 ByteCount)
{
	u8 *SrcPtr =3D (u8 *) BufPtr;
	unsigned FifoTransfersLeft;
	unsigned PartialBytes;
	unsigned BytesLeft;
	int i;

	/* Stage 1: The hold may be partially full. Write enough bytes to it to
	 * cause a push to the FIFO
	 */

	/* Calculate the number of bytes needed to trigger a push, if not enough=

	 * bytes have been specified to cause a push, then adjust accordingly
	 */
	i =3D mHold_GetIndex(F);
	PartialBytes =3D PFIFO_64BIT_WIDTH_BYTES - i;
	if (PartialBytes > ByteCount) {
		PartialBytes =3D ByteCount;
	}

	/* Calculate the number of bytes remaining after the first push */
	BytesLeft =3D ByteCount - PartialBytes;

	/* Write to the hold and advance its index */
	mHold_Advance(F, PartialBytes);

	while (PartialBytes--) {
		mHold_CopyIn(F, i, *SrcPtr);
		SrcPtr++;
		i++;
	}

	/* Push to fifo if needed */
	if (mHoldS_IsFull(F)) {
		mPush64(F);
		mHoldS_SetEmpty(F);
	}

	/* No more data to process */
	if (!BytesLeft) {
		return;
	}

	/* Stage 2: The hold is empty now, if any more bytes are left to process=
, then
	 * it will begin with nothing in the hold. Use the hold as a temporary s=
torage
	 * area to contain the data.
	 *
	 * The hold is filled then pushed out to the FIFOs a number of times bas=
ed on
	 * how many bytes are left to process.
	 */

	/* Calculate the number of times a push will need to occur */
	FifoTransfersLeft =3D BytesLeft / PFIFO_64BIT_WIDTH_BYTES;

	/* Calculate the number of partial bytes left after this stage */
	PartialBytes =3D
	    BytesLeft - (FifoTransfersLeft * PFIFO_64BIT_WIDTH_BYTES);

	/* Write to the hold and push data to the FIFO */
	while (FifoTransfersLeft--) {
		for (i =3D 0; i < PFIFO_64BIT_WIDTH_BYTES; i++) {
			mHold_CopyIn(F, i, *SrcPtr);
			SrcPtr++;
		}
		mPush64(F);
	}

	/* No more data to process
	 * HoldIndex was left at 0 by stage 1, at this point, that is
	 * still the correct value.
	 */
	if (!PartialBytes) {
		return;
	}

	/* Stage 3: All that is left is to fill the hold with the remaining data=

	 * to be processed. There will be no push to the FIFO because there is n=
ot
	 * enough data left to cause one.
	 */

	/* Write to the hold and push data to the FIFO */
	for (i =3D 0; i < PartialBytes; i++) {
		mHold_CopyIn(F, i, *SrcPtr);
		SrcPtr++;
	}

	/* Set the hold's index to its final correct value */
	mHold_SetIndex(F, PartialBytes);
}

/************************************************************************=
*******
* Write directly to the 64 bit wide transmit FIFO from an aligned source
* buffer. Leftover bytes are written to the holding buffer.
*
* @param F is a pointer to the packet FIFO instance to be worked on.
* @param BufPtr is the source buffer address on 32-bit alignment
* @param ByteCount is the number of bytes to transfer
*
*************************************************************************=
******/
static void Write64_Aligned(XTemac_PacketFifo * F, u32 * BufPtr, u32 Byte=
Count)
{
	unsigned FifoTransfersLeft =3D ByteCount / PFIFO_64BIT_WIDTH_BYTES;
	unsigned PartialBytes =3D ByteCount & (PFIFO_64BIT_WIDTH_BYTES - 1);

	/* Direct transfer */
	while (FifoTransfersLeft--) {
		mWriteFifo64(F, BufPtr);
		BufPtr +=3D 2;
	}

	/* Leftover bytes are left in the holding area */
	if (PartialBytes) {
		Write64_Unaligned(F, BufPtr, PartialBytes);
	}
}

/************************************************************************=
*******
* Read into the 64 bit holding buffer from the receive packet FIFO.
* Each time the holding buffer becomes full, then it is flushed to the
* provided buffer.
*
* @param F is a pointer to the packet FIFO instance to be worked on.
* @param BufPtr is the destination buffer address on any alignment
* @param ByteCount is the number of bytes to transfer
*
*************************************************************************=
******/
static void Read64_Unaligned(XTemac_PacketFifo * F, void *BufPtr, u32 Byt=
eCount)
{
	u8 *DestPtr =3D (u8 *) BufPtr;
	unsigned FifoTransfersLeft;
	unsigned PartialBytes;
	unsigned BytesLeft;
	int i;

	/* Stage 1: The hold may have some residual bytes that must be flushed
	 * to the buffer before anything is read from the FIFO
	 */

	/* Calculate the number of bytes to flush to the buffer from the hold.
	 * If the number of bytes to flush is greater than the "Bytes" requested=
,
	 * then adjust accordingly.
	 */
	i =3D mHold_GetIndex(F);
	PartialBytes =3D PFIFO_64BIT_WIDTH_BYTES - i;

	if (PartialBytes > ByteCount) {
		PartialBytes =3D ByteCount;
	}

	/* Calculate the number of bytes remaining after flushing to the buffer =
*/
	BytesLeft =3D ByteCount - PartialBytes;

	/* Move the hold's index forward */
	mHold_Advance(F, PartialBytes);

	/* Copy bytes */
	while (PartialBytes--) {
		mHold_CopyOut(F, i, *DestPtr);
		i++;
		DestPtr++;
	}

	/* No more data to process */
	if (!BytesLeft) {
		return;
	}

	/* Stage 2: The hold is empty now, if any more bytes are left to process=
, then
	 * it will begin with nothing in the hold. Use the hold as a temporary s=
torage
	 * area to contain the data.
	 *
	 * The hold is filled with FIFO data, then that data is written to the b=
uffer.
	 * Do this FifoTransfersLeft times
	 */

	/* Calculate the number of times a push will need to occur */
	FifoTransfersLeft =3D BytesLeft / PFIFO_64BIT_WIDTH_BYTES;

	/* Calculate the number of partial bytes left after this stage */
	PartialBytes =3D
	    BytesLeft - (FifoTransfersLeft * PFIFO_64BIT_WIDTH_BYTES);

	/* Write to the hold and push data to the FIFO */
	while (FifoTransfersLeft--) {
		/* Load the hold with the next data set from the FIFO */
		mPop64(F);

		/* Write hold to buffer */
		for (i =3D 0; i < PFIFO_64BIT_WIDTH_BYTES; i++) {
			mHold_CopyOut(F, i, *DestPtr);
			DestPtr++;
		}
	}

	/* No more data to process
	 * After processing full FIFO chunks of data, the hold is empty at this
	 * point
	 */
	if (!PartialBytes) {
		return;
	}

	/* Stage 3: All that is left is to fill the hold one more time with FIFO=

	 * data, then write the remaining requested bytes to the buffer
	 */

	/* Get FIFO data */
	mPop64(F);

	/* Copy bytes from the hold to the buffer */
	for (i =3D 0; i < PartialBytes; i++) {
		mHold_CopyOut(F, i, *DestPtr);
		DestPtr++;
	}

	/* Set the hold's index to its final correct value */
	mHold_SetIndex(F, PartialBytes);
}

/************************************************************************=
*******
* Read directly from the 64 bit wide receive FIFO into an aligned destina=
tion
* buffer. Leftover bytes are written to the holding buffer.
*
* @param F is a pointer to the packet FIFO instance to be worked on.
* @param BufPtr is the destination buffer address on 32-bit alignment
* @param ByteCount is the number of bytes to transfer
*
*************************************************************************=
******/
static void Read64_Aligned(XTemac_PacketFifo * F, u32 * BufPtr, u32 ByteC=
ount)
{
	unsigned FifoTransfersLeft =3D ByteCount / PFIFO_64BIT_WIDTH_BYTES;
	unsigned PartialBytes =3D ByteCount & (PFIFO_64BIT_WIDTH_BYTES - 1);

	/* Direct transfer */
	while (FifoTransfersLeft--) {
		mReadFifo64(F, BufPtr);
		BufPtr +=3D 2;
	}

	/* Leftover bytes are left in the holding area */
	if (PartialBytes) {
		Read64_Unaligned(F, BufPtr, PartialBytes);
	}
}
/** @name IPIF interrupt and reset registers
 *  @{
 */
#define XTE_DISR_OFFSET  0x00000000  /**< Device interrupt status */
#define XTE_DIPR_OFFSET  0x00000004  /**< Device interrupt pending */
#define XTE_DIER_OFFSET  0x00000008  /**< Device interrupt enable */
#define XTE_DGIE_OFFSET  0x0000001C  /**< Device global interrupt enable =
*/
#define XTE_IPISR_OFFSET 0x00000020  /**< IP interrupt status */
#define XTE_IPIER_OFFSET 0x00000028  /**< IP interrupt enable */
#define XTE_DSR_OFFSET   0x00000040  /**< Device software reset (write) *=
/
#define XTE_MIR_OFFSET   0x00000040  /**< Device software reset (read) */=

#define XTE_DXR_SEND_FIFO_MASK          0x00000040 /**< Send FIFO channel=
 */
#define XTE_DXR_RECV_FIFO_MASK          0x00000020 /**< Receive FIFO chan=
nel */
#define XTE_DXR_CORE_MASK               0x00000004 /**< Core */
#define XTE_DXR_DPTO_MASK               0x00000002 /**< Data phase timeou=
t */
#define XTE_DXR_TERR_MASK               0x00000001 /**< Transaction error=
 */
#define XTE_IPXR_XMIT_DONE_MASK         0x00000001 /**< Tx complete */
#define XTE_IPXR_RECV_DONE_MASK         0x00000002 /**< Rx complete */
#define XTE_IPXR_AUTO_NEG_MASK          0x00000004 /**< Auto negotiation =
complete */
#define XTE_IPXR_RECV_REJECT_MASK       0x00000008 /**< Rx packet rejecte=
d */
#define XTE_IPXR_XMIT_SFIFO_EMPTY_MASK  0x00000010 /**< Tx status fifo em=
pty */
#define XTE_IPXR_RECV_LFIFO_EMPTY_MASK  0x00000020 /**< Rx length fifo em=
pty */
#define XTE_IPXR_XMIT_LFIFO_FULL_MASK   0x00000040 /**< Tx length fifo fu=
ll */
#define XTE_IPXR_RECV_LFIFO_OVER_MASK   0x00000080 /**< Rx length fifo ov=
errun
                                                        Note that this si=
gnal is
                                                        no longer asserte=
d by HW
                                                        */
#define XTE_IPXR_RECV_LFIFO_UNDER_MASK  0x00000100 /**< Rx length fifo un=
derrun */
#define XTE_IPXR_XMIT_SFIFO_OVER_MASK   0x00000200 /**< Tx status fifo ov=
errun */
#define XTE_IPXR_XMIT_SFIFO_UNDER_MASK  0x00000400 /**< Tx status fifo un=
derrun */
#define XTE_IPXR_XMIT_LFIFO_OVER_MASK   0x00000800 /**< Tx length fifo ov=
errun */
#define XTE_IPXR_XMIT_LFIFO_UNDER_MASK  0x00001000 /**< Tx length fifo un=
derrun */
#define XTE_IPXR_RECV_PFIFO_ABORT_MASK  0x00002000 /**< Rx packet rejecte=
d due to
                                                        full packet FIFO =
*/
#define XTE_IPXR_RECV_LFIFO_ABORT_MASK  0x00004000 /**< Rx packet rejecte=
d due to
                                                        full length FIFO =
*/
#define XTE_IPXR_MII_PEND_MASK          0x00008000 /**< Mii operation now=

                                                        pending */
#define XTE_IPXR_MII_DONE_MASK          0x00010000 /**< Mii operation has=

                                                        completed */
#define XTE_IPXR_XMIT_PFIFO_UNDER_MASK  0x00020000 /**< Tx packet FIFO
                                                        underrun */
#define XTE_IPXR_XMIT_DMA_MASK          0x00080000 /**< Rx dma channel */=

#define XTE_IPXR_RECV_DMA_MASK          0x00100000 /**< Tx dma channel */=

#define XTE_IPXR_RECV_FIFO_LOCK_MASK    0x00200000 /**< Rx FIFO deadlock =
*/
#define XTE_IPXR_XMIT_FIFO_LOCK_MASK    0x00400000 /**< Tx FIFO deadlock =
*/
#define XTE_DGIE_ENABLE_MASK    0x80000000  /**< Write this value to DGIE=
 to
                                                 enable interrupts from t=
his
                                                 device */
#define XTE_CR_BCREJ_MASK       0x00000004   /**< Disable broadcast addre=
ss
                                                  filtering */
#define XTE_CR_MCREJ_MASK       0x00000002   /**< Disable multicast addre=
ss
                                                  filtering */
#define XTE_CR_HRST_MASK        0x00000001   /**< Reset the hard TEMAC co=
re */
#define XTE_UAW1_MASK          0x0000FFFF   /**< Station address bits [47=
:32]
                                                 Station address bits [31=
:0]=20
                                                 are stored in register
                                                 UAW0 */
#define XTE_MAW1_CAMRNW_MASK   0x00800000   /**< CAM read/write control *=
/
#define XTE_MAW1_CAMADDR_MASK  0x00030000   /**< CAM address mask */
#define XTE_MAW1_MASK          0x0000FFFF   /**< Multicast address bits [=
47:32]
                                                 Multicast address bits [=
31:0]=20
                                                 are stored in register
                                                 MAW0 */
#define XTE_MAW1_CAMMADDR_SHIFT_MASK 16	    /**< Number of bits to shift =
right
                                                 to align with
                                                 XTE_MAW1_CAMADDR_MASK */=

#define XTE_AFM_EPPRM_MASK     0x80000000   /**< Promiscuous mode enable =
*/
#define XTemac_mReadReg(BaseAddress, RegOffset) \
    XIo_In32((BaseAddress) + (RegOffset))
#define XTemac_mWriteReg(BaseAddress, RegOffset, Data) \
    XIo_Out32((BaseAddress) + (RegOffset), (Data))
#define XTemac_mHostOffset(HostRegOffset) \
    ((u32)(HostRegOffset) + XTE_HOST_IPIF_OFFSET)
#define XTemac_mReadHostReg(BaseAddress, HostRegOffset) \
    XIo_In32((BaseAddress) + XTemac_mHostOffset(HostRegOffset))
#define XTemac_mWriteHostReg(BaseAddress, HostRegOffset, Data) \
    XIo_Out32((BaseAddress) + XTemac_mHostOffset(HostRegOffset), (Data))

#endif

--------------050904090902070905010704--

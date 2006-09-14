Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A40367A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 21:20:25 +1000 (EST)
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1219)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GNp7u-0001t9-My by authid <dhlii> with plain_server
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 07:11:26 -0400
Message-ID: <45093A94.2080407@dlasys.net>
Date: Thu, 14 Sep 2006 07:18:44 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
In-Reply-To: <528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------040809050300020102010303"
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
--------------040809050300020102010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
> On 9/13/06, Aleck Lin <aleck@gdatech.com> wrote:
>   
>> Hi,
>>
>> I'm able to boot Linux 2.6 on ML403 board (with a ramdisk file system).
>>
>> However, during the kernel booting, it complains that "No network devices
>> available," So I figured I probably didn't enable the ethernet driver in the
>> kernel.
>>
>> >From doing "make menuconfig", under "Device Drivers" --> "Network device
>> support" --> "Ethernet(10 or 100Mbit)", I checked the box of both "Ethernet
>> (10 or 100Mbit)" and "PowerPC 4xx on-chip Ethernet support." I then
>> save/exit the menuconfig to compile the kernel again. I've attached the
>> error output at the bottom.
>>     
>
> The virtex eth device is not the same as 4xx on-chip Ethernet, so
> CONFIG_IBM_EMAC will not work.  You need the xilinx_enet driver (which
> is not in mainline).  It might be in MontaVista's 2.6 tree.
>
> I think people have posted patches for it to this list, so try
> searching the archives.  (I don't have a link off the top of my head.)
>   
    The MV 2.6 Xilinx_edk based TEMAC driver has been posted to this 
list several times.

    As of the last incarnation I tried it had no MII/PHY support and you 
had to manully change the speed of the driver 10/100/1000 by editing the 
code.
    Otherwise it worked with the PLB FIFO TEMAC, that I am using, and 
should with others.

    I have a polled driver that works with the LL TEMAC.
    I am nearly finished a PLB FIFO TEMAC driver that includes working 
autonegotiation and does not use the Xilinx_edk.
    But right now it has a receive problem - packets come in they look 
good but linux silently discards them.

    I have virtually the same code working under GHS Integrity.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040809050300020102010303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Grant Likely wrote:
<blockquote
 cite="mid528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com"
 type="cite">
  <pre wrap="">On 9/13/06, Aleck Lin <a class="moz-txt-link-rfc2396E" href="mailto:aleck@gdatech.com">&lt;aleck@gdatech.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

I'm able to boot Linux 2.6 on ML403 board (with a ramdisk file system).

However, during the kernel booting, it complains that "No network devices
available," So I figured I probably didn't enable the ethernet driver in the
kernel.

&gt;From doing "make menuconfig", under "Device Drivers" --&gt; "Network device
support" --&gt; "Ethernet(10 or 100Mbit)", I checked the box of both "Ethernet
(10 or 100Mbit)" and "PowerPC 4xx on-chip Ethernet support." I then
save/exit the menuconfig to compile the kernel again. I've attached the
error output at the bottom.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The virtex eth device is not the same as 4xx on-chip Ethernet, so
CONFIG_IBM_EMAC will not work.  You need the xilinx_enet driver (which
is not in mainline).  It might be in MontaVista's 2.6 tree.

I think people have posted patches for it to this list, so try
searching the archives.  (I don't have a link off the top of my head.)
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; The MV 2.6 Xilinx_edk based TEMAC driver has been posted to this
list several times.<br>
<br>
&nbsp;&nbsp;&nbsp; As of the last incarnation I tried it had no MII/PHY support and
you had to manully change the speed of the driver 10/100/1000 by
editing the code.<br>
&nbsp;&nbsp;&nbsp; Otherwise it worked with the PLB FIFO TEMAC, that I am using, and
should with others.<br>
<br>
&nbsp;&nbsp;&nbsp; I have a polled driver that works with the LL TEMAC.<br>
&nbsp;&nbsp;&nbsp; I am nearly finished a PLB FIFO TEMAC driver that includes working
autonegotiation and does not use the Xilinx_edk.<br>
&nbsp;&nbsp;&nbsp; But right now it has a receive problem - packets come in they look
good but linux silently discards them.<br>
<br>
&nbsp;&nbsp;&nbsp; I have virtually the same code working under GHS Integrity.<br>
<br>
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

--------------040809050300020102010303--

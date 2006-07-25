Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F09B667B71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 09:57:56 +1000 (EST)
Message-ID: <44C6AB80.9040000@digis.net>
Date: Tue, 25 Jul 2006 17:38:40 -0600
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Clint Thomas <cthomas@Soneticom.com>
Subject: Re: Booting Linux Kernel without bootloader
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
Content-Type: multipart/alternative;
	boundary="------------060304030901080100020007"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bennett78@digis.net
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
--------------060304030901080100020007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clint Thomas wrote:

> Hey guys,
>
> I have gone through the Linuxppc embedded and dev lists for 
> information related to what I am trying to do, but was unable to find 
> exactly what i'm looking for.
>
> Basically, the system I want linux running on does not require the 
> initialization of hardware that U-boot provides, or at least it does 
> not need it to boot the linux kernel. I want to load an uncompressed 
> linux kernel into memory and start the execution of the kernel, 
> without using any kind of bootloader. Is this possible? Or does linux 
> need some kind of firmware or other software to tell it to start 
> executing? Thanks for any info you might have.

You seem to be looking for a striped down U-boot functionality:
    o copy flash to ram and run code
but to do this:
    o processor registers need to be initilized
    o caches need to be flushed
    o interrupts need to be disabled
    o C environment (stack) needs to be setup
U-boot is fairly small compared to a x86 BIOS which has to find
multiple boot device choices, yet supports multiple architectures.

I'm using a BDI2000 to load/debug u-boot running in SDRAM
for a new PPC hardware design.  U-boot is probably easier to
debug than the kernel!
U-boot has other features that help with initial H/W turnon:
    o it's a debug/monitor
          o ram test
          o ram/register read/modify
    o u-boot environment
          o IP address, mac address
          o Linux boot options - NFS verses flash
          o Ethernet/NFS option using a server enables:
             o debugging kernel changes
             o debugging kernel driver modules
             o quick change of application processes
             o cross compile target code on server to local target
             o telnet to embedded H/W
    o knows how to flash partitions
          o u-boot (/dev/mtd0) (well I use the BDI to flash here)
          o can flash kernel (/dev/mtd1)
          o can flash root fs (/dev/mtd2)
          o can flash config data (/dev/mtd3)
          o this partitioning will help with future F/W updates
          o kind of required if your flash is soldered to the board
          o to read/write flash requires u-boot to relocate itself to ram

>  
> Clinton Thomas
> cthomas@soneticom.com
>  _______________________________________________
>
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
Frank Bennett

*/Technical Contractor/*

/Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
/http://www.traidsyseng.com <http://www.triadsyseng.com>
frank.bennett@triadsyseng.com <mailto:frank.bennett@triadsyseng.com>/
/
"I think there's a world market for about five computers."
        -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943




--------------060304030901080100020007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Clint Thomas wrote:
<blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.2900.2912" name="GENERATOR">
  <div><font face="Arial" size="2"><span class="675052722-25072006">Hey
guys,<br>
  <br>
I have gone through the Linuxppc embedded and dev lists for information
related to what I am trying to do, but was unable to find exactly what
i'm looking for.<br>
  <br>
Basically, the system I want linux running on does not require the
initialization of hardware that U-boot provides, or at least it does
not need it to boot the linux kernel. I want to load an uncompressed
linux kernel into memory and start the execution of the kernel, without
using any kind of bootloader. Is this possible? Or does linux need some
kind of firmware or other software to tell it to start executing?
Thanks for any info you might have.</span></font></div>
</blockquote>
You seem to be looking for a striped down U-boot functionality:<br>
&nbsp;&nbsp;&nbsp; o copy flash to ram and run code<br>
but to do this:<br>
&nbsp;&nbsp;&nbsp; o processor registers need to be initilized<br>
&nbsp;&nbsp;&nbsp; o caches need to be flushed<br>
&nbsp;&nbsp;&nbsp; o interrupts need to be disabled<br>
&nbsp;&nbsp;&nbsp; o C environment (stack) needs to be setup<br>
U-boot is fairly small compared to a x86 BIOS which has to find <br>
multiple boot device choices, yet supports multiple architectures.<br>
<br>
I'm using a BDI2000 to load/debug u-boot running in SDRAM<br>
for a new PPC hardware design.&nbsp; U-boot is probably easier to<br>
debug than the kernel!<br>
U-boot has other features that help with initial H/W turnon:<br>
&nbsp;&nbsp;&nbsp; o it's a debug/monitor<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o ram test<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o ram/register read/modify<br>
&nbsp;&nbsp;&nbsp; o u-boot environment <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o IP address, mac address<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o Linux boot options - NFS verses flash<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o Ethernet/NFS option using a server enables:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o debugging kernel changes<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o debugging kernel driver modules<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o quick change of application processes<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o cross compile target code on server to local target<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o telnet to embedded H/W<br>
&nbsp;&nbsp;&nbsp; o knows how to flash partitions<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o u-boot (/dev/mtd0) (well I use the BDI to flash here)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; o can flash kernel (/dev/mtd1)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o can flash root fs (/dev/mtd2)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o can flash config data (/dev/mtd3)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o this partitioning will help with future F/W updates<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o kind of required if your flash is soldered to the board<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; o to read/write flash requires u-boot to relocate itself to
ram<br>
<blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local"
 type="cite">
  <div>&nbsp;</div>
  <div align="left"><font face="Arial" size="2">Clinton Thomas<br>
<a class="moz-txt-link-abbreviated" href="mailto:cthomas@soneticom.com">cthomas@soneticom.com</a></font></div>
  <div>&nbsp;_______________________________________________<br>
  </div>
  <pre wrap="">Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<span style="font-style: italic; font-weight: bold;">Frank Bennett</span>
<div class="moz-signature">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Technical Contractor</em></font></big></b><span
 style="text-decoration: underline;">
</span>
<i><font face="Helvetica, Arial, sans-serif">Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
</font></i><a href="http://www.triadsyseng.com">http://www.traidsyseng.com</a>
<span style="text-decoration: underline;"><a
 href="mailto:frank.bennett@triadsyseng.com">frank.bennett@triadsyseng.com</a></span><i><font
 face="Helvetica, Arial, sans-serif">
</font></i>
"I think there's a world market for about five computers."
        -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943

<span style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------060304030901080100020007--

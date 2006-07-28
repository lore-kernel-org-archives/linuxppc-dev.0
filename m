Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 0799267A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 18:04:01 +1000 (EST)
Message-ID: <44C9C4E4.2060206@dlasys.net>
Date: Fri, 28 Jul 2006 04:03:48 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Clint Thomas <cthomas@Soneticom.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Booting Linux Kernel without bootloader
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
Content-Type: multipart/alternative;
	boundary="------------030408080004050600060401"
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
--------------030408080004050600060401
Content-Type: text/plain; charset=ISO-8859-1
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

    You system powers on. It starts executing whatever is at the reset
vector, Something has to get you from the ppc powering up and going to
never never land, to starting to execute Linux.
    The steps to get from Power on to booting Linux may not be that
complicated, Much of what needs to be done can likely be included as
part of the code for your board in arch/ppc/boot/simple.
    But something still has to be done.

    In my instance I am dealing with a Xilinx V4 (not an ML403). A small
"monitor" program is automatically loaded as part of the FPGA .bit
image. On power on it starts executing.
    It sets up the CPU, cache, and very minimal hardware configuration,
and then loads Linux out of flash and executes it.
   
    Linux does not have to have alot setup to boot. But something has to
to some minimal initial setup, get Linux into the memory of your system,
and jump to it.


   




>  
> Clinton Thomas
> cthomas@soneticom.com
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


--------------030408080004050600060401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
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
<br>
&nbsp;&nbsp;&nbsp; You system powers on. It starts executing whatever is at the reset
vector, Something has to get you from the ppc powering up and going to
never never land, to starting to execute Linux.<br>
&nbsp;&nbsp;&nbsp; The steps to get from Power on to booting Linux may not be that
complicated, Much of what needs to be done can likely be included as
part of the code for your board in arch/ppc/boot/simple.<br>
&nbsp;&nbsp;&nbsp; But something still has to be done.<br>
<br>
&nbsp;&nbsp;&nbsp; In my instance I am dealing with a Xilinx V4 (not an ML403). A
small "monitor" program is automatically loaded as part of the FPGA
.bit image. On power on it starts executing.<br>
&nbsp;&nbsp;&nbsp; It sets up the CPU, cache, and very minimal hardware configuration,
and then loads Linux out of flash and executes it.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Linux does not have to have alot setup to boot. But something has
to to some minimal initial setup, get Linux into the memory of your
system, and jump to it.<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
<blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local"
 type="cite">
  <div>&nbsp;</div>
  <div align="left"><font face="Arial" size="2">Clinton Thomas<br>
<a class="moz-txt-link-abbreviated" href="mailto:cthomas@soneticom.com">cthomas@soneticom.com</a></font></div>
  <div>&nbsp;</div>
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

--------------030408080004050600060401--

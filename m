Return-Path: <peter.ryser@xilinx.com>
Received: from outbound2-kan-R.bigfish.com (outbound-kan.frontbridge.com
	[63.161.60.23])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D1BF767B83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 11:08:01 +1000 (EST)
Message-ID: <44F38E28.9020201@xilinx.com>
Date: Mon, 28 Aug 2006 17:45:28 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Clint Thomas <cthomas@soneticom.com>
Subject: Re: PPC405 system slow boot
References: <3C02138692C13C4BB675FE7EA240952918E1E2@bluefin.Soneticom.local>
In-Reply-To: <3C02138692C13C4BB675FE7EA240952918E1E2@bluefin.Soneticom.local>
Content-Type: multipart/alternative;
	boundary="------------020105070800020209070704"
Cc: linuxppc-embedded@ozlabs.org
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
--------------020105070800020209070704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Clint,

check the interrupt sub-system of your design. What you describe 
typically happens when the PPC does not get any interrupts from the 
UART. It's most likely a mismatch between your hardware and the 
xparameters.h.

- Peter


Clint Thomas wrote:

> Hey guys,
>
> I've run through the loops to try and figure what could be wrong with 
> this system. The board in question is modeled after the Xilinx ML300 
> board. It uses a Xilinx System ACE chip to load a FPGA / Kernel image 
> from compact flash. Originally, I was trying to use the CompactFlash 
> as the root file system, but because of issues in either the design or 
> software, this would only work if SysAce was in polled I/O mode. To 
> circumvent this, I built my root filesystem into an initrd image and 
> built a single ELF file with the Kernel and RFS, then strapped that to 
> the FPGA bit file to make a single FPGA/Kernel/RFS SysAce file.
>
> Upon decompression, the Linux kernel boots quickly and loads all of 
> the device drivers. However when it gets to the prompt, it starts 
> slowing down. Output and input to and from the board becomes very very 
> slow (it displays 2 characters roughly every 20 seconds). Originally I 
> believed this to be the CPU still polling SystemAce, so I disabled the 
> Linux System ACE drivers to remove that as a possibility, however 
> after doing this, the problem still persists, even with the RFS in 
> ram! Has anybody encountered a similar situation to this before, with 
> possible insight towards a solution? Thank you for your time.
>  
> Clinton Thomas
> cthomas@soneticom.com
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

--------------020105070800020209070704
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Clint,<br>
<br>
check the interrupt sub-system of your design. What you describe
typically happens when the PPC does not get any interrupts from the
UART. It's most likely a mismatch between your hardware and the
xparameters.h.<br>
<br>
- Peter<br>
<br>
<br>
Clint Thomas wrote:
<blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952918E1E2@bluefin.Soneticom.local"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.2900.2963" name="GENERATOR">
  <div><span class="068485119-28082006"><font face="Arial" size="2">Hey
guys,<br>
  <br>
I've run through the loops to try and figure what could be wrong with
this system. The board in question is modeled after the Xilinx ML300
board. It uses a Xilinx System ACE chip to load a FPGA / Kernel image
from compact flash. Originally, I was trying to use the CompactFlash as
the root file system, but because of issues in either the design or
software, this would only work if SysAce was in polled I/O mode. To
circumvent this, I built my root filesystem into an initrd image and
built a single ELF file with the Kernel and RFS, then strapped that to
the FPGA bit file to make a single FPGA/Kernel/RFS SysAce file.<br>
  <br>
Upon decompression, the Linux kernel boots quickly and loads all of the
device drivers. However when it gets to the prompt, it starts slowing
down. Output and input to and from the board becomes very very slow (it
displays 2 characters roughly every 20 seconds). Originally I believed
this to be the CPU still polling SystemAce, so I disabled the Linux
System ACE drivers to remove that as a possibility, however after doing
this, the problem still persists, even with the RFS in ram! Has anybody
encountered a similar situation to this before, with possible insight
towards a solution? Thank you for your time.</font></span></div>
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
</body>
</html>

--------------020105070800020209070704--

Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 1C0E667A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 01:29:08 +1000 (EST)
Message-ID: <4267C6C2.4020808@ru.mvista.com>
Date: Thu, 21 Apr 2005 19:29:06 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859369@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859369@ismail.innsys.innovsys.com>
Content-Type: multipart/alternative;
	boundary="------------070602080605030605000307"
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
 thestock linux-2.5 (updated)
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
--------------070602080605030605000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rune Torgersen wrote:

> 
>
>  
>
>>Not 100% sure.  Maybe Wolfgang or someone else know what the existing 
>>m8260 pci functionality is suppose to work with.  It seems 
>>odd that it 
>>did not have some of the bits you added for the 8272ads.  Its 
>>not clear 
>>to me if it actually worked on any systems or not.  Let see 
>>if Wolfgang 
>>has any insight as a first step.
>>    
>>
>
>The current one works on 8266/8265 based boards. It requires u-boot to
>partiallyt set up PCI first.
>I have a patch tat enables 8266ADS support, but have never posted it
>(also because it has been superceded by PQ2ADS patches)
>
>The missing pieces are the siumcr setup, which is done in U-Boot (almost
>better to do it there as it is highly board dependant, and you would
>have an afoul lot of #ifdefs to support all variants)
>
>The other missing part is setup of the second outbound PCI wondow
>(pcimask1/pcibr1). This is not used, bacqause the whole outbound window
>is set up to be contiguous, and is covered by pcimsk0/pcibr0
>
>I am running a slightly modified version of m8260_setup_pci on an
>internal board port, and it works just fine.
>
>Only change I'v had to do (to m8260_find bridges) is to add a bit on the
>IORESOURCE_IO part, so that IO memory is detected correctly.
>
>        pci_init_resource(&hose->io_resource,
>			  MPC826x_PCI_LOWER_IO,
>			  MPC826x_PCI_UPPER_IO,
>			  IORESOURCE_IO | 1, "PCI I/O"); // the 1 added
>so IO areas work. :FIXME: find real source
>
>
>  
>
This is all right. The only thing I still don't understand - how this 
stuff work without PCI IRQ (don't know much about 8266 though). On my 
8272 only one IRQ is produced and it should be demux'ed in order for PCI 
devices to work. I agree that the siumcr stuff would better reside in 
the firmware, and I have submitted related patch to the u-boot-users 
list, but I have no idea whether it would be accepted or not (Wolfgang?).

The main point I actually dislike in the current m8260 implementation is 
that it adds defines for the PCI memory map while it exists (and already 
included) in platforms/pq2ads.h. The memory maps are nearly the same so 
we should decide which one will remain.

-- 
Sincerely, 
Vitaly


--------------070602080605030605000307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Rune Torgersen wrote:
<blockquote
 cite="midDCEAAC0833DD314AB0B58112AD99B93B859369@ismail.innsys.innovsys.com"
 type="cite">
  <pre wrap=""> 

  </pre>
  <blockquote type="cite">
    <pre wrap="">Not 100% sure.  Maybe Wolfgang or someone else know what the existing 
m8260 pci functionality is suppose to work with.  It seems 
odd that it 
did not have some of the bits you added for the 8272ads.  Its 
not clear 
to me if it actually worked on any systems or not.  Let see 
if Wolfgang 
has any insight as a first step.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The current one works on 8266/8265 based boards. It requires u-boot to
partiallyt set up PCI first.
I have a patch tat enables 8266ADS support, but have never posted it
(also because it has been superceded by PQ2ADS patches)

The missing pieces are the siumcr setup, which is done in U-Boot (almost
better to do it there as it is highly board dependant, and you would
have an afoul lot of #ifdefs to support all variants)

The other missing part is setup of the second outbound PCI wondow
(pcimask1/pcibr1). This is not used, bacqause the whole outbound window
is set up to be contiguous, and is covered by pcimsk0/pcibr0

I am running a slightly modified version of m8260_setup_pci on an
internal board port, and it works just fine.

Only change I'v had to do (to m8260_find bridges) is to add a bit on the
IORESOURCE_IO part, so that IO memory is detected correctly.

        pci_init_resource(&amp;hose-&gt;io_resource,
			  MPC826x_PCI_LOWER_IO,
			  MPC826x_PCI_UPPER_IO,
			  IORESOURCE_IO | 1, "PCI I/O"); // the 1 added
so IO areas work. :FIXME: find real source


  </pre>
</blockquote>
This is all right. The only thing I still don't understand - how this
stuff work without PCI IRQ (don't know much about 8266 though). On my
8272 only one IRQ is produced and it should be demux'ed in order for
PCI devices to work. I agree that the siumcr stuff would better reside
in the firmware, and I have submitted related patch to the u-boot-users
list, but I have no idea whether it would be accepted or not
(Wolfgang?).<br>
<br>
The main point I actually dislike in the current m8260 implementation
is that it adds defines for the PCI memory map while it exists (and
already included) in platforms/pq2ads.h. The memory maps are nearly the
same so we should decide which one will remain.<br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------070602080605030605000307--

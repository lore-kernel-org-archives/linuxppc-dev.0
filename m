Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx2.magma.ca (mx2.magma.ca [206.191.0.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26D8067A3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 03:48:10 +1000 (EST)
Received: from mail3.magma.ca (mail3.magma.ca [206.191.0.221])
	by mx2.magma.ca (8.13.6/8.13.0) with ESMTP id k44HWQZp004975
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 May 2006 13:32:27 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id k44HWPWw001648
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 May 2006 13:32:26 -0400
Message-ID: <445A3AB1.7040405@ics-ltd.com>
Date: Thu, 04 May 2006 13:32:33 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Moving from 2.4 to 2.6 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to take a working embedded linux system from kernel 2.4 to 
2.6. The hardware is a custom board using a Virtex II Pro with PPC405 
processor.
The working system uses u-boot 1.1.1 with linux kernel 2.4.18.

I am using the same u-boot and I am trying to port linux kernel 2.6.15 
to our platform. Using the stuff from the working 2.4 kernel port and 
other PPC4xx platforms in the 2.6.15 code as examples, I believe I have 
done everything required to get the kernel booting. However, the kernel 
seems to hang after being uncompressed. Here is what I see after running 
bootm from u-boot:

## Booting image at 00400000 ...
   Image Name:   Linux-2.6.15 ICS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    605592 Bytes = 591.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00800000 ...
   Image Name:   SELF CRD
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1430581 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03e5c000, end 03fb9435 ... OK

My first thought was that I was simply not setting up the console 
properly, and was not seeing the printk output, but I don't think I'm 
even getting that far. I tried flashing an LED in start_kernel (in the 
file init/main.c) and also in my platform_init function, but I get 
nothing. I think the kernel is hanging somewhere very early on, maybe 
when the MMU is enabled. I tried looking at the log buffer by following 
the steps in section 14.3.3 of the DULG (Linux Post Mortem Analysis), 
but I don't see anything there.

Any ideas would be appreciated.

Regards,
Chris
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.

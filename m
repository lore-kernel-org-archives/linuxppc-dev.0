Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 4C0D067AA6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 09:22:58 +1100 (EST)
Received: from [216.95.199.150] (account jpl@xiphos.ca HELO [192.168.1.169])
	by mail.net (CommuniGate Pro SMTP 4.2.5)
	with ESMTP id 41347014 for linuxppc-embedded@ozlabs.org;
	Mon, 31 Jan 2005 17:22:56 -0500
Message-ID: <41FEAFF9.7040908@xiphos.ca>
Date: Mon, 31 Jan 2005 22:23:53 +0000
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <41FC3051.2050004@xiphos.ca>
In-Reply-To: <41FC3051.2050004@xiphos.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: mmap on Virtex-II Pro
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday there,

This problem was caused by our custom OPB/PLB bridge not translating 
correctly from 64-bit access (or bursts) on the PLB to 32-bits on the OPB.


Joshua Lamorie wrote:

> Gidday there,
>
> I have Linux running on a Virtex-II Pro system (with a second FPGA 
> connected by a custom OPB/PLB bridge).
>
> I have a device on the OPB bus that I want to provide to applications 
> through mmap.  However, with my current implementation there are some 
> strange behaviours.
>
> If I mmap in my application, I can read everything in the device 
> memory (in blockram and other registers) with no problems.
> However if I write only a few bytes, they don't seem to go through to 
> the memory area, and instead some of the memory is cleared.  When I 
> write a large number of values (e.g. the counter in a for loop).  The 
> values show up, but the first 4 bytes are missing, and it only writes 
> every other 4 bytes.  For example...
>
> 0000:0000 | 04 05 06 07 00 00 00 00 0c 0d 0e 0f 00 00 00 00
> 0000:0010 | 14 15 16 17 00 00 00 00 1c 1d 1e 1f 00 00 00 00
>
> I'm using Rubini's Linux Device Drivers 2nd edition as a reference and 
> inside the mmap function of my module I simply do
>
> remap_page_range(vm_start,physical_address, vm_end-vm_start,vm_page_prot)
>
> I did a quick search through the archives and I noticed that there was 
> a call io_remap_page_range but that is just a macro pointing to 
> remap_page_ranger.  I also noticed that pgprot_noncached was used in a 
> 64 bit instance, but that doesn't exist in my kernel.
>
> I'm using 2.4.26, probably almost a year old now.
>
> Are there any simple examples of mapping OPB memory to user space?
>
> I'm also setting a couple of vm_flags such as VM_IO and VM_RESERVED.  
> Could there be a magic one that I'm missing?  I know that there are 
> some elements of the busses connected to the PPC405 in the Virtex-II 
> Pro that are 64-bit... is it possible that I'm mapping a 64-bit area 
> and nothing is correctly written?
>
> Thanks in advance for any advice.
>
> Joshua
>


-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.

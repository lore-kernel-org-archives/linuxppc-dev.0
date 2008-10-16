Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 516E9DDED6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 03:02:32 +1100 (EST)
Received: from [192.168.1.182] (unknown [192.168.1.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id DE8EFB8C0A3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 09:54:35 -0600 (MDT)
Message-Id: <1BA180A8-1655-4F10-ADDD-E5667DE182BE@securics.com>
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Cache control
Date: Thu, 16 Oct 2008 09:57:27 -0600
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a Virtex4 VF60 device with 256MB DDR2.

I have told the Linux kernel that the device has only 128MB and its  
working fine.  There is an HDL module that is populating the next 16MB  
with sensor data (0x08000000 - 0x09000000)  I mapped the area into my  
driver via `ioremap()` and also via `mmap / remap_pfn_range()`  It  
works fine.

I know that PPC cache regions work in 128MB blocks.  I assume that the  
kernel bootup is turning on cache in the first 128, because it thinks  
that its the full RAM range, and not cached in the next 128MB.

I know that if I declare the area cached, and invalidate the region  
before I read it,  the reads should be much faster than if it's not  
cached.


How can I control if the area is cached? and then invalidate it when  
new data arrives?

Is there a PPC/Linux API call to declare the region cached and  
invalidate regions before read?





Rob.

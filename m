Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id EFE3BDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 18:17:22 +1100 (EST)
Message-ID: <48F83C52.3010308@coritel.it>
Date: Fri, 17 Oct 2008 09:18:42 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Robert Woodworth <rwoodworth@securics.com>
Subject: Re: Cache control
References: <1BA180A8-1655-4F10-ADDD-E5667DE182BE@securics.com>
In-Reply-To: <1BA180A8-1655-4F10-ADDD-E5667DE182BE@securics.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Robert,

Robert Woodworth ha scritto:
> I have a Virtex4 VF60 device with 256MB DDR2.
> 
> I have told the Linux kernel that the device has only 128MB and its
> working fine. 

How? Have you used the mem kernel option?

 There is an HDL module that is populating the next 16MB
> with sensor data (0x08000000 - 0x09000000)  I mapped the area into my
> driver via `ioremap()` and also via `mmap / remap_pfn_range()`  It works
> fine.
> 
> I know that PPC cache regions work in 128MB blocks.  I assume that the
> kernel bootup is turning on cache in the first 128, because it thinks
> that its the full RAM range, and not cached in the next 128MB.
> 
> I know that if I declare the area cached, and invalidate the region
> before I read it,  the reads should be much faster than if it's not cached.
> 
> 
> How can I control if the area is cached? and then invalidate it when new
> data arrives?

If you use the ioremap, it provides non-cacheable guarded mappings,
indeed it calls __ioremap with _PAGE_NO_CACHE and _PAGE_GUARDED flags.
You can try to call directly __ioremap with the proper flags.

> 
> Is there a PPC/Linux API call to declare the region cached and
> invalidate regions before read?
> 

Yes, of course. You can see the arch/powerpc/include/asm/cacheflush.h
file to view the API to manage the cache.

> 
> 
> 
> 
> Rob.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838

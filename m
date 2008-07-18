Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12C34DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 00:57:46 +1000 (EST)
Message-ID: <4880AF55.2000807@freescale.com>
Date: Fri, 18 Jul 2008 09:57:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: how to allocate 9MB of memory in kernel ?
References: <18503022.post@talk.nabble.com>
	<200807170956.52101.arnd@arndb.de>	<18522535.post@talk.nabble.com>
	<48803D3C.5020608@coritel.it> <18525063.post@talk.nabble.com>
In-Reply-To: <18525063.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan wrote:

> 4. Now we want our 9MB SDRAM to point to the kernel circular buffer we want
> our circular buffer to be mapped to continues paged so that we could map it
> to user space.

Physically contiguous or virtually contiguous?  I think you only need the 
buffer to be virtually contiguous, which vmalloc gives you.  You only need it 
to be physically contiguous if you are passing this buffer to hardware via DMA 
(and the hardware cannot handle scatter/gather).

If you need it to be physically contiguous, you'll have to use a function like 
alloc_pages() (or the new alloc_pages_exact, which will be in 2.6.27).  To 
allocate 9MB, you'll need to increase CONFIG_FORCE_MAX_ZONEORDER to 12.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

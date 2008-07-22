Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 92948DE0A4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 01:18:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Tue, 22 Jul 2008 17:12:51 +0200
References: <18503022.post@talk.nabble.com> <4885AC94.7050501@coritel.it>
	<18587466.post@talk.nabble.com>
In-Reply-To: <18587466.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807221712.52030.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008, Misbah khan wrote:
> First of all let me thank you for your valuable suggessions ...
> 
> 1. I wanted to allocate 9MB in kernel and wanted that memory to be mapped to
> the physically continews SDRAM memory. but till now i could not found a way
> to do so ???
> 
> 2. So i thought to use ioremap to map SDRAM and make it accessible to user
> using mmap technique but there is only one doubt and that is will it be
> secure and stable and whether it is a right way of doing ???

As I have told you a few times now, you *either* allocate the memory *or*
ioremap it, NOT BOTH!!!

If you SDRAM is you main memory, you need vmalloc and remap_vmalloc_range.
If the SDRAM is not your main memory but some I/O attached buffer, you need
ioremap/of_iomap and remap_pfn_range.

	Arnd <><

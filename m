Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C2439DE23E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 17:56:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Thu, 17 Jul 2008 09:56:51 +0200
References: <18503022.post@talk.nabble.com>
In-Reply-To: <18503022.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807170956.52101.arnd@arndb.de>
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

On Thursday 17 July 2008, Misbah khan wrote:
> I need to allocate 9 MB of memory in to the kernel space which i need to
> mmap for the application to access.
> 
> I need to know what could be the best possible way of doing the same.
> 

If you don't need the memory to be physically contiguous, you can use
vmalloc to get the memory, but then you need to use remap_vmalloc_range
for mapping the memory into a user address space.

	Arnd <><

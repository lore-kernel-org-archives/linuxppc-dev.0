Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 56EC7DE0F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 07:31:43 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 rmcguire@videopresence.com
Subject: Re: 1MB alignment dma_alloc question
Date: Fri, 5 Sep 2008 23:31:36 +0200
References: <mailman.1.1220580004.22796.linuxppc-embedded@ozlabs.org>
	<CBF4EB06A92A4901B32659109487513E@absolutdaddy>
In-Reply-To: <CBF4EB06A92A4901B32659109487513E@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809052331.36463.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 05 September 2008, Russell McGuire wrote:

> So this begs a question is their a better way to get a 1MB aligned table?
> Other than allocating almost 2MB of memory and then trying to mask off the
> LSBs? Seems like an awful waste of memory. I guess the real question is
> there a better kernel call that returns already aligned DMA memory?

__get_free_pages() will allocate naturally aligned pages from the buddy
allocator, so that should do just what you need. If you don't do it at
boot time though,  you might not be able to get a full unfragmented
megabyte any more.

Another option would be to call alloc_bootmem() first, align the buffer
and call free_bootmem() on the areas that you do not need. This has to
be done *very* early in the boot process.

	Arnd <><

Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[207.189.120.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1F72DE026
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 07:19:54 +1000 (EST)
Date: Thu, 31 May 2007 14:19:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.22-rc3-mm1
Message-Id: <20070531141943.5c4d587c.akpm@linux-foundation.org>
In-Reply-To: <200705312243.18724.m.kozlowski@tuxland.pl>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200705312243.18724.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arndb@de.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 May 2007 22:43:18 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello
> 
> 	This is from iMac G3. The spufs_mem_mmap_fault() code looks bad
> in arch/powerpc/platforms/cell/spufs/file.c but somehow I'm unable to find
> the patch to blame hmm.
> 
> arch/powerpc/platforms/cell/spufs/file.c: In function 'spufs_mem_mmap_fault':
> arch/powerpc/platforms/cell/spufs/file.c:122: error: 'address' undeclared (first use in this function)
> arch/powerpc/platforms/cell/spufs/file.c:122: error: (Each undeclared identifier is reported only once
> arch/powerpc/platforms/cell/spufs/file.c:122: error: for each function it appears in.)
> arch/powerpc/platforms/cell/spufs/file.c:141: error: expected ';' before 'if'
> arch/powerpc/platforms/cell/spufs/file.c:122: warning: unused variable 'addr0'
> make[3]: *** [arch/powerpc/platforms/cell/spufs/file.o] Blad 1
> make[2]: *** [arch/powerpc/platforms/cell/spufs] Blad 2
> make[1]: *** [arch/powerpc/platforms/cell] Blad 2
> 

Yeah, that's the fix-fault-vs-invalidate-race patches, or my poor attempt
to fix them when spufs changed.  I suppose I'll have a poke at it next time
I get the powerpc machine fired up.

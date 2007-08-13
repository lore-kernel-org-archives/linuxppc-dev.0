Return-Path: <dgibson@ozlabs.org>
Date: Mon, 13 Aug 2007 10:49:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: mike zheng <mail4mz@gmail.com>
Subject: Re: Error: unsupported relocation against CSRR0
Message-ID: <20070813004903.GB15738@localhost.localdomain>
References: <5c9cd53b0708121404p5e2b8311l5a20ec481a6bed59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c9cd53b0708121404p5e2b8311l5a20ec481a6bed59@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 12, 2007 at 05:04:35PM -0400, mike zheng wrote:
> Hi All,
> 
> I have "unsupported relocation against" problem, while compiling entry.S in
> 2.4 Kernel against e500 core.  Does anyone know what is the problem? Is
> there any option I missed?

Probably means you haven't included the file with the #defines for
these SPR values.

> /kernel->   powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/kernel/.entry.o.d
> -nostdinc -isystem
> /opt/mtwk/usr/local/gcc-3_4-e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include
> -D__KERNEL__ -Iinclude  -Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-me500    -c
> -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
> arch/ppc/kernel/entry.S: Assembler messages:
> 
> entry.S:819: Error: unsupported relocation against CSRR0
> entry.S:820: Error: unsupported relocation against CSRR1
> entry.S:888: Error: unsupported relocation against MCSRR0
> entry.S:889: Error: unsupported relocation against MCSRR1
> entry.S:909: Error: unsupported relocation against CSRR0
> entry.S:911: Error: unsupported relocation against CSRR1
> 
> 
> 
> entry.S
> 
> 819   mtspr CSRR0, r11
> 820   mtspr CSRR1, r12

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

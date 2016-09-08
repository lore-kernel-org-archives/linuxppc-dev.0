Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVTBk5h7czDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 04:19:42 +1000 (AEST)
Date: Thu, 8 Sep 2016 20:19:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will  Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 "James  E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David  S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H.  Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
 Linus  Walleij <linus.walleij@linaro.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ming Lin <ming.l@ssi.samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Borislav  Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>,
 Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] atomic64: No need for
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
Message-ID: <20160908181905.GY10153@twins.programming.kicks-ass.net>
References: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 08, 2016 at 09:28:18AM -0700, Vineet Gupta wrote:
> This came to light when implementing native 64-bit atomics for ARCv2.
> 
> The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> to check whether atomic64_dec_if_positive() is available.
> It seems it was needed when not every arch defined it.
> However as of current code the Kconfig option seems needless
> 
> - for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
>   generic definition of API is present lib/atomic64.c
> - arches with native 64-bit atomics select it in arch/*/Kconfig and
>   define the API in their headers
> 
> So I see no point in keeping the Kconfig option
> 
> Compile tested for 2 representatives:
>  - blackfin (CONFIG_GENERIC_ATOMIC64)
>  - x86 (!CONFIG_GENERIC_ATOMIC64)
> 
> Also logistics wise it seemed simpler to just do this in 1 patch vs.
> splitting per arch - but I can break it up if maintainer feel that
> is better to avoid conflicts.

Works for me; you want me to take this, or do you need it for you ARCv2
patches?

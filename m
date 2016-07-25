Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rySfk38pQzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:18:22 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id c199so15621853oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:18:22 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Jul 2016 21:18:19 -0700
Message-ID: <CA+55aFyDw_jK609LcjpWvVMTzCWuH6nLUXiZDeYC2tpSaZqhXA@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] split exception table content out of module.h
 into extable.h
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>,
 Russell King <linux@armlinux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 linux-alpha@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 linux-mips <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 24, 2016 at 8:42 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> While doing an audit looking for unnecessary instances of module.h
> inclusion across arch/x86/ I found a significant number of includes
> of module.h were for things like search_exception_table and friends.
>
> For historical reasons (i.e. pre-git) the exception table stuff was
> buried in the middle of the module.h file.  So we have core kernel
> files that are completely non-modular (both arch specific and arch
> independent) that are just including module.h for this.
>
> The converse is also true, in that conventional drivers, be they for
> filesystems or actual hardware peripherals or similar, do not
> normally care about the exception tables.
>
> Here we fork the exception table content [...]

This looks to be the right thing to do as far as I can tell. I'm not
sure how big of a problem the extable stuff is (we definitely have
much bigger unnecessary include files that cause a lot more problems),
but it seems like a reasonable cleanup.

              Linus

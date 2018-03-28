Return-Path: <rob@landley.net>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BHPS4jhYzF2K6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 06:04:44 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id r19-v6so5134377itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:04:44 -0700 (PDT)
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Vladimir Murzin
 <vladimir.murzin@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams
 <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
From: Rob Landley <rob@landley.net>
Message-ID: <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
Date: Wed, 28 Mar 2018 14:04:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180328164813.GA3888@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>> Now only those architectures that have custom initrd free requirements
>>> need to define free_initrd_mem.
>> ...
>>> --- a/arch/arc/mm/init.c
>>> +++ b/arch/arc/mm/init.c
>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>  {
>>>  	free_initmem_default(-1);
>>>  }
>>> -
>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>> -{
>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>> -}
>>> -#endif
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 3f972e83909b..19d1c5594e2d 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -47,6 +47,7 @@ config ARM
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>
>> Isn't this why weak symbols were invented?
> 
> Weak symbols means that we end up with both the weakly-referenced code
> and the arch code in the kernel image.  That's fine if the weak code
> is small.

The kernel's been able to build with link time garbage collection since 2016:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d

Wouldn't that remove the unused one?

Rob

Return-Path: <keescook@google.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BDX043vSzF2LS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 03:55:12 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id x5so1785195vkd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 09:55:12 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 09:55:07 -0700
Message-ID: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Vladimir Murzin <vladimir.murzin@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Rob Herring <robh@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>, Rob Landley <rob@landley.net>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc <linux-parisc@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
>
> Signed-off-by: Shea Levy <shea@shealevy.com>

Yay consolidation! :)

> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>         default ".lzma" if RD_LZMA
>         default ".bz2"  if RD_BZIP2
>         default ""
> +
> +config HAVE_ARCH_FREE_INITRD_MEM
> +       bool
> +       default n

If you keep the Kconfig, you can leave off "default n", and I'd
suggest adding a help section just to describe what the per-arch
responsibilities are when select-ing the config. (See
HAVE_ARCH_SECCOMP_FILTER for an example.)

-Kees

-- 
Kees Cook
Pixel Security

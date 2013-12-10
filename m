Return-Path: <jonas.bonn@gmail.com>
Received: from mail-oa0-x235.google.com (mail-oa0-x235.google.com
 [IPv6:2607:f8b0:4003:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 966172C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 19:48:37 +1100 (EST)
Received: by mail-oa0-f53.google.com with SMTP id m1so5244605oag.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 00:48:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1385396045-15852-1-git-send-email-msalter@redhat.com>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
Date: Tue, 10 Dec 2013 09:48:34 +0100
Message-ID: <CACM3HyGCPMbw3t+DFFSySEytvDMnGGQMS6pVFpGbhkAoDzjhXg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Consolidate asm/fixmap.h files
From: Jonas Bonn <jonas.bonn@gmail.com>
To: Mark Salter <msalter@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
 James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 microblaze-uclinux@itee.uq.edu.au, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

Is there some reason you've excluded OpenRISC here?  Did you just miss
it, or does the implementation diverage too much to be usable with
your generic version?

Regards,
Jonas

On 25 November 2013 17:13, Mark Salter <msalter@redhat.com> wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.
>
> This has been compiled on x86, arm, powerpc, and sh, but tested
> on x86 only.
>
> This is version two of the patch series:
>
>    git://github.com/mosalter/linux.git#fixmap-v2
>
> Version 1 is here:
>
>    git://github.com/mosalter/linux.git#fixmap
>
> Changes from v1:
>
>   * Added acks from feedback.
>   * Use BUILD_BUG_ON in fix_to_virt()
>   * Fixed ARM patch to make FIXMAP_TOP inclusive of fixmap
>     range as is the case in the other architectures.
>
> Mark Salter (11):
>   Add generic fixmap.h
>   x86: use generic fixmap.h
>   arm: use generic fixmap.h
>   hexagon: use generic fixmap.h
>   metag: use generic fixmap.h
>   microblaze: use generic fixmap.h
>   mips: use generic fixmap.h
>   powerpc: use generic fixmap.h
>   sh: use generic fixmap.h
>   tile: use generic fixmap.h
>   um: use generic fixmap.h
>
>  arch/arm/include/asm/fixmap.h        | 29 +++--------
>  arch/arm/mm/init.c                   |  2 +-
>  arch/hexagon/include/asm/fixmap.h    | 40 +--------------
>  arch/metag/include/asm/fixmap.h      | 32 +-----------
>  arch/microblaze/include/asm/fixmap.h | 44 +---------------
>  arch/mips/include/asm/fixmap.h       | 33 +-----------
>  arch/powerpc/include/asm/fixmap.h    | 44 +---------------
>  arch/sh/include/asm/fixmap.h         | 39 +--------------
>  arch/tile/include/asm/fixmap.h       | 33 +-----------
>  arch/um/include/asm/fixmap.h         | 40 +--------------
>  arch/x86/include/asm/fixmap.h        | 59 +---------------------
>  include/asm-generic/fixmap.h         | 97 ++++++++++++++++++++++++++++++++++++
>  12 files changed, 118 insertions(+), 374 deletions(-)
>  create mode 100644 include/asm-generic/fixmap.h
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jonas Bonn
Stockholm, Sweden

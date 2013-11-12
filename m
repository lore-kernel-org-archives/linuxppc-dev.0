Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B46B2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 00:47:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 01/11] Add generic fixmap.h
Date: Tue, 12 Nov 2013 14:46:40 +0100
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <1384262545-20875-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1384262545-20875-2-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201311121446.40700.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 Michal Simek <monstr@monstr.eu>, James Hogan <james.hogan@imgtec.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, microblaze-uclinux@itee.uq.edu.au,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 12 November 2013, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.


Good idea, 

Acked-by: Arnd Bergmann <arnd@arndb.de>

On Tuesday 12 November 2013, Mark Salter wrote:
> +static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> +{
> +       /*
> +        * this branch gets completely eliminated after inlining,
> +        * except when someone tries to use fixaddr indices in an
> +        * illegal way. (such as mixing up address types or using
> +        * out-of-range indices).
> +        *
> +        * If it doesn't get removed, the linker will complain
> +        * loudly with a reasonably clear error message..
> +        */
> +       if (idx >= __end_of_fixed_addresses)
> +               __this_fixmap_does_not_exist();
> +

You might be able to turn this into the more readable BUILD_BUG_ON().

	Arnd

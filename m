Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFAEC31680
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 17:19:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E383C2085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 17:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E383C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jywW0FfDzDqRx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 04:19:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jytm6VBBzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 04:18:24 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id 81so21212272otj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 09:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EFqa7iDie4a4Ugk0nz5p3iJ9mNe61MmNiPA7yNETE+A=;
 b=WPWP8ye3mLF5q8H8D+r/qpn4pBImmRZx6nC4eYcpOD2V347fVVrMuSgOR8GRLDLn2x
 hJE9tXv99pnkSDO2vrQIOPrsUCcZkiL9YZnUNppNQyEvKiKBG/O52w9cuCXrh0eoz7eJ
 6THo0KGAdSKL1q3OrGBQjBW6djo2sATyO/lglCzRL3sqqC1sdj4ZVhuFNZVXhwmZTxWm
 l8hTtOiA+RPm7Mz40uxAXhtgiLW6HDXJvtoElfLwJl+is5bKxCH2xmgbU7zbq2WsZCTS
 z+NUT8aZmUpVeedpn34Ys2PLyj2bgjkm7+tb+lj1ZPz/CIHpEGk3JeT8Yl2hOlLRgr6w
 3wkQ==
X-Gm-Message-State: AJcUukd3ek2Fq4lkMHeyTftgShjkR97pOcMJ3GLzuf4EILXwcmKGTQl5
 YG4UyX21GZVWz35CGDepPA==
X-Google-Smtp-Source: ALg8bN5rbaU1m3gtFGToJ+cqBuFcMiOvNo70Mpy1u7fQlLuyqXRrBx7gRm33fEnKbPe17VBoWnrTEg==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr20338887otf.30.1548091102479; 
 Mon, 21 Jan 2019 09:18:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r1sm6393991oie.44.2019.01.21.09.18.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 09:18:21 -0800 (PST)
Date: Mon, 21 Jan 2019 11:18:21 -0600
From: Rob Herring <robh@kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Message-ID: <20190121171821.GA13557@bogus>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 10:04:06AM +0200, Mike Rapoport wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
> 
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
> 
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> + 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---
>  arch/alpha/kernel/core_cia.c              |  3 +++
>  arch/alpha/kernel/core_marvel.c           |  6 ++++++
>  arch/alpha/kernel/pci-noop.c              | 13 +++++++++++--
>  arch/alpha/kernel/pci.c                   | 11 ++++++++++-
>  arch/alpha/kernel/pci_iommu.c             | 12 ++++++++++++
>  arch/arc/mm/highmem.c                     |  4 ++++
>  arch/arm/kernel/setup.c                   |  6 ++++++
>  arch/arm/mm/mmu.c                         | 14 +++++++++++++-
>  arch/arm64/kernel/setup.c                 |  8 +++++---
>  arch/arm64/mm/kasan_init.c                | 10 ++++++++++
>  arch/c6x/mm/dma-coherent.c                |  4 ++++
>  arch/c6x/mm/init.c                        |  3 +++
>  arch/csky/mm/highmem.c                    |  5 +++++
>  arch/h8300/mm/init.c                      |  3 +++
>  arch/m68k/atari/stram.c                   |  4 ++++
>  arch/m68k/mm/init.c                       |  3 +++
>  arch/m68k/mm/mcfmmu.c                     |  6 ++++++
>  arch/m68k/mm/motorola.c                   |  9 +++++++++
>  arch/m68k/mm/sun3mmu.c                    |  6 ++++++
>  arch/m68k/sun3/sun3dvma.c                 |  3 +++
>  arch/microblaze/mm/init.c                 |  8 ++++++--
>  arch/mips/cavium-octeon/dma-octeon.c      |  3 +++
>  arch/mips/kernel/setup.c                  |  3 +++
>  arch/mips/kernel/traps.c                  |  3 +++
>  arch/mips/mm/init.c                       |  5 +++++
>  arch/nds32/mm/init.c                      | 12 ++++++++++++
>  arch/openrisc/mm/ioremap.c                |  8 ++++++--
>  arch/powerpc/kernel/dt_cpu_ftrs.c         |  5 +++++
>  arch/powerpc/kernel/pci_32.c              |  3 +++
>  arch/powerpc/kernel/setup-common.c        |  3 +++
>  arch/powerpc/kernel/setup_64.c            |  4 ++++
>  arch/powerpc/lib/alloc.c                  |  3 +++
>  arch/powerpc/mm/hash_utils_64.c           |  3 +++
>  arch/powerpc/mm/mmu_context_nohash.c      |  9 +++++++++
>  arch/powerpc/mm/pgtable-book3e.c          | 12 ++++++++++--
>  arch/powerpc/mm/pgtable-book3s64.c        |  3 +++
>  arch/powerpc/mm/pgtable-radix.c           |  9 ++++++++-
>  arch/powerpc/mm/ppc_mmu_32.c              |  3 +++
>  arch/powerpc/platforms/pasemi/iommu.c     |  3 +++
>  arch/powerpc/platforms/powermac/nvram.c   |  3 +++
>  arch/powerpc/platforms/powernv/opal.c     |  3 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
>  arch/powerpc/platforms/ps3/setup.c        |  3 +++
>  arch/powerpc/sysdev/msi_bitmap.c          |  3 +++
>  arch/s390/kernel/setup.c                  | 13 +++++++++++++
>  arch/s390/kernel/smp.c                    |  5 ++++-
>  arch/s390/kernel/topology.c               |  6 ++++++
>  arch/s390/numa/mode_emu.c                 |  3 +++
>  arch/s390/numa/numa.c                     |  6 +++++-
>  arch/sh/mm/init.c                         |  6 ++++++
>  arch/sh/mm/numa.c                         |  4 ++++
>  arch/um/drivers/net_kern.c                |  3 +++
>  arch/um/drivers/vector_kern.c             |  3 +++
>  arch/um/kernel/initrd.c                   |  2 ++
>  arch/um/kernel/mem.c                      | 16 ++++++++++++++++
>  arch/unicore32/kernel/setup.c             |  4 ++++
>  arch/unicore32/mm/mmu.c                   | 15 +++++++++++++--
>  arch/x86/kernel/acpi/boot.c               |  3 +++
>  arch/x86/kernel/apic/io_apic.c            |  5 +++++
>  arch/x86/kernel/e820.c                    |  3 +++
>  arch/x86/platform/olpc/olpc_dt.c          |  3 +++
>  arch/x86/xen/p2m.c                        | 11 +++++++++--
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++
>  drivers/clk/ti/clk.c                      |  3 +++
>  drivers/macintosh/smu.c                   |  3 +++
>  drivers/of/fdt.c                          |  8 +++++++-
>  drivers/of/unittest.c                     |  8 +++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/xen/swiotlb-xen.c                 |  7 +++++--
>  kernel/power/snapshot.c                   |  3 +++
>  lib/cpumask.c                             |  3 +++
>  mm/kasan/init.c                           | 10 ++++++++--
>  mm/sparse.c                               | 19 +++++++++++++++++--
>  73 files changed, 409 insertions(+), 28 deletions(-)

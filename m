Return-Path: <alex.bou9@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gYj00JzmzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 23:16:02 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id g141-v6so9221002ita.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 06:16:02 -0700 (PDT)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To: Christoph Hellwig <hch@infradead.org>, Alexei Colin <acolin@isi.edu>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>,
 John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
From: Alex Bounine <alex.bou9@gmail.com>
Message-ID: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
Date: Wed, 1 Aug 2018 09:15:57 -0400
MIME-Version: 1.0
In-Reply-To: <20180801095404.GA17585@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
> 
> As said before, please include it from drivers/Kconfig so that _all_
> architectures supporting PCI (or other Rapidio attachements) get it
> and not some arbitrary selection of architectures.
> 
As it was replied earlier this is not a random selection of 
architectures but only ones that implement support for RapidIO as system 
bus. If other architectures choose to adopt RapidIO we will include them 
as well.

On some platforms RapidIO can be the only system bus available replacing 
PCI/PCIe or RapidIO can coexist with PCIe.

As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or 
"Bus Support" (ARMs) sub-menu and from system configuration option it 
should be kept this way.

Current location of RAPIDIO configuration option is familiar to users of 
PowerPC and x86 platforms, and is similarly available in some ARM 
manufacturers kernel code trees.

drivers/Kconfig will be used for configuring drivers for peripheral 
RapidIO devices if/when such device drivers will be published.

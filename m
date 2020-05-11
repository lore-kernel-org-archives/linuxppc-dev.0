Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1DC47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 11:03:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203CE20736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 11:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203CE20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LJ2Q0nDfzDqQS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 21:03:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=catalin.marinas@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 49LHz56Zc2zDqfr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 21:00:27 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD751FB;
 Mon, 11 May 2020 04:00:24 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC143F305;
 Mon, 11 May 2020 04:00:20 -0700 (PDT)
Date: Mon, 11 May 2020 12:00:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/31] arm64: fix the flush_icache_range arguments in
 machine_kexec
Message-ID: <20200511110014.GA19176@gaia>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-3-hch@lst.de>
 <20200511075115.GA16134@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511075115.GA16134@willie-the-truck>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Roman Zippel <zippel@linux-m68k.org>, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
 james.morse@arm.com, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 11, 2020 at 08:51:15AM +0100, Will Deacon wrote:
> On Sun, May 10, 2020 at 09:54:41AM +0200, Christoph Hellwig wrote:
> > The second argument is the end "pointer", not the length.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/kernel/machine_kexec.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 8e9c924423b4e..a0b144cfaea71 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
> >  	 * the offline CPUs. Therefore, we must use the __* variant here.
> >  	 */
> >  	__flush_icache_range((uintptr_t)reboot_code_buffer,
> > +			     (uintptr_t)reboot_code_buffer +
> >  			     arm64_relocate_new_kernel_size);
> 
> Urgh, well spotted. It's annoyingly different from __flush_dcache_area().
> 
> But now I'm wondering what this code actually does... the loop condition
> in invalidate_icache_by_line works with 64-bit arithmetic, so we could
> spend a /very/ long time here afaict.

I think it goes through the loop only once. The 'b.lo' saves us here.
OTOH, there is no I-cache maintenance done.

> It's also a bit annoying that we do a bunch of redundant D-cache
> maintenance too. Should we use invalidate_icache_range() here instead?

Since we have the __flush_dcache_area() above it for cleaning to PoC, we
could use invalidate_icache_range() here. We probably didn't have this
function at the time, it was added for KVM (commit 4fee94736603cd6).

> (and why does that thing need to toggle uaccess)?

invalidate_icache_range() doesn't need to, it works on the kernel linear
map.

__flush_icache_range() doesn't need to either, that's a side-effect of
the fall-through implementation.

Anyway, I think Christoph's patch needs to go in with a fixes tag:

Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
Cc: <stable@vger.kernel.org> # 4.8.x-

and we'll change these functions/helpers going forward for arm64.

Happy to pick this up via the arm64 for-next/fixes branch.

-- 
Catalin

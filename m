Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD7C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 16:20:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E765D60EB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 16:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E765D60EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GfKpR2hsrz3cT1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 02:19:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=cmarinas@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GfKp46qK2z2yXh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Aug 2021 02:19:40 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2318260F8F;
 Tue,  3 Aug 2021 16:19:33 +0000 (UTC)
Date: Tue, 3 Aug 2021 17:19:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] arch: vdso: remove if-conditionals of
 $(c-gettimeofday-y)
Message-ID: <20210803161925.GC5786@arm.com>
References: <20210731060020.12913-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731060020.12913-1-masahiroy@kernel.org>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Russell King <linux@armlinux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-arm-kernel@lists.infradead.org, Andy Lutomirski <luto@kernel.org>,
 Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>,
 linux-riscv@lists.infradead.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jul 31, 2021 at 03:00:20PM +0900, Masahiro Yamada wrote:
> arm, arm64, csky, mips, powerpc always select GENERIC_GETTIMEOFDAY,
> hence $(gettimeofday-y) never becomes empty.
> 
> riscv conditionally selects GENERIC_GETTIMEOFDAY when MMU=y && 64BIT=y,
> but arch/riscv/kernel/vdso/vgettimeofday.o is built only under that
> condition. So, you can always define CFLAGS_vgettimeofday.o
> 
> Remove all the meaningless conditionals.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

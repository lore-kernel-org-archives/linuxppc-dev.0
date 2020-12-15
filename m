Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA26C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 14:22:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4E4224D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 14:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4E4224D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwL7T6YxfzDqQP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Dec 2020 01:22:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=elvis.franken.de (client-ip=193.175.24.41; helo=elvis.franken.de;
 envelope-from=tsbogend@alpha.franken.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=alpha.franken.de
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CwL3M4NXJzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2020 01:18:49 +1100 (AEDT)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kpBA4-0002PO-00; Tue, 15 Dec 2020 15:18:44 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 6A4DEC03B1; Tue, 15 Dec 2020 14:48:36 +0100 (CET)
Date: Tue, 15 Dec 2020 14:48:36 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/3] kbuild: LD_VERSION redenomination
Message-ID: <20201215134836.GA9946@alpha.franken.de>
References: <20201212165431.150750-1-masahiroy@kernel.org>
 <20201212165431.150750-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212165431.150750-2-masahiroy@kernel.org>
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
Cc: linux-kbuild@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhc@lemote.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 13, 2020 at 01:54:30AM +0900, Masahiro Yamada wrote:
> Commit ccbef1674a15 ("Kbuild, lto: add ld-version and ld-ifversion
> macros") introduced scripts/ld-version.sh for GCC LTO.
> 
> At that time, this script handled 5 version fields because GCC LTO
> needed the downstream binutils. (https://lkml.org/lkml/2014/4/8/272)
> 
> The code snippet from the submitted patch was as follows:
> 
>     # We need HJ Lu's Linux binutils because mainline binutils does not
>     # support mixing assembler and LTO code in the same ld -r object.
>     # XXX check if the gcc plugin ld is the expected one too
>     # XXX some Fedora binutils should also support it. How to check for that?
>     ifeq ($(call ld-ifversion,-ge,22710001,y),y)
>         ...
> 
> However, GCC LTO was not merged into the mainline after all.
> (https://lkml.org/lkml/2014/4/8/272)
> 
> So, the 4th and 5th fields were never used, and finally removed by
> commit 0d61ed17dd30 ("ld-version: Drop the 4th and 5th version
> components").
> 
> Since then, the last 4-digits returned by this script is always zeros.
> 
> Remove the meaningless last 4-digits. This makes the version format
> consistent with GCC_VERSION, CLANG_VERSION, LLD_VERSION.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/loongson64/Platform | 2 +-
>  arch/mips/vdso/Kconfig        | 2 +-

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

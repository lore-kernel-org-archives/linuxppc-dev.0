Return-Path: <SRS0=oOud=KJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C40C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 08:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF8661370
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 08:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF8661370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FhMhW0nVhz306j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 18:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FhMh61hqGz2yWt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 18:51:16 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14E8kuAV007787;
 Fri, 14 May 2021 03:46:56 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 14E8koYF007785;
 Fri, 14 May 2021 03:46:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 14 May 2021 03:46:49 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH kernel v3] powerpc/makefile: Do not redefine $(CPP) for
 preprocessor
Message-ID: <20210514084649.GI10366@gate.crashing.org>
References: <20210513115904.519912-1-aik@ozlabs.ru>
 <dedc7262-2956-37b2-ebfd-ae8eb9b56716@kernel.org>
 <CAK7LNASFhRE=1EBj9AoTMMEd2YJdu7bCxARAGJfZ7aXcBrMAUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASFhRE=1EBj9AoTMMEd2YJdu7bCxARAGJfZ7aXcBrMAUw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Fri, May 14, 2021 at 11:42:32AM +0900, Masahiro Yamada wrote:
> In my best guess, the reason why powerpc adding the endian flag to CPP
> is this line in arch/powerpc/kernel/vdso64/vdso64.lds.S
> 
> #ifdef __LITTLE_ENDIAN__
> OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
> #else
> OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
> #endif

Which is equivalent to

#ifdef __LITTLE_ENDIAN__
OUTPUT_FORMAT("elf64-powerpcle")
#else
OUTPUT_FORMAT("elf64-powerpc")
#endif

so please change that at the same time if you touch this :-)

> __LITTLE_ENDIAN__  is defined by powerpc gcc and clang.

This predefined macro is required by the newer ABIs, but all older
compilers have it as well.  _LITTLE_ENDIAN is not supported on all
platforms (but it is if your compiler targets Linux, which you cannot
necessarily rely on).  These macros are PowerPC-specific.

For GCC, for all targets, you can say
  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
You do not need any of the other *ORDER__ macros in most cases.
See "info cpp" for the sordid details.

> [2] powerpc-linux-gnu-gcc + -mlittle-endian    -> __LITTLE_ENDIAN__ is defined

You can just write -mbig and -mlittle btw.  Those aren't available on
all targets, but neither are the long-winded -m{big,little}-endian
option names.  Pet peeve, I know :-)

HtH,


Segher

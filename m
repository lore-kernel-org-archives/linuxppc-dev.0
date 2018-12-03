Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E5C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:08:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A89B20850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A89B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4383dp0T24zDqXl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 12:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4383Ww5xJfzDqbW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 12:03:24 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wB4138Lj002163;
 Mon, 3 Dec 2018 19:03:08 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wB3NOgsV026184;
 Mon, 3 Dec 2018 17:24:42 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 3 Dec 2018 17:24:41 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
Message-ID: <20181203232440.GB3803@gate.crashing.org>
References: <20181102004455.10157-1-joel@jms.id.au>
 <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
 <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
 <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jinsong Ji <jji@us.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 04, 2018 at 08:43:47AM +1030, Joel Stanley wrote:
> On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > > +# enabled. A future release of clang will resolve this
> > > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177

> > As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?
> 
> The developer gets something like this:
> 
> SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
> TargetConstant:i64<4823>, t146, t195
> fatal error: error in backend: Do not know how to split the result of
> this operator!
> clang-8: error: clang frontend command failed with exit code 70 (use
> -v to see invocation)

-msoft-float simply means not to use FPRs, and nothing more or less, so
that is a pretty interesting failure (will probably turn out to be a typo
or something else boring, but it is fun while it lasts).


Segher

Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5698C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 18:48:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC54B208C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 18:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZb7Xt/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC54B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JZW629hzzDr0V
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 04:48:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZb7Xt/l"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JZSK2HHMzDrCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 04:45:37 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id s18so868330wrn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uzb7erekU8g2iYVyP5gycVR/YMGgpJBA2pn7vNp581E=;
 b=JZb7Xt/l4fzTVyq93q6g8wGivNG1U7RglbzIf1zZBaafcZVV1Sf3O1e+CCrfxZGWAU
 QpMkYRRpANt4ruc23Ey5+H70EYPq2nm7buGcCdMD6vo/K3ZYREdZjfF8dbRc6l8bTWuU
 TjQJiasEYcfyQgmOcqadV0klVf/TtB3ZuMODVSMto3VdhZUdDMkWdYnbPfbHJYSRpXPC
 /CV1p+bC25/oYdeFfaofr7vDRQBrOLl71d8mjWBIuurGQjhA7O3N8cy6yi5n5gUYttbt
 uSX4Wz31KAdqWvF7Zaizgc7l0pkliJPNXocX8H0lwOPwYDpZECU4AD7Sy76br5JIbryk
 rnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uzb7erekU8g2iYVyP5gycVR/YMGgpJBA2pn7vNp581E=;
 b=N4gS3KqbZ4btjwnWdOA9YHgbI3XZQGiAJZhIELdBpe/o1O7wtAls6AFWWfxszxEhBc
 z7GxyFoeG83fFH8ZQb3yqO3ivEvVaCT+V+e7yDFFCvsbDBy2VNrR1ZonFfFhCBKkzvnq
 YfTNEjekzMk9Hd4L+Kz4Kbuh/Q1aI3tUByZCrYtCiQhoYAECuXNSH8aoOkKImvni9cv0
 UzyNdrQG5XJq/LLX7WHtuwx+v5zmn2gjNyW5uf7/x0YgXwohXBEfR0DE3M3X4gw/lZPf
 VRUmmn4z+kWsfuGQMYC3zEH919jhtwSby3Ot4Fzc179P/UJqXhoCyRO/VVnZ41xV3xtn
 3k2w==
X-Gm-Message-State: APjAAAVTyCOlCRTzc57tuSwPKreiSI1/4KYMC/KjjUwdaS3hyNuCj1r/
 ZoEtoDTf2i0M0WHlhx2AKTU=
X-Google-Smtp-Source: APXvYqzWvg1GBLeEX4emZimu3Krf58MHoihlarAwr3/DVkXxtPrZhV+yGFdEkV4Rbdn4ezwjfYwxjw==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr5917722wrq.137.1567017932509; 
 Wed, 28 Aug 2019 11:45:32 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id g65sm298385wma.21.2019.08.28.11.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 11:45:31 -0700 (PDT)
Date: Wed, 28 Aug 2019 11:45:29 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: Avoid clang warnings around setjmp and longjmp
Message-ID: <20190828184529.GC127646@archlinux-threadripper>
References: <20190812023214.107817-1-natechancellor@gmail.com>
 <878srdv206.fsf@mpe.ellerman.id.au>
 <20190828175322.GA121833@archlinux-threadripper>
 <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: LKML <linux-kernel@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 28, 2019 at 11:01:14AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 28, 2019 at 10:53 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Aug 28, 2019 at 11:43:53PM +1000, Michael Ellerman wrote:
> > > Nathan Chancellor <natechancellor@gmail.com> writes:
> > >
> > > > Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
> > > > setjmp is used") disabled -Wbuiltin-requires-header because of a warning
> > > > about the setjmp and longjmp declarations.
> > > >
> > > > r367387 in clang added another diagnostic around this, complaining that
> > > > there is no jmp_buf declaration.
> > > >
> > > > In file included from ../arch/powerpc/xmon/xmon.c:47:
> > > > ../arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
> > > > built-in function 'setjmp' requires the declaration of the 'jmp_buf'
> > > > type, commonly provided in the header <setjmp.h>.
> > > > [-Werror,-Wincomplete-setjmp-declaration]
> > > > extern long setjmp(long *);
> > > >             ^
> > > > ../arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of
> > > > built-in function 'longjmp' requires the declaration of the 'jmp_buf'
> > > > type, commonly provided in the header <setjmp.h>.
> > > > [-Werror,-Wincomplete-setjmp-declaration]
> > > > extern void longjmp(long *, long);
> > > >             ^
> > > > 2 errors generated.
> > > >
> > > > Take the same approach as the above commit by disabling the warning for
> > > > the same reason, we provide our own longjmp/setjmp function.
> > > >
> > > > Cc: stable@vger.kernel.org # 4.19+
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/625
> > > > Link: https://github.com/llvm/llvm-project/commit/3be25e79477db2d31ac46493d97eca8c20592b07
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >
> > > > It may be worth using -fno-builtin-setjmp and -fno-builtin-longjmp
> > > > instead as it makes it clear to clang that we are not using the builtin
> > > > longjmp and setjmp functions, which I think is why these warnings are
> > > > appearing (at least according to the commit that introduced this waring).
> > > >
> > > > Sample patch:
> > > > https://github.com/ClangBuiltLinux/linux/issues/625#issuecomment-519251372
> > >
> > > Couldn't we just add those flags to CFLAGS for the whole kernel? Rather
> > > than making them per-file.
> >
> > Yes, I don't think this would be unreasonable. Are you referring to the
> > cc-disable-warning flags or the -fno-builtin flags? I personally think
> > the -fno-builtin flags convey to clang what the kernel is intending to
> > do better than disabling the warnings outright.
> 
> The `-f` family of flags have dire implications for codegen, I'd
> really prefer we think long and hard before adding/removing them to
> suppress warnings.  I don't think it's a solution for this particular
> problem.

I am fine with whatever approach gets this warning fixed to the
maintainer's satisfaction...

However, I think that -fno-builtin-* would be appropriate here because
we are providing our own setjmp implementation, meaning clang should not
be trying to do anything with the builtin implementation like building a
declaration for it.

Cheers,
Nathan

Return-Path: <SRS0=Gjys=LP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B72C4743C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 11:55:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679D6112D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 11:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679D6112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G7nzc6DLDz3bs4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:55:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G7nzD0d4Dz2yYS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 21:55:34 +1000 (AEST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MderZ-1lMVw81T8b-00Zh7l for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun
 2021 13:55:29 +0200
Received: by mail-wm1-f43.google.com with SMTP id
 f16-20020a05600c1550b02901b00c1be4abso13683981wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 04:55:28 -0700 (PDT)
X-Gm-Message-State: AOAM5308L0mAxX1KrukdTjRi0Wxuad17fiJnCsNtjtSC2/tRAsdZWsIB
 QRRBVcDpVGKbMR86bdORnCFZsHylMpqrnWnv6bk=
X-Google-Smtp-Source: ABdhPJwhA2TM2PcFJQYCB+5Xx/XGY7m3KHuH6Z6RgJYL0awTBlZGuL5U6Qz/NGecGMIJ16WwJfYhY5QqBMGyQv9kk+c=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr26864111wmb.142.1624276527837; 
 Mon, 21 Jun 2021 04:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <202104031853.vDT0Qjqj-lkp@intel.com>
 <1624232938.d90brlmh3p.astroid@bobo.none>
 <e6167885-30e5-d149-bcde-3e9ad9f5d381@kernel.org>
 <87im273604.fsf@mpe.ellerman.id.au>
In-Reply-To: <87im273604.fsf@mpe.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jun 2021 13:53:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a37Pj24WqSvMKnwSS74W+WMAsmk+-kXX5qE7fCZ=QBL0g@mail.gmail.com>
Message-ID: <CAK8P3a37Pj24WqSvMKnwSS74W+WMAsmk+-kXX5qE7fCZ=QBL0g@mail.gmail.com>
Subject: Re: arch/powerpc/kvm/book3s_hv_nested.c:264:6: error: stack frame
 size of 2304 bytes in function 'kvmhv_enter_nested_guest'
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Sj7elJAEcMQsMbLHTmrzIrtorkcPzBaGPLGeZQRlu04BVgTkjqo
 MNgHDK/RUFhaIt/sAwKv8TzKk866GFc1vj6w4wPGf44PZAqys+OoNvdhzo/MJD+T6m4asut
 aVrFBCDEPlAbEgAw0oqVxcZQRUf1YBNtM81gr+Zi/ZQj3dtF7fT2xpp2xH5Jl03/4xqlaum
 xK1UVdV1IvG+WUXwFneKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVyn+I9hKuM=:VT9z647VTV0HrTiJ1dXeuv
 q5b2yeiN/sWLJgdsDOA7zL/lfw+Obpi5x7G+qTlxdzWXA80ycR+5+Q0PPSc7bPQRY1r0Fex3w
 gvbEzNMNA79dVSACffTpNpEUcAQeop4W6cYezDtc96wMEioS6tN9n4RkrYR0+bHL3FwyfNSfj
 2QUpLQT5Cj7mOaTnXElzMov2SZZU8betuahXlv7cSMJMI+QRKCRtfcJZaHx44ngjKGEqYyUgq
 pGbwXu7BaQvJOV6hg3trGAJEb5YzI5gMi9SDI9RWOwBJUHTrCS/eW+JzKAWRpTtrNewfPe+bn
 iLzGL+kQtcv4XWMANGGhkBJlW2zMwqg40q/OM+YJ6PwL3Loa4LI/OKXWPDqZwvJIrmWeAUKzd
 rget6AmI6BciinenHDAD8jBeofmaqWnHx0d/FPaidXavciHB6HjRcI71Wnq614GkcrrRtKzHQ
 sIJfo9FPjdp3v3bs2bBM63LXAsPwGf6L/3rHvEMF6mc0rYypE1JVTxa785odoCZNDSlzce5qY
 3/y58QOOpjWwa+Yl8vbYqI=
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
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 kvm-ppc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 21, 2021 at 11:46 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> > On 6/20/2021 4:59 PM, Nicholas Piggin wrote:
> >> Excerpts from kernel test robot's message of April 3, 2021 8:47 pm:
> >>>
> >>> vim +/kvmhv_enter_nested_guest +264 arch/powerpc/kvm/book3s_hv_nested.c
> >>
> >> Not much changed here recently. It's not that big a concern because it's
> >> only called in the KVM ioctl path, not in any deep IO paths or anything,
> >> and doesn't recurse. Might be a bit of inlining or stack spilling put it
> >> over the edge.
> >
> > It appears to be the fact that LLVM's PowerPC backend does not emit
> > efficient byteswap assembly:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/1292
> >
> > https://bugs.llvm.org/show_bug.cgi?id=49610
> >
> >> powerpc does make it an error though, would be good to avoid that so the
> >> robot doesn't keep tripping over.
> >
> > Marking byteswap_pt_regs as 'noinline_for_stack' drastically reduces the
> > stack usage. If that is an acceptable solution, I can send it along
> > tomorrow.
>
> Yeah that should be OK.

That's fine with me as well.

> Can you post the before/after disassembly when
> you post the patch?
>
> It should just be two extra function calls, which shouldn't be enough
> overhead to be measurable.

The thing I remember is that the 'before' code here is some seriously bad
output from llvm, and it would be helpful to have someone get the compiler
to emit the correct powerpc byteswap instructions and avoid the excessive
stack spilling.

The warning here is just a symptom of a missed optimization and the
same thing probably happens elsewhere on powerpc, even if it doesn't
exceed the stack warning limit.

        Arnd

Return-Path: <SRS0=S2bx=J6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F206C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 09:58:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569626120D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 09:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569626120D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FYdhy66byz30GR
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 19:58:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FYdhV6nwxz2xfx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 May 2021 19:58:17 +1000 (AEST)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mqro7-1lH90R3c4v-00mpaS for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 May
 2021 11:58:14 +0200
Received: by mail-wm1-f42.google.com with SMTP id g65so2973279wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 May 2021 02:58:14 -0700 (PDT)
X-Gm-Message-State: AOAM530GXnyKPrhvdyL9dlYQTryz3mDnUZZwQMcS7M7qhNL0Xxn+J6f5
 1QBYQmS3wuhBq9ZlOOI+NOB6+XhgngX1E3AungQ=
X-Google-Smtp-Source: ABdhPJwLwM4+7HWAumVwBVTy8mKR1bNlDKElkSrFM6JnoDhONvF95iiZ55DXUZCRZ5QgHthYE50RJYfEuqYwOiecy7Q=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr20474973wmk.43.1620035893994; 
 Mon, 03 May 2021 02:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210501151538.145449-1-masahiroy@kernel.org>
 <CANiq72k1hB3X6+Nc_iu=f=BoB-F9JW2j_B4ZMcv8_UpW5QQ2Og@mail.gmail.com>
 <3943bc020f6227c8801907317fc113aa13ad4bad.camel@perches.com>
 <20210502183030.GF10366@gate.crashing.org>
 <81a926a3bdb70debe3ae2b13655ea8d249fb9991.camel@perches.com>
 <20210502203253.GH10366@gate.crashing.org>
 <fcffe807353391339a03106f175ffa71377752b1.camel@perches.com>
 <20210503004457.GI10366@gate.crashing.org>
In-Reply-To: <20210503004457.GI10366@gate.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 3 May 2021 11:57:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19QJ_5tbbEq2f9=XKjVYUZcAy8QMvoM=8SNEdCnvmwyQ@mail.gmail.com>
Message-ID: <CAK8P3a19QJ_5tbbEq2f9=XKjVYUZcAy8QMvoM=8SNEdCnvmwyQ@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum GCC version to 5.2
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OqMtwTlwoTrKGolOe7poOjT1MPTosM+w7ptESghgt0TSDW0UdXV
 dih9vlchMK9LlhvG73uP6o7WPHa2T0L3oGYTMSuOm1LV4Dsr9jKXmLg99V9V7tI/OvSDtS2
 22Z0SN2PQ6jtTsLFcHTu7wwq/avYjiONPGPoofL/tiuzzNjTNOXTsflO+ZcEEc3BCDFaOOo
 CyhL8mnTK562iQWpraUwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L72nuIhcu2A=:cln3Kt8MRoz93cFWkJjz4r
 KleoqXPhlpiDK998vgp5WlBk5gwVB9GLdsB8YX6oVrhm1YVQVV+FTQ9+s5wGmJX6pyw02UHoe
 q+qIq+BAV6fQHAfNwIo+7WoKqIZd+9s9pu2h4WWHhWpoLTDIn2ho99xXUzY5HdBZXYWksUs06
 FZdRlZQi5QraiezaeNmhzU19po2BBFHvThPzSHwt0aQVA0Tr4mIVoggPR/wXmRa1ZPjy3yFBa
 h86udiVV3UZ5hia/zvK1PfMOyqaF2LZ5GYsSnMN04GftDoakV7bNchauCtfLJ6LxzAXjvAJ0Z
 qJivS4yFK44i70CUB7iq4lf+eXXlarTvgwlX/p/H4mGt8ifnx1JIT3tCgvCdPxRZ6fEf/t+4T
 1b/L+0Gs2d3n0ZYIMicuYKczg1CMfJXC2vHefI9ZAUAUVPrSrMFfe6+v2i+aqkHSOkrpNuqkb
 2HNXUQGtkS3YQFn4r22Y4w7Ni1GwGoKmsUeai3eoMJe71zzKcJCeihdBIpaGM1V33RC54YkeZ
 lyWNMYSR0SAdAxvNpr3dh5TMU03z7DincFieiiGCASWMgCVncRpzO3RUvwE/DiBU5Gr0NM6tK
 uC9+uFD8fAKIPQHsdv/24VZ+SOqxRBR+nCsnyXTi9ZSHFdkDo6FtEFC8MYZ8FHIL9smZdB70T
 2Vg4=
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
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Joe Perches <joe@perches.com>, Paul Mackerras <paulus@samba.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 3, 2021 at 2:44 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sun, May 02, 2021 at 02:23:01PM -0700, Joe Perches wrote:
> > On Sun, 2021-05-02 at 15:32 -0500, Segher Boessenkool wrote:
> > > On Sun, May 02, 2021 at 01:00:28PM -0700, Joe Perches wrote:
> > []
> > > > Perhaps 8 might be best as that has a __diag warning control mechanism.
> > >
> > > I have no idea what you mean?
> >
> > ? read the last bit of compiler-gcc.h
>
> Ah, you mean
> #pragma GCC diagnostic
> (which has existed since GCC 4.2).  Does anything in this __diag stuff
> require GCC 8?  Other than that this is hardcoded here :-)

The '8' was just a kernel thing, we made it configurable to have version
specific warnings, and I have a header file that adds these macros
for all supported compilers, but the version that is in mainline only does
it for gcc-8 or later.

Early compilers only supported "#pragma GCC diagnostic", but I think
even gcc-4.6 supported the _Pragma() syntax that lets you do it inside
of a macro.

It's something we should improve with plumbing on top, e.g. I want
a macro that lets you locally turn off both -Woverride-init on gcc
and -Winitializer-overrides on clang. It's not a reason to mandate
a newer compiler though.

        Arnd

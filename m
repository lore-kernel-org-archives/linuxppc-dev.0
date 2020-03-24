Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C64C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 03:22:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D77206F6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 03:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHtU7whO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D77206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mc544lbVzDqdk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::244;
 helo=mail-oi1-x244.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kHtU7whO; dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mc3H24HszDq9l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 14:21:14 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id p125so17131426oif.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lk9T4LRNmAXrRCA5JlX8sjxNr1G3pyzBcbbV9NarzSk=;
 b=kHtU7whOJHrBOqtdGQ+ScKNJvo38TWi1aRrPXihfpHGwwso15iRZVlpkJFDQN+1gjs
 71z3BFq8nXXfsiy+qs1aOdAD5h2RG4/ib8rX/vQJnjAqEUbtMjdXraR38BANUUvREdyM
 b+gNXkK+pD+Ob2cnsGMxFCc1YnYTKxjc31zPbby8kL/2ubC/9hZVl+2Y+Z1Qs/rFK7OU
 BYooj2evFjtK7t513t/buN8epdsthkYPWuZauO3mErWc1P0HuH2XJ8bPaYtNLXoUWejC
 +RDJwM1qkL+aH5KZQ+ak72f7nOf09H05eYg6X5qaAhggkppc5hmkxOL1VoGBwCRNS6/Z
 QTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lk9T4LRNmAXrRCA5JlX8sjxNr1G3pyzBcbbV9NarzSk=;
 b=ePpNsqdzkVtveygJjZPiNNmSbNSzt4b1+GPBu1TjpmQ78QmzCw86+PHXkH/2E9fwJj
 U1BMyjonBNjGlYXwDwRaNrDKJoQmD72S8jHk74z7glbfe7Hv/sEBUQIEX5+KtkdGHDkZ
 rOgtz4b5EKXBTQR9TjqZFL25a5ju/T1zpvE61mj5m+nGkEs0ZRAEE8MTlEVA9Y/vo47i
 x9tLQ+tpa+eVFjFOXZUOe0s/RTxcIjeVzLd3TD4CY1Zx4m0CTVvXl5PaMBm3epCvhRlb
 5/Nw7v1U1Pu/X6HgaHJwcCMebarqwSmImSqwhgz15wbdISZRIY6X4rzzMKFKGatyyWOT
 KeTw==
X-Gm-Message-State: ANhLgQ1l3tW6TXz9FMMh6wM9jDpPtEa4vwMZKZOiqTaKu8LF0EIs2S/P
 OP3HJZ4EZVrUy3fQW/iO+MgbLw62SIVnODjN/lE=
X-Google-Smtp-Source: ADFU+vsSskW+aFzz06iQTYne8VEZkIp8ReKaMZMyW8h3EbF2p6ad8YJsfsbyuwCugiqFCzXk223yrnTG1YMLEYTo6WI=
X-Received: by 2002:aca:d68a:: with SMTP id n132mr2044565oig.40.1585020072857; 
 Mon, 23 Mar 2020 20:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200320051809.24332-1-jniethe5@gmail.com>
 <20200320051809.24332-4-jniethe5@gmail.com>
 <1584944554.pe2tzckmyl.astroid@bobo.none>
 <CACzsE9qy7dUv+sbcCN-i0EeYiH=DacutULunpBdgV0h8D0m2yQ@mail.gmail.com>
 <1584956855.oidzv2r2fr.astroid@bobo.none> <87369yzces.fsf@mpe.ellerman.id.au>
In-Reply-To: <87369yzces.fsf@mpe.ellerman.id.au>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 24 Mar 2020 14:21:01 +1100
Message-ID: <CACzsE9pWWFvvN9QjGr5k7diLqGufgKFjbhu+61hMGsCwDWzLXQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] powerpc: Use a datatype for instructions
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Balamuruhan S <bala24@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 24, 2020 at 1:58 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nicholas Piggin <npiggin@gmail.com> writes:
> > Jordan Niethe's on March 23, 2020 7:28 pm:
> >> On Mon, Mar 23, 2020 at 5:27 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >>> Jordan Niethe's on March 20, 2020 3:17 pm:
> >>> > Currently unsigned ints are used to represent instructions on powerpc.
> >>> > This has worked well as instructions have always been 4 byte words.
> >>> > However, a future ISA version will introduce some changes to
> >>> > instructions that mean this scheme will no longer work as well. This
> >>> > change is Prefixed Instructions. A prefixed instruction is made up of a
> >>> > word prefix followed by a word suffix to make an 8 byte double word
> >>> > instruction. No matter the endianess of the system the prefix always
> >>> > comes first. Prefixed instructions are only planned for powerpc64.
> >>> >
> >>> > Introduce a ppc_inst type to represent both prefixed and word
> >>> > instructions on powerpc64 while keeping it possible to exclusively have
> >>> > word instructions on powerpc32, A latter patch will expand the type to
> >>> > include prefixed instructions but for now just typedef it to a u32.
> >>> >
> >>> > Later patches will introduce helper functions and macros for
> >>> > manipulating the instructions so that powerpc64 and powerpc32 might
> >>> > maintain separate type definitions.
> >>>
> >>> ppc_inst_t I would slightly prefer for a typedef like this.
> >> Are _t types meant to be reserved?
> >
> > No, just convention that structs are not normally typedefed unless
> > they are a pervasive interface that gets passed around a lot but
> > does not get accessed without accessor functions much. When you do
> > typedef them, add a _t (or less frequently _s/_u/etc). pte_t,
> > cpumask_t, atomic_t.
>
> Ideally we wouldn't use a typedef, we'd just have:
>
> struct ppc_inst {
>         u32 val;
> #ifdef CONFIG_PPC64
>         u32 suffix;
> #endif
> };
>
> That may make the conversion harder though, because you more or less
> have to update all usages at once.
Okay I will give that a try.
>
> cheers

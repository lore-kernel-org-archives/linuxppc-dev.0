Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D6C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 02:05:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E895F611C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 02:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E895F611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H90m93TjZz3051
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 12:05:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XkrIPrRz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b30;
 helo=mail-yb1-xb30.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=XkrIPrRz; dkim-atps=neutral
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H90lM0sVsz2xXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2021 12:04:46 +1000 (AEST)
Received: by mail-yb1-xb30.google.com with SMTP id y13so9818086ybi.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tz6piMeU5SmaffRbNmnfnHu1gxXBC9YCGjCvKu8dEbk=;
 b=XkrIPrRzEz2KMMyLG5dI7T+y/swRc8XV0Khbp57pyuTJX1Nz53Sy5wYFxxasrmPF+W
 XWX4DCY05NF0GjPvXZ7Ep35ASUa9bHnP+CiwvErWytJWGYSp+uEb3kahqmCSwe8eks3k
 hNvCuVF9Hrf0lJBsPeORLejCy7RsF2K5fwMf4v0o0FuhpX/k/i8/yFhv4S936uYarThx
 s57VeJJ0vlnR4Lv9n9XZHyx7v6C8YXOAFY7mBHQqKmybfx/9OxwiGmoBRvL9hbWgBn62
 Q21W/Elc3EZWmj52qEGdeHVUotFvcdY1knESEwSSod+16kOQ6XuSDFQjnJgafr2AnxmF
 ToTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tz6piMeU5SmaffRbNmnfnHu1gxXBC9YCGjCvKu8dEbk=;
 b=CDfvWD6a9DZkMqcEtGHsIcG+qSkjoOCfdnUq6p73bkxsnN5sttENEXPnnLdj/miTDF
 VcWAFhLsQI5C39i/newtV+iUXCD6qjfFNVE7kj0D7kzvAm6/uiKGAY+dr8V1AQ4RAxae
 RLOWZf0tvfaSPjA1wspx+CqVCJm25izodx+ANmoJzCReZB855xKcL2zoL/+Denpgf3XF
 z4CC0/tedmtWbw1iMNCd3TB5hPKsV62RgbdyiTBzCrw/J0DLhgRJsWys1odkAry1unTm
 r5HwR4lXj5rRUaG6OiXq7jkzeL3/616d5hlcB3Hk8UCY+ZHgUqSqvu1ymNijMiODkslV
 hceQ==
X-Gm-Message-State: AOAM530xwhj7f9m5WURHelDtq5L5AoDfe/WfUUqWe6PDUfgSGdFHCzGH
 S5Dn33kKm+wNOJ49NJDOjtsl/atyg5rWziXCVDU=
X-Google-Smtp-Source: ABdhPJx72GnacP9xthd9U/wXYrT459EEqrVhb1oa3QdSt9K3KHRK7tf+FRk49IS71Z/jfNvAPJl53stO99zV+UfTWBs=
X-Received: by 2002:a5b:f43:: with SMTP id y3mr3940004ybr.45.1631757882872;
 Wed, 15 Sep 2021 19:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACzsE9qr6QK_Xm6yVXT061sxR9SXaeFx5fkjiNAXFBFr6WDQOw@mail.gmail.com>
 <CEAW7GNXW96H.18ANPMC01JA2C@wrwlf0000>
In-Reply-To: <CEAW7GNXW96H.18ANPMC01JA2C@wrwlf0000>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Thu, 16 Sep 2021 12:04:31 +1000
Message-ID: <CACzsE9qmjABva6-RB5HVciB7tJ-XdD2=-cLFoxjh5UG9fyOJNg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] powerpc/64s: Initialize and use a temporary mm for
 patching on Radix
To: "Christopher M. Riedl" <cmr@bluescreens.de>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-hardening@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 16, 2021 at 10:40 AM Christopher M. Riedl
<cmr@bluescreens.de> wrote:
>
> On Tue Sep 14, 2021 at 11:24 PM CDT, Jordan Niethe wrote:
> > On Sat, Sep 11, 2021 at 12:39 PM Christopher M. Riedl
> > <cmr@bluescreens.de> wrote:
> > > ...
> > > +/*
> > > + * This can be called for kernel text or a module.
> > > + */
> > > +static int map_patch_mm(const void *addr, struct patch_mapping *patch_mapping)
> > > +{
> > > +       struct page *page;
> > > +       struct mm_struct *patching_mm = __this_cpu_read(cpu_patching_mm);
> > > +       unsigned long patching_addr = __this_cpu_read(cpu_patching_addr);
> > > +
> > > +       if (is_vmalloc_or_module_addr(addr))
> > > +               page = vmalloc_to_page(addr);
> > > +       else
> > > +               page = virt_to_page(addr);
> > > +
> > > +       patch_mapping->ptep = get_locked_pte(patching_mm, patching_addr,
> > > +                                            &patch_mapping->ptl);
> > > +       if (unlikely(!patch_mapping->ptep)) {
> > > +               pr_warn("map patch: failed to allocate pte for patching\n");
> > > +               return -1;
> > > +       }
> > > +
> > > +       set_pte_at(patching_mm, patching_addr, patch_mapping->ptep,
> > > +                  pte_mkdirty(mk_pte(page, PAGE_KERNEL)));
> >
> > I think because switch_mm_irqs_off() will not necessarily have a
> > barrier so a ptesync would be needed.
> > A spurious fault here from __patch_instruction() would not be handled
> > correctly.
>
> Sorry I don't quite follow - can you explain this to me in a bit more
> detail?

radix__set_pte_at() skips calling ptesync as an optimization.
If there is no ordering between changing the pte and then accessing
the page with __patch_instruction(), a spurious fault could be raised.
I think such a fault would end up being causing bad_kernel_fault() ->
true and would not be fixed up.

I thought there might be a barrier in switch_mm_irqs_off() that would
provide this ordering but afaics that is not always the case.

So I think that we need to have a ptesync after set_pte_at().

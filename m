Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF786C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 22:22:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ADB2084C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 22:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t05Y81Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ADB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cZ3v2rHgzDqtm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 09:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::c43; helo=mail-yw1-xc43.google.com;
 envelope-from=shakeelb@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="t05Y81Bu"; 
 dkim-atps=neutral
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cQjC1mn8zDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 03:50:55 +1100 (AEDT)
Received: by mail-yw1-xc43.google.com with SMTP id b63so7043823ywc.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
 b=t05Y81BuMZSuJ3Qf03/s29f5cEJAeohwbr5hZJc2RrcPRO6eHvSCEwsoBZ8TncZdL9
 PmSFv57lPf98jmd7DJUXckoKesFwgGPp40VY4Gblne/wQyqG/r/MqToljc9zsCz0qxKp
 aRnm5M1tt5gMo/vHEU2zJp8W2o3GF8OgA4ajXs0FGG40PWe6hFw+ca4OkI60pLBD3kWB
 2n2BGWP7tzRyD26c8OTdhD2D0L1F4/eMN6vCzDo06ugdYINGlLUAp76YatbfknmKYRpH
 RxNfLgU6S5LVmaxnqLCcIX5XK4x4ZS2dNEqHJe3KNImCAkYzyXEhDG7xdyu1Mm9rEMYB
 k3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
 b=cZRpo/+C5L9zVdwNhjc+H5QhRQmXdKj7tyaGd0s6q0VWWm+DuMnXlXmfImjW0A2hLf
 IPg7ic2vN/RRL4LZREI6DlqwnxKJtuMcBLSdiCi10bUzjVJITQnbqUYBwtA7gY3a4JeP
 gLJlKygeGxBsG0dKNQ4APd8SMXAib37BZWOt/oZ5DztQ8xw7Tq5jXV3W22TCHyy/69eC
 /nQmOpIMETg4B3BeTnz+5qdr3Dbt24xxAMt2gh6W3M9Ji3oL6+ww0mNX47qzsAj7vzfJ
 JXHd7vKz+Yq535WEUEJD29Lll8mZyDCPjuPWtuiaEKoQSl9l9IMXB6P9OCrw7XJihedH
 jVmw==
X-Gm-Message-State: AJcUukfwkg+/jF5LwFwSCc/4q5wjaBbjrmu2G/kTBDCDkzAjISdBA1ve
 6R6Sb8CJocZz5QWe+9asTHt+8IH4qsEB3HtzQlCKsg==
X-Google-Smtp-Source: ALg8bN6XzD17LVLAX7m/kSOcIUQ121Lu7vVxRfY/g+CIrLDeBR87sI3stQrULnEovy6QxqBn0V1BYoxbhWieErSfFEc=
X-Received: by 2002:a81:60c4:: with SMTP id
 u187mr18077076ywb.345.1547311853069; 
 Sat, 12 Jan 2019 08:50:53 -0800 (PST)
MIME-Version: 1.0
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Sat, 12 Jan 2019 08:50:42 -0800
Message-ID: <CALvZod5XfFujzzMC0n2dZmofjof0juWw45RF4475CAEu9nAv3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 13 Jan 2019 09:19:27 +1100
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
Cc: mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
 linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, will.deacon@arm.com,
 christoffer.dall@arm.com, Linux MM <linux-mm@kvack.org>,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 LKML <linux-kernel@vger.kernel.org>, james.morse@arm.com,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 7:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> > As far as I can see,
> >
> > #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> >
> > So what's the difference between:
> >
> > (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> >
> > and
> >
> > (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
>
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
>
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Can you explain a bit more on this? If this is too low priority on
your todo list then maybe me or someone else can pick that up.

Shakeel

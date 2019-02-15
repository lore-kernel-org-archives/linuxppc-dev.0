Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:25:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88020449
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IgpPjbHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415sQ68qczDqdl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:24:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="IgpPjbHn"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415pM0RfXzDqdl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:22:02 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id x131so20992367itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bENZSOHQuuyZX8td+MBYMAPFZ9vn8Em32e4eV7PH+2s=;
 b=IgpPjbHncM74sjCqKCzlzvz4wS0BWXmOIt+XL2LbAUus4B1bfu0+l0dO5cAs0eBbfD
 rU7Qdrpn2m08sqtY9hLZU0Zu3oheCwI0LayZ6zPsWzMG9RS5LTYycXckNxGU0/WHTH7h
 RPR0kJ0nGNmSWH8PgyVdkQ2Zs5M8V+/pWEPmKhiVaKeUB06ubekBhMmcPrkGJXmjlEOb
 GitB7MpfLgohOuLzIKrgp/YdOXi8FNCAxZ8RnqWJLr9LZbOIlNYdZxm/6GY4DPR4FOE2
 N93hfKpNwzutq0j/EWLsUFczHyLHWEaDHqcH3D/j4rY9zBzw8XRviacOeNxxkBoqivjK
 FAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bENZSOHQuuyZX8td+MBYMAPFZ9vn8Em32e4eV7PH+2s=;
 b=dBC3ZJ6IZRo/40SpcPG3GzHmQ8lzd9FIcwPYjWuI9hRRcHQBKHRcVKYrTULbl0DtGF
 9QBcBi62D6OjE9YHqR6RVkgkJJisLRPsKiungp4G6Ccv1B41GVSWV9FXfK5CWSpGyUkK
 I/3pxxoTfaJHkFLjO46FE98Gg/Z8/aZvqWAB7695uaix8PHa0rbvvTL6PTjSH6izfuPU
 RLnNl2qi8dFehxmhdH+iIJTcwRuRysD6fWto45vo/JMIGGZ30HjyM+g0eWh7SVV4TgPY
 hZH9wtx4zNyF6Fz95Y0S5J5jVkyjWdvWRpZcyeM/TFAxb2P+9JhDIXMvtGOsuUMrymSD
 4zLQ==
X-Gm-Message-State: AHQUAuYytK91Is2YSE4Q5qzUArokp3XN7dBgw5ibCjcgx4Tf3y18Z0uT
 C5XMXZuxBeokeO1Tq8cqHSQpItro4txbh0K07ek8hQ==
X-Google-Smtp-Source: AHgI3IZsXus+UZx5mDrDyuY4vkHl527zxVxgWDFVS9S0/pNQ3+ROakITIfMJXKu9fbAb19cMPY6frLAsUr+oNvOf1Dk=
X-Received: by 2002:a24:7351:: with SMTP id y78mr4274509itb.12.1550218920345; 
 Fri, 15 Feb 2019 00:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-2-dja@axtens.net>
 <f155a38b-c6ab-7825-71e2-15709f9410f6@au1.ibm.com>
In-Reply-To: <f155a38b-c6ab-7825-71e2-15709f9410f6@au1.ibm.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 15 Feb 2019 09:21:48 +0100
Message-ID: <CACT4Y+Yy8DLaKNXKUqKYCJSULTtBE_WNoHGxF0CnpCHKxD5Lrg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] kasan: do not open-code addr_has_shadow
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 1:12 AM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
>
> On 15/2/19 11:04 am, Daniel Axtens wrote:
> > We have a couple of places checking for the existence of a shadow
> > mapping for an address by open-coding the inverse of the check in
> > addr_has_shadow.
> >
> > Replace the open-coded versions with the helper. This will be
> > needed in future to allow architectures to override the layout
> > of the shadow mapping.
> >
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> > ---
> >   mm/kasan/generic.c | 3 +--
> >   mm/kasan/tags.c    | 3 +--
> >   2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index ccb6207276e3..ffc64a9a97a5 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -173,8 +173,7 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
> >       if (unlikely(size == 0))
> >               return;
> >
> > -     if (unlikely((void *)addr <
> > -             kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > +     if (unlikely(!addr_has_shadow((void *)addr))) {
> >               kasan_report(addr, size, write, ret_ip);
> >               return;
> >       }
> > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > index 0777649e07c4..bc759f8f1c67 100644
> > --- a/mm/kasan/tags.c
> > +++ b/mm/kasan/tags.c
> > @@ -109,8 +109,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
> >               return;
> >
> >       untagged_addr = reset_tag((const void *)addr);
> > -     if (unlikely(untagged_addr <
> > -                     kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > +     if (unlikely(!addr_has_shadow(untagged_addr))) {
> >               kasan_report(addr, size, write, ret_ip);
> >               return;
> >       }
> >
>
> --
> Andrew Donnellan              OzLabs, ADL Canberra
> andrew.donnellan@au1.ibm.com  IBM Australia Limited
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/f155a38b-c6ab-7825-71e2-15709f9410f6%40au1.ibm.com.
> For more options, visit https://groups.google.com/d/optout.

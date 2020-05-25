Return-Path: <SRS0=r5XJ=7H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC146C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 06:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC95206D5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 06:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehQSl2w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC95206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Vmnn2RdBzDqD8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2020 16:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::244;
 helo=mail-lj1-x244.google.com; envelope-from=jrdr.linux@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ehQSl2w9; dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Vmll3cKDzDqQZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2020 16:05:07 +1000 (AEST)
Received: by mail-lj1-x244.google.com with SMTP id a25so7795419ljp.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2020 23:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yBEIyGoELaaD+alubGuUtHR8SFOTBJNSGDV1DmXECiU=;
 b=ehQSl2w9nY5dfRV6wriDcpTZGCg4P5IKERzl8jgDRtg3uhpkzAwd3ER92Qp5OiHoL/
 +MhqCnu8zW56GE60KkTpJ3oxdAr6etM08OheP4CCIkAn/xtpCdIWN8MBUnqveJ5A4gLK
 RxkTpS7YVbBXUhcNkQ0TNE9KA9K4ocnXhAr9Xa3XG9LmJrZ/GQj5cA/ExPP8Fd98XPTh
 m6maZFzKLWQYjHH2rRA/tj3ZfnY7463WV62NMrjiV1kJ8DIfE1/EJlw3GwWSPvhUcvDT
 16JRko4weBL9UUlbBUdoncQNMaTcFehwoljIqIq6/MYZcwy7q9UKtzsmUWudXb5uw850
 eMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yBEIyGoELaaD+alubGuUtHR8SFOTBJNSGDV1DmXECiU=;
 b=T3XbD9EGditXOs1MtCUysiWS7YsfxhuctZ/sY+7JYkkv+0/1fxkSZgXTG7qNFwNjAu
 yi2mQ1rfBUmqvC1g0T+g0MGtwyZQ3lsdLpPAvhQ5GcFMDhgMRIixEGDSt0UV8Tc7Usrz
 0WzMBLlcit53GUNid48cwdJyBXnWPVg9L/b53Sm5ZQSp5NNJbtYaobGXo4OavVVCaZgF
 iDh8eDRchLuS31xXXVg6GVlmuJGC5OcVQT9D8UfUdzuqstbRRhU7kQG8PRsqplNWNGIC
 aYX+fUTBuJK8Zzxc/1oDBQjoar1K+2BUAtjg6bI26fQydFhXpyCA9s8i2P0wAXm/DGEJ
 6Ckg==
X-Gm-Message-State: AOAM532UkxZ3h6HO959SPieaT5kvZXQHbbpt0W59RAkf2gBYqYTKFH7W
 e5vRN48i5t1fxUAzoMirmHkx036bdq++IebZGhU=
X-Google-Smtp-Source: ABdhPJwOO/TJa9JhhYdJXPau2E/wFjjcMVGycTDzEnfXyjgQyMTqifURPEuLOUykpugkn4KaOaj319Yr0zMyHaEJvV8=
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr12277083ljm.70.1590386703464; 
 Sun, 24 May 2020 23:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <1590294434-19125-1-git-send-email-jrdr.linux@gmail.com>
 <c70dc7fa-352d-9f61-abb9-d578072978c9@nvidia.com>
In-Reply-To: <c70dc7fa-352d-9f61-abb9-d578072978c9@nvidia.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 25 May 2020 11:43:08 +0530
Message-ID: <CAFqt6zbYbnbc9VHsOJu8J5QFGqSksHVyWF+bD3JqHhxaFeG2Tg@mail.gmail.com>
Subject: Re: [linux-next RFC v2] mm/gup.c: Convert to use
 get_user_{page|pages}_fast_only()
To: John Hubbard <jhubbard@nvidia.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 jolsa@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, msuchanek@suse.de, kvm-ppc@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, pbonzini@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 25, 2020 at 6:36 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-23 21:27, Souptick Joarder wrote:
> > API __get_user_pages_fast() renamed to get_user_pages_fast_only()
> > to align with pin_user_pages_fast_only().
> >
> > As part of this we will get rid of write parameter. Instead caller
> > will pass FOLL_WRITE to get_user_pages_fast_only(). This will not
> > change any existing functionality of the API.
> >
> > All the callers are changed to pass FOLL_WRITE.
>
> This looks good. A few nits below, but with those fixed, feel free to
> add:
>
>      Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
> >
> > There are few places where 1 is passed to 2nd parameter of
> > __get_user_pages_fast() and return value is checked for 1
> > like [1]. Those are replaced with new inline
> > get_user_page_fast_only().
> >
> > [1] if (__get_user_pages_fast(hva, 1, 1, &page) == 1)
> >
>
> We try to avoid talking *too* much about the previous version of
> the code. Just enough. So, instead of the above two paragraphs,
> I'd compress it down to:
>
> Also: introduce get_user_page_fast_only(), and use it in a few
> places that hard-code nr_pages to 1.
>
> ...
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 93d93bd..8d4597f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1817,10 +1817,16 @@ extern int mprotect_fixup(struct vm_area_struct *vma,
> >   /*
> >    * doesn't attempt to fault and will return short.
> >    */
> > -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> > -                       struct page **pages);
> > +int get_user_pages_fast_only(unsigned long start, int nr_pages,
> > +                     unsigned int gup_flags, struct page **pages);
>
> Silly nit:
>
> Can you please leave the original indentation in place? I don't normally
> comment about this, but I like the original indentation better, and it matches
> the pin_user_pages_fast() below, too.
>
> ...
> > @@ -2786,8 +2792,8 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
> >    * If the architecture does not support this function, simply return with no
> >    * pages pinned.
> >    */
> > -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> > -                       struct page **pages)
> > +int get_user_pages_fast_only(unsigned long start, int nr_pages,
> > +                     unsigned int gup_flags, struct page **pages)
>
>
> Same thing here: you've changed the original indentation, which was (arguably, but
> to my mind anyway) more readable, and for no reason. It still would have fit within
> 80 cols.
>
> I'm sure it's a perfect 50/50 mix of people who prefer either indentation style, and
> so for brand new code, I'll remain silent, as long as it is consistent with either
> itself and/or the surrounding code. But changing it back and forth is a bit
> aggravating, and best avoided. :)

Ok, along with these changes I will remove the *RFC* tag and repost it.

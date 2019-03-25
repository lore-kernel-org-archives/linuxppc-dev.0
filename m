Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1ACC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690E220863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZDbQf6wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690E220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SgG91ftTzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 03:49:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="ZDbQf6wF"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sg9g5thZzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 03:45:27 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id w30so11061068qta.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=azszLIWADnCz8AeAgm8+58HpL8DqZnCAWctdIVFE5Zo=;
 b=ZDbQf6wFJU+EYUfgK208d7q5xgEAsedfDWsH7HcS+TgxZe1Tssa2BPdsAG2/hwMAys
 rsvWpbV2F4p94YwmKTFIuX4ZYCNds18YVeb5XKR3N/q/IwU3EkNwJcTVzYn6EDh7fZln
 2OZxPHIHWfFGj7YZXdyCqHS05W2dh7149lXSg4/ukEQUMHL7D7Y6NtaabG2aYj9KasxM
 PHuOzwzg4iM4288xlpCX0Y7+myHdwiQDA5aQ9iytY8LSSCnI+uBbm/mNp75vQ71uvTOh
 1u0QcVedoEpv2k/lmslIikFO/JBL2Dw9XFQLEa1MLkr1UZsADEa008jT8NGlhOraW5UW
 A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=azszLIWADnCz8AeAgm8+58HpL8DqZnCAWctdIVFE5Zo=;
 b=fFWBlYQb5lR7R3nI4JtzjucnAOsP5/Y/SN213Iqf5GtC42Y96xzS9iC8EZQ+EhdIL/
 xDxWdJpmkXoHvYEyLG11rN10a2xKsX2JnYpJfqCDg/HooaGVHtRveEjO/kdXBoECvoHs
 m9mVJI//v687/E3rKnaQxz9WSuNMfRzB7FGEqHRgLwGxWY+ZW50RLwPUWbBLPromipnj
 ieFaPGqV7fQkBHLEiI6dLnB5tueeVqsNiDcQAp+hIsj9sapux7swfX+y9SYOLlWjgNoZ
 l4g38vqVwr4dBuUXa1m9Rwy+Rz6kUQhId0NyP/geqtjRaBcmT+4oFqeeEP4t7YjzDmPo
 /miw==
X-Gm-Message-State: APjAAAUDwOsJpfVh3fhjbyaUAbsbOy8zN1YoID8Tk96ZXWnA5fhvxIDn
 TKlOX+NzOAx1Nu0EOlyMBee9CQ2jOoD4h6JFLFTEGw==
X-Google-Smtp-Source: APXvYqwyqN1SmdoxO8BNg708b3bvqvBy5e7BsLNFvrI9L6R6ElZeTlrOFSa7GssTU28fSAH0U/YXsNRayrnRchybewU=
X-Received: by 2002:ac8:2396:: with SMTP id q22mr22096706qtq.382.1553532323693; 
 Mon, 25 Mar 2019 09:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-2-ira.weiny@intel.com>
 <CAA9_cmffz1VBOJ0ykBtcj+hiznn-kbbuotu1uUhPiJtXiFjJXg@mail.gmail.com>
 <20190325061941.GA16366@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190325061941.GA16366@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Mar 2019 09:45:12 -0700
Message-ID: <CAPcyv4hPxoX1+u=fjzCeVYOd9Bck9d=A9SQ-mjzeMA2tf9B9dA@mail.gmail.com>
Subject: Re: [RESEND 1/7] mm/gup: Replace get_user_pages_longterm() with
 FOLL_LONGTERM
To: Ira Weiny <ira.weiny@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 linux-mips@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 7:21 AM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
> > > @@ -1268,10 +1246,14 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
> > >                                 putback_movable_pages(&cma_page_list);
> > >                 }
> > >                 /*
> > > -                * We did migrate all the pages, Try to get the page references again
> > > -                * migrating any new CMA pages which we failed to isolate earlier.
> > > +                * We did migrate all the pages, Try to get the page references
> > > +                * again migrating any new CMA pages which we failed to isolate
> > > +                * earlier.
> > >                  */
> > > -               nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
> > > +               nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
> > > +                                                  pages, vmas, NULL,
> > > +                                                  gup_flags);
> > > +
> >
> > Why did this need to change to __get_user_pages_locked?
>
> __get_uer_pages_locked() is now the "internal call" for get_user_pages.
>
> Technically it did not _have_ to change but there is no need to call
> get_user_pages() again because the FOLL_TOUCH flags is already set.  Also this
> call then matches the __get_user_pages_locked() which was called on the pages
> we migrated from.  Mostly this keeps the code "symmetrical" in that we called
> __get_user_pages_locked() on the pages we are migrating from and the same call
> on the pages we migrated to.
>
> While the change here looks funny I think the final code is better.

Agree, but I think that either needs to be noted in the changelog so
it's not a surprise, or moved to a follow-on cleanup patch.

Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 21:32:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F69621900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 21:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH8NebHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F69621900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QxhF4vHvzDqSg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 08:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OH8NebHD"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QxfK2ffzzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 08:30:48 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id e24so5773747itl.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wgnh9GZfm6qdLmvZgnj3r3+BNlXkGOKn5T8ZaWKJok0=;
 b=OH8NebHDunzRV5JGQub2VtJ7qq4h4earirMR6lyAD1tbndqgaSQo6EHAFa1XOmj0Gs
 dVcO4mHB+I8Gzjx2PQQrJytnVorWQ136649AIwDqb+OrY0aZhZe/CAiDgikXseWKBQG2
 FkOiYPQ3ReZiCpOVfobxEopPeTsjWAbW4arVQm7GeTBum/QFo7st3RTKFW/k4BUo6iKi
 qqrOWnIunmKP+BcjLSDh5OjjWDpxn9ZH3R47GB9vvFeHXdgr8SGbrbJmFBbpxMtnf7r8
 gcRkEbTPG+V6sm+ujH2atRnCWCKSY69YXpLKQ3Gjo/8PWZNT9d+9uu3qs6PBsKPI7PrA
 gBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wgnh9GZfm6qdLmvZgnj3r3+BNlXkGOKn5T8ZaWKJok0=;
 b=ZE9Ab7zqm2FfLXUYfCOy6+Z+AK1+wtBd3Ms9DVpWb44h8ChAmTJ6N/CgsrfRNIjMK4
 ZJXwXlM70rufg/VRcEJMtuZN3PrVBUjM1zcSgi96NfQIRDv9A1TbSBCFRGx0s6TV6Xzk
 OTKDHnoKhHDr2OgB0EsYpsHpbljsCslMjxlbTRw2lvii2wIwKwHqdry76OsbZW2tVMe9
 H40BI/wBGgph9yModxDjEtgovjYiA80YYVmCy4C26Xoj3OluNU8K7wQZCJ7LfPWJQNT7
 OTlI5gwqgp55OAwSRIJs3EZmDunDyZxRRypypAf+bmQy584IlF09+tQ4Q0wJDVNAsQNw
 UIMQ==
X-Gm-Message-State: APjAAAXq9FTSzHPiOST7ZOC+HT6kk3nXtQ0JzlMWH3GFlMQ2iPHkWR/4
 WJS/kV+qZsADkQp4+ZznScuZ9ww9gAjyAJneTJ8=
X-Google-Smtp-Source: APXvYqwmWYd90xIyw8yRh2ooXx60Z7HEDF1dbzChi7O8iR8by0Ikm8lKRK2GZFAQJ/A+sEyAwZAwm0xNODtGjD6Sum4=
X-Received: by 2002:a24:21d5:: with SMTP id e204mr910352ita.56.1553290247101; 
 Fri, 22 Mar 2019 14:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-3-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-3-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@gmail.com>
Date: Fri, 22 Mar 2019 14:30:35 -0700
Message-ID: <CAA9_cmcs+kUMA=j2UYwSRpEo+NMktTv5Od73fS-E9wxVr_v43g@mail.gmail.com>
Subject: Re: [RESEND 2/7] mm/gup: Change write parameter to flags in fast walk
To: ira.weiny@intel.com
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> In order to support more options in the GUP fast walk, change
> the write parameter to flags throughout the call stack.
>
> This patch does not change functionality and passes FOLL_WRITE
> where write was previously used.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

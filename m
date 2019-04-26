Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E5C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:35:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A37206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yxMG00XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A37206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qw7847k9zDqf3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:35:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="yxMG00XR"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qw5K4BmFzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 10:33:19 +1000 (AEST)
Received: by mail-oi1-x243.google.com with SMTP id l203so1602594oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=husfLeAUYRUpmyxx/IOBfWRF88c+2Bw6W/zLaIXEA5s=;
 b=yxMG00XRw8W8gPUsSvOidLXP7LF3BedxzpWzi1PTS4ri+eYU8v80sONYvSsjtJM2GW
 wFTOb6JqEVuH7DzSurkgHYEdEr3Q5zeBmpl84g+jca74K1GKrF7Xor93CJEIvFdldwmq
 En26Ux164dU7E+aT12PHHdcVIAIvrnsPs17DGqKrKxLJbHi8/eWFI24goDhTUHKiGjmm
 uJr1VWdSaFqAnpl3ZmXcYvoGsODlF/zfcC/FgybwVBvOqVGSOyFep/PP9tb1hDt/wcgX
 ZtyPCD8w+mPd1oiSGTqPEpbwpi4lxpVcmZZ7m6genkJjL6QG8Qx2OhHahDQqhdSOK6jn
 gwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=husfLeAUYRUpmyxx/IOBfWRF88c+2Bw6W/zLaIXEA5s=;
 b=nc49Pp7iJbAzCOzNwfmVzxWGIN0WQy2ETXWqzoSNgdaJlcjGkWyk4NqiRwte5Ssdjx
 zDygy39SZZoJMSkxXP9psPiaEcYw4ykYfAAzuBbQtZxgGsEfu+bSlx9srNq9buJyuPEx
 kB8B0yhPScR+xdZsUGc1VhqkSrtayPhLsHxvCM+3AUhaa3hHXNtA3A9RPRadj+/VktXJ
 mkrOB/XY23o2xA4RFpCXWuP7JuHflYpLOt50SOIRlVKDhgq97iFf1QW26KYzK3IKgtA7
 XMPWQGOr7etD5pI8k80DozvboPU5B+np1OCF8ikxJvqlzhoYPc/YlytAzGiywG8+Z82+
 9Ybg==
X-Gm-Message-State: APjAAAVbaC3zaK2Bs43EltyS+A8HbNVeu9qXgf5kdyKZFoOSXFjhMfer
 AChF+5huWeINRId3AUnn+EiZkVy+q6GM9W9CG7XKJg==
X-Google-Smtp-Source: APXvYqw1+ZJvz+ZxUUyq0eqW43gC2WMrQ8d3BXIt3dl9j88+0wZGDtOHhjZNKsuCANGX8D3bycXuRTYIAelS2XRy3HE=
X-Received: by 2002:aca:e64f:: with SMTP id d76mr5550827oih.105.1556238795714; 
 Thu, 25 Apr 2019 17:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
 <20190424173833.GE19031@bombadil.infradead.org>
 <CAPcyv4gLGUa69svQnwjvruALZ0ChqUJZHQJ1Mt_Cjr1Jh_6vbQ@mail.gmail.com>
 <20190425073149.GA21215@quack2.suse.cz>
In-Reply-To: <20190425073149.GA21215@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Apr 2019 17:33:04 -0700
Message-ID: <CAPcyv4iYMP4NWxa08zTdRxtc4UcbFFOCwbMZijB0bc2WcawggQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
To: Jan Kara <jack@suse.cz>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Matthew Wilcox <willy@infradead.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 25, 2019 at 12:32 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 24-04-19 11:13:48, Dan Williams wrote:
> > On Wed, Apr 24, 2019 at 10:38 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Apr 24, 2019 at 10:13:15AM -0700, Dan Williams wrote:
> > > > I think unaligned addresses have always been passed to
> > > > vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
> > > > the only change needed is the following, thoughts?
> > > >
> > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > index ca0671d55aa6..82aee9a87efa 100644
> > > > --- a/fs/dax.c
> > > > +++ b/fs/dax.c
> > > > @@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> > > > vm_fault *vmf, pfn_t *pfnp,
> > > >                 }
> > > >
> > > >                 trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> > > > -               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
> > > > +               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
> > > >                                             write);
> > >
> > > We also call vmf_insert_pfn_pmd() in dax_insert_pfn_mkwrite() -- does
> > > that need to change too?
> >
> > It wasn't clear to me that it was a problem. I think that one already
> > happens to be pmd-aligned.
>
> Why would it need to be? The address is taken from vmf->address and that's
> set up in __handle_mm_fault() like .address = address & PAGE_MASK. So I
> don't see anything forcing PMD alignment of the virtual address...

True. So now I'm wondering if the masking should be done internal to
the routine. Given it's prefixed vmf_ it seems to imply the api is
prepared to take raw 'struct vm_fault' parameters. I think I'll go
that route unless someone sees a reason to require the caller to
handle this responsibility.

Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B535C10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:35:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26047217D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Occ+ZVvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26047217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qPWZ6CPGzDqdL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:35:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="Occ+ZVvn"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qPTb22K5zDqW6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 14:34:04 +1000 (AEST)
Received: by mail-oi1-x243.google.com with SMTP id a6so16121173oie.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jJtlgM+LwfAvNu2EDOj4s3A18h6lrPGqDuRQRlrYCbc=;
 b=Occ+ZVvnra0nOKbAXzS/qYzJINSE/JVG8Gm5SbhA3iX31jg0J/gz91Hh7K4tzFENwo
 7ZNjfnL0zwM7Fie5yIU2/mGcD5/Rx5LNy1kREspLapy+AWMB9zWO5O3uin8BAjpDZmah
 K/uSqWRZz1EhT9WzAyyDEOW4/VFjSAsFoC/yBvWRHB8cVVABJbBDZnBxK9BzXLHQzsSr
 5bQwW4tn5dvOnhHmoTpCGYBdc8OfjLHTf8ekfo+O6k9byftz+zs1L6QaW+97Tp95mdw9
 w/jJuFE7b64TJXdR9mUgeImjxKCS31YpCOSYHGlFhCCTKwhABoy50ex+7HRCHA+gpGh9
 R+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jJtlgM+LwfAvNu2EDOj4s3A18h6lrPGqDuRQRlrYCbc=;
 b=KckSmfkBurRZbGlF9glaSFAIZol45zsoFO7WobD3yNKmG6f4BzYmbCb0oeAp/apwWS
 ihLxmgsVWizJLPv4HsEwPQmSBxY7m5y5pvvGFf6rqIR8Nn3eKyJbZq1mcs5QeRNItChk
 8i3hx876XwvdD7cCpNLrT2CAKVMQAYZGCx86JGwOfSuYplCDufVEQLHCzFc+dg1koIJF
 MUjDn9nKbK9Qcv6FkZLKV1TOxwtZDmwRpn8kgHDvqXkquhoTI4pkroSr8RsMS1AVq0W/
 75Wn9xnjOW4zbcAGm/7s7ov38Z97EPVsjPOaF+bAXopo2ZRyUbH3NJUr2TM3fxpzD8DI
 /v2g==
X-Gm-Message-State: APjAAAUB6VXy6tJKyi8anC+ipKiW0iHmPY1dNySzauLFZr5vnmwJviJO
 eZQ/hwm/CYR4WvJ664cqnx80Xwb//Prat3zIWCFTLw==
X-Google-Smtp-Source: APXvYqx4X1rED4ag/iCBqdoQfuMFALGSYZtppDpW7HxJZCfMthGgpn5KlRxa9nhY2r/51Mm2aPykjEFyhXiur/X1vYc=
X-Received: by 2002:aca:d513:: with SMTP id m19mr1852513oig.73.1556166840821; 
 Wed, 24 Apr 2019 21:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
 <20190424173833.GE19031@bombadil.infradead.org>
 <CAPcyv4gLGUa69svQnwjvruALZ0ChqUJZHQJ1Mt_Cjr1Jh_6vbQ@mail.gmail.com>
 <444ca26b-ec38-ae4b-512b-7e915c575098@linux.ibm.com>
In-Reply-To: <444ca26b-ec38-ae4b-512b-7e915c575098@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Apr 2019 21:33:49 -0700
Message-ID: <CAPcyv4isw_qht_BGUmTcawLD4YYFQVztF1EAn_m8WHKHZcbphw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Matthew Wilcox <willy@infradead.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 6:37 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 4/24/19 11:43 PM, Dan Williams wrote:
> > On Wed, Apr 24, 2019 at 10:38 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Wed, Apr 24, 2019 at 10:13:15AM -0700, Dan Williams wrote:
> >>> I think unaligned addresses have always been passed to
> >>> vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
> >>> the only change needed is the following, thoughts?
> >>>
> >>> diff --git a/fs/dax.c b/fs/dax.c
> >>> index ca0671d55aa6..82aee9a87efa 100644
> >>> --- a/fs/dax.c
> >>> +++ b/fs/dax.c
> >>> @@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> >>> vm_fault *vmf, pfn_t *pfnp,
> >>>                  }
> >>>
> >>>                  trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> >>> -               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
> >>> +               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
> >>>                                              write);
> >>
> >> We also call vmf_insert_pfn_pmd() in dax_insert_pfn_mkwrite() -- does
> >> that need to change too?
> >
> > It wasn't clear to me that it was a problem. I think that one already
> > happens to be pmd-aligned.
> >
>
> How about vmf_insert_pfn_pud()?

That is currently not used by fsdax, only devdax, but it does seem
that it passes the unaligned fault address rather than the pud aligned
address. I'll add that to the proposed fix.

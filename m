Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E61C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F59E21900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gXnr/LKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F59E21900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qyfv4CzzzDqVh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 09:16:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="gXnr/LKc"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qycv458yzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 09:14:39 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id z126so5869304itd.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wm2+IDsr0NmRaIQ9GIimbnBiutoAYhXqklaChAdkC0E=;
 b=gXnr/LKcmO3n/AkDnk5tuJJz0sD52kdAC51zKOFpz9IFbfbYifTLF6ymlYbHKb1Fzf
 5IK9kzfgRjlOjG8rPf/pLCcCoxWGCDHkfS90S+LKj3jcXm5xQYa13eJcPAUZ+hXohZjm
 IBPo+8GJ+Rq8y+Q+kI7lVQj+zb+PR7I30rOlJksrdJy/Wp2dqUTjZA9F3vGG+ezwSQtN
 Rd0g5Hf0LyHnnPkTMRnIAwxLFm25gMxn56/wKPSlCPteP5nwXO0eAhs4klJ0MxT6YP2e
 dxwI2R6VEa8rmJFaL4xGk5paDuSdBggXv21lLkD4qtLHBeTsgNPI61yo109FsRi4r0QQ
 8DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wm2+IDsr0NmRaIQ9GIimbnBiutoAYhXqklaChAdkC0E=;
 b=UjHJW5sls7NbNm6o8uLyvzTcjrBc3eHMfzwMhDd/ZzHcACjduchQ7RH6WZAQWnymaN
 N4gO5hF0n4/jCIBzZQHpkcWn9SIU+7qAHFzmt1tCUFNzgf3doGV80luEGkD+qASKKnC8
 9cPtiF5ZmLpbpOSn86HXlGX0JYItR63RK1OumkqD+rKIJTif++LWVL0fYtKH3iSo+pIl
 8J/K4jJUte7p1acddAk/NmKZzx6sqOqLC3iYnckj97C86QLvqnhALfhKqeIFtXEye1Va
 gkoXzOpPSXPnSfXV2G3XgKcdIOpHLhYA1MuAX7NwUDOEVYi8IyuXroV0uPT7ZkZVOz/o
 RdQg==
X-Gm-Message-State: APjAAAV4p1npDEO0YU6kZy+DKxyCmdvZWSd+o9KoVI4qpf070l8feHVM
 Z4U14EABpclLAk6qX/P/DsejljbEqfGlbQZfCCAy+YPwoXcLhQ==
X-Google-Smtp-Source: APXvYqwIoaHTQX3ElVQKOchmDlJSSWqTKG84OsYpQvQY0PG83rmTkoixgVtLY+vkXQxXTMX8UIfgiVFJTO08ZCVWvdY=
X-Received: by 2002:a24:411f:: with SMTP id x31mr3120456ita.169.1553292877426; 
 Fri, 22 Mar 2019 15:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-6-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-6-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Mar 2019 15:14:26 -0700
Message-ID: <CAA9_cmdQjMekSFU09gLc87-PVx2iHeeh2jC6KeFY1UeadpPh4A@mail.gmail.com>
Subject: Re: [RESEND 5/7] IB/hfi1: Use the new FOLL_LONGTERM flag to
 get_user_pages_fast()
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
> Use the new FOLL_LONGTERM to get_user_pages_fast() to protect against
> FS DAX pages being mapped.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/user_pages.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
> index 78ccacaf97d0..6a7f9cd5a94e 100644
> --- a/drivers/infiniband/hw/hfi1/user_pages.c
> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
> @@ -104,9 +104,11 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>                             bool writable, struct page **pages)
>  {
>         int ret;
> +       unsigned int gup_flags = writable ? FOLL_WRITE : 0;

Maybe:

    unsigned int gup_flags = FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);

?

>
> -       ret = get_user_pages_fast(vaddr, npages, writable ? FOLL_WRITE : 0,
> -                                 pages);
> +       gup_flags |= FOLL_LONGTERM;
> +
> +       ret = get_user_pages_fast(vaddr, npages, gup_flags, pages);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.20.1
>

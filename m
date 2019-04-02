Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:09:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988D22082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4eR2Tw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988D22082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YJhV431FzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:09:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="C4eR2Tw5"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YJfg19CLzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:08:10 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id f22so3247702ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AGo5oTI2Yfj7Uhl2QLHbccss+tDPjaUu5FzxEc5YqE=;
 b=C4eR2Tw5sXCjH8eJKkVQd3ET5lU3Hm0j7L5H1VLvrXwjI+Bz23NL8yeWu4pKlxfMRb
 VPmlIRowurSL+d0xERO7IqvlrDr/mjvQv/ssiiSLbO/w3bQ+foW3e4lowNwSqhb29TQj
 MFAc933oR19KnnCeqtXbUvhulFbTYAtcj1uaoaKdtrcQRiAKPhQFsbjNbx3EnIwI7fTL
 JiM2490hva+DT+cjTgDhqFod4YoPWPsDAGWPAgZMTCvwDzecO+AhviMcxzY0qGjFyTqG
 A5nR6ZHeQuzAj9JGhluse37flAruN3bJoCBe6FTtigjnsA3TB6Zu6eNwh0c5mIr2CnVc
 KPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AGo5oTI2Yfj7Uhl2QLHbccss+tDPjaUu5FzxEc5YqE=;
 b=dcIE/zeE6qTGsAokJ11VpbwRkz6peRsenyTBXhjUJgsrDsc061425lbVjtkDV9951f
 xpfGA2vw8ow5FNDUe9odjOf8al+YHILQw3/Xl4FVm2HSlWIyuVfBYuB8mgaEo32+QccU
 4b5ve315tx6CpDHNovJEjIEjoxFpoXKwTgC83AGxdgT0m9mREmqtfG3yN4oiL0abL295
 gBqyuDfqtVob+7T6YMATn6M/emhKKJFdb0iwyH5wOM4aWMmW462zu60G+Y8jh+UtuG+k
 dS3i90EzWEUwPrFZtPPmdYXK5MiREb9R1CsMuAB3cJsMAGADmBEQcQDjYytHae/CVe/0
 b9Pg==
X-Gm-Message-State: APjAAAUqvs91FWDfnBKJPeeSAaXPUnz7MoRisXnyvDL+C22PV8uVgyiv
 KpnfLbAf8wv/6rzQzRrIbcg+OtYW4vf50Esp4Lw=
X-Google-Smtp-Source: APXvYqz9EYfqtjcbZH24cRXOInatM2RF6K4Z1G380ozqptjE5/UXnJxZELiKFWI5H7X8oaGFwSOVFW8lvfeBZs7LvZw=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr2504143itb.107.1554185287199; 
 Mon, 01 Apr 2019 23:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190315005420.20212-1-jniethe5@gmail.com>
In-Reply-To: <20190315005420.20212-1-jniethe5@gmail.com>
From: Oliver <oohall@gmail.com>
Date: Tue, 2 Apr 2019 17:07:55 +1100
Message-ID: <CAOSf1CFfhoTzmvOHrQG6zrpLs4L92F9Mnyw7Muuyi8Py-TAuLw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Add mmap to opal export sysfs nodes
To: Jordan Niethe <jniethe5@gmail.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 11:55 AM Jordan Niethe <jniethe5@gmail.com> wrote:
>
> The sysfs nodes created under /opal/exports/ do not currently support
> mmap. Skiboot trace buffers are not yet added to this location but
> this is a suitable for them to be exported to. Adding mmap support makes
> using these trace buffers more convenient. The state in the header of
> the trace buffer is needed to ensure the read position has not been
> overwritten. Thus the header of the buffer must be read, then the
> read position itself. Using lseek/read to do this introduces a delay
> that could result in incorrect reads if the read position is overwritten
> after the header is read.
>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2b0eca104f86..3cfc683bb060 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -714,6 +714,15 @@ static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
>                                        bin_attr->size);
>  }
>
> +static int export_attr_mmap(struct file *fp, struct kobject *kobj,
> +                               struct bin_attribute *attr,
> +                               struct vm_area_struct *vma)
> +{
> +       return remap_pfn_range(vma, vma->vm_start,
> +                               __pa(attr->private) >> PAGE_SHIFT,
> +                               attr->size, PAGE_READONLY);
> +}
> +
>  /*
>   * opal_export_attrs: creates a sysfs node for each property listed in
>   * the device-tree under /ibm,opal/firmware/exports/
> @@ -759,6 +768,7 @@ static void opal_export_attrs(void)
>                 attr->attr.name = kstrdup(prop->name, GFP_KERNEL);
>                 attr->attr.mode = 0400;
>                 attr->read = export_attr_read;
> +               attr->mmap = export_attr_mmap;

You are assuming that it's safe to allow the export to be mmap()ed
here and that's not always the case. e.g.

[16:56 oliveroh@localhost .../firmware/exports]$ lsprop
symbol_map       00000000 30125640 00000000 0003598d
hdat_map         00000000 31200000 00000000 00800000
phandle          100002e8 (268436200)
name             "exports"

The symbol_map export there does not start (or end) at a page
boundary. If you allow user programs to mmap() that export it will
make everything from 0x30120000 to 0x30160000 and the additional space
might contain internal firmware data structures that we'd rather not
allow userspace to access.You can protect against that by validating
the export starts and ends on a page boundary and only populating the
.mmap when it's safe to do so.

>                 attr->private = __va(vals[0]);
>                 attr->size = vals[1];
>
> --
> 2.20.1
>

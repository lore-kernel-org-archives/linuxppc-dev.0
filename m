Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74698C4332D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 20:37:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B892072C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOuV7mgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B892072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jzHP4vLbzDrQy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 07:37:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=pankaj.gupta.linux@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=KOuV7mgf; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jsnf1bKczDrPC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 03:29:58 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id o12so3344640wrh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dUjkv/1kdxAPc8FvGXSwJvqVlpdlMdd7sScfjZuLtXU=;
 b=KOuV7mgfPxa5BS7QM1EmpVKHl+utg3R1NuD+eghOx5tCnKmaPuHRVXjvk7ETGC7+IH
 pWrSjx5ZFJvHZf44R+FxNhYQeCT5QW+rQ4hPqVWEYiBB13CMSgH3RlgZseLHIeM1bG2l
 1obkvh3OhbRF8Mk7ezjkpUNYtcONq6/QkjHI3j/LQhbXuFNPvr+ozb6qq6d7/OoORL65
 flbWD6QSUtjzo8zmFjsywEco3MosobFFfwQQ/QEi9RDyxPZkUizLDlfsgEoBkxyn28FZ
 T+rxTDp7rTvNrrva4WA9EN5sBtyDWyGY0mu7exVkkA3+j062YpuZVJfNb//An6i8J7Dg
 Q10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dUjkv/1kdxAPc8FvGXSwJvqVlpdlMdd7sScfjZuLtXU=;
 b=VSYR4isjO6eWYpMzqfnd4YZrZc2VVX1Wgt+zqsR+ZyHR2yT5+6U3hDQMR7l9puPrPq
 O2gAyr+hecevPbwjwIDI5zGafyzSQJdMmJWuwwDL0pYJQlZEoiGu6X0wO/9uOPxJG3u2
 7RO2T5L6vB9EbGzgOZlFVHpysnJZWiNgl+wIgUdJFM14NUwkc1mJrX6nSKC/wbFABNCo
 XPe3myjb+yxpSOmPkcpVDYsYg5bh4GAY7BEoJTHYBSpMmaPD+xGwp7XdrHRKuqvWk55J
 brCKrMnt57dy/7Ktzghx7Q4o3QvOdhsmW/vhPTF6dkoo29fh502XzdRPCy6pyXv8fCvh
 Rohw==
X-Gm-Message-State: ANhLgQ0iOUYVw+JkQjK9j6rs+/9LymSQlblGUnPRHNrW6AMv59hIdHNf
 X8UzttagBFTX8Wlie08fmka4ZoTDHqshUaToOrs=
X-Google-Smtp-Source: ADFU+vvErlZUbjGMAWaIpw3qbv9beB1N3R3kHK0bJH6Z7AaZmsMVBHwa/EoutXRVLGkwpqQKNDNT9RewnuF5ANVC4ms=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr5298504wrt.107.1584635395363; 
 Thu, 19 Mar 2020 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com>
 <20200319131221.14044-3-david@redhat.com>
In-Reply-To: <20200319131221.14044-3-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 19 Mar 2020 17:29:44 +0100
Message-ID: <CAM9Jb+heQ+Z_Hx5F-0vGLWfc4gxQRzh7am-gw+gGTJxn-7kyZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] drivers/base/memory: map MMOP_OFFLINE to 0
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 Mar 2020 07:34:17 +1100
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
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Historically, we used the value -1. Just treat 0 as the special
> case now. Clarify a comment (which was wrong, when we come via
> device_online() the first time, the online_type would have been 0 /
> MEM_ONLINE). The default is now always MMOP_OFFLINE. This removes the
> last user of the manual "-1", which didn't use the enum value.
>
> This is a preparation to use the online_type as an array index.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          | 11 ++++-------
>  include/linux/memory_hotplug.h |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8c5ce42c0fc3..e7e77cafef80 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -211,17 +211,14 @@ static int memory_subsys_online(struct device *dev)
>                 return 0;
>
>         /*
> -        * If we are called from state_store(), online_type will be
> -        * set >= 0 Otherwise we were called from the device online
> -        * attribute and need to set the online_type.
> +        * When called via device_online() without configuring the online_type,
> +        * we want to default to MMOP_ONLINE.
>          */
> -       if (mem->online_type < 0)
> +       if (mem->online_type == MMOP_OFFLINE)
>                 mem->online_type = MMOP_ONLINE;
>
>         ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> -
> -       /* clear online_type */
> -       mem->online_type = -1;
> +       mem->online_type = MMOP_OFFLINE;
>
>         return ret;
>  }
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3aaf00db224c..76f3c617a8ab 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -48,7 +48,7 @@ enum {
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
>         /* Offline the memory. */
> -       MMOP_OFFLINE = -1,
> +       MMOP_OFFLINE = 0,
>         /* Online the memory. Zone depends, see default_zone_for_pfn(). */
>         MMOP_ONLINE,
>         /* Online the memory to ZONE_NORMAL. */
> --
> 2.24.1

Looks good to me.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>
>

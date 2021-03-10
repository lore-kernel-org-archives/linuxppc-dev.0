Return-Path: <SRS0=GP0G=II=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:44:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5681464DAF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5681464DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DwRwz6x26z3dX0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 20:44:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=christian.brauner@canonical.com; receiver=<UNKNOWN>)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DwRlL0jQJz3bPT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 20:35:41 +1100 (AEDT)
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.brauner@canonical.com>) id 1lJvFj-00086e-11
 for linuxppc-dev@lists.ozlabs.org; Wed, 10 Mar 2021 09:35:39 +0000
Received: by mail-ed1-f70.google.com with SMTP id p12so8073209edw.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 01:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ftVdUr9F7AHKavJWsV/WnPi5WDLeKje7PJ4qiKh1hck=;
 b=aAUmSp7LLy9kpxNxYpubfAizB00Tpp1X5QF+DxMrtmLTPYx6Lm8GmHW+hy3yHCcaQU
 2HUnEYqJm/DW6qu8/9cEIQVzHYx8lSFRQqx3CYipr3B3CAPSFCIdekDEHhYSE/xpif58
 GcEhcULgy8+pFRi+nEYz36rHaE59XCfIvVrj0GIfIDrQVBdn5DunCWPkvQrL5HbtgOdw
 FGuIXVzrC1oFbmSpfma0y8N0VJkb7wP6SnBS0pVcZf3eLPFKQNGtap3Nztra93TkHabk
 nEoWSXR5A1s7mOfmEwChYBB5p7kEz5XqrY+H5EzCU9SB3yEz21Ouu7BpUczDn+nxJOHj
 ySvQ==
X-Gm-Message-State: AOAM5304PTGXUTWEkbic/4NfZ0pg8wDvbdhaTZBF839yPkS3pyE1d8ZC
 2JXoywJhQKOSAYsxhorFjZPll0nxsb15Stlh1AcC7u17MCG3Cf+BVb0HbR1i57p0Dba+d5T+Na9
 QWsqm/OIFgmNuj5N2e2GR9O42NEP4rSfUrLZWbVU0kKQ=
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231932edt.249.1615368938785; 
 Wed, 10 Mar 2021 01:35:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKM4jWVMgAtlSQkiU252tjiKuhRmDMSNYvDzZOnsMhIIvOmtcr+xfyqFDOCgMHfGsUcv8k2Q==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231923edt.249.1615368938641; 
 Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de.
 [95.90.240.160])
 by smtp.gmail.com with ESMTPSA id dg26sm10364101edb.88.2021.03.10.01.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Date: Wed, 10 Mar 2021 10:35:37 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Message-ID: <20210310093537.7azjgcywllkda7lg@gmail.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
X-Mailman-Approved-At: Wed, 10 Mar 2021 20:42:36 +1100
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Minchan Kim <minchan@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Nadav Amit <namit@vmware.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 09, 2021 at 04:53:41PM +0100, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0EAC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678B8222D0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OexzxhmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678B8222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440G4p2z3pzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="OexzxhmP"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440FdF0bYNzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:11:12 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so1956005pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+hxE9i2LXNTz12oXWns34FZR2YhTG4F31i4IBVFK/io=;
 b=OexzxhmPQPLB/5GuvN/TPNOSfFrVu8unoCJCiEobEFwb5nW131NFCPSWYfd/vVLTI8
 SHNqFEBZ4+taALRUNix76ejXHUUaDEd/+CY/Bj28I0B1kwcpBv6Js1Sbrrk3W4v4aWf1
 R/tYyZTipLpVfRjZotU7TujdLp+2++02/FlRJ/m+hveK25TvAkLu2d0ah9VCsfpBhuRN
 Fha7OODN6pyB7AFLepqTIIXcla9mMBZ15VLpjZDQSNkG9bxg8xCr7Yk734OaTLCKsayB
 fonuQWEEU7MzDwbOFSYSezeNszCCHXNQAL2h17IxOexjBJh5LtE91dswAolCvY7wll9A
 dWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+hxE9i2LXNTz12oXWns34FZR2YhTG4F31i4IBVFK/io=;
 b=gGNmmpeQAyMsffEpVpbVKE1uRICPpdxraluIVT3+2GxCyVoQ1AbyPF/K0Pne1v7Hia
 FDnKzgB4SnIGfSiC+2WPrGM+F17TOube7N0Qd3EIlQLk47KKa3zlvlPSK4woiB5h8wTc
 UHajYycTtP3hjD6PTQN64V8WxNp6Wk/pguldvPdiTvNeX2nvwAI1c+v91dEzV92IOD+d
 tzx2HHkQYRxXkYIw33IIvMd4prukdOUeGhgQtQiwCxd6caDerwsfIM5hMpF5XO7x64d/
 yzq+mbkxlg1UdDtCUU1VSMHYxBtqeWUiNWA/XcwTUFkcYU0KuSwLA1LNvegQ0ixnrhcg
 +1sg==
X-Gm-Message-State: AHQUAuZ5xohnuVwubzffTgt9duzG+T+7hcji66S07ASENI30r6DR5EIi
 jeIkonB4Okol3sth9fDJIN20jw==
X-Google-Smtp-Source: AHgI3IaVZ6CJpbhcHZy5MaVvStomkjS8sfJXLrjGqxqqWXEAYYMbSCyOTxp692oWbQJzEybUaW9Z4A==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr705255plr.15.1550099471348; 
 Wed, 13 Feb 2019 15:11:11 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 p64sm554108pfi.56.2019.02.13.15.11.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 15:11:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1gu3gM-0001M9-5y; Wed, 13 Feb 2019 16:11:10 -0700
Date: Wed, 13 Feb 2019 16:11:10 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: ira.weiny@intel.com
Subject: Re: [PATCH V2 3/7] mm/gup: Change GUP fast to use flags rather than
 a write 'bool'
Message-ID: <20190213231110.GD24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190213230455.5605-1-ira.weiny@intel.com>
 <20190213230455.5605-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213230455.5605-4-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 14 Feb 2019 10:16:36 +1100
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
Cc: Martin Brandenburg <martin@omnibond.com>, linux-fbdev@vger.kernel.org,
 Rich Felker <dalias@libc.org>, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Hildenbrand <david@redhat.com>, Rob Springer <rspringer@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Jason Wang <jasowang@redhat.com>,
 devel@lists.orangefs.org, linux-media@vger.kernel.org,
 Ben Chan <benchan@chromium.org>, Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Kai =?utf-8?B?TcOka2lzYXJh?= <Kai.Makisara@kolumbus.fi>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexandre Bounine <alex.bou9@gmail.com>, Todd Poynor <toddpoynor@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Moritz Fischer <mdf@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Wu Hao <hao.wu@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Christian Benvenuti <benve@cisco.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 03:04:51PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> To facilitate additional options to get_user_pages_fast() change the
> singular write parameter to be gup_flags.

So now we have:

long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
		    struct page **pages, unsigned int gup_flags);

and 

int get_user_pages_fast(unsigned long start, int nr_pages,
			unsigned int gup_flags, struct page **pages)

Does this make any sense? At least the arguments should be in the same
order, I think.

Also this comment:
/*
 * get_user_pages_unlocked() is suitable to replace the form:
 *
 *      down_read(&mm->mmap_sem);
 *      get_user_pages(tsk, mm, ..., pages, NULL);
 *      up_read(&mm->mmap_sem);
 *
 *  with:
 *
 *      get_user_pages_unlocked(tsk, mm, ..., pages);
 *
 * It is functionally equivalent to get_user_pages_fast so
 * get_user_pages_fast should be used instead if specific gup_flags
 * (e.g. FOLL_FORCE) are not required.
 */

Needs some attention as the recommendation is now nonsense.

Honestly a proper explanation of why two functions exist would be
great at this point :)

Jason

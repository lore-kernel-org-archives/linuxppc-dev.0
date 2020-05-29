Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF1C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 12:12:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54C92074D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 12:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54C92074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YNjx5N3ZzDqg5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 22:12:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.216.68; helo=mail-pj1-f68.google.com;
 envelope-from=mcgrof@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YNf666txzDqf5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 22:09:16 +1000 (AEST)
Received: by mail-pj1-f68.google.com with SMTP id q9so1263416pjm.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 05:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6vvgKHZv01UUvGrvhAsOqf6+UpVrlcy+OwWplQqQmoA=;
 b=ZUYxIsIzZlRnFNjqaofJ9YtDneGHsFXwX81+PFwsVro4lBucPkswr8sx4fePrEI8lB
 BdrL5mWz9rwLeQFjzf9trbWeioy46gFCYCvH8rw8s3fiAb8HPp5atm7yy6UmwuNQWOob
 umUANVJ0Sn80GX1R3svdeJQmIKEr4epU07GOFzzL/RprMU6Jvg1She7EqZwuG5qTu1ow
 AS4R9H3sQkilMtWZkszPxB3lF5agyei1kereVe6tY+FjSIRUyh3aRbMR6IDdFDt88t+e
 v5e1sGvV3Z6SEWSUGI9LHaSVncy78govFGdhDw5EUS87rbLhLOIdj7G1gl7sU5OpxgBc
 h0SQ==
X-Gm-Message-State: AOAM532FEGJG10wTQHr4JZOX9+T7CmQkULmGLrqCIMzos8VIISQLd7mj
 crxX1idmZco73D3IhFLuJw0=
X-Google-Smtp-Source: ABdhPJwH0ItHfFV94FqIi+i7pGGCJoHNOMavuCMZwaTSNJ24JRmSNe+lTFt06Kawbit8Fif5KqcKXw==
X-Received: by 2002:a17:90a:ce11:: with SMTP id
 f17mr2283340pju.123.1590754154418; 
 Fri, 29 May 2020 05:09:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id l187sm7199102pfl.218.2020.05.29.05.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id AE8314046C; Fri, 29 May 2020 12:09:12 +0000 (UTC)
Date: Fri, 29 May 2020 12:09:12 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/13] firmware_loader: simplify sysctl declaration with
 register_sysctl_subdir()
Message-ID: <20200529120912.GD11244@42.do-not-panic.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-10-mcgrof@kernel.org>
 <20200529102613.GA1345939@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529102613.GA1345939@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: jack@suse.cz, rafael@kernel.org, airlied@linux.ie, amir73il@gmail.com,
 clemens@ladisch.de, dri-devel@lists.freedesktop.org,
 joseph.qi@linux.alibaba.com, sfr@canb.auug.org.au, mark@fasheh.com,
 rdna@fb.com, yzaikin@google.com, joonas.lahtinen@linux.intel.com,
 keescook@chromium.org, arnd@arndb.de, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, julia.lawall@lip6.fr, jlbec@evilplan.org,
 rodrigo.vivi@intel.com, nixiaoming@huawei.com, vbabka@suse.cz, axboe@kernel.dk,
 tytso@mit.edu, linux-kernel@vger.kernel.org, ebiederm@xmission.com,
 daniel@ffwll.ch, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com, viro@zeniv.linux.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 29, 2020 at 12:26:13PM +0200, Greg KH wrote:
> On Fri, May 29, 2020 at 07:41:04AM +0000, Luis Chamberlain wrote:
> > From: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > Move the firmware config sysctl table to fallback_table.c and use the
> > new register_sysctl_subdir() helper. This removes the clutter from
> > kernel/sysctl.c.
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/base/firmware_loader/fallback.c       |  4 ++++
> >  drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
> >  drivers/base/firmware_loader/fallback_table.c | 22 +++++++++++++++++--
> >  include/linux/sysctl.h                        |  1 -
> >  kernel/sysctl.c                               |  7 ------
> >  5 files changed, 35 insertions(+), 10 deletions(-)
> 
> So it now takes more lines than the old stuff?  :(

Pretty much agreed with the other changes, thanks for the review!

But this diff-stat change, indeed, it is unfortunate that we end up
with more code here than before. We'll try to reduce it instead
somehow, however in some cases during this spring-cleaning, since
the goal is to move code from one file to another, it *may* require
more code. So it won't always be negative. But we'll try!

  Luis

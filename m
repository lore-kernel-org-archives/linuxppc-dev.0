Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3819AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 12:21:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B7320723
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 12:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YNwC2VCkzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 22:21:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.215.193;
 helo=mail-pg1-f193.google.com; envelope-from=mcgrof@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YNpk5ZP6zDqfd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 22:16:46 +1000 (AEST)
Received: by mail-pg1-f193.google.com with SMTP id d10so1417383pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 05:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1QRcJc+0V37tU9/CoMttBOeUhGM/q++JCRSrvKfZi1c=;
 b=fqG4bLy1TRVuFELdorsqknCk8ONEkHcZI4c02GoFRogMnGsZyQK2UjW3jM0H2knYlh
 9tcXb5jM2dC1dsEcMtDaikARE953wr87bhq+9fQIRlzL10tk6ZpshTTKuBZex86k7boQ
 6vXIFj5oTmA6iYYD7jZdeuc76jxXtkJUxekVY7O6WYQHbfdaz5rFCAIHeRzpDcY9/Wgr
 xQnwhT6lDtZ6wGgu7PEzSsBDR3xiONTZ380UktHaEfzSooXE1DF3VMhecHWB/lePtAzy
 b/xGzJhcoIGII7TwoLCmF0GHua+P65DZ2ZDG4UoHu/DYyk/eJDlI7GtKhlleuaGpYD/2
 ffSg==
X-Gm-Message-State: AOAM533+Fch2NUORZIqgecqOKpQpYZzxQSt1MIWy0FBLPitoK5+s7P4m
 HrLOAAWRGNkGUYRoociLNo8=
X-Google-Smtp-Source: ABdhPJyXXen44MBfu6MyEx4C7z2Ttl/Mr2eBWsGlqpPiqejkkDLE4gTu0+5b69yRv2/USHCPT392yg==
X-Received: by 2002:a63:dc0f:: with SMTP id s15mr7843478pgg.182.1590754602683; 
 Fri, 29 May 2020 05:16:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id z13sm7663876pfj.153.2020.05.29.05.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:16:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 982654046C; Fri, 29 May 2020 12:16:40 +0000 (UTC)
Date: Fri, 29 May 2020 12:16:40 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
Message-ID: <20200529121640.GE11244@42.do-not-panic.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-2-mcgrof@kernel.org>
 <87d06n17mm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d06n17mm.fsf@intel.com>
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
 julia.lawall@lip6.fr, jlbec@evilplan.org, rodrigo.vivi@intel.com,
 nixiaoming@huawei.com, vbabka@suse.cz, axboe@kernel.dk, tytso@mit.edu,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, daniel@ffwll.ch, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 viro@zeniv.linux.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 29, 2020 at 11:13:21AM +0300, Jani Nikula wrote:
> On Fri, 29 May 2020, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Often enough all we need to do is create a subdirectory so that
> > we can stuff sysctls underneath it. However, *if* that directory
> > was already created early on the boot sequence we really have no
> > need to use the full boiler plate code for it, we can just use
> > local variables to help us guide sysctl to place the new leaf files.
> 
> I find it hard to figure out the lifetime requirements for the tables
> passed in; when it's okay to use local variables and when you need
> longer lifetimes. It's not documented, everyone appears to be using
> static tables for this. It's far from obvious.

I agree 2000% that it is not obvious. What made me consider it was that
I *knew* that the base directory would already exist, so it wouldn't
make sense for the code to rely on earlier parts of a table if part
of the hierarchy already existed.

In fact, a *huge* part of the due dilligence on this and futre series
on this cleanup will be to be 100% sure that the base path is already
created. And so this use is obviously dangerous, you just *need* to
know that the base path is created before.

Non-posted changes also deal with link order to help address this
in other places, given that link order controls how *initcalls()
(early_initcall(), late_initcall(), etc) are ordered if you have
multiple of these.

I had a link order series long ago which augmented our ability to make
things clearer at a link order. Eventually I believe this will become
more important, specially as we end up wanting to async more code.

For now, we can only rely on manual code inspection for ensuring
proper ordering. Part of the implicit aspects of this cleanup is
to slowly make these things clearer for each base path.

So... the "fs" base path will actually end up being created in
fs/sysctl.c after we are *fully* done with the fs sysctl cleanups.

  Luis

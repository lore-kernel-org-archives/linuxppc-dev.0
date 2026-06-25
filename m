Return-Path: <linuxppc-dev+bounces-22994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209BCDE00B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:38:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmSHJ28zpz2y8p;
	Fri, 26 Jun 2026 04:38:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782412700;
	cv=none; b=es1bshng3lsKYNCJ4JzBDF8Usx5hEn00RBmpRzkxdY88XfJr8QRAUn8B0Ct5PnY+HSaY2AcMReIj34WlzhYepdgCOXortj9r2ON54iMvZ9jSC1SO6+i5KyuMGt1CtX/NnPTndcGwi9N47q+aYVP2jQSdcMyK3Djpc2sSVkowrD7ZuR/r1tqLX7YWtNc4hwu0eBN6audXAwC71NCmXUe4YUTA3KIlyUAGPdubYqZGt6ORpk37Qe1n73dnaWoHDzCXeO6LpdIYYghYfBPAEdErkDekpxSdNO0QB2noOiGZApqjD1sBk2E+lbPh+GmoA31owXzqJEmZ4Ks49bYXukwm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782412700; c=relaxed/relaxed;
	bh=xHuTG/PvzMnxTSampUx+792v7zbUVHG83vmebKN74Wc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=idC48ZVXPK6Cic0jyfuwmjlgtBjul8ADx78hvjfn7XSnpJznAJvV/t5aC8cpZDE/8Uy+kU3beBhbtXkBkNXPzOlUENMCJzIEGB1GwbgmiF19w+j+OBS5ESXk3B0j8QM0HnDeQjxYSM5Kmh54KzmdyCzrVYyj8knWWnBysdd3VVEf1fvEHeNzUsztz+QihrO+nkFbSMnjStriwSyhe/jb3KPw9z5BzlorxVLc/ewMbpcYSAW9W/QgZvfrPKrEjebVawfamHSrthkRob96zmKgW/OU9ukxY69VixcPyyZmFEVRfJ50/PJwVRP/U2/DfDSFx1+ZL/vYsa9dzo5telzWTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tLwaJIGd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tLwaJIGd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmSHG4p7pz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 04:38:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E11F240029;
	Thu, 25 Jun 2026 18:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B15B1F000E9;
	Thu, 25 Jun 2026 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782412695;
	bh=xHuTG/PvzMnxTSampUx+792v7zbUVHG83vmebKN74Wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tLwaJIGdu3vCcT7gq1t7pAtyOv9iJyUSpnLOVACdnNzPSBY03B+S6+64qmCX/b4au
	 ENS8DYoxuKdxluVxTywKyaJuW+Y80UXDHRfGHTSaR8owcHUhT8lLZZbHnj5RDwZEne
	 OHCWVsaJj20SOiJNx20LeC1ToR707vXDQd+udOdk=
Date: Thu, 25 Jun 2026 11:38:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <include@grrlz.net>, Feng Tang
 <feng.tang@linux.alibaba.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Mukesh Kumar Chaurasiya
 <mchauras@linux.ibm.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>, Rio
 <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Douglas Anderson
 <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>, Tejun Heo
 <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, Miroslav Benes
 <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper
 for callers that handle all_bt
Message-Id: <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
In-Reply-To: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
	<20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
	<aj1Jh57McGH94gGY@pathway.suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 17:30:15 +0200 Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> > On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:
> > 
> > > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > > Add a helper that strips that bit without turning an all_bt only mask into
> > > a kernel_sys_info fallback.
> > 
> > I assume this patch wants a Fixes: and a cc:stable also.
> > 
> > It would be nice to have the conventional [0/N] cover letter to tell
> > readers what this is all about.
> > 
> > The patches all have different Fixes: targets.  This risks inviting the
> > -stable maintainers to merge only some of the patches into some
> > kernels, resulting in an untested combination and which might break
> > things.
> 
> I do not agree here. The Fixes tag should should point to a commit
> which introduced the regression into the given code. And finding
> some magic common point beause there is some magic undocumented
> process for maintaining stable kernels sounds like a way to hell
> to me.

Well, as said, this potentially asks -stable maintainers to cherrypick
individual patches from this series into various kernel versions. 
Potentially resulting in code combinations which nobody has tested. 
Heck, the individual patches may not even compile.

If we're to add the series to mainline as a single atomic lump then we
should add it to -stable as a single atomic lump, as that's the only
thing which has been tested.  To communicate this to -stable
maintainers we can choose a Fixes: target to which the series can be
added as a single atomic lump.

Of course, we could always discuss this with -stable maintainers ;)


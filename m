Return-Path: <linuxppc-dev+bounces-22990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00F2CDE001
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:31:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmN863cWFz2yZc;
	Fri, 26 Jun 2026 01:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a12:4180:dc1:929::42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782401510;
	cv=none; b=LEWX0SDGSDsQJfN2L56iClFZmbXaHgtHhD9jy8vHJPq38VOaDTB7Z3GVpe52TuW1FuevmjvB/VJflih83CT3YxLZOh3kpXv+gvKN7t3F9CmyRZ9uvM39F32CC0xe+hjsZ7Gklu+Y+TR5Ga0HBdFoJigAWoL7arMbzSpfDerrLsjVWR2V+KcNvjgKNpHXP5lJpk0wqilLHk+HHivMvXrQDuA0vQ1OSlEIBJzG6UM6Vi4R7VtFNx/dOJ7tu8yypqmHmcwLyDKV2KVcU9frj2kp1z+o0wyuPPW5XPv/jijoVgNiZghNTsyGwi4f2zo5Zm0J2z72Ue6SNbACq8KceTmSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782401510; c=relaxed/relaxed;
	bh=NixNq7qAtZ/8X0xtfv5u+m8JY5i7HeWwMBne1v0htc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LfWAx0y0jkKVsJ1U25RMQD8puR8m+rVe6tMkZYVgvQoqWfdUTzCxXC62bvH8LO3O+yt6WcZJUQUr9oMKLnysAlY+wYEhK74e3jnLg9y/G8n86paHlb2i4L9yuzji9zBxnZWWx+mIMZziOuV227dffijqUTk0NDTbQriTce0ZEEzpTxRWZxcSUHJYZKiv/UgpFLSM6z5PKleVxukH3eC+WZC1K+UDWN86Y6PdTRWxXbbQKYQywjz8IHD7k8dkkTBfuiaxGMKVfxi6Joyz/2ki1djn4wPsPqa0oZ49dgTEAlVqEL8tG/eGqgAq6jrSNLS0jjtW2l+rst6xrQc0EIj2Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=f2SILeTa; dkim-atps=neutral; spf=pass (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=f2SILeTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2a12:4180:dc1:929::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmN855t2qz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:31:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401507;
	bh=NixNq7qAtZ/8X0xtfv5u+m8JY5i7HeWwMBne1v0htc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f2SILeTal3qnKgVE5kNh6l6d/A3PZJcv62oA+S28jDTtfJBljJQOtOM3P6Saw787E
	 0jTGpA5fBARhVJLRyitw74lFGLAeELGYKslDMKknAcjPaESpiMQrtfa8Aa3Wg3kY+K
	 MOUTQWmQv7V/4grQtGr6NnVzyx++Ng4MFf427HVY=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmN8336JfzGpDM;
	Thu, 25 Jun 2026 15:31:47 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmN826G0szGpDB;
	Thu, 25 Jun 2026 15:31:46 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:31:47 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Feng Tang <feng.tang@linux.alibaba.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jinchao Wang <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>,
 Rio <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>,
 Tejun Heo <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>
Subject: =?US-ASCII?Q?Re=3A_Fixed_tag_magic=3A_was=3A_Re=3A_=5BPATCH_v2_1/4=5D_sys?=
 =?US-ASCII?Q?=5Finfo=3A_add_helper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz>
Message-ID: <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>
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
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>> 
>> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > Add a helper that strips that bit without turning an all_bt only mask
>into
>> > a kernel_sys_info fallback.
>> 
>> I assume this patch wants a Fixes: and a cc:stable also.
>> 
>> It would be nice to have the conventional [0/N] cover letter to tell
>> readers what this is all about.
>> 
>> The patches all have different Fixes: targets.  This risks inviting the
>> -stable maintainers to merge only some of the patches into some
>> kernels, resulting in an untested combination and which might break
>> things.
>
>I do not agree here. The Fixes tag should should point to a commit
>which introduced the regression into the given code. And finding
>some magic common point beause there is some magic undocumented
>process for maintaining stable kernels sounds like a way to hell
>to me.
>
>Best Regards,
>Petr


oh no.
I added the generic tag to V4, no worries, it is the earliest possible
fixes tag. But I really don't wanna be doing a V5 just to revert my
fixes tags.

Thanks!


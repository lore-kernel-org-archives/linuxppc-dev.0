Return-Path: <linuxppc-dev+bounces-22995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2932CDE00B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 21:01:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmWRw45S6z2y8p;
	Fri, 26 Jun 2026 07:01:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.167.222.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782421260;
	cv=none; b=BhgR8ePtQdOrMxQscORfybGCmqyPxoaC2nY61YK2rbkyhTXf6g1wmOpzKD87fhKVehAPI/+RjuE15/z8rFNorbajfh1nDbHAA2bWPNBVp6QrhWr1bnRTd1nw5aE80c7ZRic5QaDBPMAa/1lz4RaGGaXz8MTr8grlRw/VGGt91QoeVOYJsKASijVdG1x22vwsrkn/c89rfORE46SoinTDG92dCOfrXZ0sEfq7DCFNGdqluoH77If07Hbzoxx1PkvoGAxQkbejoVVq+VzcXjFQfuNDmaObyxIq0E5r/Zv7j+5r03bJ4VOonmZMvGO/7FePnYnVGP33jlCKH3PddmlXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782421260; c=relaxed/relaxed;
	bh=64HTg0uFKX95Q5pSeC9H32PA2JC3Aqc39eu22kNWJLg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Kve57zp1wh1cFBJjzQtXFJoiPuWch4s2hFoekH9rbGvRVOrRm8h3C7peh/+W63GRtXpuYdB64s5rs4LPJNnSmSub2UZAnpuxatxwRrGwlxQsUtzfp62cKD+DQ/cmdNSkX+1fQwokijzQpn+quTvYgNOVAZ8Wak3rfqr9B9yG4JuOEi8cSo31SUk+g2nsTjfMuqa8uW6VExoORdSKwkscHNmwiQMviyheyjLXGDMP5RrJFc+Odtz3MxHqpL/SltsNBDsqlXL0SYqOS5XHKx6X1OqDdEdMCORsSbt17o4FuKwwxof/11PXW1hkY0myziTzsUUxCZASEtWORm1na9wYQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=GxvgJFkE; dkim-atps=neutral; spf=pass (client-ip=198.167.222.108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=GxvgJFkE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=198.167.222.108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 87373 seconds by postgrey-1.37 at boromir; Fri, 26 Jun 2026 07:00:57 AEST
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmWRs0ysYz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 07:00:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782421250;
	bh=64HTg0uFKX95Q5pSeC9H32PA2JC3Aqc39eu22kNWJLg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GxvgJFkEbpITe5DBm/v10raibSet+yGLFH6b9hw3t4LlZGM5OKX55kIEwOEsMaq9k
	 koxzBhKyAYCPOnf79CwvO/Fh8mq+B1sbVRPziffuSYgzSsayol1qmNeMDLYuANBKqO
	 ZHzVdiK4eHF+RMoF9UzKVA8dyPW4EbbSThCr4BTs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmWRk19Vqz6vy4;
	Thu, 25 Jun 2026 21:00:50 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmWRj4tZPz4y2q;
	Thu, 25 Jun 2026 21:00:49 +0000 (UTC)
Date: Thu, 25 Jun 2026 22:00:46 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz> <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
Message-ID: <B0FE0A33-91FF-4914-A535-73505C01F9E1@grrlz.net>
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

On 25 June 2026 19:38:14 BST, Andrew Morton <akpm@linux-foundation.org>
wrote:
>On Thu, 25 Jun 2026 17:30:15 +0200 Petr Mladek <pmladek@suse.com> wrote:
>
>> On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>> > On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>> > 
>> > > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > > Add a helper that strips that bit without turning an all_bt only
>mask into
>> > > a kernel_sys_info fallback.
>> > 
>> > I assume this patch wants a Fixes: and a cc:stable also.
>> > 
>> > It would be nice to have the conventional [0/N] cover letter to tell
>> > readers what this is all about.
>> > 
>> > The patches all have different Fixes: targets.  This risks inviting
>the
>> > -stable maintainers to merge only some of the patches into some
>> > kernels, resulting in an untested combination and which might break
>> > things.
>> 
>> I do not agree here. The Fixes tag should should point to a commit
>> which introduced the regression into the given code. And finding
>> some magic common point beause there is some magic undocumented
>> process for maintaining stable kernels sounds like a way to hell
>> to me.
>
>Well, as said, this potentially asks -stable maintainers to cherrypick
>individual patches from this series into various kernel versions. 
>Potentially resulting in code combinations which nobody has tested. 
>Heck, the individual patches may not even compile.
>
>If we're to add the series to mainline as a single atomic lump then we
>should add it to -stable as a single atomic lump, as that's the only
>thing which has been tested.  To communicate this to -stable
>maintainers we can choose a Fixes: target to which the series can be
>added as a single atomic lump.
>
>Of course, we could always discuss this with -stable maintainers ;)
>


Hi Andrew, I ended up deciding on a generic fixes tag on V3, if you
would like to have a look.

Thanks!


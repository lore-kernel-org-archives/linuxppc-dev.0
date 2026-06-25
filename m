Return-Path: <linuxppc-dev+bounces-22993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B0CDE001
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:48:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmNVw59X3z2y8p;
	Fri, 26 Jun 2026 01:48:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a12:4180:dc1:929::42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782402488;
	cv=none; b=MNUOTotJPtxL9J6OQ98+3FFRp6vql7LwZWaVt6fC5obY5AJoBqLTADLERqauyTlU+N9Z5qlM0bhjhTmrn4XoGBpKWTouDn63w28iLxNOgzH0SKWh++vblD/WWibHM993TUCZwCtsvLrBcwBc3M/ehXuk2zThQt0JQ0B9KsA7+KXq2fyYwJLtoZQz7UAwz9oBZeVnyGkFZbdd3vtTCnmodKTh8iob2HaCD/m02gS3ogBnewkBBo2m3PC5cCCkMhk0EXk+z3U71hQ7Yg914IjrFsBZGNNc/75WaBPTlHfBFpWvej88ILmGSKCFrTJfL5CnwiJx+vnCkeHSzpMyN7Y6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782402488; c=relaxed/relaxed;
	bh=eA8msFe4nCREb1EQHy7RNtgoYqKSimrXWAQli+HDGwo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YucjaF3ga6f+LO6E4IGh/0xE9YGMf1wPVWgHo527fWFPWth5i9YNk711pCYDNNznwixDkUSEaFuHBhspoGHleSfqizuQ/JpVYoCuto4XMiusWxcLrYRduRGj0x2XINmGRjV9lVCG+e99IMFUn1h1e945qtFnXj2abw8sbx/r3dBcrkTcoeQ7LjCfK2XeS3CWeNLg0mNsGL6ppZMJVCK+p7hWj1dJu7utjATkJuCHJYFCrZZFCTAyKAtS3apBX9KFbWHyD9zvnYB4vgJ16e8mUbTgicNZ3lt2cEZHYoLllAzDfQ3/LlBvVAGdvPbN5pOVYXLmf/946+eeIWqbucXpnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YI4Lvsii; dkim-atps=neutral; spf=pass (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YI4Lvsii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2a12:4180:dc1:929::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmNVv6TNLz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:48:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782402484;
	bh=eA8msFe4nCREb1EQHy7RNtgoYqKSimrXWAQli+HDGwo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YI4LvsiifIK0LLippDYvNlYIvgt46NgpzhuMRJeQ/R/l/XxXC6L2S0OnpclJDOrIq
	 8xRDVBmklPDeSReseuN2Qf1WTUGYUlf7JdxfksuURDVPjhBH2MjJKanEYE3lPddook
	 wh/aUaEdeuZ/Hgld+aW8Uckly1XRqK2AGni7zQ4I=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmNVr5lSMzGpDl;
	Thu, 25 Jun 2026 15:48:04 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmNVr2X9JzGpDM;
	Thu, 25 Jun 2026 15:48:04 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:48:04 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
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
In-Reply-To: <A9C69766-159B-4A79-B409-AD56B2856F8F@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz> <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net> <aj1MdKcXP3uIW7AX@pathway.suse.cz> <A9C69766-159B-4A79-B409-AD56B2856F8F@grrlz.net>
Message-ID: <13CAC0EF-D0DC-4106-AF0E-B7BF4B51FC12@grrlz.net>
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

On June 25, 2026 4:46:11 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>On June 25, 2026 4:42:44 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>wrote:
>>On Thu 2026-06-25 16:31:47, Bradley Morgan wrote:
>>> On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>>> wrote:
>>> >On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>>> >> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan
><include@grrlz.net>
>>> >wrote:
>>> >> 
>>> >> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>>> >sys_info().
>>> >> > Add a helper that strips that bit without turning an all_bt only
>>mask
>>> >into
>>> >> > a kernel_sys_info fallback.
>>> >> 
>>> >> I assume this patch wants a Fixes: and a cc:stable also.
>>> >> 
>>> >> It would be nice to have the conventional [0/N] cover letter to tell
>>> >> readers what this is all about.
>>> >> 
>>> >> The patches all have different Fixes: targets.  This risks inviting
>>the
>>> >> -stable maintainers to merge only some of the patches into some
>>> >> kernels, resulting in an untested combination and which might break
>>> >> things.
>>> >
>>> >I do not agree here. The Fixes tag should should point to a commit
>>> >which introduced the regression into the given code. And finding
>>> >some magic common point beause there is some magic undocumented
>>> >process for maintaining stable kernels sounds like a way to hell
>>> >to me.
>>> >
>>> >Best Regards,
>>> >Petr
>>> 
>>> 
>>> oh no.
>>> I added the generic tag to V4, no worries, it is the earliest possible
>>> fixes tag. But I really don't wanna be doing a V5 just to revert my
>>> fixes tags.
>>
>>This is the risk when sending 4 versions of a fix within 5 days.

Oops, I was wrong, 3 versions.


>>A good practice is to wait at least one week before sending another
>>version. It gives people chance to react and helps the discussion
>>to settle.
>>
>>That said, I am not going to block this because of the fixes tags.
>>But I suggest to wait longer next time.
>>
>>Best Regards,
>>Petr
>>
>
>The whole fixes tag thing is unfortunate.
>
>because it should be Fixes: then whatever commit ADDS the regression.
>
>Not a common fixes tag for all! 
>
>Maybe when it's merged, Andrew or someone else could do 
>
>
>Cc: stable@vger.kernel.org [5.10] for instance, for it to be backported to that version.
>
>That should fix the whole fiasco
>
>Thanks!

Thanks!


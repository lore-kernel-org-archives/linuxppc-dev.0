Return-Path: <linuxppc-dev+bounces-22967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28560CDB47F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 20:51:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glvH432pMz2xl6;
	Thu, 25 Jun 2026 06:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2c0f:f930:0:4::108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782334272;
	cv=none; b=k+EnC8QPiUOh7MADnSwgOTxZ2NF/otkMNhNrGsOgoOSuUyNHNJPOUzjxnTj1SK7QOe47YNCpS9cd2DcMeKU4XJMpP0JsxSoFKo4GNYmmnkrAt1SBzENPjZoPlcA5TSEkeim2OWY3ayaZGOBB0eblvLRIt3xlM0jubwfHOFQ1baMxH5gsiZ60qYFqcfHFTnjwedrT8RG86kAf/YheyGmoLzy9R1mqUxekhjlY7jZcy0NZEuf9kU4z5ZGePIyNDZF3mFGj9rD2pD7j+pIEBWdhLhu5vXxX273ZzSYUWZYtQGyXqP6WRy9MYp6VI3u4HZfQTdq99fYxCeuYjDcesj7w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782334272; c=relaxed/relaxed;
	bh=msQPwdVONZeSYGE9jE2dmPBtZAtGxjXbxerzmKa/UWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kxRgKucIEQdY3sdX/VSTuHVWbt7H5jGslHiQMlVMrKUSDiqxmEKh7HoY7wWwgYGCZwhadhDB6EN2SrLrFJEsvHuRwALDxLKjShLRSuJr/8zdIVcvddTmt5DAiz3eU4uyD0XJmHOTXlMECbsZQm8VvWPox/PfjytARO8pqPe+Z1D5mspXhyLHuFnl5yyJwsevYRIn/6QtNSVQwU05m/jsjsZERhViaBtgpdVTbto+6Nzc5ZSBIjjU1H1cvy3G6Yc1lSxiueZIKad+krxtm+Y/HRL8Q+IA3fX780J9NQtu1YudVWcS7VJYBw87evZt1gY0rZgPV1z4H7Z/viZeImy0JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=JSG/Ctd2; dkim-atps=neutral; spf=pass (client-ip=2c0f:f930:0:4::108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=JSG/Ctd2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2c0f:f930:0:4::108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 377 seconds by postgrey-1.37 at boromir; Thu, 25 Jun 2026 06:51:09 AEST
Received: from devianza.investici.org (devianza.investici.org [IPv6:2c0f:f930:0:4::108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glvH16TWmz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 06:51:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782333878;
	bh=msQPwdVONZeSYGE9jE2dmPBtZAtGxjXbxerzmKa/UWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JSG/Ctd2Md6Q+xRTMF28fasvwDclbHM8QOk8NEF3F3N4ZRC+sC8XAJG0A0953LXyV
	 xocsWCAFCUtjaA11haOGtLlLFxVfktCvnvbiSL7KW0sm7z+hmgDA5i2Eb9KVsm79dT
	 UZgamLEMLDbi2dyDVI48q7e2G3g95Icr2d2JzlQ0=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4glv7V21j2z6vLR;
	Wed, 24 Jun 2026 20:44:38 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4glv7T6C6sz4y2q;
	Wed, 24 Jun 2026 20:44:37 +0000 (UTC)
Date: Wed, 24 Jun 2026 21:44:37 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
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
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_sys=5Finfo=3A_add_he?=
 =?US-ASCII?Q?lper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
Message-ID: <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
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

On June 24, 2026 9:34:19 PM GMT+01:00, Andrew Morton
<akpm@linux-foundation.org> wrote:
>On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>
>> Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> Add a helper that strips that bit without turning an all_bt only mask
>into
>> a kernel_sys_info fallback.
>
>I assume this patch wants a Fixes: and a cc:stable also.

Fixes, perhaps 
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup") ?

>It would be nice to have the conventional [0/N] cover letter to tell
>readers what this is all about.

I added a what I changed? I'm iffy on cover letters, if you want I'll do
it...

>The patches all have different Fixes: targets.  This risks inviting the
>-stable maintainers to merge only some of the patches into some
>kernels, resulting in an untested combination and which might break
>things.

In merge-time, could we do 


Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")


>It would be cleaner to make all patches have the same Fixes: target if
>possible.

Ditto.

Thanks!


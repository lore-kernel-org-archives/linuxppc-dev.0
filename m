Return-Path: <linuxppc-dev+bounces-19228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C4D6AAFF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:26:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmsKb40HLz2xls;
	Fri, 03 Apr 2026 06:26:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775157987;
	cv=none; b=kiFngu921lrb40+j/sMdhEgPkUxbJ6uUMKOwSCF9A2rt2jAwRqwP9ZuOiC8iwXG2BddBGdEQ+axj/N2aaL9VP+bidRcELtEdvRX7ZlLNDH8eTQPUFHNLk5Kk/zZplqeuWAHiCRnRH/QmKrKiWkcA/nvSEjfDJin2wPvOgDBs3VJFeBmDogxbg5UkO0A35s/kL0XQwUSNms3qLJt7KIcpWz3820pPpOUCSfZoV5U3GMJUWd+FVkEo9vSsCX0TCoI8CI9RGveL6KMrwzIaV+mrAlNu+7HBZxqlq3nBqwXauMp5ZOKsdz9TgY3lpa9alFsslED9Ac2liHCoLriUqnQ0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775157987; c=relaxed/relaxed;
	bh=3PqOUhzsRPx9D5vtzblp2P9mFGliWuzJGA+r6wok8jk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XB6xSzUH5h4QnmKfvFVFKF0inzIYILpOGEkw9i8rgLnen9KIzm1Nocq5V4x1dRrtmh35boXhKheerE4QFM+vfhP6eW848KDrFsGTpQpTnB/660g/ZMU2AAU+yD89ATLiLU4OZzFJB2Yihf5gxnmLQB7KbQCRJDjqTji5bYUt0y6wIi5K3/V8KTvBW9N7wyR+ULw4CV3vaxIxE7mcOpuuQivCDFj0GhFgwMogqmCZqyrVlFKulYPhR/IRzeYLIRlglblmytvaYqaZIYBrfAjjGPz7ulP6pyBQJnIrOERsgSBmgdTXprjXKZ8vuhSmZyrRGC3i0oueh+H+hTrfmduuxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VJmlyU2f; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VJmlyU2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmsKY747nz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 06:26:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D5C2244478;
	Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40095C116C6;
	Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775157982;
	bh=XLkaYuwC8TJumKWLKI6Vqdpwwz2SiUWTGMJT6mO3V9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJmlyU2fMvJ0khCoy1tyTA7o/BVvGJ9czzpOxX4I4bqpdJtlryV5k/ynLUFFpZkha
	 gMc07NJW1hL7Bub2F4I1a4k1Qz3ZGwd6bBlsuD1SSsPJYsSDtyw7f7Z/oxcgdcppbR
	 aUabFPTvkOy2z4MQNc/SpSztOnFwEL6XHe61Nkrk=
Date: Thu, 2 Apr 2026 12:26:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org, Harry Yoo
 <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Srikar
 Dronamraju <srikar@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
Message-Id: <20260402122621.566be08b7d16ba082371b5a4@linux-foundation.org>
In-Reply-To: <6a5f2139-0ff8-40b3-88f9-98d2ea020d6f@efficios.com>
References: <20260319233745.GA769346@ax162>
	<abzKcGiRSR_E8lLN@hyeyoo>
	<7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
	<ab1J9ODkX5iChu-C@hyeyoo>
	<7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
	<7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
	<h5qax9x2.ritesh.list@gmail.com>
	<20260320192153.759d6fec57f04fb653a0dac7@linux-foundation.org>
	<6a5f2139-0ff8-40b3-88f9-98d2ea020d6f@efficios.com>
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

On Thu, 2 Apr 2026 11:30:53 -0400 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-03-20 22:21, Andrew Morton wrote:
> > On Sat, 21 Mar 2026 06:42:41 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> >> Looks like this is causing regressions in linux-next with warnings
> >> similar to what Harry also pointed out. Do we have any solution for
> >> this, or are we planning to hold on to this patch[1] and maybe even
> >> remove it temporarily from linux-next, until this is fixed?
> > 
> > Yes, I'll disable this patchset.
> 
> Hi Andrew,
> 
> I have prepared fixes for this issue. On which branch should I rebase
> them ? Do you still have the HPCC series in your branch or should I
> send it anew ?

Cool thanks.

It's best to do a full resend after -rc1 please, presumably against
mainline.  Show reviewers the latest version, refresh memories, etc.



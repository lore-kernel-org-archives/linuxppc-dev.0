Return-Path: <linuxppc-dev+bounces-22968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE92FCDB47C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 03:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gm4Cd5zL6z2xdb;
	Thu, 25 Jun 2026 13:33:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782358429;
	cv=none; b=HV1kXaEzxQGNDbLbueWF5FFyF8hM4DOYnJBLL8AbXUBcHyC7rMtl8M6P/2Ah2AOp8UAlYo/GTvfEnLfnY9nD5xFOuNo7AzjMwZtzs9TlFRo3VjW3+V7gcBHcKig7izGOqD2yAWBRA02F5FHxZieR7ReYJcgTbF1VRr/j+YK6/lFhSV3hf1Fs6y4+NE75Xs0iZKl/hCdAL+NHI7DQpjG/Ch+mr1F2m0sdStzlmFN7vcgc3ATXU/IA9m/9cQ2fwFlLTM0u+xlP2lKzjjRvgEgRjVz8+F6ZWP7cNaIAITA9vP/iyDVyKCZjJ6cq8kuBIcLu5JWFrFFzfPRBF/AjGCuwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782358429; c=relaxed/relaxed;
	bh=QK/WgekjtjSCmNGa+5JxIa5FygQOjUBbLChzAd+upEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekGZgle0K7bufZdi4mYfNnh1oBvLhkC/UBkRvIbvFYkHSYhIFL/jFWiIiTkahQ2INr/WcM5jG3+Hjdzxalp5mtfBPgvWFFgeFJEccgV8GNkmSLBZ2i2BqfOThxxqw++OcueNjGB49P6in+H/ccOfr+l248DZ71RE5NY15I/A5CqPCgQDrFDg3BN8fkXK7WUVeoSAjItVgrudtQoxqOnnw51sMXDOG5BBm1t/0BR9n9XlX8nqZfYHU7D5avvB0TN8b/M639tJ3d6qbQjhlDrpABCkUWFVkSGOh0uAINn/wIF87MCVd65sV7v35xN1sqcASrc10NZOcqeqa5LGfh2OFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OvO7FUSl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OvO7FUSl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gm4CZ5HzFz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 13:33:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782358420; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QK/WgekjtjSCmNGa+5JxIa5FygQOjUBbLChzAd+upEE=;
	b=OvO7FUSlBPRuCBs7yGaYljpPhXjuCiRwGtIkqry5NcpQu8/rQZbIotXROOIcxjCEiGtYm3RwWVFiV4j8Be/mehZuXosTTqTt39rv45ZqTeakhIoKgQT5TcMysnzNwVl8EGmCs1AUTeNbUXbOhH15SV9yJvaMEB3p5NJDzcXLrms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X5a-j0z_1782358416;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5a-j0z_1782358416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Jun 2026 11:33:37 +0800
Date: Thu, 25 Jun 2026 11:33:36 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] panic: avoid duplicate all CPU backtraces from
 sys_info
Message-ID: <ajyhkJjVw3s_phsT@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
 <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
 <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>

On Wed, Jun 24, 2026 at 05:12:28PM +0100, Bradley Morgan wrote:
> On June 24, 2026 3:50:27 AM GMT+01:00, Feng Tang
> <feng.tang@linux.alibaba.com> wrote:
> >On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
> >> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> >> other CPUs. Do not ask sys_info() to handle that bit again later in the
> >> panic path.
> >> 
> >> Use sys_info_without_all_bt() so panic_print=all_bt does not request
> >more
> >> output after the CPUs are stopped.
> >
> >Good catch! Thanks!
> >
> >Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs,
> >and
> >this patch does avoid dumping local call trace again!
> >
> >For the whole serie, feel free to add:
> >
> >Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
> >
> >Thanks,
> >Feng
> 
> Thanks a lot Feng!
> 
> All 4 patches, right?

Yes.

> 
> I'll let the maintainer (whomever will merge it) merge it, and add 
> your tag!
> 
> If you would like, Feng, if you CC me on any watchdog, etc etc patch,
> I'm sure I'll help review! :)
> 
> Thanks for your tag.
 
No problem. Thanks for fixing the bug I introduced! :)

- Feng


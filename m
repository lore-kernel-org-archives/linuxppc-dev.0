Return-Path: <linuxppc-dev+bounces-22954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618BACDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 02:50:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glRJK4v3bz2yVv;
	Wed, 24 Jun 2026 12:50:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782269441;
	cv=none; b=mVaM3tyED/tozLcmp7BS3Vo2tDV2UAwJhCJXmjpTHdedyvkBZb2Gwh14tVE3Gd2FVmfe44gC6wcPUCrMX1jgbzLODkE+pYe5vJ+dqoKsWTsW3lzOlSK5U12qKwi+Y8gdbHoMARxoT/ZLBojy1lv2cZbCMngXtdyshsNzXpSQU8ZEJWV/TS8vsmE+/oNss28s8PViRcKfO82Yul9A86nuegflB7YtFdW4ZUkCkw8vrNvkHE+ArjYAn933eHJoAjbHkP2pMrYXbIEkUsYA8IPt7ql6AqlqA0CoOKMnT8o3KsAYp5+hvL1Oplr2N9Qcsud0ixdRJkMFF7RkttWZ/LFE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782269441; c=relaxed/relaxed;
	bh=QK2Sa3tUM9FmdHMKVzdbtY23gSTQnspEbezYtpW8lPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpOnMjhQ/Tm9aesElTXfGH0K9vSnBhoHJwGuyDoMDRwNsWsirnHzZVsb/MqCTg8jrMOi/ZXCidc2iNJkRyPiGQyZjLuUZl3XgGJzoWFISt/AkU8b2OTs7rz3BSZz1Gr47Z7R5dAGDJv+rQJKRBmujyL8lG54fvkmf4WwqDFcE4hz0hmkTFY44ykdpdjWYkJ9ecCStzhr2pnyURNaXkSbziJRTS/AKjpeZLb5tvc7vc6qKgMiem+VF4HLvYI7RKI9fjfsW+5SEStqDrt/zxqve1JwfD91xqeBF5qx4bZuro9d6z1CoR5Bp3c1jSWxEg+NU8cd3ebtp498pr7kFyIfgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xeyQjXdn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xeyQjXdn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glRJH2qJcz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 12:50:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782269433; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QK2Sa3tUM9FmdHMKVzdbtY23gSTQnspEbezYtpW8lPQ=;
	b=xeyQjXdnyMdiZKetPmfT8LibER3U6NrPWNTdxe7OwIWej5VVV+teyapaVRFhCUrYkjG9x+NPDNr9pLX6O0soGvH7aYgPxnIVJMVwnd8rXrfCe+fzygIMkg6Jgv8Fz5NqWWMX4/yzVi3OqbXpk0HFolrMoKZ8YNu5wNzsYZhntjA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X5W1YNy_1782269429;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5W1YNy_1782269429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 10:50:29 +0800
Date: Wed, 24 Jun 2026 10:50:27 +0800
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
Message-ID: <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
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
In-Reply-To: <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>

On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> other CPUs. Do not ask sys_info() to handle that bit again later in the
> panic path.
> 
> Use sys_info_without_all_bt() so panic_print=all_bt does not request more
> output after the CPUs are stopped.

Good catch! Thanks!

Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs, and
this patch does avoid dumping local call trace again!

For the whole serie, feel free to add:

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,
Feng

> 
> Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sys info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - New patch using the same helper for panic.
> 
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d030f88ad4ef..2cf229c7c0cf 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> -	sys_info(panic_print);
> +	sys_info_without_all_bt(panic_print);
>  
>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>  
> -- 
> 2.53.0


Return-Path: <linuxppc-dev+bounces-22962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558D6CDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 16:12:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gln5j1XW7z2yRF;
	Thu, 25 Jun 2026 02:12:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.218.207.228
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782317561;
	cv=none; b=RLjrjB17AbgkzSSqAQDVPUNsNrz+BfLKwwXHUClMjCQy7hdorIctikoBXN+RisMhdLfURf2VzBP4t8UwPxMPz0fW79mmSdqIwg+tDkGlh7GQhyqEDRLPNv8YZJMivWCcQcSD/k4J8hF7eAlTfU5xeZUMVwPR8X6DJtORCbo/nk1vr1k71jpUiPElQpwI1Fto+gmyjoDaBcWm85vF691lCOfpesTTRxhypO2bAWWjHBtf3fFux3vfQ/PKO8wcLnXYYx5p5n2he1e10v3D3Y/4DbU4VkRRB6XxxvkqkDQv+E3LX+Qi+7qr4oFVfoUHKG40FcY7agXYe+FwzaRmBUHh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782317561; c=relaxed/relaxed;
	bh=VnQUr85LCOui0QkTY9NjKigopViBoQ7x5EYpB8b0K74=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gkUClgKHgyA4wEbIxIpAUzqJbNZT+s8bamAZhiymtRwCKzRFiFm8k7F4tUKYXmP7yQHCoj2I03piznCaH4tQrh04L+IpXY4Ahm+QWRg+ii5794XdpX+tF6ExaJrnRdEoWWd43PYcSU5h1314u6vwdhzDDQ/yqFsi7vTuheJL3sFloXKFh1D7RihtgQOLfb13sAEnCucNLEjrI+P4omYXwNOcqv22bBSwArqQbYx7gsqnrmYHOCyz2YNLBzAcxZcrwxymBi+BghygI4oiThqygAq1f+KD55OcR1VLQk6PuS3BM0FjmV61R6zFwBrO16OTmPFKJhl4WIjx2xBtPffqzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YrM62DRh; dkim-atps=neutral; spf=pass (client-ip=185.218.207.228; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YrM62DRh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=185.218.207.228; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gln5d5MyWz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 02:12:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782317551;
	bh=VnQUr85LCOui0QkTY9NjKigopViBoQ7x5EYpB8b0K74=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YrM62DRhSFVLelbhXvWrZU2rfJ6oaoVsnB26D6/+rcUoc3Ss5Sz+tIpjVmMAARFKy
	 euhDTMnvO1Wf4e9iOlGsLUtgdY/42yZ2093VMpt26QBylka7cYdwyOu3/WtVHXnyWB
	 dk9YkvCd773tu6PrJth1qChw2NdWbYuV6HQFCaak=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gln5W2j6JzGp8s;
	Wed, 24 Jun 2026 16:12:31 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gln5V3s2VzGp8r;
	Wed, 24 Jun 2026 16:12:30 +0000 (UTC)
Date: Wed, 24 Jun 2026 17:12:28 +0100
From: Bradley Morgan <include@grrlz.net>
To: Feng Tang <feng.tang@linux.alibaba.com>
CC: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_panic=3A_avoid_dupli?=
 =?US-ASCII?Q?cate_all_CPU_backtraces_from_sys=5Finfo?=
In-Reply-To: <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net> <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
Message-ID: <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>
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

On June 24, 2026 3:50:27 AM GMT+01:00, Feng Tang
<feng.tang@linux.alibaba.com> wrote:
>On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
>> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
>> other CPUs. Do not ask sys_info() to handle that bit again later in the
>> panic path.
>> 
>> Use sys_info_without_all_bt() so panic_print=all_bt does not request
>more
>> output after the CPUs are stopped.
>
>Good catch! Thanks!
>
>Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs,
>and
>this patch does avoid dumping local call trace again!
>
>For the whole serie, feel free to add:
>
>Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
>
>Thanks,
>Feng

Thanks a lot Feng!

All 4 patches, right?

I'll let the maintainer (whomever will merge it) merge it, and add 
your tag!

If you would like, Feng, if you CC me on any watchdog, etc etc patch,
I'm sure I'll help review! :)

Thanks for your tag.


>> 
>> Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show
>sys info")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes since v1:
>> - New patch using the same helper for panic.
>> 
>>  kernel/panic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index d030f88ad4ef..2cf229c7c0cf 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> -	sys_info(panic_print);
>> +	sys_info_without_all_bt(panic_print);
>>  
>>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>>  
>> -- 
>> 2.53.0
>

Thanks!


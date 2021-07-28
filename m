Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB9C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 15:32:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DA860E09
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 15:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55DA860E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZd2R759Rz3cc6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 01:32:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=hfec=mu=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZd264Tf1z2xKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jul 2021 01:32:14 +1000 (AEST)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21C1060E09;
 Wed, 28 Jul 2021 15:32:11 +0000 (UTC)
Date: Wed, 28 Jul 2021 11:32:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 6/7] sections: Add new is_kernel() and is_kernel_text()
Message-ID: <20210728113204.67fa6dfc@oasis.local.home>
In-Reply-To: <20210728081320.20394-7-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
 <20210728081320.20394-7-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, ryabinin.a.a@gmail.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, ast@kernel.org, mingo@redhat.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 28 Jul 2021 16:13:19 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> @@ -64,8 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
>  
>  int notrace core_kernel_text(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext &&
> -	    addr < (unsigned long)_etext)
> +	if (is_kernel_text(addr))

Perhaps this was a bug, and these functions should be checking the gate
area as well, as that is part of kernel text.

-- Steve


>  		return 1;
>  
>  	if (system_state < SYSTEM_RUNNING &&
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 884a950c7026..88f5b0c058b7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -235,7 +235,7 @@ static void describe_object(struct kmem_cache *cache, void *object,
>  
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -	if (addr >= (void *)_stext && addr < (void *)_end)
> +	if (is_kernel((unsigned long)addr))
>  		return true;
>  	if (is_module_address((unsigned long)addr))
>  		return true;
> -- 

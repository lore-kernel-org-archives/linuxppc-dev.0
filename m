Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA0C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 14:47:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9495160F91
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 14:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9495160F91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZc2C2d7kz30G4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 00:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=hfec=mu=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZc1n6M3Jz307m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jul 2021 00:46:53 +1000 (AEST)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4215C60527;
 Wed, 28 Jul 2021 14:46:49 +0000 (UTC)
Date: Wed, 28 Jul 2021 10:46:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 2/7] kallsyms: Fix address-checks for kernel related
 range
Message-ID: <20210728104642.7ae75442@oasis.local.home>
In-Reply-To: <20210728081320.20394-3-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
 <20210728081320.20394-3-wangkefeng.wang@huawei.com>
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
Cc: linux-arch@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 ryabinin.a.a@gmail.com, arnd@arndb.de,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 ast@kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 mingo@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 28 Jul 2021 16:13:15 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> The is_kernel_inittext/is_kernel_text/is_kernel function should not
> include the end address(the labels _einittext, _etext and _end) when
> check the address range, the issue exists since Linux v2.6.12.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/kallsyms.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 2a241e3f063f..b016c62f30a6 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -27,21 +27,21 @@ struct module;
>  static inline int is_kernel_inittext(unsigned long addr)
>  {
>  	if (addr >= (unsigned long)_sinittext
> -	    && addr <= (unsigned long)_einittext)
> +	    && addr < (unsigned long)_einittext)
>  		return 1;
>  	return 0;
>  }
>  
>  static inline int is_kernel_text(unsigned long addr)
>  {
> -	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
> +	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
>  		return 1;
>  	return in_gate_area_no_mm(addr);
>  }
>  
>  static inline int is_kernel(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
>  		return 1;
>  	return in_gate_area_no_mm(addr);
>  }


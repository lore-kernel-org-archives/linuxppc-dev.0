Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A20C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB2021874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Zi5ZwJ9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB2021874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QFRx4WFFzDqTq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 05:19:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="Zi5ZwJ9P"; 
 dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QFQ85hKdzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 05:17:52 +1100 (AEDT)
Received: by mail-qt1-x843.google.com with SMTP id z17so6658715qts.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nq8thke8AAguuyUY8uu9Lf6Dq379TbWozTWnKwSQ0mI=;
 b=Zi5ZwJ9PlIvYa8DSIECnCbalBEUOgpuIjs0WSCG2SBnJE3ZhZkUFul6HDdWAPJOpm/
 piNYKFb/BK51xfBlq6w+3wwCe3eqEhGAPLmvFGltK1Ht4S5KdIAAixYx9+nSOYDvcd3I
 D0/DmsQB8QLDsVb+5TTjidvoroLdSDYNPAnrCx1lr9OIGPoqFzmcl6K0eVH6kXQPcmFW
 s1xCXBYk3n8A0Q27DgEkin8ZicHNgBWqWB5bU7lRwF7qCFB98N1fFnDWM6mB/yQFmjbC
 lr8JiyF6yc9sdanvfv0IorpMOnScmhIiiOwlQx9Z9LilQEymcGGTYGhk345mlqW1hRrE
 RNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nq8thke8AAguuyUY8uu9Lf6Dq379TbWozTWnKwSQ0mI=;
 b=m4DsZL7bXPrQFuD/XesmxWjbq5guNgJD7AEjoh7jxgOavj41PoFKjx/QBO/KqUpCk1
 9YT9/OQ4b9veNF4zszwh9uEmB4OkrmdYaTXxcpBSezE4/7kbI1gwmzfpHSKE1zDeZpmU
 I2GI+8K+LzW0MnUX6WQOlZJhEJU/4djmo4jtAVtmJZ3Ac9TzFwWGR4rsczUX/jHw5HsE
 t6umQw+e1+zJzegcTYOOu8Ej7zTbk9NoFngzMUzjrXCbELspGKS/h5IeqN0ygF4+soCL
 dwOB24+yEIVSa2hMKs7DfGndKuvD7tSnN9arzOzhbK/ihFA54Sa4kLVSpM+lN1o2BK68
 LQyA==
X-Gm-Message-State: APjAAAXhaT/6fZmrLc8kbI9CxhxujXlHPFQS0eFiYGgHHD5qnTZyvVnB
 DDptgsY61qfk+UDwy/Bwf0RgQA==
X-Google-Smtp-Source: APXvYqzH4lZLJtvN18IQVcBYAAWDGWi+UZTAC3zqVsSviENEchLNO0/tfVB35Kl8u2oUO+FPu+1H4A==
X-Received: by 2002:ac8:3113:: with SMTP id g19mr4420688qtb.356.1553192268668; 
 Thu, 21 Mar 2019 11:17:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id y17sm3021889qtf.72.2019.03.21.11.17.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Mar 2019 11:17:48 -0700 (PDT)
Message-ID: <1553192266.26196.16.camel@lca.pw>
Subject: Re: [PATCH] kmemleak: powerpc: skip scanning holes in the .bss section
From: Qian Cai <cai@lca.pw>
To: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Date: Thu, 21 Mar 2019 14:17:46 -0400
In-Reply-To: <20190321171917.62049-1-catalin.marinas@arm.com>
References: <20190321171917.62049-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-21 at 17:19 +0000, Catalin Marinas wrote:
> The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.
> 
> kernel_init
>   kvm_guest_init
>     kvm_free_tmp
>       free_reserved_area
>         free_unref_page
>           free_unref_page_prepare
> 
> With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel. As the
> result, kmemleak scan will trigger a panic when it scans the .bss
> section with unmapped pages.
> 
> This patch creates dedicated kmemleak objects for the .data, .bss and
> potentially .data..ro_after_init sections to allow partial freeing via
> the kmemleak_free_part() in the powerpc kvm_free_tmp() function.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Tested-by: Qian Cai <cai@lca.pw>

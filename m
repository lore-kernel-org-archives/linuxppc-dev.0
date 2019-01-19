Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E1C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1E42086A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1E42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hJGs6sW3zDqbW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 11:15:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hJDx2Jb4zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 11:13:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43hJDx0V7dz8t70
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 11:13:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43hJDw6LtSz9sDP; Sat, 19 Jan 2019 11:13:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43hJDw3LvXz9sDL
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2019 11:13:20 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C193AAD4C;
 Sat, 19 Jan 2019 00:13:16 +0000 (UTC)
Date: Sat, 19 Jan 2019 01:13:14 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/64s: Support shrinking the SLB for debugging
Message-ID: <20190119011314.45cb9864@naga>
In-Reply-To: <20190117121328.13395-4-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-4-mpe@ellerman.id.au>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Jan 2019 23:13:28 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On machines with 1TB segments and a 32-entry SLB it's quite hard to
> cause sufficient SLB pressure to trigger bugs caused due to badly
> timed SLB faults.
> 
> We have seen this in the past and a few years ago added the
> disable_1tb_segments command line option to force the use of 256MB
> segments. However even this allows some bugs to slip through testing
> if the SLB entry in question was recently accessed.
> 
> So add a new command line parameter for debugging which shrinks the
> SLB to the minimum size we can support. Currently that size is 3, two
> bolted SLBs and 1 for dynamic use. This creates the maximal SLB

Doesn't this violate the power of 2 requirement stated in 2/4?

Thanks

Michal

> pressure while still allowing the kernel to operate.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/slb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 61450a9cf30d..0f33e28f97da 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -506,10 +506,24 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  	asm volatile("isync" : : : "memory");
>  }
>  
> +static bool shrink_slb = false;
> +
> +static int __init parse_shrink_slb(char *p)
> +{
> +	shrink_slb = true;
> +	slb_set_size(0);
> +
> +	return 0;
> +}
> +early_param("shrink_slb", parse_shrink_slb);
> +
>  static u32 slb_full_bitmap;
>  
>  void slb_set_size(u16 size)
>  {
> +	if (shrink_slb)
> +		size = SLB_NUM_BOLTED + 1;
> +
>  	mmu_slb_size = size;
>  
>  	if (size >= 32)


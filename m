Return-Path: <SRS0=IXoQ=NA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAACC67863
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 07:02:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EB121486
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 07:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="kYPGjBPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EB121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42cYcX270dzF39v
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 18:02:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="kYPGjBPq";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42cYYq0qZkzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 17:59:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="kYPGjBPq"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42cYYp71rXz9sDK; Sat, 20 Oct 2018 17:59:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42cYYk0kwSz9sCs;
 Sat, 20 Oct 2018 17:59:37 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540018782; bh=W5m2t7bke8mdzOVyIMhE+lPjpUu7nJ6q+f7/Uhwus/c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kYPGjBPq+Wj8Eh+35R8VOEDpuN30IRzM8Bv65eLB7156gnBBxTdcDinDMd9ZxTQnT
 lUPADglieX5+s62aWGrUI7M1An1oQ6Zqwvte9kgXOo+qAYXcc17exfGnI3RNcEL8LB
 3VxBG/EPKpxbcBFQSsgiDgjH5yFzrB00QlCrITaUtmRKAT7d+xr6WWgMver31pvtQe
 Tm3YCbD2uR1TzPwoDttdXie7rT2iQrZjWVg/F6aJ3rGHRbAapNfnLSjtK1VBDSnNtL
 1Z6bfQmzBOWQHhw667zE7+uO1FWPhEKBuhBOgTb6xhj8u7FHw84mIe+C10O1g/aJ0q
 ldtw1mIscouHg==
Date: Sat, 20 Oct 2018 17:59:23 +1100
From: Anton Blanchard <anton@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/time: Fix clockevent_decrementer initalisation
 for PR KVM
Message-ID: <20181020175923.4cbc5434@kryten>
In-Reply-To: <20181019042319.9457-1-mpe@ellerman.id.au>
References: <20181019042319.9457-1-mpe@ellerman.id.au>
X-Mailer: Mutt/1.8.0 (2017-02-23)
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
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 19 Oct 2018 15:23:19 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> In the recent commit 8b78fdb045de ("powerpc/time: Use
> clockevents_register_device(), fixing an issue with large
> decrementer") we changed the way we initialise the decrementer
> clockevent(s).
> 
> We no longer initialise the mult & shift values of
> decrementer_clockevent itself.
> 
> This has the effect of breaking PR KVM, because it uses those values
> in kvmppc_emulate_dec(). The symptom is guest kernels spin forever
> mid-way through boot.
> 
> For now fix it by assigning back to decrementer_clockevent the mult
> and shift values.

Thanks Michael, I missed that completely.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> 
> Fixes: 8b78fdb045de ("powerpc/time: Use
> clockevents_register_device(), fixing an issue with large
> decrementer") Signed-off-by: Michael Ellerman <mpe@ellerman.id.au> ---
>  arch/powerpc/kernel/time.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 40868f3ee113..68e8f963d108 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -989,6 +989,10 @@ static void register_decrementer_clockevent(int
> cpu) 
>  	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d]
> cpu[%d]\n", dec->name, dec->mult, dec->shift, cpu);
> +
> +	/* Set values for KVM, see kvm_emulate_dec() */
> +	decrementer_clockevent.mult = dec->mult;
> +	decrementer_clockevent.shift = dec->shift;
>  }
>  
>  static void enable_large_decrementer(void)


Return-Path: <SRS0=ygHD=TN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C7C04AB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 06:43:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C2B20879
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="WL8j2isZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C2B20879
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 452WVb3SdczDqKr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 16:43:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452WSy6RY1zDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 16:42:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="WL8j2isZ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 452WSy2tP5z9s4Y; Mon, 13 May 2019 16:42:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1557729730; bh=bfjxecMrdmX4OfnJ3FpAf871ZQ2GIHJ1hAkeFqBk1YI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WL8j2isZzN21WNnf6psha+YqfAlDb9btXeL3ZX/QhF50KzvyC84Y5xGTE4GlMumC/
 bVyZRfSqyYfncHBMRU15MxWuzdG3ku92gGIIXFEyMLmWeR37u8Icq/000C3E3FI3DN
 n4hNuZcbr0lC74gdqqFfON+N5H/YgkeD1VYkPYjgxXspNYtVBXvLmEiqgAnLf3XiFd
 oBC5R5m5PpM5+WcjT0F/SgTkJ50TvtvaA+EsHPZaqtg6pYL/FaB2AxO1TSBXbsTQUn
 UfJjVKHPcwfpRHnkvACt1zx3bWeuu1NEuyveUaeubY9qvLmedTGBhRnhe0KewLKN1m
 FelH6kV6zkr8Q==
Date: Mon, 13 May 2019 16:42:07 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 2/2] powerpc/64s: KVM update for reimplement book3s
 idle code in C
Message-ID: <20190513064207.GA11679@blackberry>
References: <20190428114515.32683-1-npiggin@gmail.com>
 <20190428114515.32683-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428114515.32683-3-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 28, 2019 at 09:45:15PM +1000, Nicholas Piggin wrote:
> This is the KVM update to the new idle code. A few improvements:
> 
> - Idle sleepers now always return to caller rather than branch out
>   to KVM first.
> - This allows optimisations like very fast return to caller when no
>   state has been lost.
> - KVM no longer requires nap_state_lost because it controls NVGPR
>   save/restore itself on the way in and out.
> - The heavy idle wakeup KVM request check can be moved out of the
>   normal host idle code and into the not-performance-critical offline
>   code.
> - KVM nap code now returns from where it is called, which makes the
>   flow a bit easier to follow.

One question below...

> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 58d0f1ba845d..f66191d8f841 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
...
> @@ -2656,6 +2662,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  
>  	lis	r3, LPCR_PECEDP@h	/* Do wake on privileged doorbell */
>  
> +	/* Go back to host stack */
> +	ld	r1, HSTATE_HOST_R1(r13)

At this point we are in kvmppc_h_cede, which we branched to from
hcall_try_real_mode, which came from the guest exit path, where we
have already loaded r1 from HSTATE_HOST_R1(r13).  So if there is a
path to get here with r1 not already set to HSTATE_HOST_R1(r13), then
I missed it - please point it out to me.  Otherwise this statement
seems superfluous.

Paul.

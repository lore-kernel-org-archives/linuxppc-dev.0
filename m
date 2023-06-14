Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A0AEB64D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jun 2023 04:11:07 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=DFfOrXRu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QgsRY20z8z30hw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jun 2023 14:11:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=DFfOrXRu;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QgsQW3c7Yz301d
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2023 14:10:11 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4QgsQT3Xndz4x4G; Wed, 14 Jun 2023 14:10:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1686715809;
	bh=wvvRc9qy6Ni7t/b7z+9GETWf6P/wewVtlrltmdxCvjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFfOrXRu+Zyg3+Fad0QP8M1k5KhwxTXq8rYTpjt/ZqPs1emMh/0XpTc9GFfMQTXpC
	 x1Tg15tU6Ag18OQXH0RWERG/mlTQZwCdy/qgcFkoETTyIz015+f4eMr4vsq2rOrt7N
	 qkAEVOn27CnNPfU9vby0DDO2A5+XP00l9JqBzdCOz2nygF0MTFJ43y8nxi2nkXHraF
	 /7v6wQr2btfPPr6FGm0M3oBIfqVgehn3CxNCfHugZuUnu3ApTGMxmJ68Hd6fuWQGPf
	 FeZEJDiMEvlv1oCGlooxUfOdEz9qIchWVxiOeCulNIJYhnrHxW7AJgK/nx8h55syBh
	 QRRhLB5gU9FJg==
Date: Wed, 14 Jun 2023 14:10:05 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: baomingtong001@208suo.com
Subject: Re: [PATCH] KVM: PPC: remove unneeded variable
Message-ID: <ZIk9nVjY4G2xInd1@cleo>
References: <20230614023206.3865-1-luojianhong@cdjrlc.com>
 <de7ae31f88510a6b04f29fc01ab44854@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7ae31f88510a6b04f29fc01ab44854@208suo.com>
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
Cc: thuth@redhat.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, seanjc@google.com, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 14, 2023 at 10:34:45AM +0800, baomingtong001@208suo.com wrote:
> fix the following coccicheck warning:
> 
> arch/powerpc/kvm/book3s_pr.c:424:5-6: Unneeded variable: "r".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  arch/powerpc/kvm/book3s_pr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 9118242063fb..d03b31b240d7 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -421,14 +421,14 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
> 
>  static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
>  {
> -    int r = 1; /* Indicate we want to get back into the guest */
> +    /* Indicate we want to get back into the guest */

Instead of leaving the comment here, where it makes no sense, please
move it to the return statement below.

> 
>      /* We misuse TLB_FLUSH to indicate that we want to clear
>         all shadow cache entries */
>      if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
>          kvmppc_mmu_pte_flush(vcpu, 0, 0);
> 
> -    return r;
> +    return 1;
>  }
> 
>  /************* MMU Notifiers *************/

Paul.

Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75EC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:48:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E021520879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="UnXSexZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHXB2jbqzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:48:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPs5l3tzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="UnXSexZ5"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPs2tlzz9s9G; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135777; bh=wZ10BfTD5E0Lhh0YTRcpvE6cKeFqkB6KHAqlo4FUzwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UnXSexZ5aL8hoyBQ3j41+UekKDngiGQa7383zpcBaiLZxy7Wvg71A5FY5booER2T4
 XnjFtDjkBfo9oC/oEOkdpKE8EdCsy/raPWPkiAeNN0ITAevTNHvtxPTJiaFEZCv2rL
 eaDwfgAdx+EAOpZtYEml84gkGpIo6wKo94xi58kxasr6sCpvWInQpYxq0opPB8CZT2
 rCf5aXHECDSb15MSRJUigqrZpL8bKbovq3tZZfSZvor27rkEgh0CklSJ9LULouZoja
 v0o8MX+k9FuoWQsjGX22rS5Q0oyroRyOlsDDWypNueKMNBRblzSiiYwjU/NmIneNRQ
 6+ty5ii/y6UJA==
Date: Tue, 22 Jan 2019 15:56:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 03/19] KVM: PPC: Book3S HV: check the IRQ controller type
Message-ID: <20190122045642.GB15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-4-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 07, 2019 at 07:43:15PM +0100, Cédric Le Goater wrote:
> We will have different KVM devices for interrupts, one for the
> XICS-over-XIVE mode and one for the XIVE native exploitation
> mode. Let's add some checks to make sure we are not mixing the
> interfaces in KVM.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/kvm/book3s_xive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index f78d002f0fe0..8a4fa45f07f8 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -819,6 +819,9 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>  
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return -EPERM;
> +
>  	if (!xc)
>  		return 0;
>  
> @@ -835,6 +838,9 @@ int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
>  	u8 cppr, mfrr;
>  	u32 xisr;
>  
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return -EPERM;
> +
>  	if (!xc || !xive)
>  		return -ENOENT;

I can't see how these new checks could ever trigger in the code as it
stands.  Is there a way at present?  Do following patches ever add a
path where the new checks could trigger, or is this just an excess of
caution?  (Your patch description should ideally have answered these
questions for me.)

Paul.

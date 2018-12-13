Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C1C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 05:26:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A9320672
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 05:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="r3Awj8W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A9320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fhxl6MwtzDqZQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 16:26:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="r3Awj8W/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fhtz2jMvzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 16:24:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="r3Awj8W/"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43Fhty6VcSz9sB5; Thu, 13 Dec 2018 16:24:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544678666; bh=C3xG7BpB7RrOW1qVUJww46ozhkYbAJjuxsx0SX3yomY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r3Awj8W/kRr1yQwzUpyvw399Tbz+d0CgMs71o2Iypyk4gM5ki4G+9dzT+YF7zP8EE
 fP3eqLorYHc/GTyMQTra7po2A2X3UX8s52A6VTmHOwBMr0JZ0M5avh0SDSmhw4Hwmo
 e8n+HrLobXV6MPgJWZjAKeaIVu+a3XlZEESH2lBgg1GD15lIp/teiK8fO1Ew4rAmyS
 7BSFvGO3s+HaDU8/NDtV3cBWIJ0KCktG+haBDl6hdYy1EDzcVNkbcoWrYEPgc0Zqn2
 +B22JA4OLO+v62ygnTsYCLJyr6nNRT7p7CZCMrzjxBp/BZKMnSI0fuUTNtgNZA1yVn
 QbWjzyF5439JA==
Date: Thu, 13 Dec 2018 16:24:18 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH V2 7/8] KVM: PPC: Introduce new hcall H_COPY_TOFROM_GUEST
 to access quadrants 1 & 2
Message-ID: <20181213052417.GA8827@blackberry>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
 <20181210035825.29404-8-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210035825.29404-8-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 10, 2018 at 02:58:24PM +1100, Suraj Jitindar Singh wrote:
> A guest cannot access quadrants 1 or 2 as this would result in an
> exception. Thus introduce the hcall H_COPY_TOFROM_GUEST to be used by a
> guest when it wants to perform an access to quadrants 1 or 2, for
> example when it wants to access memory for one of its nested guests.
> 
> Also provide an implementation for the kvm-hv module.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

[snip]

>  /*
> + * Handle the H_COPY_TOFROM_GUEST hcall.
> + * r4 = L1 lpid of nested guest
> + * r5 = pid
> + * r6 = eaddr to access
> + * r7 = to buffer (L1 gpa)
> + * r8 = from buffer (L1 gpa)

Comment says these are GPAs...

> + * r9 = n bytes to copy
> + */
> +long kvmhv_copy_tofrom_guest_nested(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_nested_guest *gp;
> +	int l1_lpid = kvmppc_get_gpr(vcpu, 4);
> +	int pid = kvmppc_get_gpr(vcpu, 5);
> +	gva_t eaddr = kvmppc_get_gpr(vcpu, 6);
> +	void *gp_to = (void *) kvmppc_get_gpr(vcpu, 7);
> +	void *gp_from = (void *) kvmppc_get_gpr(vcpu, 8);
> +	void *buf;
> +	unsigned long n = kvmppc_get_gpr(vcpu, 9);
> +	bool is_load = !!gp_to;
> +	long rc;
> +
> +	if (gp_to && gp_from) /* One must be NULL to determine the direction */
> +		return H_PARAMETER;
> +
> +	if (eaddr & (0xFFFUL << 52))
> +		return H_PARAMETER;
> +
> +	buf = kzalloc(n, GFP_KERNEL);
> +	if (!buf)
> +		return H_NO_MEM;
> +
> +	gp = kvmhv_get_nested(vcpu->kvm, l1_lpid, false);
> +	if (!gp) {
> +		rc = H_PARAMETER;
> +		goto out_free;
> +	}
> +
> +	mutex_lock(&gp->tlb_lock);
> +
> +	if (is_load) {
> +		/* Load from the nested guest into our buffer */
> +		rc = __kvmhv_copy_tofrom_guest_radix(gp->shadow_lpid, pid,
> +						     eaddr, buf, NULL, n);
> +		if (rc)
> +			goto not_found;
> +
> +		/* Write what was loaded into our buffer back to the L1 guest */
> +		rc = kvmppc_st(vcpu, (ulong *) &gp_to, n, buf, true);

but using kvmppc_st implies that it is an EA (and in fact when you
call it in the next patch you pass an EA).

It would be more like other hcalls to pass a GPA, meaning that you
would use kvm_write_guest() here.  On the other hand, with the
quadrant access, kvmppc_st() might well be faster than
kvm_write_guest.

So you need to decide which it is and either fix the comment or change
the code.

Paul.

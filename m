Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC45C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 02:07:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BC02075B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 02:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLXsCF+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BC02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GDT41H8bzDr4R
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 13:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLXsCF+Y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLXsCF+Y"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GDQG0n9gzDqy9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 13:04:53 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id i12so2023933pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XAOuSnvLznc5xfVAAzl2XrOksvScsM+7FxgEkiZa3h0=;
 b=mLXsCF+YIDLjHN6qt5LdD8HTgVHDGfLBRAzeJI6THtbZW+a5FxibTuFWqwIT1xdTOS
 vs2IF/PKHe9E/4Env2WN/77RNi2LNq9929en8WjDpmgjQfY1OKwM7EA/lvxvxSBSfVhL
 DM1SGrWFTj6r3KfGNJ0jlADWfXGNU2K45iH1T3YY7QIab589/H/BUKSaKnhWr413lyli
 mYwDxIf9DC7bDWgaWpWfTxf0u0k1aOkjvGIHqiktZdLDAthE1RMrFCeVydwWBVN33Ki4
 TrAc81dcesB0nDtwWQ9DjKFoHEB6DZ4MLDTziFaD3OYVanjBOD7+BkS8NU/awOOqhuBr
 wgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XAOuSnvLznc5xfVAAzl2XrOksvScsM+7FxgEkiZa3h0=;
 b=AG4/PHFL8lkXyhkyNNXwi/A5AK6l6y7+u6CPA7LSAylaGP8tLnIcsYz6Zzb3OUATsC
 mwZrmba3DadRSoHRxBbvFkksosjev6j6oxtSUXXqVXsRS3//3hGhuvxopGV290QqrDYC
 jwPSEQI5VrU8sWiBu+ky2DPfcKs1A05IYp5uj/1Bu7tnOJedqWzyjj4lPYnkpRZv3R3S
 PvMng8m/221UTqLIlmas/CRabAdiLA4+Vg+02VqxK8BSG7g8rTzUKdsdI59bb4wYwdGw
 Z/r2twecra3+6Uh/zQ3mhepdIyXEYnxMzZL/WdSNA4uMuzAkKT6Zn2OedIAXPBjPSOCO
 0zZQ==
X-Gm-Message-State: AA+aEWbkDYOMlxIPPIvbJTRkOV+tatvLRzLVpwFiplWmquCP4ZJaYu9S
 JkcJ+ASv9F1oKqzf4DckioI=
X-Google-Smtp-Source: AFSGD/WI+pwaeKKz6En7tRn8YR6zZ50gDK2Y3fFtwkWtbnqD/He4nKDnUfZ1vysp30jyeo5mk+Brdg==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr1140062pfa.30.1544753091560; 
 Thu, 13 Dec 2018 18:04:51 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id i193sm4764932pgc.22.2018.12.13.18.04.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 18:04:48 -0800 (PST)
Message-ID: <1544753082.1865.8.camel@gmail.com>
Subject: Re: [PATCH V2 7/8] KVM: PPC: Introduce new hcall
 H_COPY_TOFROM_GUEST to access quadrants 1 & 2
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Date: Fri, 14 Dec 2018 13:04:42 +1100
In-Reply-To: <20181213052417.GA8827@blackberry>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
 <20181210035825.29404-8-sjitindarsingh@gmail.com>
 <20181213052417.GA8827@blackberry>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-12-13 at 16:24 +1100, Paul Mackerras wrote:
> On Mon, Dec 10, 2018 at 02:58:24PM +1100, Suraj Jitindar Singh wrote:
> > A guest cannot access quadrants 1 or 2 as this would result in an
> > exception. Thus introduce the hcall H_COPY_TOFROM_GUEST to be used
> > by a
> > guest when it wants to perform an access to quadrants 1 or 2, for
> > example when it wants to access memory for one of its nested
> > guests.
> > 
> > Also provide an implementation for the kvm-hv module.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> [snip]
> 
> >  /*
> > + * Handle the H_COPY_TOFROM_GUEST hcall.
> > + * r4 = L1 lpid of nested guest
> > + * r5 = pid
> > + * r6 = eaddr to access
> > + * r7 = to buffer (L1 gpa)
> > + * r8 = from buffer (L1 gpa)
> 
> Comment says these are GPAs...
> 
> > + * r9 = n bytes to copy
> > + */
> > +long kvmhv_copy_tofrom_guest_nested(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_nested_guest *gp;
> > +	int l1_lpid = kvmppc_get_gpr(vcpu, 4);
> > +	int pid = kvmppc_get_gpr(vcpu, 5);
> > +	gva_t eaddr = kvmppc_get_gpr(vcpu, 6);
> > +	void *gp_to = (void *) kvmppc_get_gpr(vcpu, 7);
> > +	void *gp_from = (void *) kvmppc_get_gpr(vcpu, 8);
> > +	void *buf;
> > +	unsigned long n = kvmppc_get_gpr(vcpu, 9);
> > +	bool is_load = !!gp_to;
> > +	long rc;
> > +
> > +	if (gp_to && gp_from) /* One must be NULL to determine the
> > direction */
> > +		return H_PARAMETER;
> > +
> > +	if (eaddr & (0xFFFUL << 52))
> > +		return H_PARAMETER;
> > +
> > +	buf = kzalloc(n, GFP_KERNEL);
> > +	if (!buf)
> > +		return H_NO_MEM;
> > +
> > +	gp = kvmhv_get_nested(vcpu->kvm, l1_lpid, false);
> > +	if (!gp) {
> > +		rc = H_PARAMETER;
> > +		goto out_free;
> > +	}
> > +
> > +	mutex_lock(&gp->tlb_lock);
> > +
> > +	if (is_load) {
> > +		/* Load from the nested guest into our buffer */
> > +		rc = __kvmhv_copy_tofrom_guest_radix(gp-
> > >shadow_lpid, pid,
> > +						     eaddr, buf,
> > NULL, n);
> > +		if (rc)
> > +			goto not_found;
> > +
> > +		/* Write what was loaded into our buffer back to
> > the L1 guest */
> > +		rc = kvmppc_st(vcpu, (ulong *) &gp_to, n, buf,
> > true);
> 
> but using kvmppc_st implies that it is an EA (and in fact when you
> call it in the next patch you pass an EA).
> 
> It would be more like other hcalls to pass a GPA, meaning that you
> would use kvm_write_guest() here.  On the other hand, with the
> quadrant access, kvmppc_st() might well be faster than
> kvm_write_guest.
> 
> So you need to decide which it is and either fix the comment or
> change
> the code.

Lets stick with gpa for now then for consistency, with room for
optimisation.

> 
> Paul.

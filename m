Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C271EC43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 02:22:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C712077D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 02:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRr/HqlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C712077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tkGZ5jV3zDqNX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 13:22:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cRr/HqlX; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tkDf28S5zDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 13:20:34 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id m15so2295147pje.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Re4NQk2RB9sNiF8DGAf288Mt9Yn1VNpDfRDodIkG9K8=;
 b=cRr/HqlXxeXOv6l1esgPf6GJPSAaY0eW5WZs98vVxw/Q6fl5VefdUAwGOjzL/jlmZb
 prtFUMD2ru3KEHM6bwC64XEHIMUcrDT85aIy7G7kxQzoYP7SSIP0JKTwnH8qyTMhl187
 WXgizP240w+Bk3+aP8HblpslaS+EvDe9OKGeyKKd3b4ET+PzQk+361y7uotMEEpx0Iaq
 p4Gr4y3VwWa/nEXDDx2uVnlxMFHHVxi4Ii4RgOI+zF65UUJp0+EzuVanOntIOfFFXkow
 gUKJIGCN90CSiypDyTAmRQ3FjmyK2LM+zQV2ZRDhvQEZ9jm530EuQOomYRYg9uRe1DaN
 4Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Re4NQk2RB9sNiF8DGAf288Mt9Yn1VNpDfRDodIkG9K8=;
 b=VyvTWb4ObQWkLG5y7IKDmHAX61qFeSxW6JZdzYQ3ESGdJATivuQUF4S/7cEre4wLFk
 GDsEAdX7ewBjG0I1VCpin3ilZznL6eCjBhNe9nXxxNfg/nr05h9moTmwAibCbqIWbN6o
 L8EklFX33+RyBKN+X01MrBb1XSybjpCofml9FxEKiS4QRiIY96wPwtMwjPsay5KOcwAO
 BgdvKq0QjE1W3MYE3QIiDd1nofhMal0rAtc+6TUpxaYPnv7KAsZIO2g0CDJIL04qH0WI
 +T4F5FTdS4NWUoQvVoNvdVgOpYMQGD6Y4FhTlziT7EipVVMxY4gNMgXoTWomiv70bbLu
 hvPA==
X-Gm-Message-State: AGi0PuZaJppHL97vBJmwUt0i69YXI9k/ALHvfMYhufk6wWJmG1/DXvrb
 9Us2wcko0b70f37CKiCqJPI=
X-Google-Smtp-Source: APiQypLKK3WBeepcwTRI0VWs0W7SjIgNVI0eDYXodL9N/SmWKhnh7oFwi/EYOmS4Or2CSwXdtfwYhw==
X-Received: by 2002:a17:90a:2307:: with SMTP id
 f7mr7058981pje.152.1585880432205; 
 Thu, 02 Apr 2020 19:20:32 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id 193sm4707503pfa.182.2020.04.02.19.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 19:20:31 -0700 (PDT)
Date: Fri, 03 Apr 2020 12:20:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC/PATCH  2/3] pseries/kvm: Clear PSSCR[ESL|EC] bits before
 guest entry
To: Bharata B Rao <bharata@linux.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
References: <1585656658-1838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1585656658-1838-3-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1585656658-1838-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585880159.w3mc2nk6h3.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Gautham R. Shenoy's on March 31, 2020 10:10 pm:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> ISA v3.0 allows the guest to execute a stop instruction. For this, the
> PSSCR[ESL|EC] bits need to be cleared by the hypervisor before
> scheduling in the guest vCPU.
>=20
> Currently we always schedule in a vCPU with PSSCR[ESL|EC] bits
> set. This patch changes the behaviour to enter the guest with
> PSSCR[ESL|EC] bits cleared. This is a RFC patch where we
> unconditionally clear these bits. Ideally this should be done
> conditionally on platforms where the guest stop instruction has no
> Bugs (starting POWER9 DD2.3).

How will guests know that they can use this facility safely after your
series? You need both DD2.3 and a patched KVM.

>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c            |  2 +-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 25 +++++++++++++------------
>  2 files changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index cdb7224..36d059a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3424,7 +3424,7 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcp=
u *vcpu, u64 time_limit,
>  	mtspr(SPRN_IC, vcpu->arch.ic);
>  	mtspr(SPRN_PID, vcpu->arch.pid);
> =20
> -	mtspr(SPRN_PSSCR, vcpu->arch.psscr | PSSCR_EC |
> +	mtspr(SPRN_PSSCR, (vcpu->arch.psscr  & ~(PSSCR_EC | PSSCR_ESL)) |
>  	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
> =20
>  	mtspr(SPRN_HFSCR, vcpu->arch.hfscr);
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index dbc2fec..c2daec3 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -823,6 +823,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_PID, r7
>  	mtspr	SPRN_WORT, r8
>  BEGIN_FTR_SECTION
> +	/* POWER9-only registers */
> +	ld	r5, VCPU_TID(r4)
> +	ld	r6, VCPU_PSSCR(r4)
> +	lbz	r8, HSTATE_FAKE_SUSPEND(r13)
> +	lis 	r7, (PSSCR_EC | PSSCR_ESL)@h /* Allow guest to call stop */
> +	andc	r6, r6, r7
> +	rldimi	r6, r8, PSSCR_FAKE_SUSPEND_LG, 63 - PSSCR_FAKE_SUSPEND_LG
> +	ld	r7, VCPU_HFSCR(r4)
> +	mtspr	SPRN_TIDR, r5
> +	mtspr	SPRN_PSSCR, r6
> +	mtspr	SPRN_HFSCR, r7
> +FTR_SECTION_ELSE

Why did you move these around? Just because the POWER9 section became
larger than the other?

That's a real wart in the instruction patching implementation, I think
we can fix it by padding with nops in the macros.

Can you just add the additional required nops to the top branch without
changing them around for this patch, so it's easier to see what's going
on? The end result will be the same after patching. Actually changing
these around can have a slight unintended consequence in that code that
runs before features were patched will execute the IF code. Not a
problem here, but another reason why the instruction patching=20
restriction is annoying.

Thanks,
Nick

>  	/* POWER8-only registers */
>  	ld	r5, VCPU_TCSCR(r4)
>  	ld	r6, VCPU_ACOP(r4)
> @@ -833,18 +845,7 @@ BEGIN_FTR_SECTION
>  	mtspr	SPRN_CSIGR, r7
>  	mtspr	SPRN_TACR, r8
>  	nop
> -FTR_SECTION_ELSE
> -	/* POWER9-only registers */
> -	ld	r5, VCPU_TID(r4)
> -	ld	r6, VCPU_PSSCR(r4)
> -	lbz	r8, HSTATE_FAKE_SUSPEND(r13)
> -	oris	r6, r6, PSSCR_EC@h	/* This makes stop trap to HV */
> -	rldimi	r6, r8, PSSCR_FAKE_SUSPEND_LG, 63 - PSSCR_FAKE_SUSPEND_LG
> -	ld	r7, VCPU_HFSCR(r4)
> -	mtspr	SPRN_TIDR, r5
> -	mtspr	SPRN_PSSCR, r6
> -	mtspr	SPRN_HFSCR, r7
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  8:
> =20
>  	ld	r5, VCPU_SPRG0(r4)
> --=20
> 1.9.4
>=20
>=20
=

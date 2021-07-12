Return-Path: <SRS0=qNK6=ME=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4803CC07E96
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 02:50:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824AC6103E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 02:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824AC6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GNSt94XNyz3bW3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 12:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BKehAuhb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BKehAuhb; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GNSsZ0Z90z2yRT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jul 2021 12:49:36 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 x21-20020a17090aa395b029016e25313bfcso9686935pjp.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jul 2021 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=SNO1KimycIzKpt5Apyoty4HeLUuDV+TjJEXeIogdbvE=;
 b=BKehAuhbcq54ppez/+TFzzsO+x1UFuoOgwS4+TBBBQ7jrSHYIHtgzVCwGFmneIWEk/
 4QrK6KtcusgWU3EBbm58/5+ogKMvRzhys+xT2CJnkXqIUuyoR/5zkIW4mq0Om3tHYUzl
 /BKwzPirkhh5C8OATGbeMB+wCPUv8DEAYGAIVajB8FhBLjqQlpzhWHw30KcFjuWTCisZ
 4jxNOI48saYRCTPXwDZe91E1Yc8ew6g2MGjMCVtsjPzhLP1wzDS8pYCobEJbOf5qCECt
 zfEhzGcsTq9yvglEHYJ1K4utKer0z1tVuguaxGP+2pQe9rNT8ynxPVRkU/WWXUVMuCB2
 ugQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=SNO1KimycIzKpt5Apyoty4HeLUuDV+TjJEXeIogdbvE=;
 b=D8c35hwtoXrVHGbet+lYXYrrNbn/cSMsE5pLHrftvKZXDpLKb5/k8zYbHRBsqxRnpM
 7XCET7HcxuA0ZWkOVWWurJPE2IckoAQwzROz4wOipn0isuyOdLql+UvgKecpov1eKUQu
 xMLVjBzZMDNFTgzhb6IMdBiiv08WrjnnI2PMLv3wHUgHopHuxm73Oex6oQzcYGs7NDDj
 p52euLLzOLjcujZLtCDj54sEwqn8550jzthS0OuABdLzdAYEApmQ3amqY4nFHjsmQc1o
 3GkDFPwOPxtonHw1hhJg2/PYsG2Oo5UpMhTY90enVloThnjO1ipSBqNzaMJIsopvHNXN
 5MIA==
X-Gm-Message-State: AOAM53234uuSlLZDeCS9coi6O4pNGgFPMp5XzGeXN+TSoQ//faNYRcvb
 C3pIghSxu62YbeSBnx0Sp0Q=
X-Google-Smtp-Source: ABdhPJwpBi7gJS3g4qVNqz79SV6nITfMUOcG/gU7gdW5uwHe0FPJdsAq0kTFwM/IZodoSsYOc6Z6yg==
X-Received: by 2002:a17:90a:b28a:: with SMTP id
 c10mr11641822pjr.59.1626058173348; 
 Sun, 11 Jul 2021 19:49:33 -0700 (PDT)
Received: from localhost (203-219-181-43.static.tpgi.com.au. [203.219.181.43])
 by smtp.gmail.com with ESMTPSA id
 x40sm531402pfu.176.2021.07.11.19.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 19:49:32 -0700 (PDT)
Date: Mon, 12 Jul 2021 12:49:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 11/43] KVM: PPC: Book3S HV P9: Implement PMU
 save/restore in C
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
 <20210622105736.633352-12-npiggin@gmail.com>
 <A647F37A-F32C-46B7-8A2E-C4D7CDB012E3@linux.vnet.ibm.com>
In-Reply-To: <A647F37A-F32C-46B7-8A2E-C4D7CDB012E3@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1626057686.aeolnlaqjr.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Athira Rajeev's message of July 10, 2021 12:47 pm:
>=20
>=20
>> On 22-Jun-2021, at 4:27 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> Implement the P9 path PMU save/restore code in C, and remove the
>> POWER9/10 code from the P7/8 path assembly.
>>=20
>> -449 cycles (8533) POWER9 virt-mode NULL hcall
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> arch/powerpc/include/asm/asm-prototypes.h |   5 -
>> arch/powerpc/kvm/book3s_hv.c              | 205 ++++++++++++++++++++--
>> arch/powerpc/kvm/book3s_hv_interrupts.S   |  13 +-
>> arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  43 +----
>> 4 files changed, 200 insertions(+), 66 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/in=
clude/asm/asm-prototypes.h
>> index 02ee6f5ac9fe..928db8ef9a5a 100644
>> --- a/arch/powerpc/include/asm/asm-prototypes.h
>> +++ b/arch/powerpc/include/asm/asm-prototypes.h
>> @@ -136,11 +136,6 @@ static inline void kvmppc_restore_tm_hv(struct kvm_=
vcpu *vcpu, u64 msr,
>> 					bool preserve_nv) { }
>> #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>>=20
>> -void kvmhv_save_host_pmu(void);
>> -void kvmhv_load_host_pmu(void);
>> -void kvmhv_save_guest_pmu(struct kvm_vcpu *vcpu, bool pmu_in_use);
>> -void kvmhv_load_guest_pmu(struct kvm_vcpu *vcpu);
>> -
>> void kvmppc_p9_enter_guest(struct kvm_vcpu *vcpu);
>>=20
>> long kvmppc_h_set_dabr(struct kvm_vcpu *vcpu, unsigned long dabr);
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index f7349d150828..b1b94b3563b7 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -3635,6 +3635,188 @@ static noinline void kvmppc_run_core(struct kvmp=
pc_vcore *vc)
>> 	trace_kvmppc_run_core(vc, 1);
>> }
>>=20
>> +/*
>> + * Privileged (non-hypervisor) host registers to save.
>> + */
>> +struct p9_host_os_sprs {
>> +	unsigned long dscr;
>> +	unsigned long tidr;
>> +	unsigned long iamr;
>> +	unsigned long amr;
>> +	unsigned long fscr;
>> +
>> +	unsigned int pmc1;
>> +	unsigned int pmc2;
>> +	unsigned int pmc3;
>> +	unsigned int pmc4;
>> +	unsigned int pmc5;
>> +	unsigned int pmc6;
>> +	unsigned long mmcr0;
>> +	unsigned long mmcr1;
>> +	unsigned long mmcr2;
>> +	unsigned long mmcr3;
>> +	unsigned long mmcra;
>> +	unsigned long siar;
>> +	unsigned long sier1;
>> +	unsigned long sier2;
>> +	unsigned long sier3;
>> +	unsigned long sdar;
>> +};
>> +
>> +static void freeze_pmu(unsigned long mmcr0, unsigned long mmcra)
>> +{
>> +	if (!(mmcr0 & MMCR0_FC))
>> +		goto do_freeze;
>> +	if (mmcra & MMCRA_SAMPLE_ENABLE)
>> +		goto do_freeze;
>> +	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +		if (!(mmcr0 & MMCR0_PMCCEXT))
>> +			goto do_freeze;
>> +		if (!(mmcra & MMCRA_BHRB_DISABLE))
>> +			goto do_freeze;
>> +	}
>> +	return;
>=20
>=20
> Hi Nick
>=20
> When freezing the PMU, do we need to also set pmcregs_in_use to zero ?

Not immediately, we still need to save out the values of the PMU=20
registers. If we clear pmcregs_in_use, then our hypervisor can discard=20
the contents of those registers at any time.

> Also, why we need these above conditions like MMCRA_SAMPLE_ENABLE,  MMCR0=
_PMCCEXT checks also before freezing ?

Basically just because that's the condition we wnat to set the PMU to=20
before entering the guest if the guest does not have its own PMU=20
registers in use.

I'm not entirely sure this is correct / optimal for perf though, so we
should double check that. I think some of this stuff should be wrapped=20
up and put into perf/ subdirectory as I've said before. KVM shouldn't=20
need to know about exactly how PMU is to be set up and managed by
perf, we should just be able to ask perf to save/restore/switch state.

Thanks,
Nick

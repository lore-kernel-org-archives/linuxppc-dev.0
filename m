Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E31C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:11:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D746D2084A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G03E+3WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vqJy55XHzF3LQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 14:11:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G03E+3WJ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vqGJ0mfwzF3JB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:09:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="G03E+3WJ"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42vqGJ00b4z8x0y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:09:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42vqGH6kmdz9sCQ; Wed, 14 Nov 2018 14:09:11 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="G03E+3WJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42vqGG6hR2z9s8J;
 Wed, 14 Nov 2018 14:09:10 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g7-v6so7120663pfo.10;
 Tue, 13 Nov 2018 19:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Wh2tSh4Fj+oX5dlC6xme9YHcYd/3psgOTqQQo3w5zU=;
 b=G03E+3WJ9LilQNpxNV+3GUr+OXoJNoTIfDLBJvWNG9HwMiCZIJwXsVuJ90SAJlHeqM
 4nQF72PUqnRvq3U5VOyyBQK/F2Or+b0g/y8tnO6wxzKY8M7w89zOqUBYhMLqDcjTIVnh
 1hyYe6lNohU4zPaI9mHZq5L/+OTHhWoKanSugCKMhpjHVFvQhEjiRKSk7qvz0AinN41K
 EYFV4OMmRWlNsA8tSNCNd5n8LpW87orQmcYZi0/9+ltqF+YNsqUAWKX3Z+kn+0WwMhmX
 KvRSBkk7hhvt99ah5QVqiHuoPiHONNT2EEPlR3bMMATn1TaSjjPGfG+j/rCV5xb1jkY7
 szqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Wh2tSh4Fj+oX5dlC6xme9YHcYd/3psgOTqQQo3w5zU=;
 b=eGSniaOCRNTcBgEv8niqZkKILFUWSzTBj94HGVV5YIOOmNECn/xV8bcWB+WLncJ0im
 UrbJ6shgOUEbQ+O1iw4eIf3IGTuvtpvq5pL+SbWPqoYXP5QjN+KNr6n9ar8Z7jFCWPrt
 Zw/gj9//LIDzRtmO3PmtsH9xBOivyvOg3UFCGT3R4kOUl2rsVzaHeGmWOG1Kx1EpbAW5
 rW6549ZL2QQCyKF0cCHqAMqbdlzYQfpo9NUs61EZyA1p765kWtuQbCR6wRjVmE0bWlcB
 WH6ohDdZCHoMcspVRLXG5QOae8tGSDo1gIPGfDryaIOr3V6JNlEoKO+fkGjf0HoYoPo1
 WupA==
X-Gm-Message-State: AGRZ1gKyH1lz+ALAF9MG3ThDgT4MDd9eu96TQ/2ZV3025cYCalaV07Mw
 vAmJ1FDnZYLuMBqyRGnbh+U=
X-Google-Smtp-Source: AJdET5eTSZjMAFxwwU0uaM0n2Z2KnlkbsgEt7A8e3SKCQLvO7Gib5u6bzy4q7ZR8Z0s+57l7sML5+w==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr220577pfe.148.1542164948950; 
 Tue, 13 Nov 2018 19:09:08 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id n22sm854434pfh.166.2018.11.13.19.09.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Nov 2018 19:09:08 -0800 (PST)
Message-ID: <1542164943.17117.0.camel@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: fix handling for interrupted
 H_ENTER_NESTED
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, kvm@vger.kernel.org
Date: Wed, 14 Nov 2018 14:09:03 +1100
In-Reply-To: <20181109032723.16394-1-mdroth@linux.vnet.ibm.com>
References: <20181109032723.16394-1-mdroth@linux.vnet.ibm.com>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-08 at 21:27 -0600, Michael Roth wrote:
> While running a nested guest VCPU on L0 via H_ENTER_NESTED hcall, a
> pending signal in the L0 QEMU process can generate the following
> sequence:
> 
>   ret0 = kvmppc_pseries_do_hcall()
>     ret1 = kvmhv_enter_nested_guest()
>       ret2 = kvmhv_run_single_vcpu()
>       if (ret2 == -EINTR)
>         return H_INTERRUPT
>     if (ret1 == H_INTERRUPT)
>       kvmppc_set_gpr(vcpu, 3, 0)
>       return -EINTR
>     /* skipped: */
>     kvmppc_set_gpr(vcpu, 3, ret)
>     vcpu->arch.hcall_needed = 0
>     return RESUME_GUEST
> 
> which causes an exit to L0 userspace with ret0 == -EINTR.
> 
> The intention seems to be to set the hcall return value to 0 (via
> VCPU r3) so that L1 will see a successful return from H_ENTER_NESTED
> once we resume executing the VCPU. However, because we don't set
> vcpu->arch.hcall_needed = 0, we do the following once userspace
> resumes execution via kvm_arch_vcpu_ioctl_run():
> 
>   ...
>   } else if (vcpu->arch.hcall_needed) {
>     int i
> 
>     kvmppc_set_gpr(vcpu, 3, run->papr_hcall.ret);
>     for (i = 0; i < 9; ++i)
>            kvmppc_set_gpr(vcpu, 4 + i, run->papr_hcall.args[i]);
>     vcpu->arch.hcall_needed = 0;
> 
> since vcpu->arch.hcall_needed == 1 indicates that userspace should
> have handled the hcall and stored the return value in
> run->papr_hcall.ret. Since that's not the case here, we can get an
> unexpected value in VCPU r3, which can result in
> kvmhv_p9_guest_entry() reporting an unexpected trap value when it
> returns from H_ENTER_NESTED, causing the following register dump to
> console via subsequent call to kvmppc_handle_exit_hv() in L1:
> 
>   [  350.612854] vcpu 00000000f9564cf8 (0):
>   [  350.612915] pc  = c00000000013eb98  msr = 8000000000009033  trap
> = 1
>   [  350.613020] r 0 = c0000000004b9044  r16 = 0000000000000000
>   [  350.613075] r 1 = c00000007cffba30  r17 = 0000000000000000
>   [  350.613120] r 2 = c00000000178c100  r18 = 00007fffc24f3b50
>   [  350.613166] r 3 = c00000007ef52480  r19 = 00007fffc24fff58
>   [  350.613212] r 4 = 0000000000000000  r20 = 00000a1e96ece9d0
>   [  350.613253] r 5 = 70616d00746f6f72  r21 = 00000a1ea117c9b0
>   [  350.613295] r 6 = 0000000000000020  r22 = 00000a1ea1184360
>   [  350.613338] r 7 = c0000000783be440  r23 = 0000000000000003
>   [  350.613380] r 8 = fffffffffffffffc  r24 = 00000a1e96e9e124
>   [  350.613423] r 9 = c00000007ef52490  r25 = 00000000000007ff
>   [  350.613469] r10 = 0000000000000004  r26 = c00000007eb2f7a0
>   [  350.613513] r11 = b0616d0009eccdb2  r27 = c00000007cffbb10
>   [  350.613556] r12 = c0000000004b9000  r28 = c00000007d83a2c0
>   [  350.613597] r13 = c000000001b00000  r29 = c0000000783cdf68
>   [  350.613639] r14 = 0000000000000000  r30 = 0000000000000000
>   [  350.613681] r15 = 0000000000000000  r31 = c00000007cffbbf0
>   [  350.613723] ctr = c0000000004b9000  lr  = c0000000004b9044
>   [  350.613765] srr0 = 0000772f954dd48c srr1 = 800000000280f033
>   [  350.613808] sprg0 = 0000000000000000 sprg1 = c000000001b00000
>   [  350.613859] sprg2 = 0000772f9565a280 sprg3 = 0000000000000000
>   [  350.613911] cr = 88002848  xer = 0000000020040000  dsisr =
> 42000000
>   [  350.613962] dar = 0000772f95390000
>   [  350.614031] fault dar = c000000244b278c0 dsisr = 00000000
>   [  350.614073] SLB (0 entries):
>   [  350.614157] lpcr = 0040000003d40413 sdr1 = 0000000000000000
> last_inst = ffffffff
>   [  350.614252] trap=0x1 | pc=0xc00000000013eb98 |
> msr=0x8000000000009033
> 
> followed by L1's QEMU reporting the following before stopping
> execution
> of the nested guest:
> 
>   KVM: unknown exit, hardware reason 1
>   NIP c00000000013eb98   LR c0000000004b9044 CTR c0000000004b9000 XER
> 0000000020040000 CPU#0
>   MSR 8000000000009033 HID0 0000000000000000  HF 8000000000000000
> iidx 3 didx 3
>   TB 00000000 00000000 DECR 00000000
>   GPR00 c0000000004b9044 c00000007cffba30 c00000000178c100
> c00000007ef52480
>   GPR04 0000000000000000 70616d00746f6f72 0000000000000020
> c0000000783be440
>   GPR08 fffffffffffffffc c00000007ef52490 0000000000000004
> b0616d0009eccdb2
>   GPR12 c0000000004b9000 c000000001b00000 0000000000000000
> 0000000000000000
>   GPR16 0000000000000000 0000000000000000 00007fffc24f3b50
> 00007fffc24fff58
>   GPR20 00000a1e96ece9d0 00000a1ea117c9b0 00000a1ea1184360
> 0000000000000003
>   GPR24 00000a1e96e9e124 00000000000007ff c00000007eb2f7a0
> c00000007cffbb10
>   GPR28 c00000007d83a2c0 c0000000783cdf68 0000000000000000
> c00000007cffbbf0
>   CR 88002848  [ L  L  -  -  E  L  G  L  ]             RES
> ffffffffffffffff
>    SRR0 0000772f954dd48c  SRR1 800000000280f033    PVR
> 00000000004e1202 VRSAVE 0000000000000000
>   SPRG0 0000000000000000 SPRG1 c000000001b00000  SPRG2
> 0000772f9565a280  SPRG3 0000000000000000
>   SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6
> 0000000000000000  SPRG7 0000000000000000
>   HSRR0 0000000000000000 HSRR1 0000000000000000
>    CFAR 0000000000000000
>    LPCR 0000000003d40413
>    PTCR 0000000000000000   DAR 0000772f95390000  DSISR
> 0000000042000000
> 
> Fix this by setting vcpu->arch.hcall_needed = 0 to indicate
> completion
> of H_ENTER_NESTED before we exit to L0 userspace.

Nice Catch :)

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> 
> Cc: linuxppc-dev@ozlabs.org
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c
> b/arch/powerpc/kvm/book3s_hv.c
> index d65b961661fb..a56f8413758a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -983,6 +983,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu
> *vcpu)
>  		ret = kvmhv_enter_nested_guest(vcpu);
>  		if (ret == H_INTERRUPT) {
>  			kvmppc_set_gpr(vcpu, 3, 0);
> +			vcpu->arch.hcall_needed = 0;
>  			return -EINTR;
>  		}
>  		break;

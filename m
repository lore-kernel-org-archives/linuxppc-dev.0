Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8C606A33C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpNw+k3e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBPh1Bf8z2xmV;
	Thu, 12 Nov 2026 18:11:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794467464;
	cv=none; b=dO7wfzISIE1hTF0cM1MTH1vA8MwbDqMntst8afHPI+przmNo5MkhzJas5FVWAbo0B9NiJ3hn7Y+r2Ur1PA+CnBSL/+iEC/Qazc3HALw7XQvvgzIQwubLA5zfG9XboiTWYpztS/I3CCKhKcPFiV0Ua2ZDgOfDeuP1NtUbS0vVK5ssZ4PySbj+iajkJvd+XxK+7C1iilgPHWKYIBhT7JGlMK7fvCD71eHyevaJzvEpBkCXQOgDq4IyoxFeawVaGRjsFYey8mCKMIPCw6ZgWFFITEGeH0cHBZfu6zxTmZUktCulcmwS/MgAHR641j3BuLJnEjwbWr3z3i3qcvbXDm2q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794467464; c=relaxed/relaxed;
	bh=bam7xp0wKd9NthErk/ZzQ3KYZ8ciAxCqEVr2lw2zM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNVe3IEMhDNMIk0ha5E8Qj7QXyck/T0wjuku69hg8I3poGCxL/IPsYA58MJ/xGx4nHOjreRmQq9q/eTQUJObSy30mD/nSua5IYgZa19HOKa8dO1hNW0mxg9OSeBmJDhqGPYhpiqjjF9PGaFJZUvMSaZboWNre/7SuGjCK6F9YGLXPxEC0UOTmOp0T8aZxhYgqDc6uETbwaR//tMMVe/Tu59JuF1V0kGPYgTUJ9Nm1GbqfiwBKitRc/aYfE44wAOoCFEUePP/cxETt2xx0ytwAcdK000eryujSQST6mB+bHaUD8wigkC89EuwRhXyzTAL6tbTotGpIT053QhmXwAWvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpNw+k3e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpNw+k3e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBPg30gkz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:11:02 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so3213750b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 23:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467460; x=1795072260; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bam7xp0wKd9NthErk/ZzQ3KYZ8ciAxCqEVr2lw2zM1g=;
        b=IpNw+k3eH2chWq2hxvjFNfHhAhDxcMJySVLU8mQpbgDvQZqnMGKJK3McJl7zibc2Tu
         m+s8lYVc6lrMdkHqceEoXukfMDktPdrpOBXu5dYDBFF4GLw54vPyDKwHd0DJHgNdixcB
         Sq0xu9XeUoNpOuhRUwHtnRBRKWkwHnK0WBmltLzlsNvkIrPO4yOgECkFF4/wCZoFyIVW
         1gs4brtrUvjpqQyipHJ6YuAEObT7RmipyiHjgiGMzAFUMbOMcsXebUBAK2KwD88XHZRG
         wEMQ9WBsWk/kfk7rK7ZnFfNT07g7y4CrFgbRqFoVFqC/W4KCvRQnwxX1kw2c6DYPfaV0
         0sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467460; x=1795072260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bam7xp0wKd9NthErk/ZzQ3KYZ8ciAxCqEVr2lw2zM1g=;
        b=frdMQBykso+g7HpduUFhINXLV6Tj7PrJi0IuJVPUudKx27z+h3OgJBRgKtifnVCm9J
         0UuFuAb8VyAWtrS5FZVEvWupiFdjUWsmXMyXJAd1GbdSE01xPo74/Kj92cnGZbFauTNx
         I43AQk/s67BOH1Y19ABp7x0kppg6XCSFgbgX+r0mC0nRrxrHoIoHt88SC9buF+og3cG8
         oDLrV/M4N6oHN/st4maJIbIxqVhwASSjXNCfKzY35k8ECnzCqLSp9pyCbSCeBUhlSuTA
         wCvWYE+NDxnCduuYrD3yAxageTV6U6n6KXlP6sUdQvvpc1qZeI+dmUuiTE1KhVjLCWEZ
         IYNg==
X-Forwarded-Encrypted: i=1; AL+hErF5sj5hpf149cFGtCO9VDV72eKw9bklAsO+ajmdOuZfl3keBB0VaP7vuDfNYz6Op8PCgs2QsHyW9OjsUUE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8pcDj0wxqx74JIWC4zG8muNMufkGl0i6ithj6oVmlcJ+rHz2Ha
	+lBAl4adeXHiGCYLhdkfD6p9Iixf1YnO+MpirjaS+A/kSbP0Uf2+8Mdw
X-Gm-Gg: AYBFou3aJInfRrcEhcKBV953vJUhtxQSOR7d/ZOCir44AYFeHVsmHylySYJnMKKQZNp
	PlxsvZ+e5s60Gr+iH35N3kbXjNx8npm8dM41Yt6BBvHLh3oh+U2n2HsuT/UymNCqxs3l8Vh8rh8
	rgiHxSmsCZJE1UNqF4i9+L0q+bPw6L2/sGNs09GzGGF827O2oq22i+HOGNFlLeA5zgtNsbwPbCh
	EYImuH4kwaMVMsYXVr6LNKuyTjzAAQZjbKO0V5y3gkSqeUIGA8sJt0n/92pH+EwKZOIqaJQXNsC
	6+i4QQyjTr6zD5i6gVb2tmA4G2NCqbtvSafsh5czdxjWGKg2YIl2tHPBR/5sb4SmB5VtLGlcMyl
	NYK6T+zB6CYNHRaQTLLfDX/YRVW7qhHAVi0aoX0IaidQ+QqZt0isiktQEioe9gn/sOZbsW3M/sD
	jjXL4JB6VwpSRMwzzl319s0L4yV4vFIwX9YK3KXuTKmPOrRK06vAkCnsaBS8/VaUP62jeYdX48J
	Eq+KpKHSK96g5wp+NCQ/86K1GLGhafv/K6cuMScR8J1aciCYtnKfblJ/c/yyz5QF4VgZUDonj1a
	R0RQP2ddX9ADR81me+guUIyk4stN/fzzPXydow1OL1ZB9NiChrlRJIbcwGwXVAfWrv7R/b+Pcw=
	=
X-Received: by 2002:a05:6a00:39a0:b0:886:9187:1a00 with SMTP id d2e1a72fcca58-8bc1cd64cf1mr4696362b3a.59.1794467460359;
        Wed, 11 Nov 2026 23:11:00 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab4fd5c6sm2999042b3a.46.2026.11.11.23.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:10:59 -0800 (PST)
Date: Thu, 12 Nov 2026 12:40:53 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	ritesh.list@gmail.com, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH v2 3/3] KVM: PPC: Use ppc_hard_irq_disable before guest
 entry
Message-ID: <avVma1vGZ2cbRM5G@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
 <20261110053238.3794500-4-sshegde@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110053238.3794500-4-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:02:38AM +0530, Shrikanth Hegde wrote:
> After applying preempt disable patch, i.e PATCH 2/3, Christian reported
> a subsequent warning stopping his board to boot properly.
> 
> WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
> CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
> Tainted: [W]=WARN
> Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
> NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
> LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
> Call Trace:
> [c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
> [c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c
> 
> It triggers below warning...
> 
> static inline void kvmppc_fix_ee_before_entry(void)
> {
>         trace_hardirqs_on();
> 
>         /*
>          * To avoid races, the caller must have gone directly from having
>          * interrupts fully-enabled to hard-disabled.
>          */
>         WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
> 
> This happens since kvmppc_prepare_to_enter does first local_irq_disable
> followed by hard_irq_disable. This leaves a small window where interrupt
> may occur and it could set the irq pending bit in PACA.
> 
> That local_irq_disable was necessary for PPC32 to track the lockdep
> state etc. On PPC64 hard_irq_disable is good enough. There is no need to
> do both. Use the new irq api to do the necessary one.
> 
> Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..4ee3d7bfe917 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -81,13 +81,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  	int r;
>  
>  	WARN_ON(irqs_disabled());
> -	/*
> -	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
> -	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
> -	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
> -	 */
> -	local_irq_disable();
> -	hard_irq_disable();
> +	ppc_hard_irq_disable();
>  
>  	while (true) {
>  		xfer_to_guest_mode_prepare();
> @@ -101,8 +95,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  			 */
>  			local_irq_enable();
>  			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
> -			local_irq_disable();
> -			hard_irq_disable();
> +			ppc_hard_irq_disable();
>  			if (r) {
>  				/*
>  				 * The generic helper does not set the exit
> @@ -134,8 +127,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  			local_irq_enable();
>  			trace_kvm_check_requests(vcpu);
>  			r = kvmppc_core_check_requests(vcpu);
> -			local_irq_disable();
> -			hard_irq_disable();
> +			ppc_hard_irq_disable();
>  			if (r > 0)
>  				continue;
>  			break;
> -- 
> 2.52.0
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


Return-Path: <linuxppc-dev+bounces-29542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B03CCC6B1C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 03:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4v9V4GvWz2yqT;
	Thu, 15 Oct 2026 14:45:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792035934;
	cv=none; b=kqAyKvjSmXef45weVuPj/vch0PbvdIttffSgRWQs1iPFXfF9FO4p3P44c4tzJQhPStec/FENFnqbelA/APznQctp0ZAdJ6q0dSFYW/NcSketgE4uH8G2e5jv2lOqhhD6XsvgMw44FmC83J5Vd03VNSQn+7To9tE5CyhSZr3xRkCLir1nGDJ1hv8UJcTPfc3FZiN4/kf5qrwoyplBN+fr56azhj/s2j5wMvvt4AbhvaDjcxsr7r+wKpn8IXqxCp6b/b0FodK/rWhwaHTIFvO4VGykHr8xLo2RYbT48H51g1rL46ev66xK6a+FMWDeXRpU+L0wAJ6H/ynofwmHxFLtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792035934; c=relaxed/relaxed;
	bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=l98CF5xIdBxQNtBpAg7ddjjvcmLdZYXStxBKYJ+DdK0R+lJA/S0f76f1bx8CTCU3AquBoUbLIK5s8xiRxmyHa+/Xl6xBlDlSMXQZxzqVxWc6lWuGcNE5gB7ZnkejnNw9FIlp6GIHPznooedDLoU5tiaxuqc9JEntN8frrjJMYOGyxK1KdkSpwrqmsWF90v90DQcOAVp6ywZ6B6m3W5B7gH7E9REcGPb+w83SS5inRDb1cGnGWm1JOwt4nN2qTMEFEDL3LxKp+b64XrFtA4PvxPX/J9BHmGo1vzAhcyqnas8bkiykgZgB21otl/BHZJzKu31MVK7UTPIjN5KzCBsPzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FRZsCNv+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FRZsCNv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4v9T02PZz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 14:45:31 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-14394530ec6so3980581c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792035929; x=1792640729; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=FRZsCNv+jvhSY+EomO4M6tjUfRO1cuPgOy4EHKctmAnouWqS/u2mtMgmRvrqN8gpRi
         TPtBJDSr+FQVAOKK0feKHs+SqEqJOmqXYFaOVlyrVPeLnxqgdhBpc4x8R9RK/AtNzQID
         7nYXgMPlft74N5FBBeq1zyDRhCvjVzixPccb8ZOMHA1SVsfqDj6HWKDHfsr+zm9fiD/d
         l8sNufkEQc5fTG6YZc1KJ8xJY2TsKWrOc+iRix6Hv9rDqqmIMbVyy7aMYPZQVT/1IjM4
         IQtw/j6Ez8gSi57yIKRAF+D98+kuYoESSwDHBkRxfDdrgtuReuLHAT+DL8TAkX+IWGFW
         TogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035929; x=1792640729;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=MaANVVflNqVgJtBpSpNXVLrYTGRETLvKMOiJxywXcPl7vBccL8bdGLqMM42OUI8IVp
         jKAXwvfSRapOAlkjFV8NwSjz2YywBOafjK8VWO7i0BrOfGXY2s3tRGbqBBwgYghHOXQ1
         jLSTu0PHT9PmRFFqMr0lUi9hbc6OEApq84eNk+8JwOxpdkfAU96VXHCmMl758TJN7zpa
         btq31JJbp1KLNeINj7RmX+UZLaKOW/eP3kdfs9fAKZ0+OpSjp/OLzvG41OLXO42IqHQt
         qlsy9k5guTTj26zXMSGTo15hqQkpZ2YrQ9CtbLYjkB/wh9gZYhK73gnfNffJnLiONUG9
         0e9g==
X-Forwarded-Encrypted: i=1; AKwUvBym/QvGb9QWC+IdwbhMYSegCSftpQx0WlJwrj6ROBhfe46Ej5RCNrO01XpqKQ1gsr3CKULdon35pw4A1zw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLCbITJfNOIsYlSBTz5coigZVOX9pV3HsIa1q5eie0pEH10Qcaj
	aTKvnY2bkjDGNfz1c/oLIapqO+OH58Bx5ZFfnp70bLMsIYUEjMVrsf9r
X-Gm-Gg: AYBFou1llqCEN2LlYiAXrVcWc+YTUKl4Aq63U3g3zec0/3nSllQ96HwcSXF25agcVi4
	0erlC+q2zpY4g0ei+/X3mHuK0CfXbv4uzTjIMj8kvKYS9jqxtDCHYZpnXKs0boVUp9jlbOHDuU6
	WCBP8z8ye+tp4MJLkEHnktXfjawis0qdpaeesCdDbQMRTUgmlxSbzkIE+PGg0Itf3Fya8Padk+f
	MjJH+yG2Vv3l5m6I+1nQx5I5i3vQQDmJVNZdUJtBnJ8ucA+LMFVxTbqn3SU0Tc3kQmeppiTOPUs
	Mbb3FtECpcaQIJynQAaJeQPknPZJuZma8gtZsSLBqOpQCar08kb0v1CzsVlHQ1QYpF7jVErIn76
	8wUzzhLvVxPe5/VgeyV8TqmGVQt0QW+5f+8nsjM793T6esRVLG1dmLXIeYkTN1RjMemxHn6IJLc
	A24NMk4KHUHPpg4bfkqBMqYiv7FPaFfoLjnY9aHCIjvLO+IZoqyGjLldObTsPmjh5idyOQ
X-Received: by 2002:a05:7022:7e08:b0:144:fa58:95d8 with SMTP id a92af1059eb24-16a61a6ebb0mr33060504c88.27.1792035929111;
        Wed, 14 Oct 2026 20:45:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm50853605c88.22.2026.10.14.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:45:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
In-Reply-To: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Date: Thu, 15 Oct 2026 09:14:32 +0530
Message-ID: <v773r5jz.ritesh.list@gmail.com>
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> A previous change ("KVM: PPC: Book3S HV: Add preempt_disable() around
> virtual-mode HPTE bit-lock users") at [1] added preempt_disable() around
> guest vCPU HPT hcalls and page fault handlers executed in virtual mode.
> This ensures vCPU threads cannot be preempted while holding
> HPTE_V_HVLOCK or the reverse-map lock.
>
> However, several host-side virtual-mode paths in book3s_64_mmu_hv.c also
> acquire HPTE_V_HVLOCK and lock_rmap() in process context with preemption
> enabled.  Specifically, kvm_unmap_rmapp() and kvm_age_rmapp() take both
> locks during MMU notifier callbacks and memslot flushes, while
> resize_hpt_rehash_hpte() acquires HPTE_V_HVLOCK during HPT resizing.  If
> a host thread is preempted while holding either bit-lock, any guest vCPU
> thread scheduled on the same CPU spinning for the same lock with
> preemption disabled will never yield, resulting in a permanent CPU hang.
>
> Fix this by disabling preemption across these host-side critical
> sections.
>
> For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable()
> before lock_rmap() so that both the rmap chain lock and the subsequent
> HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
> To preserve the ABBA lock ordering between the two locks, re-enable
> preemption after dropping the rmap lock on any retry or early-exit path
> before spinning on cpu_relax(), allowing the lock holder to be
> scheduled.
>
> For kvm_htab_write(), the HPT migration restore path, replace the direct
> calls to kvmppc_do_h_remove() with kvmppc_virtmode_do_h_remove(), a thin
> wrapper that brackets kvmppc_do_h_remove() with preempt_disable() and
> preempt_enable(), mirroring the existing kvmppc_virtmode_do_h_enter()
> helper.
>
> For resize_hpt_rehash_hpte(), place preempt_disable() before the
> try_lock_hpte() spin loop and preempt_enable() after unlock_hpte() at
> the function exit.
>
> [1] https://git.kernel.org/powerpc/c/abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
> - Separated host-side fixes in book3s_64_mmu_hv.c into a standalone patch
>   (guest-side paths were merged from v1 resend).
> - Previous discussion: https://lore.kernel.org/all/20261007182116.12479-3-amachhiw@linux.ibm.com/
>

Thanks. Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E440606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgRDXgZu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRMm73NZgz2xKx;
	Sat, 14 Nov 2026 16:16:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794633367;
	cv=none; b=aspD2BklZk2Ytc0kNtotx6iaTgT7uFlVykw0aazHn3hIzviVudWN0831zuPJwCCChYGNrQdgnArYbo+mcw6dqjwSCs28BrMAbM1PhsQdkDokbJCD5us6Wv1S96b95+HFR3TcqK7TEihb1ruQ/OB9qw7865cZi6KyaTTDOa93rhPvW8DADfft0DPK4rPZSA+dr5gwTxOCm7xozpYAGEWwpeaaPu0hYIE7aodD46p/iPz/mbBi+NJFfrq2fqINYAAaPso8kN6RFoMKim4BY40j1PKGWsRn/uBIEeWk9ryEVco/03huw3JdH0qE3nX/xlop5owqkg4v4IgEsvdTWiWKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794633367; c=relaxed/relaxed;
	bh=auEFv6Wzik355jOg4Z+xLlNi2IgivCMaU5F0Bxyhp6c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VvFhea+xEmvEjo3cqHvugP0+H3OzrGvYytWM9BjNax6GF+doM+Gj60XkiD8aG8m8s+sMqbIOBSmdLkQz6Na0c+hxbCcFvBKshYWuuBNvpPfbtBUxtSkrGrYDeUh75S1cj9sOIREyM7Rx2he5qLRvnqzNf76LjNuWWPyq7S3gQMuZnLMZ+SVoq6vxUTSwgKRCVZO1HmPfxJ181WPxKbEdbjjcwthtu1RJIOCEzwGd5nm45Ghf/YzbCVgHiQl9eoGty/F1bXYs59QooSD72IzhnXjkgNV1FNygKwWJYWJbin+YWbIUsWM7oGi5SE0kTzR9HME/rnsgSlezmcz2bjFUVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgRDXgZu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgRDXgZu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRMm60ZnVz2xKv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 16:16:04 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1b3ada81853so1608718c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633361; x=1795238161; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=auEFv6Wzik355jOg4Z+xLlNi2IgivCMaU5F0Bxyhp6c=;
        b=SgRDXgZurCSqR8B/SeZZkQpShl/NqonrpuEEQ4z73DSELLEfh8euXsTvUvoHcOC+vL
         IyOmuEHsbF9G2y/ljFecHj4qC2QTdKV0xbPAOkQ0pqLsyQ0sfI0MS49pYKYWYMJKbGUP
         13eA4o1lLun0+Fk+iakBRBsUIHUoT3Aswn0XQuTFYRhSUCiK5Poeex5563hkWCfOBfun
         llP/6M3KjOmwRXgb1O16cqVA93RsKrijWQWHc8mfEgPRNC+P3DNuYVSZmjPivgvHY1tf
         YqozjLHM0sv74dYycBGc/68o8PstaXq85EHhYZF39iSKBs0g49Iw47xN6RY3bakCAbxs
         YgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633361; x=1795238161;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auEFv6Wzik355jOg4Z+xLlNi2IgivCMaU5F0Bxyhp6c=;
        b=ARXo/BpSu1BsDZR1YoF8sorePKkQc0G2dNmU2n1EmYEiY6ASy9H+a9+ARtYUGGTYYK
         m2F6b0bfuKeHSgx2+2IJSbp3Lzv8DmKgLTvPH+3sssfvFHN8PefONND/K7XcwMhp45Rc
         Qt/4xnJMG2wG5umdj+HJH36SFkSbBtUUGKZHxBv8Ud6Ey3minfNr14rWCoZGbXBkb8XG
         Nc2tbfFBXhFykZ3EOX1/gvyNnHPAirSE+oGy12QorRVZ5HoDcJdYnWk1ua7ByJxIdbMH
         mL41peJqRQkYMXcOnLc3ng1cOTFPWZAEL/tnmL1vMNVsQ4nuQK4qC+6BfYInLHTi2rwB
         YARQ==
X-Forwarded-Encrypted: i=1; AL+hErFa8/iKa4qlZEbh3sJGuUgl1J/SjsJDDtqdPj14PKuf4m0Akl+sCzMOIlNJdKfWxGekuCUu5R0Mo/ZcE6M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+N+T0vG8VAgg87byjdDRbxvYxc2hV8FEqXIUB/df1ZcAtXIBEW
	ef0iOz4Z/9hCqcBvrcOJkVyHzMLFSaKPG7ru1we7tCxSk6o0G/4fgQTQ
X-Gm-Gg: AYBFou1XnzAyzfAs5P3fzY0Sd8fUDCPwuCuWCTofhnAz6u43YKJ1UPPSWWp+ogkmZuB
	1f6f5Z3NTP/Pz5K5yrTBdqsWadmCmtSPNy9T0LFD0A7AFZlqjQgfATKuGqy+Uxfx1o3PHjVobgb
	xWNPwMjlGybPaoAlQfuzqMs51UvHxiYKSd+gNHP0QiWIVrOHdsnkLF4mstllaB0puMraTpD0hv3
	fTPWsyP3Oyqc8neo/C+hkgiuxOJu77HV+GVHqhS0MgiTjnryi5iomfFJTvL1hdQFjAK1tnJS9N0
	84unTVKGBZuGyOoNa2C5lmtLxIDV9vOirhGByHkj/SC2Kk1J+HHaLz4lfPK4U++A0aFI0ro9Dmq
	bcYXNJ7cb0P+ViFFTI94LSZvhnr7F/axF+ETtoLcC4jjB775Wte9EqyMGO22mRQ1A65bW3V9dpw
	NB5PNvPvh2XA1vrT29WXczIaQWNj4RjXBQIz2qw6mP9dgpNgfE80GquTa7ae+8zEEYFtnyqExBY
	m8K/bsk6AZuc3r+hBtz83EP/nGXY7tooeD6hbIVJe0oI+T8RkrUM/J6X27gwKEbybcLOh8AmBbe
	yLEIQiJHjYFl5W7/3d3AziU5J5c=
X-Received: by 2002:a05:7022:92a:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1b5030e9a6emr6381022c88.11.1794633360987;
        Fri, 13 Nov 2026 21:16:00 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm14545581c88.5.2026.11.13.21.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:15:59 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v3 2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
In-Reply-To: <20261112130913.4124175-3-sshegde@linux.ibm.com>
Date: Sat, 14 Nov 2026 10:42:32 +0530
Message-ID: <h5hk808v.ritesh.list@gmail.com>
References: <20261112130913.4124175-1-sshegde@linux.ibm.com> <20261112130913.4124175-3-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> Christian reported that booting preemptible kernel on FSL Cyrus+ board
> causes boot hang.
>
> The logs pointed that system was busy in printing below warning.
>
> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
> Modules linked in:
> CPU: 3 UID: 1000 PID: 4884 Comm: qemu-system-ppc Not tainted 7.3.0-rc1-powerpc64-smp-preempt #1 PREEMPT
> NIP [c000000000003338] .enable_kernel_fp+0x30/0x78
> LR [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> Call Trace:
> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>
> Which is...
>
> void enable_kernel_fp(void)
> {
>         unsigned long cpumsr;
>         WARN_ON(preemptible());
>
> And...
>
> Though irq's are hard disabled after kvmppc_prepare_to_enter, but
> kvmppc_fix_ee_before_entry enables the softmask's IRQ state.
> That causes the irqs_disabled to return false.
> Hence leading to the warnings.
>
> Fix it by re-ordering the code to load the FP and Altivec
> before enabling the softmask IRQ state.
>
> Suggested-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kvm/booke.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

LGTM. So, please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



Return-Path: <linuxppc-dev+bounces-28408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C1ECA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:30:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hthyL3jl2z2yMK;
	Mon, 28 Sep 2026 23:30:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790602234;
	cv=none; b=We2fVWXKr/3jebGYh9LtjYKMqv25cSYwDWFa3+/snxMVUItpCDzYdzzsKcR35N5M9JtceaPprG5Hr9uZqWTLgXUBV5Fg/hYlErfe07/mXHGBInQKw+F1Ihlh+9xtiwS3cBIgIYkiZMp3Y/LcjhQ5P8r50GhAKxlJl98aWmwwjmDVhg6OKFbnphy0Uks5QD+cq/QI7grOdLz/VhIrygHpYd7jtVFnqZ9Qz5oFmQu5Bdd6dWYKsKgNDizp1AM1BvIZtjPa3naRZBXTM+xlvBnbrBKW6rYaqO3VsSeJVXwMBkb5TayZukTsK7DifRmHb9TrQMOrvU//No7pNKESK77ESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790602234; c=relaxed/relaxed;
	bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=dfbazbtk6L3v6HXFb7zFOVXmLlxerH9dbMd2Zm4sGp9i4Ob0ZRh0j0TwwWVm3UxIPkSLck5pUN4v8IB99Fov+5EmU7S9URR8RG7BfM+eXByAcr5aP2+X7VuSOHeGzYHa4+WWiTM+Ww3KGIEHgJJ8aJ2OqpbJgecfvPtR57CmJWIOvAWv/c4udm2meB8QDwVYGkJZaalMwGV3JLWGQZcjVkZrKoNA7/qLLGJjNLvFVP56y27yNUECr+jRJupNtYkJPdwmxkIweJVbIeSxXShC2JVL7oPn4L5HP2x2ZyoWPXFHQ4ZM+D/0uIeh2NOgP2HRRrVj4Y5dglvogdGw2uvigg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Da5NQY6o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Da5NQY6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hthyJ4Hqtz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:30:31 +1000 (AEST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-93c7014af8eso104101785a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602228; x=1791207028; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=Da5NQY6oR11MrpPCVUnu1YRlK22cpvL/UKcLVMLxrA9DcqTT4fHUFDC5NvnWQ2hc5G
         g5vutxvSaWAWpoirEGMoxxKU17mxQUswWkQjU7VsQOWJwI9zi3u1ZVj2f1lwYYp2A+GG
         xL2KiV+OHL/mkLbIoiFmAq7iYuRFJugawbOeLOvJgQRGTeIfaow61rijSFJkEyfU0Ar8
         QgJu0huHQ6/5QjhtTol1YO+fBxFLWogj3eVSlGZ5zM0p/acUTh75BLyVt2FgL/+7+x1p
         Q6jAb0UGRU8ENkfxcrAclWTQtAmcWSOdVexUvX5j+30OyTkVznBDjZoGfGVe6QKXx7q+
         HvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602228; x=1791207028;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=L/cEQs+YaIFchiaI+lX50Paz4+AoPnElHrSwdpMT34gdeF0f36gdsORgpDYHUky/5O
         sxoY0kcSi4UWlejbZ5iVvX2yzYYs0uFDHABN3shGUlYUjnCJEtT/bj9nfLp9ulEKiOs+
         iHow6nV6STdpQEl6QXxbF2p7yW34OFbMnnPj05T0kVqjfxeOg5exJioIAejv38RrfsRz
         pzcx3DoBUh6q4Lj7VgWUrFluIisRM9dx4Lk0OFlKi+ZSGNItUvTh9wZW3ifH5AM8Ka6A
         9HFPc1v1crDn+rbsfVzkhkKTuV148uLcIGEt83G/R2Hv6YtwXjASuWjR7Np6xuieHhFR
         61CA==
X-Forwarded-Encrypted: i=1; AKwUvByVd17GkZhLGLehczvbVcfDk9kC1+EL8xSnea3icRUN7RaGJpmp93zy9g1LzUgD8BdX/g/L6KA2BYaaKww=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nk3Uu6Zrn1HK1FONHr2E1ivYFuTyr5QjnF7aL9ApeOtYw4CaSu
	qOYstvZ8sPS7jieUlQcbLb+g8l3qLhy7X6M9BQwgSjD9m0DIhPk7Fel3
X-Gm-Gg: AYBFou3NsxCalXrlwejx34prrHuXaeqg5/VxupH6gaaIlJdvGXdKGWRCQSrqzjZoPs4
	zjAl7iGk0xX0R5JUi4cv8guzOd0BrYo1OTZr/ioWUqn7xm9FLhtO6tOsVLdgxBhJyQmXpTiG1ym
	wq2UJ/E165HKccisEzz6Uk3p3XWi9INeqzeRwjh+bmYTuFkXmhlU/LAiDHKJ3zxRpffgXJ1uaXB
	PYL1WPwWZzYr3qymR/Idncztm3Zs7q+fCNvcAo/dqOOQUXYKzqE+kDkK9HqI/Re2PAITcZfwJ2k
	g4UN5KfE7vimODciEhrOHpepNmNPjrqHlHIN8ahf7aoko9OLF9MkOv74Y3ipm4GoNs6lKrIAc6l
	4yzIeNhTXKEJG/ulKzEHe0bKb3OPU5rRVxB1G0emRhGTfFSlAmzU2pV6Bjanxf3fyXJN0JyzlAb
	WpjlS/knAaIQl1FytIUk2FNmtUfpz9M80l9CTZFHANX4pvStT8eUscvS0EX5U8yo2ET8SUo5EUH
	Qmfskv+MYCyxLjNMcaFY8zQsvbBOvCfs7xVdRehsOVE9kaTLYuH5g==
X-Received: by 2002:a05:620a:2888:b0:93a:ea:b00e with SMTP id af79cd13be357-93c43d9e0eemr2013943785a.30.1790602206503;
        Mon, 28 Sep 2026 06:30:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a443fsm151650285a.12.2026.09.28.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:30:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
In-Reply-To: <20260928122837.8782-2-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 18:57:16 +0530
Message-ID: <v77pjykr.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-2-amachhiw@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> The virtual-mode HPT hcall handlers (H_ENTER, H_REMOVE, H_BULK_REMOVE,
> H_CLEAR_REF, H_CLEAR_MOD) call into book3s_hv_rm_mmu.c, which accesses
> memslots via kvm_memslots_raw().  kvm_memslots_raw() uses
> rcu_dereference_raw_check() to bypass SRCU lockdep annotation checking.
> This is safe in real mode because the entire guest entry/exit is wrapped
> in srcu_read_lock/unlock inside kvmppc_run_core() and
> kvmhv_run_single_vcpu().
>
> However, since commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual
> mode handlers for HPT hcalls and page faults"), these same handlers are
> also executed in virtual mode via kvmppc_pseries_do_hcall(), which runs
> after SRCU has already been released on guest exit.
>
> A concurrent KVM_SET_USER_MEMORY_REGION deletion or move can therefore
> call synchronize_srcu_expedited() — which does not wait for this thread —
> and then kfree(slot) and vfree(slot->arch.rmap) while the hcall handler
> still holds a raw pointer to the memslot.  lock_rmap() then writes to
> freed vmalloc memory, leading to use-after-free and memory corruption.
> Because kvm_memslots_raw() suppresses lockdep checks, this race is
> entirely silent.
>
> Fix this by factoring out the 7 HPT hcall handlers (H_REMOVE, H_ENTER,
> H_READ, H_CLEAR_MOD, H_CLEAR_REF, H_PROTECT, H_BULK_REMOVE) into a
> helper function, kvmppc_pseries_do_hpt_hcall(), and wrapping its call
> site in srcu_read_lock(&kvm->srcu) / srcu_read_unlock(&kvm->srcu, idx).
> Targeting only the HPT hcalls avoids wrapping non-HPT hcalls that sleep
> (such as H_CONFER, H_REGISTER_VPA, H_PAGE_INIT) or handlers that already
> acquire SRCU internally (such as H_RTAS).
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

I had looked at this path in depth earlier itself. LGTM.
Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


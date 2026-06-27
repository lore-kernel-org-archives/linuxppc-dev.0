Return-Path: <linuxppc-dev+bounces-23042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66AFC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 12:12:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnWdN0D94z2y71;
	Sat, 27 Jun 2026 22:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782562359;
	cv=pass; b=kcd9t21JHA9XGMk0/EwUnpGh04VvBuW6sN7hf95WWWV9xPQTGa75tp08cgF1Qgr12bpyy499chdqAEGdXV93RBMlwWqb5xv+GoU4y7XwdoD0Y7tXugK9vJGtkBnqNLTzKsOVt+gRs49yE9z87fRHn0D9pj7bPfoTxSXL5GwxtVKGFCrFSHseO3aj0oQ3nZTrdd5Kmmoh/GkGgbF0kIMbL0LT1zHA96zCTJEpGNhtdyN9rSDI5xFdiAcmQ/2N63W6J7MI/a0hKS5PeMrsG8zHjI3MIY5q3vqroKJT9LcmuAB7GhGYpS6HARVkPNbsfHVlc7pHZsUguomo3toeO8o70A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782562359; c=relaxed/relaxed;
	bh=cy4DI3TsxmLv010P6gehwKWLLpTXcCeB0vT4skTVm24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8VqPuQ0RN96opI6/HM3n4YAqMifPjx0qcrGy9jBLafFHlr/t9Ool2tx4lfVs8mCKeaDnCjiF7n6hSS2B98YSoiG1b0pBRaEzx2ZGi8CmBXiR1+hgAzUkbB6OpZvP1X/LGUZF47gn5RpLiYPBDwk24gmyGu1jf/Hi4beWNGxKtWSwC+V5DQehdqL32cc9mZvYwLnUY7Kfm+bQYn5tAQqkJLwLXPe5V+FI/2fUni6N8yZBgMxq2rMKqIGEpnf2JFm6OtNE2qPLYEI6YscGZJSHtsAzkj1zCQ5hKSh2LGHUYRvd8FSGe8yXfORaNmSUVqSwDS8FEAVw85EfSYd0RE/cA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nVMxcLnO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=harsh.prateek.bora@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nVMxcLnO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=harsh.prateek.bora@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnWdK6PP5z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 22:12:36 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c0868ca8738so302955366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 05:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782562352; cv=none;
        d=google.com; s=arc-20260327;
        b=a6L04IMbvCc+JGEvrSDeCsd3mcxeYcqncf0wobN1hYSs/omy/YheuTJrFQyFEVtno0
         dksTtvVexozrBj+3szjcPTLIrEplFc6hqTnUw3pNj1I/yzgbwoTe2E3pERW/9qQJNQVB
         a18kFEI6e0zzVwtjKuJyfynNUm307wtBI0L6voKpsuJzDS/Eyd6sjqpXH+DNnVmu8Fk6
         pBgmHTbEMuLKqyry1AuaXpjNNRoormt9vQ/I/LEQAPgV8zRliO53fsRmyShWunrx1XSS
         D9fhIyTV3wle+5Z090mmJ+ZfSZHyQib2u2fizF4w3RkbuaYoRVRaKwq4YT0loSRfS0+Q
         Oaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cy4DI3TsxmLv010P6gehwKWLLpTXcCeB0vT4skTVm24=;
        fh=xSBOAya9z0vjnfwTQOdyb3+ne5ibyAwvDchEKKRDhB8=;
        b=n1KGkYAEWZ9EUN9olQy8DoUQPehOH9JKPbXxMQ3PCXSa9BBmGse7/t4Yw6I0UAZN8N
         FTzOLU1bMHtCZUS12QUf9yO3Qan/OVqHmTwTMiiyLkvPiDeqZsOAN5yp3GPzfC1k2Lgl
         CSsi1Vf21wOkjdXU42fXLuvim9Cy6qtmGTECWqfHYpmqh6Da3IJSuEgabReR+Dmi1mNb
         1BdrFCkriTRiu5dQeqsbquD6/6yIB9qGuEx1Gf16gyVwI6Pr4EKcsz4LKaRGHvjOSu6e
         Bm8tDu2B/XepCn/4fyKfjun9xbkuU57GFbkNtKfaWugdDw2IuhaFsylvtSJP48hBr5nX
         9cHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782562352; x=1783167152; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cy4DI3TsxmLv010P6gehwKWLLpTXcCeB0vT4skTVm24=;
        b=nVMxcLnOFrhtx5POWGeXOTORjUtCaac5v9aXZ0YFRKAoHN1VbNq3CG970U+urb9XEZ
         ZCrHnr+XmUtfcgUU1CnAM8XV0AC8cfBxFC9yUtabrkHNOkVzkgmrSBEFL1yEbfl5v4ct
         NSJ231+q45gKRrAmFT66oBndSo9NPx5Gc+nb3NS84ggDinhZxVbn9QHRk8YjoG/WPcdJ
         b4N8wzZfsSwvLWXi6lcCUoU60KnYpZh0SZRSHH3e8yGx59vsp/OGAHsfKAuG9nB4fLoK
         9qYxwoET9uxBbE+KTZh9UKMAvAmk2lcMN156tiJIDUm8TsTI3/0ibTbaiF8dlbkRurPm
         B6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782562352; x=1783167152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy4DI3TsxmLv010P6gehwKWLLpTXcCeB0vT4skTVm24=;
        b=sbvCtQNYu2q0NsDUcaLDrK9iyjnT0hlOK7UK4jlP6vrto2v5GzEPP7pci/2eyKuMr7
         zFHwiQpePYJFSo6UEGRRSI3WhsxCoUGRBpo0/SN5WMnH4L2NB38GkJl7p9EkymI0F/v0
         CrWPC0fqoUmvmjpE5BxWir3fIlYuq3FTWvTTY6fu+TI5jdYUk7mKlK8FZvSLTq+1wbik
         tDCavml4Jyv9IB2bi7C2v2lunKi7ppfz7R+pkRigG0+uZoIFc6tp5WWJyPp81MQO87EP
         bZTwTa93HDYs3J/tihPr6ZzXZg5VHXdDZLU0ZdQx+fDEMpJdtlc/7gwk/iLISJ8mBJDR
         5h4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rozu6oAAGZ8iX9zZXvUCfiZ8N0v7rzCJy79GbqHe1SylJOwe8VkZVe1ZZo8dcNzRqtdbpKQJIoCobcnVe4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWMtCPPzsz9Mlt9+NG+SFd+lAt/Ve5GE7xQkvvgIhLWzxDEWSZ
	gpLHqb0DjwnMxiixJSqq9+Mwv5nPrt+U+41/IOUjHcxy8NoBccj1IqmlU5F13JGGDie4kjjpNgF
	ynHIRhEiHz9rWlgsPjlTHrf/eL8zeHl4=
X-Gm-Gg: AfdE7clcGXzARS3IRduMS0w3XeaJom8aIrQC+jS0YuF8gl8TIlCiolv3aoY76TpBfT+
	i1OMTiedSx1Pn3YAf5WT0TjWWd7F462/NYcmFtCLUiNFR3Mx1EwvKYnjRnwessCx9+PJ50XIpk+
	lUu36dGkDKH1c1crWXv4zmQtW9KKjwfLuRMv7QZaqeV5G8ck0VwmAlLuahEG1ogEFakPhjnNldw
	oLedb8R1pYjzPSR1bezkjlxbAE8LgbMkQeOGRdAwO0sK3eNcsdQkm643D/sn8ZonYNihqJan+aq
	ai7kTfmsraFESXqxOPLiy298rSERqFj/9MiPGmm74Q==
X-Received: by 2002:a17:907:969e:b0:c0d:8c04:92d0 with SMTP id
 a640c23a62f3a-c1206187628mr629556366b.49.1782562351456; Sat, 27 Jun 2026
 05:12:31 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260626105449.2897924-2-vishalc@linux.ibm.com>
In-Reply-To: <20260626105449.2897924-2-vishalc@linux.ibm.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Sat, 27 Jun 2026 17:42:17 +0530
X-Gm-Features: AVVi8CeOYK8-722fmFONs4dTOwmUD9X-UtwyKQDxvg7Wx9MzBPS-7U7oHufGBPE
Message-ID: <CAEuJdmpdX1+Cpt82w-USq0E_ACiAB3n_tCJJzgDO6aVbFF1bSA@mail.gmail.com>
Subject: Re: [PATCH 0/1] KVM: powerpc/book3s_hv: Handle deferred CFS bandwidth
 throttle on guest re-entry
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: maddy@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>, mpe@ellerman.id.au, 
	chleroy@kernel.org, Gautam Menghani <gautam@linux.ibm.com>, bigeasy@linutronix.de, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000bfa54d06553b23cc"

--000000000000bfa54d06553b23cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun, 2026, 4:26=E2=80=AFpm Vishal Chourasia, <vishalc@linux.ibm.=
com>
wrote:

> This series fixes a KVM scheduling bug on Book3S HV (POWER8/POWER9/POWER1=
0)
> where a guest VM under a cpu.max bandwidth limit can run arbitrarily past
> its
> quota and then appear completely frozen for minutes afterwards.
>
> =3D=3D Background =3D=3D
>
> Commit 2cd571245b43 ("sched/fair: Add related data structure for task bas=
ed
> throttle"), merged in v6.18, changed how CFS bandwidth throttling enforce=
s
> its limit. Previously, throttle_cfs_rq() dequeued tasks directly. Under t=
he
> new scheme it queues a task_work item via task_work_add(..., TWA_RESUME),
> sets TIF_NOTIFY_RESUME, and relies on that work running on the kernel
> return
> path to actually dequeue the task.
>
> For KVM guests this means the work must be drained before each guest entr=
y,
> not just on the normal syscall return path. commit 935ace2fb5cc ("entry:
> Provide infrastructure for work before transitioning to guest mode")
> introduced kvm_xfer_to_guest_mode_handle_work() for exactly this purpose.
> x86 (commit 72c3c0fe54a3), arm64 (commit 6caa5812e2d1), riscv, s390, and
> loongarch all adopted it. Book3S HV did not. [1]
>

IMHO, there is significant info in the cover letter (Background and RCA)
that deserves to be part of the patch commit log.

Thanks
Harsh

>
> =3D=3D Root Cause =3D=3D
>
> Book3S HV's vCPU run loops =E2=80=94 kvmhv_run_single_vcpu() for POWER9+ =
and
> kvmppc_run_vcpu() for pre-POWER9 =E2=80=94 only test TIF_SIGPENDING and
> TIF_NEED_RESCHED before re-entering the guest. TIF_NOTIFY_RESUME is never
> checked, and the deferred throttle task_work therefore never runs while a
> vCPU is inside the run loop.
>
> For a CPU-bound guest that generates few KVM exits back to QEMU user spac=
e
> (e.g. a compute-heavy or busy-looping workload), the vCPU thread never
> returns to user mode. throttle_cfs_rq() sets cfs_rq->throttled =3D 1 and
> queues the task_work, but the guest continues to run unchecked.
> cfs_rq->runtime_remaining goes increasingly negative with every schedulin=
g
> period while the throttle flag sits ignored.
>
> The only mechanism recovering that debt is the periodic bandwidth timer
> replenishment: 30 ms of quota is added per 100 ms period. When
> runtime_remaining has drifted hundreds of seconds negative, recovering to
> zero at 300 ms/s takes minutes =E2=80=94 during which the cgroup is legit=
imately
> throttled and the VM is completely frozen once it finally exits to user
> space.
>
> =3D=3D Debugging =3D=3D
>
> vCPU was placed in a cgroup where CPU bandwidth limits were set.
> quota =3D 30ms
> period =3D 100ms
>
> The bug was diagnosed using a bpftrace script probing throttle_cfs_rq()
> and unthrottle_cfs_rq() and sampling cfs_rq->runtime_remaining every
> second. The trace shows the debt accumulation phase, the slow recovery
> phase, and the immediate re-throttle on resumption:
>
>   Debt accumulation (vCPU in guest, no exits):
>     +1471 s  runtime_remaining=3D-209702865115 ns  throttled=3D1
>     +1472 s  runtime_remaining=3D-210402866357 ns  throttled=3D1
>     ...                                    # ~-700 ms/s (growing debt)
>     +1477 s  runtime_remaining=3D-213902833931 ns  throttled=3D1
>
>   Recovery (vCPU exits to QEMU user space; bandwidth timer replenishes):
>     +1478 s  runtime_remaining=3D-213617443453 ns  throttled=3D1
>     +1479 s  runtime_remaining=3D-213317443453 ns  throttled=3D1
>     ...                                    # ~+300 ms/s (30ms quota/100ms=
)
>
>   After ~710 seconds of recovery, debt reaches zero:
>     =E2=94=80=E2=94=80=E2=94=80=E2=94=80 unthrottle_cfs_rq @ cpu=3D768  +=
2190.029568131 s =E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       runtime_remaining =3D 1 ns            # just crossed zero
>
>   The vCPU immediately re-enters the guest and over-runs its quota again:
>     =E2=94=80=E2=94=80=E2=94=80=E2=94=80 throttle_cfs_rq @ cpu=3D768  +21=
90.055327252 s =E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       runtime_remaining =3D -5667293 ns     # 26 ms of debt already
>
>   The cycle then repeats identically from a fresh -700 ms/s accumulation.
>
> cpu.stat confirms the pathology =E2=80=94 100% throttle rate and virtuall=
y all
> CPU time accumulated in kernel (KVM) mode:
>
>   nr_periods   =3D 117457
>   nr_throttled =3D 117457     # every single period
>   system_usec  =3D 4334782636 # >99.99% kernel time (QEMU in KVM_RUN)
>
> strace of the QEMU vCPU thread confirms long stretches where
> ioctl(KVM_RUN) does not return =E2=80=94 the vCPU is running in guest mod=
e
> with no VM-exits reaching user space.
>
> =3D=3D Fix Summary =3D=3D
>
> Opt Book3S HV into VIRT_XFER_TO_GUEST_WORK and drain pending guest-mode
> work (including the deferred CFS throttle task_work) on every guest
> re-entry in both run loops. The changes are supersets of the existing
> need_resched() checks and do not alter the signal or exit accounting.
>
> [1]
> https://lore.kernel.org/all/20250421102837.78515-2-sshegde@linux.ibm.com/
>
> Vishal Chourasia (1):
>   KVM: powerpc/book3s_hv: Use generic xfer to guest work function
>
>  arch/powerpc/kvm/Kconfig     |  1 +
>  arch/powerpc/kvm/book3s_hv.c | 58 +++++++++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 7 deletions(-)
>
> --
> 2.54.0
>
>
>

--000000000000bfa54d06553b23cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 26 Jun, 2026, 4:26=E2=80=
=AFpm Vishal Chourasia, &lt;<a href=3D"mailto:vishalc@linux.ibm.com">vishal=
c@linux.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This=
 series fixes a KVM scheduling bug on Book3S HV (POWER8/POWER9/POWER10)<br>
where a guest VM under a cpu.max bandwidth limit can run arbitrarily past i=
ts<br>
quota and then appear completely frozen for minutes afterwards.<br>
<br>
=3D=3D Background =3D=3D<br>
<br>
Commit 2cd571245b43 (&quot;sched/fair: Add related data structure for task =
based<br>
throttle&quot;), merged in v6.18, changed how CFS bandwidth throttling enfo=
rces<br>
its limit. Previously, throttle_cfs_rq() dequeued tasks directly. Under the=
<br>
new scheme it queues a task_work item via task_work_add(..., TWA_RESUME),<b=
r>
sets TIF_NOTIFY_RESUME, and relies on that work running on the kernel retur=
n<br>
path to actually dequeue the task.<br>
<br>
For KVM guests this means the work must be drained before each guest entry,=
<br>
not just on the normal syscall return path. commit 935ace2fb5cc (&quot;entr=
y:<br>
Provide infrastructure for work before transitioning to guest mode&quot;)<b=
r>
introduced kvm_xfer_to_guest_mode_handle_work() for exactly this purpose.<b=
r>
x86 (commit 72c3c0fe54a3), arm64 (commit 6caa5812e2d1), riscv, s390, and<br=
>
loongarch all adopted it. Book3S HV did not. [1]<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">IMHO, there is significant =
info in the cover letter (Background and RCA) that deserves to be part of t=
he patch commit log.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Tha=
nks=C2=A0</div><div dir=3D"auto">Harsh</div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=3D=3D Root Cause =3D=3D<br>
<br>
Book3S HV&#39;s vCPU run loops =E2=80=94 kvmhv_run_single_vcpu() for POWER9=
+ and<br>
kvmppc_run_vcpu() for pre-POWER9 =E2=80=94 only test TIF_SIGPENDING and<br>
TIF_NEED_RESCHED before re-entering the guest. TIF_NOTIFY_RESUME is never<b=
r>
checked, and the deferred throttle task_work therefore never runs while a<b=
r>
vCPU is inside the run loop.<br>
<br>
For a CPU-bound guest that generates few KVM exits back to QEMU user space<=
br>
(e.g. a compute-heavy or busy-looping workload), the vCPU thread never<br>
returns to user mode. throttle_cfs_rq() sets cfs_rq-&gt;throttled =3D 1 and=
<br>
queues the task_work, but the guest continues to run unchecked.<br>
cfs_rq-&gt;runtime_remaining goes increasingly negative with every scheduli=
ng<br>
period while the throttle flag sits ignored.<br>
<br>
The only mechanism recovering that debt is the periodic bandwidth timer<br>
replenishment: 30 ms of quota is added per 100 ms period. When<br>
runtime_remaining has drifted hundreds of seconds negative, recovering to<b=
r>
zero at 300 ms/s takes minutes =E2=80=94 during which the cgroup is legitim=
ately<br>
throttled and the VM is completely frozen once it finally exits to user<br>
space.<br>
<br>
=3D=3D Debugging =3D=3D<br>
<br>
vCPU was placed in a cgroup where CPU bandwidth limits were set.<br>
quota =3D 30ms<br>
period =3D 100ms<br>
<br>
The bug was diagnosed using a bpftrace script probing throttle_cfs_rq()<br>
and unthrottle_cfs_rq() and sampling cfs_rq-&gt;runtime_remaining every<br>
second. The trace shows the debt accumulation phase, the slow recovery<br>
phase, and the immediate re-throttle on resumption:<br>
<br>
=C2=A0 Debt accumulation (vCPU in guest, no exits):<br>
=C2=A0 =C2=A0 +1471 s=C2=A0 runtime_remaining=3D-209702865115 ns=C2=A0 thro=
ttled=3D1<br>
=C2=A0 =C2=A0 +1472 s=C2=A0 runtime_remaining=3D-210402866357 ns=C2=A0 thro=
ttled=3D1<br>
=C2=A0 =C2=A0 ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ~-7=
00 ms/s (growing debt)<br>
=C2=A0 =C2=A0 +1477 s=C2=A0 runtime_remaining=3D-213902833931 ns=C2=A0 thro=
ttled=3D1<br>
<br>
=C2=A0 Recovery (vCPU exits to QEMU user space; bandwidth timer replenishes=
):<br>
=C2=A0 =C2=A0 +1478 s=C2=A0 runtime_remaining=3D-213617443453 ns=C2=A0 thro=
ttled=3D1<br>
=C2=A0 =C2=A0 +1479 s=C2=A0 runtime_remaining=3D-213317443453 ns=C2=A0 thro=
ttled=3D1<br>
=C2=A0 =C2=A0 ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ~+3=
00 ms/s (30ms quota/100ms)<br>
<br>
=C2=A0 After ~710 seconds of recovery, debt reaches zero:<br>
=C2=A0 =C2=A0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80 unthrottle_cfs_rq @ cpu=
=3D768=C2=A0 +2190.029568131 s =E2=94=80=E2=94=80=E2=94=80=E2=94=80<br>
=C2=A0 =C2=A0 =C2=A0 runtime_remaining =3D 1 ns=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 # just crossed zero<br>
<br>
=C2=A0 The vCPU immediately re-enters the guest and over-runs its quota aga=
in:<br>
=C2=A0 =C2=A0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80 throttle_cfs_rq @ cpu=3D=
768=C2=A0 +2190.055327252 s =E2=94=80=E2=94=80=E2=94=80=E2=94=80<br>
=C2=A0 =C2=A0 =C2=A0 runtime_remaining =3D -5667293 ns=C2=A0 =C2=A0 =C2=A0#=
 26 ms of debt already<br>
<br>
=C2=A0 The cycle then repeats identically from a fresh -700 ms/s accumulati=
on.<br>
<br>
cpu.stat confirms the pathology =E2=80=94 100% throttle rate and virtually =
all<br>
CPU time accumulated in kernel (KVM) mode:<br>
<br>
=C2=A0 nr_periods=C2=A0 =C2=A0=3D 117457<br>
=C2=A0 nr_throttled =3D 117457=C2=A0 =C2=A0 =C2=A0# every single period<br>
=C2=A0 system_usec=C2=A0 =3D 4334782636 # &gt;99.99% kernel time (QEMU in K=
VM_RUN)<br>
<br>
strace of the QEMU vCPU thread confirms long stretches where<br>
ioctl(KVM_RUN) does not return =E2=80=94 the vCPU is running in guest mode<=
br>
with no VM-exits reaching user space.<br>
<br>
=3D=3D Fix Summary =3D=3D<br>
<br>
Opt Book3S HV into VIRT_XFER_TO_GUEST_WORK and drain pending guest-mode<br>
work (including the deferred CFS throttle task_work) on every guest<br>
re-entry in both run loops. The changes are supersets of the existing<br>
need_resched() checks and do not alter the signal or exit accounting.<br>
<br>
[1] <a href=3D"https://lore.kernel.org/all/20250421102837.78515-2-sshegde@l=
inux.ibm.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore=
.kernel.org/all/20250421102837.78515-2-sshegde@linux.ibm.com/</a><br>
<br>
Vishal Chourasia (1):<br>
=C2=A0 KVM: powerpc/book3s_hv: Use generic xfer to guest work function<br>
<br>
=C2=A0arch/powerpc/kvm/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0arch/powerpc/kvm/book3s_hv.c | 58 +++++++++++++++++++++++++++++++----=
-<br>
=C2=A02 files changed, 52 insertions(+), 7 deletions(-)<br>
<br>
-- <br>
2.54.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000bfa54d06553b23cc--


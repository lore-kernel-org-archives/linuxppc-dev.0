Return-Path: <linuxppc-dev+bounces-24955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667D9C54F51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 22:34:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8qz04gqtz2xqM;
	Wed, 29 Jul 2026 08:34:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785265478;
	cv=pass; b=NN7Bxw1bXbP1H2o5ojstH0jgfAeoYawEDU72vtZ04qbkuXAlydLGhuB13tByr9+omzCbU/6IoZ24iaMwzDjmMzcxCkhy87g6b/aZFe8yqg5+d2w1WtV9aeO48YGBnvOJIWXOP78FfL6MjEzjS+M7gb3EwOUiLFDOWiJh8OqvYPBt6MfTTGNssXMu3swlyomf1FwXyS+Zcmww+3MQdL3WchaBorQHPJKfj6mniiJ3oBV9JmsH78wU0dJMvsJ3DQVsyqae0snnbahJgySztTGAZpMMEc234Rsju2RLrf0jgaNsH0aFaUrYscibeUxCqQIqK6pBgsqogoLvZZzPtIP/0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785265478; c=relaxed/relaxed;
	bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J9Eyrgw7xc7PzJc6SDxweGlvJ7CJehQFNdK+XKJAuNaDwzZRl2s/qReyd9xYLsBSX0wOtlfPEpSAoB069tPjHPLdynPEr/HZpyDLM4HQc3OLBiDf1TvxFBo6lgZTA0vsW+FVgGxgGGtFHmOCkeXJZDxHKmihAgpPWA1xMM8dtkyW1uS//OYZB2Hzwd5hO3+vBtfqYAEliKG0/kYVDDs2Kl4xhnU3mtiMPglzj/AU6d5OMZcnlphgMamWXCLbT3yJnELEALW+5rv2D6/LvC7tYu3gckAedS3CILDBGmjrSAf5SCePJHrNCL2YE9oc8yVneUR6e+8+kBXxNtS8spDYvA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pecd9uD9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pecd9uD9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8lJN1Znlz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 05:04:34 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c1671ec8692so21979966b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 12:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265470; cv=none;
        d=google.com; s=arc-20260327;
        b=Iljb1DZkKWbvYYKBo9Rl9lYyFmYdz+R2V7FlRhwYb0nh8fEpGxpfRC2HnIsQymvd/8
         fP7csyjH7wfXAsg+dnatWZ/SiwGW4QiuHLLX6dLF8H1dYJGcK2V1IE40+EhkKDRgkfHa
         Wc1XzVKRoVeU7RUl6c92MNYy6iZmjNGcDfxYPyuTGTg0CrTwM8VptN2bcp1bY1PzBPTn
         qsMDP9V9xh9XUFpk8Wj5VdeY13QhtuiMJXTdrjfIhwmwihKj8y9aNlrzFuZZe/uDEQvn
         BGGRSK2RQbH/TC4D4cfbF6mpjvZe9ZgNlWRyNcGxiV5mqdd7dvdxpc0lSoT3IOSFoRk6
         0mPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        fh=d7XXVjYfg3l3ggkZfTx44iNNmnKdZTqPxMUTwRy0Iv4=;
        b=lT06ftZSVFSUmvAbGQC2C8k60lREf4h46EKvMst245XMBI9lirYF8+Qefuvf4TxKvV
         JX1Qf3QciDg2zk3Q9Htth/gOMhjUgD4a4KfZblpP6XkiZqkQ6r+QqguGwq62Yc/EzdV9
         yDAA36UiWqACHMX62Wp/I0kuZPaAE4CmlzmQTRm7mXO+rvL4mhswYSjBw78JwoLeNdv/
         pXR5JWrlmD39zI7P4N/Rtoben7ZjcucP0LtNYEVbwmiulwiIq5OIZZj8AZjkovkNFcnT
         vi18lMoYFumhci+TtOLcorvXQd9ohTWEXEKrU2Klrhj/gQWgDBu6odw/mUtiIPubSPRb
         AVxg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265470; x=1785870270; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        b=pecd9uD9gvRCmKt1vC7k2IDCnnQCN9xFcf4nREO7Hyvb+xZ/UbCTII2cVsY3cynTe8
         vBT52wDLS4oL8RpCdF6i3phqvLxFfdBFhRA8FUzwpGZtiRIjXo/oR5TtuK2WYn9DEF7O
         qgKSEl32LzpaQAJ5xKm7QA0a15STrRJC/XkWh9mDdrDdQGpCNhUbV95KXvXHx7KLKUWQ
         HtgMEbDKZbvk9nk3ymaUqozblL8R1cUI2m1Fk7B94c8zgKjzo3aelB4Mpvj8Gsx7+nES
         gQdyphAt2hmhD+B1stnJS+02Dz4ke5PyIsYYjXND2C8OvNfW8/Q8St74DVtrZZxDr9VF
         2RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265470; x=1785870270;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        b=roY5NYZK8R9io87QEMAomwXzqe94Xv52I1+zP3XXIh86BVSYtJup2d0uPEAN5KpatP
         1irdSGtXF7aDCcD6U8OtNCgoyXUCYJOQ+rOsl8AcKpt2gOLJZugw27Lto7SHhfl+Ka+V
         kjE19+PrmYQEU1YKz9a3QZs/oWQA7R7MKP5qTnD0P6JFdq41cRxFG6Pnml4Q4DspRySz
         jTCCXCvPYB4fFuEmoR+unzrMRwoU3lzTwrfeHZh8SfroDMKF0O/v89IQFs0yWG9cX0jd
         iurC6B/K6fktT9FJVvzqu31nhOe0OVziSPaw63owxpTq3eaigbkPVJWLc8YlfxGBmcME
         8x9g==
X-Forwarded-Encrypted: i=1; AHgh+RrwYEDmkj9xvQQt+1RZO1abPAhrSqxC6k1D9rK9i+phsEYAOckB70kNLAlbrM3TdqTqFXCNfKpIsVt4F7g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwanDtPsNwONoZhpR2CIdob3IiotpfWwPqB1uRQ+lJzVwaaK2X6
	chf8Elh29iCLyMXtPwm5537UYD3Rf/z8NjSEFUc4yBjagCQghzCKbbjpNA5R4A9EaEZ2Fww0IKm
	PYhqXNSfPSrxEBaXbIebRBjZJMCTYtg==
X-Gm-Gg: AR+sD12BT3DnhO0bTjy05wdE/5X6Y9nAEgHgY5Nwnv9j/wQLng58EPIAsp96QDp6R0g
	8RFbFs79m1VVTfMJPc7E7885D7Ir3t9P3Kreuf8Abt9r0C1xM6vgCY68LXadYRySAoc34f26XZg
	Ky4YsDarJkpXHjW79aktv/rraiOnXzJDj7WrjTl9hHS/sN6tiWjGBdu1oY99nRa6pEpP0Z1Xldy
	lJN8UfjR4i2RHmt7uK71FHVCW7vGzu69TsKZkJiAHO63Cmp7klt3npIuP5yGS66xb10QYz446gE
	9NUar/+4lwnRubqoOLm3zGqv7TD+f60u5/Lg3ORqKjBYhMxPz1V8a2bT68MGl+4UqFFAjR6y
X-Received: by 2002:a17:907:9455:b0:c15:ce72:935e with SMTP id
 a640c23a62f3a-c1f71d7a48dmr204907366b.17.1785265469836; Tue, 28 Jul 2026
 12:04:29 -0700 (PDT)
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
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 29 Jul 2026 04:04:17 +0900
X-Gm-Features: AUfX_mxJJhLv5diWJuX6TiQ6lduJOcthNv0biaHCaSTCMAugyGy8Ps_oJHT9MKo
Message-ID: <CAGEsz8F60gmDxhvqiNib1h3=SoTMi_Uuz4PYOa8DrukHQaTK5w@mail.gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Hold KVM reference for HPT resize work
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

KVM_PPC_RESIZE_HPT_PREPARE schedules resize_hpt_prepare_work() with a
raw pointer to the enclosing KVM object. Book3S-HV VM destruction does
not wait for this work, so the worker can access struct kvm after
kvm_destroy_vm() has freed it.

A later prepare request with a different shift can also replace
kvm->arch.resize_hpt while the previous work remains busy. Such detached
work still retains its raw KVM pointer.

A pseries hash guest can initiate the work with H_RESIZE_HPT_PREPARE.
QEMU handles KVM_EXIT_PAPR_HCALL by issuing the prepare ioctl, and the
guest can then request RTAS power-off to initiate VM teardown. For a
4 GiB guest, QEMU permits shift=26, which makes the unlocked allocation
interval long enough to reproduce the race without instrumentation.

On unmodified upstream master 62cc90241548, the first shift=26
iteration produced:

BUG: KASAN: slab-use-after-free in mutex_lock+0x44/0xf0
Write of size 8 at addr c000000006330c18 by task kworker/0:1/10

Workqueue: events resize_hpt_prepare_work
mutex_lock
resize_hpt_prepare_work
process_one_work
worker_thread

The KVM object was freed concurrently by:

kvm_destroy_vm
kvm_vm_release
__fput
sys_close

Hold a KVM reference for every scheduled resize work and release it only
after the callback has stopped accessing the KVM. This covers both the
current resize and busy work detached by a replacement request. Once all
workers have dropped their references, VM destruction can safely release
the completed current resize object.

With this patch, KASAN reported no error in 10 shift=26-to-18 replacement
iterations, 1,000 shift=18-to-19 replacement iterations, or a
deterministic run that paused both callbacks for one second across VM
close. A powerpc64le vmlinux build, git diff --check, and strict
checkpatch also passed.

Fixes: 5e9859699aba ("KVM: PPC: Book3S HV: Outline of KVM-HV HPT
resizing implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 18 +++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer and full KASAN trace have not been posted publicly and
are available on request.

diff --git a/arch/powerpc/include/asm/kvm_ppc.h
b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa4660..371268a794c3c 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -226,6 +226,7 @@ extern int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
                                           struct kvm_ppc_resize_hpt *rhpt);
 extern int kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
                                          struct kvm_ppc_resize_hpt *rhpt);
+void kvmppc_release_hpt_resize(struct kvm *kvm);

 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46c..7776d6bcb5c53 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1409,6 +1409,17 @@ static void resize_hpt_release(struct kvm *kvm,
struct kvm_resize_hpt *resize)
                kvm->arch.resize_hpt = NULL;
 }

+void kvmppc_release_hpt_resize(struct kvm *kvm)
+{
+       /*
+        * Each resize worker holds a KVM reference, so all workers have stopped
+        * accessing the KVM before VM teardown reaches this point.
+        */
+       mutex_lock(&kvm->arch.mmu_setup_lock);
+       resize_hpt_release(kvm, kvm->arch.resize_hpt);
+       mutex_unlock(&kvm->arch.mmu_setup_lock);
+}
+
 static void resize_hpt_prepare_work(struct work_struct *work)
 {
        struct kvm_resize_hpt *resize = container_of(work,
@@ -1417,8 +1428,10 @@ static void resize_hpt_prepare_work(struct
work_struct *work)
        struct kvm *kvm = resize->kvm;
        int err = 0;

-       if (WARN_ON(resize->error != -EBUSY))
+       if (WARN_ON(resize->error != -EBUSY)) {
+               kvm_put_kvm(kvm);
                return;
+       }

        mutex_lock(&kvm->arch.mmu_setup_lock);

@@ -1452,6 +1465,7 @@ static void resize_hpt_prepare_work(struct
work_struct *work)
                resize_hpt_release(kvm, resize);

        mutex_unlock(&kvm->arch.mmu_setup_lock);
+       kvm_put_kvm(kvm);
 }

 int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
@@ -1506,6 +1520,8 @@ int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
        INIT_WORK(&resize->work, resize_hpt_prepare_work);
        kvm->arch.resize_hpt = resize;

+       /* Keep the KVM alive until the worker has finished accessing it. */
+       kvm_get_kvm(kvm);
        schedule_work(&resize->work);

        ret = 100; /* estimated time in ms */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3b..3425aa8b6a8ec 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5889,6 +5889,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
        if (!cpu_has_feature(CPU_FTR_ARCH_300))
                kvm_hv_vm_deactivated();

+       kvmppc_release_hpt_resize(kvm);
+
        kvmppc_free_vcores(kvm);


--
2.47.2


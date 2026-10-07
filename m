Return-Path: <linuxppc-dev+bounces-28985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F086CA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j03vF39CRz30CZ;
	Wed, 07 Oct 2026 18:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791356489;
	cv=none; b=Wg2CFViiC77rcIfzSz6oZcBUm9ZrXWf4Ir1L7pNYd2eQe7wO0HK09gqJsT5OvArRuR+k+mV1l3o9iYyeBRFMAQPgo9cOGMEwXUYwovW64Koc1bEebdkSRoFbo6EgEqtB7tZUM1/+25/RKP3OCgFIARsU1hTKoSQL7eoIkEvJz5m5iNUB/RrwQ1QlVkAK3lYh9CCZu8OZWhKZwj6DwiXFJSyPAq+s1X/RYxFn6hFFDdu1bAV8aFwHFH1p1l5H5attEUAm+naigivyEVZQRGNWHZyMdbd50U4elKx5Btu/HbqB93yj3qWTPRMA4GUIZCpi8WQj7gaClHPP8VoTKoCBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791356489; c=relaxed/relaxed;
	bh=oLpEQSu57uD4VcTdj38WGaIEWGG6OR3d21k199k1TPg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=O01q67jwbWtFYsX92ZpEalxWDZ3++tgAIY5ws8JK6shOeXpYYtgdFR8ajju3NZkuB3nHlFJVuN0yGA2LXOywuLNEXxRU0xdNMVSpTdfMcIUgfwq318qTuG/+tVSfOatrqNiKJ/qxTZSW2oa/cN/bbu6KsTm+l0Y1+epcQ0xWr4BM/X7zNfl0SfhQCY98ASYnuxwZcDQTgs3h38FXrwaD4a5vR14hN9o7RyPoOlRpuC6K8Xt+cDb4RRjUTbBbBxQhvx8GDi4Iy698MtIX1yxgtdKvc3fjicSTopCGJOZDIyPF0F5qVktC5MZI8Lu9kjJeL9b2NwkInTcB1Ag6oFBFGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VdtbGS6j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VdtbGS6j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j03vD2Lhpz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 18:01:27 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3282db206d3so10597140eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791356486; x=1791961286; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oLpEQSu57uD4VcTdj38WGaIEWGG6OR3d21k199k1TPg=;
        b=VdtbGS6jKE9/Sqj+2SxWDQfj8xvRTLHmt0Z++cgpcQcrem7ClPuvSbN/Es8dYAOsGW
         31PPDVqQFYjl6lIF2qm19E/dQ7Ur10wu0YL7Qc6f9JL08QSPWTDHE7BzCgCG5oldUinQ
         P9F/vzUHgH7EH1p9JN5eiLYJwN7oL1bknZRBUJyb1LvzUiwfjaSp/+RT7Xk2opCuuGBV
         Cglg5pQCutHnBrL6/KxOTI63muFXsBzNGMGlQJ7mS57/dzxCztdqwxOytqad57TYyrHi
         uHLTFapchNOhPaeym1dcrmjqmRRP7yaYVjdGyaTNHiW+TQFjOziXgWBQ5j1Ny1HplY+z
         QhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356486; x=1791961286;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLpEQSu57uD4VcTdj38WGaIEWGG6OR3d21k199k1TPg=;
        b=E4nYS6NPUlyHxJu8L/MnH0/85+lR7M7TfJw4nxu/ME0FxEeMGzRDF46aVWmUdrni+j
         TIaNgzMca6f42HdQzsFh3IfRhVWz9RoWQLOVkGbUFWNoZbc5Ywm/Hxz7CdCoKuejza6s
         5UB7o2UkKQUQtbYr2x8CEYnrIBeGA+hlurOB80Paxz5AUJH1olKmybwR4QgNQAVR/fx3
         hAfyn1T80gvtPO4UYriTaBK3gGhxgRRXEzr08TpMrrpnTjAB5ycvWgIvn2SCRzWuVPa7
         MVyODy+P+kOoRz+alpCm4er6pGx8V01giomoBNiKtg6AaQwtebERsTOl6gC0W8MywuYq
         uo6w==
X-Forwarded-Encrypted: i=1; AKwUvBzKVXDrCxSGbDz7xdI5QFYYsyPMWe2kXlqT32LCF8ob21OnNhuK3hO5kjS+pQIpbsAkHTB9bM0Fz3N4BuE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI6yxTuSPmzeoFW8DjxOKYDkfAbz4aXHLcTQ5oDJisE3zEaqwFc
	SnTyIyKv3dn8GJpwYV45g8fNyLBlaDojhS8cJpNcazl9VEFc2LFjgi+E
X-Gm-Gg: AYBFou0j920Ta6nmnafyyMq9NuIUI1wZK3mS6ir7JQ+qt34AaPcekSUcJqnKmyBgYnr
	4gHeGyVTrD55Fp0M272pMrAQ1eQVeTwbjBzLBUzXR/sqihymvCfaoE8mqfpxHc8ADlIOgD+qWoF
	teO+C29KwF8JhxHbTLUinNRZitZxztULtLE4PfgGIunZp0/FGUR+zjSUPXsADHGu9pdbzwPW8fc
	qopsbf7/gY3A7NEYRgr8OdWE9zdapc4T5qmz6/dsRJ0ostxLs0HcZdc83H8augVpZ99POM5Tnfj
	vNWjhXWwh34yKBhez1zGAq92N7juuoLu/ScSOgXPP4/iLJ4J7H/TFE5v7TWalHqojWmaDDR6rJY
	V6ZNplgFhnIzfMswnVqYTQAe5h5eheTEWWlGSEhkihVAw3ytDN+xvXfIif5Y+LBZvvHofzYYdEd
	oAmeDHq+56I1K89nNIk7V/z9Tqiv1PQUqeq6jpLPevbz0tV64tSBCH5gLLEMKAR7X+qzB5rfwx3
	P+iWMFqAfn/PkXdnnKFP/fA9908zmEqunaixx3NDU5hyITDxuKInQ==
X-Received: by 2002:a05:7301:6907:b0:34c:85c:da56 with SMTP id 5a478bee46e88-3515dde8fa4mr1393173eec.17.1791356485497;
        Wed, 07 Oct 2026 00:01:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm5850369eec.13.2026.10.07.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:01:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v3 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
In-Reply-To: <20261006122404.99358-3-amachhiw@linux.ibm.com>
Date: Wed, 07 Oct 2026 11:48:24 +0530
Message-ID: <33uirq33.ritesh.list@gmail.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com> <20261006122404.99358-3-amachhiw@linux.ibm.com>
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

> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule, but several paths do
> not.
>
> kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
> data-side and instruction-side faults after guest exit with preemption
> enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
> handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
> handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
> H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
> H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
> kvm->mmu_lock.  That raw lock choice is intentional because
> kvmppc_do_h_enter() is also called from real-mode paths, so the correct
> fix is to establish the proper preemption context at the virtual-mode
> caller boundary.
>
> On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
> kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
> HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
> enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
> resize respectively.
>

I was going over all the callers of lock_rmap() and try_lock_hpte() on,
and I see that we might have missed kvm_htab_write() path...

... after spending sometime looks like we need this diff for
kvm_htab_write() path as well, since it calls kvmppc_do_h_remove() which
calls try_lock_hpte() and lock_rmap(), although the race window is much
narrower and maybe very hard to hit.

But still, could you kindly look into this and if needed please take it
forward too. Please note that this is not tested, so hoping that you
could take care of that too.


Thanks!
-ritesh


diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 908495f2b001b..916db7ceb51a9 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -47,6 +47,8 @@
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
                                long pte_index, unsigned long pteh,
                                unsigned long ptel, unsigned long *pte_idx_ret);
+static void kvmppc_virtmode_do_h_remove(struct kvm *kvm,
+                               unsigned long pte_index, unsigned long *hpret);

 struct kvm_resize_hpt {
        /* These fields read-only after init */
@@ -308,6 +310,19 @@ static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,

 }

+/*
+ * Virtual-mode H_REMOVE.  kvmppc_do_h_remove() is also called from real
+ * mode, where preempt_disable() is not usable, so the guard stays here.
+ * The helper takes HPTE_V_HVLOCK and the rmap bit and does not sleep.
+ */
+static void kvmppc_virtmode_do_h_remove(struct kvm *kvm,
+                               unsigned long pte_index, unsigned long *hpret)
+{
+       preempt_disable();
+       kvmppc_do_h_remove(kvm, 0, pte_index, 0, hpret);
+       preempt_enable();
+}
+
 static struct kvmppc_slb *kvmppc_mmu_book3s_hv_find_slbe(struct kvm_vcpu *vcpu,
                                                         gva_t eaddr)
 {
@@ -1878,7 +1893,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
                        nb += HPTE_SIZE;

                        if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
-                               kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
+                               kvmppc_virtmode_do_h_remove(kvm, i, tmp);
                        err = -EIO;
                        ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, i, v, r,
                                                         tmp);
@@ -1907,7 +1922,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,

                for (j = 0; j < hdr.n_invalid; ++j) {
                        if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
-                               kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
+                               kvmppc_virtmode_do_h_remove(kvm, i, tmp);
                        ++i;
                        hptp += 2;
                }




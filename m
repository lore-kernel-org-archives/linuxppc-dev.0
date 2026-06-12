Return-Path: <linuxppc-dev+bounces-22558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A253CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:36:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMX05Q09z2ykX;
	Sat, 13 Jun 2026 00:36:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781274976;
	cv=none; b=bbS26AulXCsENWohqTcmYYHN/rAY3iV9EGm2YiZwTY0g3NjnYT11OAX7CoPpEX3OfU2Ga4oepKJzuoyBK/Kw4em3znlINK6yNI4d3bY80uxGZg+EmJd2q6ruZewkjyKL5zKohqEgOSl4JgLmYvOM9GsG6fMafYI8qqoRgjKz4h6VnG7uVf9LkD3PesdKtMv28+AmtZAMjrrhTN5tqXFsNuVyd1U4Mm/F1k2SNuzXwJDdGueCEG6v7CVU868nQsHBvCtS1kuZrVAEYiNQ62m8YTEFlF6HUVvh7xraCYTbZOQvs/PUZXTr75T6/XnLQ2oMfL8fw2vgQWPPvGN9wXDoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781274976; c=relaxed/relaxed;
	bh=VTVHpWDAc44gU8kS/zE/FGdewgWSDCACvR7pfF1CeHQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=epcLh29Dcc/pqFNX0pB4jkpId9+ctwPhkLwv00w45NbLzc+CU1J2+iazGrfvivJ4hID9C0VdPpZx9ZVkFdw01FSj+cSx3SSnVcGoio57pOinhk9XdAzaZsyFGq2tVepc8O26o1nWx5mPfyLt8VZopwimBqMGaZZ4BEPg7yDv8pTxYSVLZRalk2VgDKuf3c6rvCHjkkKli2Rjpt4DAkeMjKAbdjx02WQQF/EkIqnI6HNSogb79VtbCEzi6CpGSsxQ78a7OY1OSj1ARvMsJFfoezKItP9BAi0XaABAl6dfakThx10xSjLCl3ZItykoKNrQLAvWJ9QCwuXUBVM/jdU4Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bZ2pifww; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bZ2pifww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcMWz00mkz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 00:36:14 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8422871b42dso655032b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274971; x=1781879771; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTVHpWDAc44gU8kS/zE/FGdewgWSDCACvR7pfF1CeHQ=;
        b=bZ2pifwwW985BWPr+G9QwF/h+Ti1Mo9PGZwiRuzwyRZYVcN86LGNRoDKKHSdXYBvPf
         wEJRUcORMBYThdl4itJq1D//th2WlX7thb+7dJSUgR8CAepaXp/ZxdEkHcwttHeVR933
         FMFAJkWDFiaz9X7y+owt8eJ0H0OrESTv/7rkuCJ/QYyO0IOdplLYQ3Cjd44aMeBJHgxn
         Wc3mZqiqfbSnhpsr/4WcSJGzZ941xqK//2yFzQdlLEt0CBBTBl0aGyylOG1rUKwpiple
         j8X81+HjB1lAje/pKIZ+LZHizD2ynnwU5o/s7hAPymw69NCL/dKM7UEJr1ij4AL5xPE1
         CLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274971; x=1781879771;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTVHpWDAc44gU8kS/zE/FGdewgWSDCACvR7pfF1CeHQ=;
        b=mE6qdWOLebL6XMZItDqAnyfd9z4p/Z6hnj/fo9MdTqWTzC9lKs7QQld4LrGu1PBNm7
         yjkxcMUiew3q2XWzCYBuayVeRcS+VKv9Z9iI3rPX0Twngf2EPwu+90bqIvNaojco0g3g
         QA2yQfJ1Jfqib6X4/l6M3yysMaAiBCe/cRPg5GZpjuTeuXejrYmCRQ3LecbF2qk8+Cak
         5Jz7HgKxvV+v9DISC9hm4fIEhi2S/DC28Fg3t3nb+/6PCNG39ndE6z0qKtkInptcX4Ji
         3tw9i1ew8HN6tIGRMYso6SqZZHEToMeNQRn4MnVNN8f5XtOJqo+fsL0haJR2N+qE/7Pl
         YMgw==
X-Forwarded-Encrypted: i=1; AFNElJ/1BSrpOAhVJGQXijrqoxzM+xx8Vgs7SlRSbV5Wo5yn7Bwiy1sCLJX4nfPTkj8xqNj+85tXPYRwYnb+UsI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx59Pemnjz8hO6hT/gYX4kdJ25TC41c/j0vqI3JmigIZC9r/BAj
	tG8KMO50bYo/dMEmsP/sbDR5fsIkuDT9uOHuwdLA0fT0f1pbZBVPar5g
X-Gm-Gg: Acq92OG6fBW3kSZgcpurRwAbgyFmNRUP0g7fBil4y4o6FEwt0ARp0aoKwG8JsRac0VG
	M2LRARWKdC4H1w6BnUxhBbHUXB3GHZRM9Ls5b5E4XdX7lFbHOf67NsPBzLC9nyGZsQiDzZTufV0
	9FsFCVKMrCge+S7Acz0d/9VdPzW6LJaSIXorXMLWgljdXgtOK3fz6yR2B3R+Vo9Sinj7x91fkaC
	lX+lkfNEv6ei7U6UnsdU5A2Riw0UCFy3mWuY0jZp07BaIZtePZZcIcTtASBbqTsMoD4xpbFOYmy
	cqeIaFTTV4mzDdKT37ED8n/6PGJpLQbA7hqXwY8PG5Is71UiFcWTtSM1YZ2dZiSVOZ28p8SvPXI
	EV5VfFsnXBhhV2Rl9nF2xJjCX5eoV04mCFz4sE9uxriB/yaP9HXbB0SNXf3Xawyv527tgoS79D4
	Izcr96VIuBzN7nnNjd1Mel3UShhHc4rbTOqmg+
X-Received: by 2002:a05:6a00:f93:b0:842:46a6:e2cf with SMTP id d2e1a72fcca58-8434ce46552mr3664545b3a.21.1781274971241;
        Fri, 12 Jun 2026 07:36:11 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf039fsm2390771b3a.20.2026.06.12.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:36:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
In-Reply-To: <aiml9iB_vUASRRQV@google.com>
Date: Fri, 12 Jun 2026 18:19:37 +0530
Message-ID: <ik7nexem.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com> <aiml9iB_vUASRRQV@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> 
>> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
>> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
>> VM's limit.
>> 
>> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
>> to the kvm_create_max_vcpus test case to limit vCPU IDs to
>> KVM_CAP_MAX_VCPUS on powerpc.
>
> How is this not a KVM bug?  Literally the reason this test exists is to validate
> KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.

It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
vcpu id = core * stride + thread,
  .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)

So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
with the maximum stride / SMT value.

Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.

e.g.
static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
...
		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
			pr_devel("KVM: VCPU ID too high\n");
			core = KVM_MAX_VCORES;              /* rejected case */
		} else {

So, it's expected on PowerPC. vcpus with higher IDs can be created but
for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
But since the test as of now is not doing that - that's the reason why
the patch only allows to test max vcpu IDs upto max vcpus.



But I guess you must be hating the #ifdef __powerpc__ there. I agree I
don't like it either.. maybe we can do it this way?


-#ifdef __powerpc64__
        /*
-        * powerpc has a particular format for the vcpu ID that depends on
-        * the guest SMT mode, and the max ID cap is too large for non-SMT
-        * modes, where the maximum ID is the same as the maximum vCPUs.
+        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
+        * so a default VM can't necessarily use the full advertised ID range.
+        * Let the arch limit the highest ID this test will create.
         */
-       kvm_max_vcpu_id = kvm_max_vcpus;
-#endif
+       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);


And then in kvm_util.c -
+
+__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
+{
+       return vcpu_id_max;
+}

and lib/powerpc/processor.c can define -

+
+int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
+{
+       /*
+        * The stride is the default SMT mode from KVM_CAP_PPC_SMT (1 on
+        * POWER9+, the host's threads-per-subcore on POWER8) and is always <=
+        * MAX_SMT_THREADS, so the result never exceeds KVM_CAP_MAX_VCPU_ID.
+        *
+        * TODO: exercising the higher (sparse) ID range would require setting
+        * KVM_CAP_PPC_SMT and creating strided vCPU IDs.
+        */
+
+       int stride = kvm_check_cap(KVM_CAP_PPC_SMT);
+
+       return nr_vcpus * (stride > 0 ? stride : 1);
+}


If this looks good, then I can re-spin a newer version with the
following changes:

1. Use above logic in Patch-4 for kvm_create_max_vcpus_test instead of
   hardcoded #ifdef __powerpc__ logic.

2. Drop patch-5 (print vcpu_id) debug patch

3. Squash all the type specifier changes i.e. Patch 6-10 in the main
   Patch-3, the patch which adds kvm selftests support for powerpc.


-ritesh


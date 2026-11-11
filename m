Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652D606E20C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qev54AsB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqs3JlPz3bZf;
	Thu, 12 Nov 2026 09:29:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436169;
	cv=none; b=E0IGoxuwKOyd4+LFKzVvMpMZNUgeaz2zz1vvd24IhJf2WWNDbES23YfsY7osO3Q3psItfUccR1ugDW0q89Uav/mzZ3w6wEEm34SCpUBgWjneOGoXCu4H7VpoW7f2crsE++3dqL2CMxO/b0C0o+oFQRaEQ9PlJSEw5HYre3kE848B8PwdqpppaWy028gdmpCdyD4EEezDhyLE9vJ7o6Y64gmChFwAB58JxF/4Ez/FK7IkW2ikBFue/gpsugAqRcfE1K5LpsvRZ8N3n/PpnbVYG6ZlKaoUIE1MPlxvErXxv/8JwEzxXtSqRocs9AXqmRg+xaYnrBn5FbOHifQlzHthcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436169; c=relaxed/relaxed;
	bh=TIWrijKrA2nzOaHIkh2rqMVDBQWKHuqynjXpx+Gqrqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkeyb1QzOnjCbTq3GFmyxiFbrRoSGvNMx71lsia3saJda0kstkMZfeZ4vhqu6MKFgWM9nO1otq2Xa4bZ/tz5nYgd+0rk0iIbewh7j5fqnJw2F/N4vZOOH7M4wd2PDMvDE+PYjTZKfiPTmgBYAhMeugobAXeTYES08guolIDgDP4Ng8AS0xZATTwPc2OHz0nYjaGcA0sf8rqbrta8QuruebU0pyYM89sSYfZdX/ND/z5VSvN9IOhhG8vOyj4fC1W/3IFzUD9vtHBd1GVb4dYRJaMLpKvT0R3x1OG3Sxjqp5BgS3+qbkqYjl6oOXo96i8AsNYyDQ+UrYN9W1gvH7TpDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qev54AsB; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qev54AsB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj3D5Yz30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TIWrijKrA2nzOaHIkh2rqMVDBQWKHuqynjXpx+Gqrqk=; b=qev54AsBLwMlGevexDKrvoAopr
	bmK3FXCOynS6kTZwXv1841vKQ0VxD6TKzQlVlWsn41Z44yt4LSwScwK+kGhFUF6Kp8wFQvA2hirve
	HTJoMiv7NPn5wNqfyLS7G0zpfux6Kqyh6HFsvsJDAA6N7jPgAX3OA/B59uV3JNiVe0BclpBEPTgE1
	ez+2bWZ7WYHQgt1N2vXADndRKiBdZFCWjKC/f7KnYtH+0jbEecXjeHtsq3Xo5a5npcZzXvhWFICWq
	+GOMC/s/9jv1FtOuG4XPGcnSuz5o8FkD7IKQ26T+gl4tp0kAGKdNkRCYLHyW14n4RTVLcybSyu6tl
	4on1K8SQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoc-00000009dbc-2AlK;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000008O-45AQ;
	Wed, 11 Nov 2026 22:29:11 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 09/16] KVM: planes: Kick the running twin's pCPU, not the request target's
Date: Wed, 11 Nov 2026 14:29:04 -0800
Message-ID: <20261111222911.477-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261111222911.477-1-dwmw2@infradead.org>
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
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The remote kick paths (kvm_make_vcpus_request_mask(),
kvm_make_all_cpus_request(), __kvm_vcpu_kick()) read
READ_ONCE(vcpu->cpu) of the plane-0 vCPU. But vcpu->cpu is per plane
vCPU (kvm_arch_vcpu_load() refreshes only the loaded twin's copy),
while vcpu->mode is shared in kvm_vcpu_common. When the vCPU thread
has migrated pCPUs while a non-zero plane was loaded, the shared mode
reads IN_GUEST_MODE but the IPI goes to plane 0's stale pCPU: a
waiting request such as a remote TLB flush completes while the twin
keeps running on stale translations.

Read the pCPU from common->current_vcpu in both kick paths. It names
the loaded twin, so its cpu field tracks where the vCPU thread runs
(on x86, kvm_arch_vcpu_load() refreshes it).

Found by a local Sashiko review.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 virt/kvm/kvm_main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d256bbf301f4..24d2291b60a2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -244,7 +244,14 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
 	 */
 	if (kvm_request_needs_ipi(vcpu, req)) {
-		cpu = READ_ONCE(vcpu->cpu);
+		/*
+		 * vcpu->cpu is per plane vCPU and kvm_arch_vcpu_load()
+		 * refreshes only the loaded twin's, so this plane's copy
+		 * can point at a pCPU the thread has long left while a
+		 * twin runs elsewhere.  The mode just checked is shared;
+		 * the IPI must go where the running twin actually is.
+		 */
+		cpu = READ_ONCE(READ_ONCE(vcpu->common->current_vcpu)->cpu);
 		if (cpu != -1 && cpu != current_cpu)
 			__cpumask_set_cpu(cpu, tmp);
 	}
@@ -4129,7 +4136,13 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 	 * vCPU also requires it to leave IN_GUEST_MODE.
 	 */
 	if (kvm_arch_vcpu_should_kick(vcpu)) {
-		cpu = READ_ONCE(vcpu->cpu);
+		/*
+		 * Target the running twin's pCPU: this plane's vcpu->cpu
+		 * goes stale whenever the thread migrates while another
+		 * plane is loaded, and the IN_GUEST_MODE just observed is
+		 * the (shared) mode of whichever twin runs.
+		 */
+		cpu = READ_ONCE(READ_ONCE(vcpu->common->current_vcpu)->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
 			 * Use a reschedule IPI to kick the vCPU if the caller
-- 
2.50.1



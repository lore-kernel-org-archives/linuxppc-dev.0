Return-Path: <linuxppc-dev+bounces-28956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5C0CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZK5g0xz2y2h;
	Tue, 06 Oct 2026 21:30:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282601;
	cv=none; b=eWKQ/6YWNHICVil1PNAoc69boGbm5f/ky7AyGsiI0EKh7T+pL38g9onNjsY88ChnOqHoR8rRf5BHip2F5FC0NO/2av7GyKSHrjg4EmRoLN42rGefqAQukAw9xmeMIDejmafbx4ozG6y47KYVcKy7w9x3YKAmOsFZBLgS1gpTdzEwUsnAZqFJpO2b1YWAfBB7ZGsBAz3wHonJ6hJ5BYVb+RrcNBhmAdtl4u1Uy5OWHT0qFCrjTp9BF2LxJl3m/7Uc+9gmrLENHqgIwdEgHbTuxFvISBQPgdcAdd/Kg0edPPBigz/tgjupummNm/ayOBc+ATFZfgUiO6GCjSTRrUAAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282601; c=relaxed/relaxed;
	bh=ZcbRoP+uea/9OIqckWxSVeGmNCVXFZup7WqyFdJFlC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1NO7keOg9AGDt/qBwe59tmc+13auR7iq8U+StynxKMSPS2N9Iof7az7nd975IZN0jvzQ23JTr3jXVWrsBCykVyeKnxEGmf84wFWJYOEYuVApSk1jxJr0+b7rVN5jPfBPC3F3Ll+CHR+ZMyBM8Wl+lByZ4cstGKwwg+m3ph24imLqlxbgh+XOdOegeyc8DmLxjR1RJONoJoQLQ0A0pvcS1RpW0fCqIMo1UTEZITjXpOKqDhKMVv7xftDj87h5RYLd4aAg+UqktHLBM2rTqbhOAj41m3akVrekaYQljGs1tSohGsL1FMJaJ0S/BGGacMotzNScGda+K26S3Gk06SBYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m2zA1WjK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m2zA1WjK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZK0jYmz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:00 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-34c4a0868b6so2164144eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282599; x=1791887399; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcbRoP+uea/9OIqckWxSVeGmNCVXFZup7WqyFdJFlC8=;
        b=m2zA1WjKqb7KsY2ewbHuhnDL/k/fhSjO6vW+RfDckX65izyPAjhufJoEp8jTK1Sp1/
         SMUBHjQZEfGI+uWoNeeB02+/FXxSQ8uy4H6JIK0/Yl5hC1Lel+Emjd2kAoBn+dQ6K6fU
         YgG7mf0FztAGLWwcnr6/JhTgpnkDgbFuCA9skbt+fCzi8+DkKx0C+0KBvFBFG9u2qU4U
         /YFtdySH16APS+53WZNqfL0obcQBzw4WSRwC4nQnzPkWihkf+uN2CMk71kyjbWlZmGjQ
         c63NA3IFR/T6sRiIuL9o1vb7Chcq8uSmCGP9lX5b1KeMHdHXsHwyjwCxCqFTPJQLmPy9
         4dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282599; x=1791887399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcbRoP+uea/9OIqckWxSVeGmNCVXFZup7WqyFdJFlC8=;
        b=t66Ll/0whoTBP+I6X1i//nErEkQHjU2mm2wGIJDimumuiSdp5I5nCQ/xQYoWgrt8j7
         Y+K17ra6Kb3HVkVw1uoTRYrEDKCB4qGodTPBshnLr5DmknMlT4phvqKUHBFY90BhhFdZ
         tcXdPqTOosdwxCDOBMFra9t3GrptzqONxwmA+ilgiMRRAKo7Cx5IhIq+91DGoSIYd5FX
         DamRbcXznPaPEJ81pqFVzyZM9F4JbNp0fJ73LmFrUSKU3cft4SVWkwY/A1ooySzqYHlH
         sgp31l3a09ZNZLdXIFU61iRRQ3+/rjZGCox8AuxaxC+Lbx6rHPMxLH+0fc2BoHTH8Fet
         2/HQ==
X-Forwarded-Encrypted: i=1; AKwUvBybPn6bj/jqQ9JAwnfjfINz4hsbBoP7R88QedVEPforn6QflHQr4XD+KiVawVRrwR5Ktc0+CT/fhe9hryM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kDM0ocNNNkw7nBIHAUy/Ba1njz0ZgmwoNvzP6jBOfCPU/MaIBU
	kMdKXzrouPXc6p+gsv2NVQe9qnTkt5zPWKqg7YFS76Ht4KRs3O+5HXZM
X-Gm-Gg: AYBFou02+AzIzgnICBza2ii6J3nu443qgj2w2OVZAcUbpoGMCg7ykSavTZcQYHpqjvg
	Hs8OCK5yP02dsBZ8QjFJkYHr84PUzRyp1AAvJET+wIzcQLkCM0j/DJe2Y5e7Dgtp1pyvZTgc+b7
	G4VVL+FJYqo91qd4FsGtwwyvBKfZdknO9RvpRDYamr0PCFq5SzQUireBBq59VvjYiGJdVy5v0ir
	7vKP/G/78cdmQfMj7/ppkyM3Zh+/g24Bl8Gqic9m0nUCEmumTV5B2DFDIiIKE2rWaZwjJQVXdhy
	2RfKMPV50aIB9F4XigvrfNmhWNO8OcA/aBbsYoGUL+IVhrE3F+iAB4RGoMSQ2CarRLNTXu5IeQU
	/fAvTI8YQ5uSXEdjTC78OjLOG+L30vLDt/vWLwb1gMypxmVE7vBv7NZE3Z6EqdfIPvF5u9uhCs4
	b55LOZMVj1nh8xLD4+OM27/JHWVVg1Om2+qEMWog3wKSfdzdsd/blsRqfGnhJ1aA+w4gIF7fJSI
	JJJWN9n3F4bK/1bnJICbKZOILBLv43KElBCw/tsZ+MuE1QfEuo+9mTygKQH
X-Received: by 2002:a05:7301:9a90:b0:351:54a:e320 with SMTP id 5a478bee46e88-3514dc8203cmr903000eec.2.1791282598999;
        Tue, 06 Oct 2026 03:29:58 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:57 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 3/8] KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
Date: Tue,  6 Oct 2026 15:58:37 +0530
Message-Id: <bbfbaa9fb2eca8c92f59dc980546c2587dcfc130.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit

kvm_create_max_vcpus creates vCPUs from 0..MAX_VCPUS-1, then again
with ids at the top of KVM_CAP_MAX_VCPU_ID.

On PowerPC the vCPU id is not a flat index: it encodes SMT thread plus
core. So on powerpc maximum permitted vCPU ID depends on the VM's SMT
mode and the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple
non-SMT VM's limit.

So, skip that second loop when KVM_CAP_PPC_SMT is non-zero. The cap is
0 on other arches, so they still run it. The 0..MAX_VCPUS pass is
unchanged.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..1b95027d41ba 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -58,7 +58,13 @@ int main(int argc, char *argv[])

 	test_vcpu_creation(0, kvm_max_vcpus);

-	if (kvm_max_vcpu_id > kvm_max_vcpus)
+	/*
+	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
+	 * which case system topology is encoded into the vCPU ID and so a VM
+	 * can't use the full advertised vCPU ID range without crafting a valid
+	 * platform specific topology.
+	 */
+	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
 		test_vcpu_creation(
 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

--
2.39.5



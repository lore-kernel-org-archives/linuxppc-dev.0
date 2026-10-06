Return-Path: <linuxppc-dev+bounces-28959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4198DCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:30:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZg42Dvz30V2;
	Tue, 06 Oct 2026 21:30:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282619;
	cv=none; b=BXCTb8SkxHnxdpWqx00XAObG3hRHp2RFQg9haSf9HlzmT/hc9p7asnJrGmgYhUuaNkSsyaE2cv5s3dxDV4GDjNiI5GhfI4qkwHzVSna2yMsMYaZMBUFH60fJlicY0Tbws2nh+y5a6nREx84ev3feQREEhHlCxNaFeH+3+4kFBc/xCoiYwJGc3cl/j8HKFLe/fEZ1UkYncxtHUFfxXJcceV8pXkm5raNinU7kSTmGXgJnROksuUopSjm6XMHQdf+Pr6AlubyKwLRwYxyOfA4Y7s5/JLQll/sHKFZatOYpTL7goHB8OMAHM+12quPCtv/LY+eAyH6UWgHYHG67Ik4otw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282619; c=relaxed/relaxed;
	bh=f2zCsQ/oYn3ghBOOGUriCrZuEtWUXY39VXZEGkJ0WUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c62mVV9+Q7U1c7co5pABNKTMpwnS+cXjsyFnlOrxXWtemhxDCF9t9/u3z0N+kK1F8dt988sCvp+gJyIa2qeR++6kcsvjUsPiLpG9EbmsymXJ7zKcsjuxNi+NP41i6sYP4BO9ztbNnh5sRxGUXBpyJTcRe2ub3CypBVrgZ0B0E5dDwH+bPAAlrYEnh0ArNNxUEf61F74AaUsYmZEqnLwN10bsTMhpa5QiIJaFv+dy5+QVkyH+115GClWVfNCPWM0ipWAuJHCnROPJAFLZ/iR+kMfdmgOdsoAVkPterUrEZTTW2MNCjS6wepB62h89GnXKxT2WYpHansqLnQk+ZSqI/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qyZ8F4Ah; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qyZ8F4Ah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZf5FcLz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:30:18 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-35115b52125so422328eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282617; x=1791887417; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2zCsQ/oYn3ghBOOGUriCrZuEtWUXY39VXZEGkJ0WUI=;
        b=qyZ8F4Ahs74X1puixaQ2jWuKVcQ3CKCt43wQiNrpQseNCupRqanUhuX24Xmwofz3pl
         HtzBmK0GEBoOVwrlllC1Isc2ys+32n7lFE3DcgrfVnwGeJ+yrd6jBsgUs80ZkZ2AgfEz
         iIpq90yU2TAmbQ7B8gjWP7hgwNef5Jhd4WChKiYdS5wLzagoIGA2p74LXguw0GmZehSR
         ykU3tmqZNwXOWv6xIIDlFvoZALSnsK2RxFqoSpdl+I8QCvgkdO7ke1W3Q4XBcqghR0c8
         pJh92AgBp8O8FdyNlgEHF8EztHkm88eS0yFy2I1ZaQaw5Hemg1/SrYRiBmm7F+8sjnm+
         z8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282617; x=1791887417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2zCsQ/oYn3ghBOOGUriCrZuEtWUXY39VXZEGkJ0WUI=;
        b=nIB41nyi9bjPwDTjv2CWV4yD0iaEIyexxxgJ0iYhTRLwLcEsnXosu3lqgWsqzs9CKy
         8Ubki9E92U7y8r/Qh99lSlTrvjmG4IrJyOIsCLFzwTsS6qUvW1rskH4la30amuCneIo1
         OwjgddSAmrmKmitM9mMVQobL1jVDS5TqeiyzhCHTkC2kbEYA1VI5UpmnXHqcA83DVmUK
         p42z1gLNHBxHcssorOAI0w7/ZkVdcvXyYit3moAumm5QTZc3lGjE/Z1W/aI4JGJUZ77h
         v7Gjr9AZJAxu9XStgAu2Fv/OGvkzO/Nmtjfh+qXb9t6srSEoPIE57RfRW2M6v50yK9ZO
         7o8w==
X-Forwarded-Encrypted: i=1; AKwUvBy0Mstggg0qAySVEpnBx8sqyISPh8LnBhw+/Q+fWwyswSRiZGjS3ouBJWV3U2IiasKvZa+RzcouofpzOiE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mScllzkmz2J+d6R8uCaW9dtIqtdZpLmI1b6dGfZzPahiOJ0cf5
	g7On20zwAMmorPthP6uzL8tVmd3jQNdbllmK0hVhrInTv4doiUuPV1tj
X-Gm-Gg: AYBFou0uSCZQKHi0PDmlDMw4SoOfQFI8Q1niQDygVTkmkx14IyJPZ5+B2XsqKJtOvy4
	rOvgofiAG+PK/oIcTd7fs2aPR/66ZaG3HZd3Jis7lsGZ+jNAnq4zLyj2TK00p21l0PNyFT0vpVI
	VWh5fP2WvIAwF4DHVJ5gbpgQ1hWeNMpkRAKxe9hpUKRqRr7deFJk8r9OSSIJzoyi8GOqku/+b+D
	gMPdgpjO46Gu9U+EH4Dsj5dAcl2OzkusJzUFOsfHh1paXRxSYzdBySm68TDtPD4Vn0JihqOcxVb
	/2iLc+oWRVdHoNfhW1Jot+tRYHJiv9yggNWJOMUY62mPlOK20bxvIBAYHNZDlcDqZlk/DjZqCsW
	3qReUYaoDCgtU05C9ZlWeNj2bgQ2m6GEVtoY4YP4ArsIklyroP/8xlfmN3+okvEmWoL91MQhrRD
	NpTzIDTbAIeC2G9Xri9vv2CddWR9JeTYsjZyrDDSby39tyKqj1A643xAAYsTxVCngF6Y/mzXJQe
	PUbSk1Fl5UkdstC5MFRtl/qGiTZOwOuKRhlxjWLMN+6rnpqINI0DWiHHbPx3HeiS93QT+k=
X-Received: by 2002:a05:7301:6790:b0:351:248d:d63b with SMTP id 5a478bee46e88-3514e2b30dbmr1487049eec.11.1791282616520;
        Tue, 06 Oct 2026 03:30:16 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:15 -0700 (PDT)
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
Subject: [PATCH v7 6/8] KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:40 +0530
Message-Id: <c8856b73b06bd4b44ff31e7454c8fc56dd402428.1791280439.git.ritesh.list@gmail.com>
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

On a PAPR LPAR, KVM_CREATE_VCPU is H_GUEST_CREATE_VCPU and
KVM_CAP_MAX_VCPUS is only the vcpuId range but is not a guarantee from
L0 i.e. because L0 Guest Management Space can be exhausted before that
many vCPUs exist, so creating MAX_VCPUS is not a valid assert.

So, skip the test when powerpc is pseries LPAR (running nested i.e.
ibm,hypertas-functions is present).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 1b95027d41ba..22279c638d06 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -39,6 +39,12 @@ int main(int argc, char *argv[])
 	int kvm_max_vcpu_id = kvm_check_cap(KVM_CAP_MAX_VCPU_ID);
 	int kvm_max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 
+	/*
+	 * PowerPC's PAPR L0 does not guarantee KVM_CAP_MAX_VCPUS when running
+	 * on pseries LPAR (nested kvm-on-powervm).
+	 */
+	TEST_REQUIRE(!kvm_is_ppc_pseries_lpar());
+
 	pr_info("KVM_CAP_MAX_VCPU_ID: %d\n", kvm_max_vcpu_id);
 	pr_info("KVM_CAP_MAX_VCPUS: %d\n", kvm_max_vcpus);
 
-- 
2.39.5



Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8265C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:06:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E292075C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="TDnUGLf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E292075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T8yB33sxzF3D1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TDnUGLf0";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89l5DXNzF37v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TDnUGLf0"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89k6006z9shy; Mon,  8 Oct 2018 16:31:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89k2gK6z9sD2;
 Mon,  8 Oct 2018 16:31:38 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976698; bh=6w0Hy6mdjFKblOjg+1Quta1fS8/UpJ+L0TQs3UmPYHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TDnUGLf0+PitANuesI+1VbzWlZ7j53K1owB264NO8Rv7RUSAfghQs4Eq7UyqMXdsb
 M1aXYPICgf9RDjGeLo3mfa9yaYLaj4O3ntKPT6pjNe2Bi8OhSjcbLT2xcOvlblg0gZ
 qLnPQLppI6UMIlEbtBj2Fnl+XUtSeNvuaylKpSyRyEHDnjBalc6K0LXZhBlySbuexr
 LReXdApKrAVa84rDyO5jVG8h6Naz2wfr0f3D9EMyE+D8S+icWY76WoJvWc0/kh9hEP
 cPpN4zhYfKx0Qa2VOMldCcHZpBpNpDW2l4ZA5ZhWoXy+fFNrfTH1uC0L5UA03gnWXr
 c0SHQJpbj6HZw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 13/33] KVM: PPC: Book3S HV: Clear partition table entry on
 vm teardown
Date: Mon,  8 Oct 2018 16:30:59 +1100
Message-Id: <1538976679-1363-14-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

When destroying a VM we return the LPID to the pool, however we never
zero the partition table entry. This is instead done when we reallocate
the LPID.

Zero the partition table entry on VM teardown before returning the LPID
to the pool. This means if we were running as a nested hypervisor the
real hypervisor could use this to determine when it can free resources.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 123bd18..8425d72 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4505,13 +4505,19 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	kvmppc_free_vcores(kvm);
 
-	kvmppc_free_lpid(kvm->arch.lpid);
 
 	if (kvm_is_radix(kvm))
 		kvmppc_free_radix(kvm);
 	else
 		kvmppc_free_hpt(&kvm->arch.hpt);
 
+	/* Perform global invalidation and return lpid to the pool */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		kvm->arch.process_table = 0;
+		kvmppc_setup_partition_table(kvm);
+	}
+	kvmppc_free_lpid(kvm->arch.lpid);
+
 	kvmppc_free_pimap(kvm);
 }
 
-- 
2.7.4


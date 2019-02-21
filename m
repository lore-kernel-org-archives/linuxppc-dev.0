Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25758C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 02:43:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957BF2086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 02:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="AQib0iF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957BF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444f0z4wRHzDqF6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 13:43:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444dxY3vhNzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 13:40:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="AQib0iF3"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 444dxY2WGMz9sDn; Thu, 21 Feb 2019 13:40:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 444dxY1zKsz9sCH; Thu, 21 Feb 2019 13:40:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550716833; bh=M8WDL4zt7b1DHVn1l4SdTiqv2JRsqOlZc/WSudxmcm4=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=AQib0iF3XYyQo4laRFDec9Iz0CW4+hYFJNUzErOeU+hiaNDl1FM4HlkQXfW9vAyVI
 HGMn7/hKL5p8h7aIvhUqXzQdz/Z5SofLAoWN6XgFpofsJLlSPKoVsf2dfKURR8FKDM
 tdxnTqbZLoGAoy2ULDu0vcR4iDuCVE9ZfiPF/Uye13q3aZ8NNHaHmrLkAlgutAIx8L
 XlxjrD/DrXBWvTVJkv4r06VQ+tTt04p4sbSeCB02rPtcntE3Gd/rBwTo5qfBuNNv1B
 klYmGH1xbEWMe945+StNWJXEeYpse+FJdnndZJPIk12QH0wyNKeb9wljjFnexOH+MW
 k+hh2FVorUryQ==
Date: Thu, 21 Feb 2019 13:40:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/64s: Better printing of machine check info
 for guest MCEs
Message-ID: <20190221024020.j2efszvvewtcsebz@oak.ozlabs.ibm.com>
References: <20190221023849.7zra6dhii6fele6i@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221023849.7zra6dhii6fele6i@oak.ozlabs.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds an "in_guest" parameter to machine_check_print_event_info()
so that we can avoid trying to translate guest NIP values into
symbolic form using the host kernel's symbol table.

Reviewed-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
v2: add 'level' parameter to printk, as pointed out by Mahesh

 arch/powerpc/include/asm/mce.h        | 2 +-
 arch/powerpc/kernel/mce.c             | 8 +++++---
 arch/powerpc/kvm/book3s_hv.c          | 4 ++--
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index a8b8903e1844..17996bc9382b 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -209,7 +209,7 @@ extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
-					   bool user_mode);
+					   bool user_mode, bool in_guest);
 #ifdef CONFIG_PPC_BOOK3S_64
 void flush_and_reload_slb(void);
 #endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index bd933a75f0bc..d501b48f287e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -301,13 +301,13 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		evt = this_cpu_ptr(&mce_event_queue[index]);
-		machine_check_print_event_info(evt, false);
+		machine_check_print_event_info(evt, false, false);
 		__this_cpu_dec(mce_queue_count);
 	}
 }
 
 void machine_check_print_event_info(struct machine_check_event *evt,
-				    bool user_mode)
+				    bool user_mode, bool in_guest)
 {
 	const char *level, *sevstr, *subtype;
 	static const char *mc_ue_types[] = {
@@ -387,7 +387,9 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
 	       "Recovered" : "Not recovered");
 
-	if (user_mode) {
+	if (in_guest) {
+		printk("%s  Guest NIP: %016llx\n", level, evt->srr0);
+	} else if (user_mode) {
 		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
 			evt->srr0, current->pid, current->comm);
 	} else {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d8bf05a449fe..81cba4b5afbd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1216,7 +1216,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
 		/* Print the MCE event to host console. */
-		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
+		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
 
 		/*
 		 * If the guest can do FWNMI, exit to userspace so it can
@@ -1406,7 +1406,7 @@ static int kvmppc_handle_nested_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		/* Pass the machine check to the L1 guest */
 		r = RESUME_HOST;
 		/* Print the MCE event to host console. */
-		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
+		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
 		break;
 	/*
 	 * We get these next two if the guest accesses a page which it thinks
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 79586f127521..05c85be0370f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -587,7 +587,7 @@ int opal_machine_check(struct pt_regs *regs)
 		       evt.version);
 		return 0;
 	}
-	machine_check_print_event_info(&evt, user_mode(regs));
+	machine_check_print_event_info(&evt, user_mode(regs), false);
 
 	if (opal_recover_mce(regs, &evt))
 		return 1;
-- 
2.11.0


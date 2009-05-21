Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id EF61BDDDA9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 05:53:16 +1000 (EST)
Received: by ewy11 with SMTP id 11so1475261ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:53:14 -0700 (PDT)
Message-ID: <4A15B129.8070700@gmail.com>
Date: Thu, 21 May 2009 21:53:13 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: avi@redhat.com, paulmck@linux.vnet.ibm.com
Subject: [PATCH] KVM: powerpc: beyond ARRAY_SIZE of vcpu->arch.guest_tlb
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do not go beyond ARRAY_SIZE of vcpu->arch.guest_tlb

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 0fce4fb..c2cfd46 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -125,7 +125,7 @@ static int kvmppc_emul_tlbwe(struct kvm_vcpu *vcpu, u32 inst)
 	ws = get_ws(inst);
 
 	index = vcpu->arch.gpr[ra];
-	if (index > PPC44x_TLB_SIZE) {
+	if (index >= PPC44x_TLB_SIZE) {
 		printk("%s: index %d\n", __func__, index);
 		kvmppc_dump_vcpu(vcpu);
 		return EMULATE_FAIL;

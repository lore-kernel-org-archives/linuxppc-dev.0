Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58007B71D0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 32/35] KVM: PPC: Document KVM_INTERRUPT ioctl
Date: Tue, 31 Aug 2010 04:32:13 +0200
Message-Id: <1283221937-21006-33-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds some documentation for the KVM_INTERRUPT special cases that
PowerPC now implements.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 Documentation/kvm/api.txt |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/kvm/api.txt b/Documentation/kvm/api.txt
index 44d9893..24d6341 100644
--- a/Documentation/kvm/api.txt
+++ b/Documentation/kvm/api.txt
@@ -320,13 +320,13 @@ struct kvm_translation {
 4.15 KVM_INTERRUPT
 
 Capability: basic
-Architectures: x86
+Architectures: x86, ppc
 Type: vcpu ioctl
 Parameters: struct kvm_interrupt (in)
 Returns: 0 on success, -1 on error
 
 Queues a hardware interrupt vector to be injected.  This is only
-useful if in-kernel local APIC is not used.
+useful if in-kernel local APIC or equivalent is not used.
 
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
@@ -334,8 +334,37 @@ struct kvm_interrupt {
 	__u32 irq;
 };
 
+X86:
+
 Note 'irq' is an interrupt vector, not an interrupt pin or line.
 
+PPC:
+
+Queues an external interrupt to be injected. This ioctl is overleaded
+with 3 different irq values:
+
+a) KVM_INTERRUPT_SET
+
+  This injects an edge type external interrupt into the guest once it's ready
+  to receive interrupts. When injected, the interrupt is done.
+
+b) KVM_INTERRUPT_UNSET
+
+  This unsets any pending interrupt.
+
+  Only available with KVM_CAP_PPC_UNSET_IRQ.
+
+c) KVM_INTERRUPT_SET_LEVEL
+
+  This injects a level type external interrupt into the guest context. The
+  interrupt stays pending until a specific ioctl with KVM_INTERRUPT_UNSET
+  is triggered.
+
+  Only available with KVM_CAP_PPC_IRQ_LEVEL.
+
+Note that any value for 'irq' other than the ones stated above is invalid
+and incurs unexpected behavior.
+
 4.16 KVM_DEBUG_GUEST
 
 Capability: basic
-- 
1.6.0.2

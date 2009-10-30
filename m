Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9DE5B7C36
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:35 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 02/27] Pass PVR in sregs
Date: Fri, 30 Oct 2009 16:47:02 +0100
Message-Id: <1256917647-6200-3-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right now sregs is unused on PPC, so we can use it for initialization
of the CPU.

KVM on BookE always virtualizes the host CPU. On Book3s we go a step further
and take the PVR from userspace that tells us what kind of CPU we are supposed
to virtualize, because we support Book3s_32 and Book3s_64 guests.

In order to get that information, we use the sregs ioctl, because we don't
want to reset the guest CPU on every normal register set.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v4 -> v5

  - make PVR 32 bits
---
 arch/powerpc/include/asm/kvm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index bb2de6a..c9ca97f 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -46,6 +46,8 @@ struct kvm_regs {
 };
 
 struct kvm_sregs {
+	__u32 pvr;
+	char pad[1020];
 };
 
 struct kvm_fpu {
-- 
1.6.0.2

Return-Path: <segooon@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 36BD6B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 20:04:32 +1100 (EST)
Received: by ewy22 with SMTP id 22so2162266ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 02:04:29 -0700 (PDT)
From: Vasiliy Kulikov <segooon@gmail.com>
To: kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc: kvm: fix information leak to userland
Date: Sat, 30 Oct 2010 13:04:24 +0400
Message-Id: <1288429464-21763-1-git-send-email-segooon@gmail.com>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Structure kvm_ppc_pvinfo is copied to userland with flags and
pad fields unitialized.  It leads to leaking of contents of
kernel stack memory.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver, so it is not tested at all.

 arch/powerpc/kvm/powerpc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2f87a16..38f756f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -617,6 +617,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_PPC_GET_PVINFO: {
 		struct kvm_ppc_pvinfo pvinfo;
+		memset(&pvinfo, 0, sizeof(pvinfo));
 		r = kvm_vm_ioctl_get_pvinfo(&pvinfo);
 		if (copy_to_user(argp, &pvinfo, sizeof(pvinfo))) {
 			r = -EFAULT;
-- 
1.7.0.4

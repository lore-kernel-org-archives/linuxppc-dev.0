Return-Path: <segooon@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id 3F894B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 05:55:28 +1100 (EST)
Received: by eyg24 with SMTP id 24so2470057eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 11:55:26 -0700 (PDT)
From: Vasiliy Kulikov <segooon@gmail.com>
To: kernel-janitors@vger.kernel.org
Subject: [PATCH v2] powerpc: kvm: powerpc: fix information leak to userland
Date: Sat, 30 Oct 2010 22:55:22 +0400
Message-Id: <1288464922-8812-1-git-send-email-segooon@gmail.com>
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

Structure kvm_ppc_pvinfo is copied to userland with "flags" and "pad"
fields unitialized.  It leads to leaking of contents of kernel stack
memory.  We have to initialize them to zero.

In patch v1 Jan Kiszka suggested to fill reserved fields with zeros
instead of memset'ting the whole struct.  It makes sense as these
fields are explicitly marked as padding.  No more fields need zeroing.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2f87a16..5962336 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -604,6 +604,8 @@ static int kvm_vm_ioctl_get_pvinfo(struct kvm_ppc_pvinfo *pvinfo)
 	pvinfo->hcall[1] = inst_ori | (KVM_SC_MAGIC_R0 & inst_imm_mask);
 	pvinfo->hcall[2] = inst_sc;
 	pvinfo->hcall[3] = inst_nop;
+	pvinfo->flags = 0;
+	memset(&pvinfo->pad, 0, sizeof(pvinfo->pad));
 
 	return 0;
 }
-- 
1.7.0.4

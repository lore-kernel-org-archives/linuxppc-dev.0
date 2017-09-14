Return-Path: <groug@kaod.org>
Received: from 5.mo2.mail-out.ovh.net (5.mo2.mail-out.ovh.net [87.98.181.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtbmD2GWmzDrSZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 10:26:02 +1000 (AEST)
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id C4776AAED9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 23:56:34 +0200 (CEST)
Subject: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
From: Greg Kurz <groug@kaod.org>
To: kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Date: Thu, 14 Sep 2017 23:56:25 +0200
Message-ID: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following program causes a kernel oops:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kvm.h>

main()
{
    int fd = open("/dev/kvm", O_RDWR);
    ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
}

This happens because when using the global KVM fd with
KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
called with a NULL kvm argument, which gets dereferenced
in is_kvmppc_hv_enabled(). Spotted while reading the code.

Let's use the hv_enabled fallback variable, like everywhere
else in this function.

Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 arch/powerpc/kvm/powerpc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..ee279c7f4802 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -644,8 +644,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_PPC_HTM:
-		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
-		    is_kvmppc_hv_enabled(kvm);
+		r = cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
 		break;
 	default:
 		r = 0;

Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztwh25TvkzF1kN
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 06:09:03 +1100 (AEDT)
Subject: Re: Build regressions/improvements in v4.16-rc3
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Olof Johansson <olof@lixom.net>
References: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
 <51783a88-f15e-f604-8439-1711282e4462@xenosoft.de>
Message-ID: <af2981b4-99ca-ec15-d81e-d99623d069a3@xenosoft.de>
Date: Sat, 3 Mar 2018 20:08:53 +0100
MIME-Version: 1.0
In-Reply-To: <51783a88-f15e-f604-8439-1711282e4462@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Could you please add the following patches?

---

Fixes: accb757d798c ("KVM: Move vcpu_load to arch-specific 
kvm_arch_vcpu_ioctl_run")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
arch/powerpc/kvm/powerpc.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642c78f5..0083142c2f84 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1608,7 +1608,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, 
struct kvm_run *run)

kvm_sigset_deactivate(vcpu);

+#ifdef CONFIG_ALTIVEC
out:
+#endif
vcpu_put(vcpu);
return r;
}

---

Olof's patch for P.A. Semi boards:

---

arch/powerpc/platforms/pasemi/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
          return;
      }

+    pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
      for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
          if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
              of_node_get(np);

---

Thanks,
Christian

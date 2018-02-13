Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgsRN3WzjzF1Q5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:04:46 +1100 (AEDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: [PATCH 1/2] KVM: PPC: Fix compile error that occurs when
 CONFIG_ALTIVEC=n
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20180213045130.r35rdy24uokzixho@oak.ozlabs.ibm.com>
Date: Tue, 13 Feb 2018 20:04:39 +0100
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <D5D01768-C887-4DD2-8FD6-2B188B6A0315@xenosoft.de>
References: <20180213045130.r35rdy24uokzixho@oak.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I successfully compiled the latest Git kernel with this patch without enable=
d AltiVec for my Freescale P5020 board today. The patch works without any pr=
oblems.

=E2=80=94 Christian

Sent from my iPhone

On 13. Feb 2018, at 05:51, Paul Mackerras <paulus@ozlabs.org> wrote:

Commit accb757d798c ("KVM: Move vcpu_load to arch-specific
kvm_arch_vcpu_ioctl_run", 2017-12-04) added a "goto out"
statement and an "out:" label to kvm_arch_vcpu_ioctl_run().
Since the only "goto out" is inside a CONFIG_VSX block,
compiling with CONFIG_VSX=3Dn gives a warning that label "out"
is defined but not used, and because arch/powerpc is compiled
with -Werror, that becomes a compile error that makes the kernel
build fail.

Merge commit 1ab03c072feb ("Merge tag 'kvm-ppc-next-4.16-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc",
2018-02-09) added a similar block of code inside a #ifdef
CONFIG_ALTIVEC, with a "goto out" statement.

In order to make the build succeed, this adds a #ifdef around the
"out:" label.  This is a minimal, ugly fix, to be replaced later
by a refactoring of the code.  Since CONFIG_VSX depends on
CONFIG_ALTIVEC, it is sufficient to use #ifdef CONFIG_ALTIVEC here.

Fixes: accb757d798c ("KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioc=
tl_run")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
arch/powerpc/kvm/powerpc.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642c78f5..0083142c2f84 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1608,7 +1608,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, str=
uct kvm_run *run)

   kvm_sigset_deactivate(vcpu);

+#ifdef CONFIG_ALTIVEC
out:
+#endif
   vcpu_put(vcpu);
   return r;
}
--=20
2.11.0

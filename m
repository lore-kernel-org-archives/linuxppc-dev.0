Return-Path: <pbrobinson@gmail.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFA61A0396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 03:28:30 +1100 (AEDT)
Received: by mail-wm0-x22b.google.com with SMTP id 128so203627413wmz.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2016 08:28:30 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Feb 2016 16:28:27 +0000
Message-ID: <CALeDE9Pc6z5Ed=92u47VPpQ9V-bKsUg95vy1pDSQ805U0R=z-g@mail.gmail.com>
Subject: build regression from c153693: Simplify module TOC handling
From: Peter Robinson <pbrobinson@gmail.com>
To: amodra@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 kernel@lists.fedoraproject.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alan,

Your patch for "powerpc: Simplify module TOC handling" is causing the
Fedora ppc64le to fail to build with depmod failures. Reverting the
commit fixes it for us on rawhide.

We're getting the out put below, full logs at [1]. Let me know if you
have any other queries.

Regards,
Peter

[1] http://ppc.koji.fedoraproject.org/kojifiles/work/tasks/5115/3125115/build.log

+ depmod -b . -aeF ./System.map 4.5.0-0.rc2.git0.1.fc24.ppc64le
Depmod failure
+ '[' -s depmod.out ']'
+ echo 'Depmod failure'
+ cat depmod.out
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/powernv/opal-prd.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/pseries/pseries_energy.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/pseries/hvcserver.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm-pr.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm-hv.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/rcu/rcutorture.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/trace/ring_buffer_benchmark.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/torture.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/fs/nfs_common/nfs_acl.ko
needs unknown symbol .TOC.
depmod: WARNING:
/builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/fs/nfs_common/grace.ko
needs unknown symbol .TOC.

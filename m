Return-Path: <dinarv@gmail.com>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 988B91A038E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 08:03:10 +1100 (AEDT)
Received: by mail-lf0-x232.google.com with SMTP id j78so123441667lfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2016 13:03:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALeDE9Pc6z5Ed=92u47VPpQ9V-bKsUg95vy1pDSQ805U0R=z-g@mail.gmail.com>
References: <CALeDE9Pc6z5Ed=92u47VPpQ9V-bKsUg95vy1pDSQ805U0R=z-g@mail.gmail.com>
From: Dinar Valeev <dinarv@gmail.com>
Date: Tue, 9 Feb 2016 22:02:45 +0100
Message-ID: <CADqALGTumTqorBs2sok54EHLA7PeHREKjQjudZBGPfhx3Suh6A@mail.gmail.com>
Subject: Re: build regression from c153693: Simplify module TOC handling
To: Peter Robinson <pbrobinson@gmail.com>
Cc: amodra@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, kernel@lists.fedoraproject.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 9, 2016 at 5:28 PM, Peter Robinson <pbrobinson@gmail.com> wrote:
> Hi Alan,
>
> Your patch for "powerpc: Simplify module TOC handling" is causing the
> Fedora ppc64le to fail to build with depmod failures. Reverting the
> commit fixes it for us on rawhide.
Anton's patch [1] fixes it.

[1] https://build.opensuse.org/package/view_file/Base:System/kmod/depmod-Ignore_PowerPC64_ABIv2_.TOC.symbol.patch
>
> We're getting the out put below, full logs at [1]. Let me know if you
> have any other queries.
>
> Regards,
> Peter
>
> [1] http://ppc.koji.fedoraproject.org/kojifiles/work/tasks/5115/3125115/build.log
>
> + depmod -b . -aeF ./System.map 4.5.0-0.rc2.git0.1.fc24.ppc64le
> Depmod failure
> + '[' -s depmod.out ']'
> + echo 'Depmod failure'
> + cat depmod.out
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/powernv/opal-prd.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/pseries/pseries_energy.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/platforms/pseries/hvcserver.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm-pr.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/arch/powerpc/kvm/kvm-hv.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/rcu/rcutorture.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/trace/ring_buffer_benchmark.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/kernel/torture.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/fs/nfs_common/nfs_acl.ko
> needs unknown symbol .TOC.
> depmod: WARNING:
> /builddir/build/BUILDROOT/kernel-4.5.0-0.rc2.git0.1.fc24.ppc64le/./lib/modules/4.5.0-0.rc2.git0.1.fc24.ppc64le/kernel/fs/nfs_common/grace.ko
> needs unknown symbol .TOC.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

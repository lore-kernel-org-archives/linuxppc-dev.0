Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FBECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:31:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F1F20831
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F1F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hTyz41GhzF3Jd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 03:31:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hTwR1CdMzF3H0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 03:29:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42hTwF5vLzz9ttRl;
 Fri, 26 Oct 2018 18:29:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HwGcJyKzKPCa; Fri, 26 Oct 2018 18:29:17 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42hTwF5Kd3z9ttRx;
 Fri, 26 Oct 2018 18:29:17 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id DDD6E75B; Fri, 26 Oct 2018 18:29:16 +0200 (CEST)
Received: from 37.165.153.35 ([37.165.153.35]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 26 Oct 2018 18:29:16 +0200
Date: Fri, 26 Oct 2018 18:29:16 +0200
Message-ID: <20181026182916.Horde.8LHYJj4tB_PV5JLEA5Czjw1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 0/5] Guarded Userspace Access Prevention on Radix
In-Reply-To: <20181026063513.30806-1-ruscur@russell.cc>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> a =C3=A9crit=C2=A0:

> Guarded Userspace Access Prevention is a security mechanism that prevents
> the kernel from being able to read and write userspace addresses outside =
of
> the allowed paths, most commonly copy_{to/from}_user().
>
> At present, the only CPU that supports this is POWER9, and only while usi=
ng
> the Radix MMU.  Privileged reads and writes cannot access user data when
> key 0 of the AMR is set.  This is described in the "Radix Tree Translatio=
n
> Storage Protection" section of the POWER ISA as of version 3.0.

It is not right that only power9 can support that.

The 8xx has mmu access protection registers which can serve the same=20=20
purpose.=20Today on the 8xx kernel space is group 0 and user space is=20=20
group=201. Group 0 is set to "page defined access permission" in MD_AP=20=
=20
and=20MI_AP registers, and group 1 is set to "all accesses done with=20=20
supervisor=20rights". By setting group 1 to "user and supervisor=20=20
interpretation=20swapped" we can forbid kernel access to user space=20=20
while=20still allowing user access to it. Then by simply changing group=20=
=20
1=20mode at dedicated places we can lock/unlock kernel access to user=20=20
space.

Could=20you implement something as generic as possible having that in=20=20
mind=20for a future patch ?

Christophe

>
> GUAP code sets key 0 of the AMR (thus disabling accesses of user data)
> early during boot, and only ever "unlocks" access prior to certain
> operations, like copy_{to/from}_user(), futex ops, etc.  Setting this doe=
s
> not prevent unprivileged access, so userspace can operate fine while acce=
ss
> is locked.
>
> There is a performance impact, although I don't consider it heavy.  Runni=
ng
> a worst-case benchmark of a 1GB copy 1 byte at a time (and thus constant
> read(1) write(1) syscalls), I found enabling GUAP to be 3.5% slower than
> when disabled.  In most cases, the difference is negligible.  The main
> performance impact is the mtspr instruction, which is quite slow.
>
> There are a few caveats with this series that could be improved upon in
> future.  Right now there is no saving and restoring of the AMR value -
> there is no userspace exploitation of the AMR on Radix in POWER9, but if
> this were to change in future, saving and restoring the value would be
> necessary.
>
> No attempt to optimise cases of repeated calls - for example, if some
> code was repeatedly calling copy_to_user() for small sizes very frequentl=
y,
> it would be slower than the equivalent of wrapping that code in an unlock
> and lock and only having to modify the AMR once.
>
> There are some interesting cases that I've attempted to handle, such as i=
f
> the AMR is unlocked (i.e. because a copy_{to_from}_user is in progress)..=
.
>
>     - and an exception is taken, the kernel would then be running with th=
e
>     AMR unlocked and freely able to access userspace again.  I am working
>     around this by storing a flag in the PACA to indicate if the AMR is
>     unlocked (to save a costly SPR read), and if so, locking the AMR in
>     the exception entry path and unlocking it on the way out.
>
>     - and gets context switched out, goes into a path that locks the AMR,
>     then context switches back, access will be disabled and will fault.
>     As a result, I context switch the AMR between tasks as if it was used
>     by userspace like hash (which already implements this).
>
> Another consideration is use of the isync instruction.  Without an isync
> following the mtspr instruction, there is no guarantee that the change
> takes effect.  The issue is that isync is very slow, and so I tried to
> avoid them wherever necessary.  In this series, the only place an isync
> gets used is after *unlocking* the AMR, because if an access takes place
> and access is still prevented, the kernel will fault.
>
> On the flipside, a slight delay in unlocking caused by skipping an isync
> potentially allows a small window of vulnerability.  It is my opinion
> that this window is practically impossible to exploit, but if someone
> thinks otherwise, please do share.
>
> This series is my first attempt at POWER assembly so all feedback is very
> welcome.
>
> The official theme song of this series can be found here:
>     https://www.youtube.com/watch?v=3DQjTrnKAcYjE
>
> Russell Currey (5):
>   powerpc/64s: Guarded Userspace Access Prevention
>   powerpc/futex: GUAP support for futex ops
>   powerpc/lib: checksum GUAP support
>   powerpc/64s: Disable GUAP with nosmap option
>   powerpc/64s: Document that PPC supports nosmap
>
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  arch/powerpc/include/asm/exception-64e.h      |  3 +
>  arch/powerpc/include/asm/exception-64s.h      | 19 ++++++-
>  arch/powerpc/include/asm/futex.h              |  6 ++
>  arch/powerpc/include/asm/mmu.h                |  7 +++
>  arch/powerpc/include/asm/paca.h               |  3 +
>  arch/powerpc/include/asm/reg.h                |  1 +
>  arch/powerpc/include/asm/uaccess.h            | 57 ++++++++++++++++---
>  arch/powerpc/kernel/asm-offsets.c             |  1 +
>  arch/powerpc/kernel/dt_cpu_ftrs.c             |  4 ++
>  arch/powerpc/kernel/entry_64.S                | 17 +++++-
>  arch/powerpc/lib/checksum_wrappers.c          |  6 +-
>  arch/powerpc/mm/fault.c                       |  9 +++
>  arch/powerpc/mm/init_64.c                     | 15 +++++
>  arch/powerpc/mm/pgtable-radix.c               |  2 +
>  arch/powerpc/mm/pkeys.c                       |  7 ++-
>  arch/powerpc/platforms/Kconfig.cputype        | 15 +++++
>  17 files changed, 158 insertions(+), 16 deletions(-)
>
> --
> 2.19.1



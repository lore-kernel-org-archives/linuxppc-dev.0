Return-Path: <B32721@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E9542C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 02:26:08 +1000 (EST)
Received: from mail126-db9 (localhost [127.0.0.1])	by
 mail126-db9-R.bigfish.com (Postfix) with ESMTP id 4E8AC4E0046	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 16:25:59 +0000 (UTC)
Received: from DB9EHSMHS001.bigfish.com (unknown [10.174.16.229])	by
 mail126-db9.bigfish.com (Postfix) with ESMTP id F31E4220046	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 16:25:56 +0000 (UTC)
From: Udma Catalin-Dan-B32721 <B32721@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] Update compilation flags with core specific options
Date: Wed, 24 Jul 2013 16:25:52 +0000
Message-ID: <FE751157F0442848A159F3AB4CB1F55B3F83F1@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1372764004-18896-1-git-send-email-catalin.udma@freescale.com>
 (from catalin.udma@freescale.com on Tue Jul  2 06:20:04 2013)
 <1374624677.15592.48@snotra>
In-Reply-To: <1374624677.15592.48@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This breaks the vdso for e500v1/v2 (userspace dies with SIGILL), since
> KBUILD_CFLAGS doesn't get used when building asm files, and the vdso
> uses mftbu/mftbl which are not being assembled to the form that
> e500v1/v2 support.
>=20
> We should be setting -mcpu=3Dwhatever and -msoft-float in both CFLAGS and
> AFLAGS, since we don't call "as" directly, and target selection should
> not differ based on whether we're building a C file or an asm file.
>=20
> -Scott
[CU] Thank you, Scott. I'll update also AFLAGS.

I have some questions about how you reproduce the SIGILL issue.
I tried to reproduce the issue looking to gettimeofday.S, that uses
mftbu/mftbl. In my tests, I obtained the same output when compiling this fi=
le
for p1021rdb before and after this patch, and also after adding -mcpu to
AFLAGS: "objdump -d arch/powerpc/kernel/vdso32/gettimeofday.o" looks the sa=
me
for the cases mentioned above:
   "mftbu r3" from .S file is decoded to "mfspr   r3,269" in "objdump -d" o=
utput

Indeed, for -mcpu=3D601/power3, the "objdump -d" output is "mftbu r3" and a=
ccording to
powerISA this instruction would cause Illegal Instruction error handler to =
be invoked
and permits the sw to emulate the instruction.

Regards,
Catalin

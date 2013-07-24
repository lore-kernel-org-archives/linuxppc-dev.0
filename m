Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 233DB2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 03:45:50 +1000 (EST)
Received: from mail88-db8 (localhost [127.0.0.1])	by mail88-db8-R.bigfish.com
 (Postfix) with ESMTP id 4AE5E38014D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 24 Jul 2013 17:45:44 +0000 (UTC)
Received: from DB8EHSMHS015.bigfish.com (unknown [10.174.8.234])	by
 mail88-db8.bigfish.com (Postfix) with ESMTP id A173DBC0046	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 17:45:42 +0000 (UTC)
Date: Wed, 24 Jul 2013 12:45:36 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Update compilation flags with core specific options
To: Udma Catalin-Dan-B32721 <B32721@freescale.com>
In-Reply-To: <FE751157F0442848A159F3AB4CB1F55B3F83F1@039-SN1MPN1-001.039d.mgd.msft.net>
 (from B32721@freescale.com on Wed Jul 24 11:25:52 2013)
Message-ID: <1374687936.15592.55@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2013 11:25:52 AM, Udma Catalin-Dan-B32721 wrote:
> > This breaks the vdso for e500v1/v2 (userspace dies with SIGILL), =20
> since
> > KBUILD_CFLAGS doesn't get used when building asm files, and the vdso
> > uses mftbu/mftbl which are not being assembled to the form that
> > e500v1/v2 support.
> >
> > We should be setting -mcpu=3Dwhatever and -msoft-float in both CFLAGS =20
> and
> > AFLAGS, since we don't call "as" directly, and target selection =20
> should
> > not differ based on whether we're building a C file or an asm file.
> >
> > -Scott
> [CU] Thank you, Scott. I'll update also AFLAGS.
>=20
> I have some questions about how you reproduce the SIGILL issue.
> I tried to reproduce the issue looking to gettimeofday.S, that uses
> mftbu/mftbl. In my tests, I obtained the same output when compiling =20
> this file
> for p1021rdb before and after this patch, and also after adding -mcpu =20
> to
> AFLAGS: "objdump -d arch/powerpc/kernel/vdso32/gettimeofday.o" looks =20
> the same
> for the cases mentioned above:
>    "mftbu r3" from .S file is decoded to "mfspr   r3,269" in "objdump =20
> -d" output
>=20
> Indeed, for -mcpu=3D601/power3, the "objdump -d" output is "mftbu r3" =20
> and according to
> powerISA this instruction would cause Illegal Instruction error =20
> handler to be invoked
> and permits the sw to emulate the instruction.

It probably depends on what the default is for your toolchain.

-Scott=

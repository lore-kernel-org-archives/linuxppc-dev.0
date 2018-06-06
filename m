Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410zTf4zPgzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 16:36:22 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w566XwJB036724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2018 02:36:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2je3bqed0u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2018 02:36:19 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 Jun 2018 07:36:14 +0100
Date: Wed, 06 Jun 2018 12:06:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/5] powerpc/64: memcmp() optimization
To: Michael Ellerman <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
 <877eneasg9.fsf@concordia.ellerman.id.au>
 <20180606062153.GA7342@simonLocalRHEL7.x64>
In-Reply-To: <20180606062153.GA7342@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1528266847.dixm3thyfj.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simon Guo wrote:
> Hi Michael,
> On Tue, Jun 05, 2018 at 12:16:22PM +1000, Michael Ellerman wrote:
>> Hi Simon,
>>=20
>> wei.guo.simon@gmail.com writes:
>> > From: Simon Guo <wei.guo.simon@gmail.com>
>> >
>> > There is some room to optimize memcmp() in powerpc 64 bits version for
>> > following 2 cases:
>> > (1) Even src/dst addresses are not aligned with 8 bytes at the beginni=
ng,
>> > memcmp() can align them and go with .Llong comparision mode without
>> > fallback to .Lshort comparision mode do compare buffer byte by byte.
>> > (2) VMX instructions can be used to speed up for large size comparisio=
n,
>> > currently the threshold is set for 4K bytes. Notes the VMX instruction=
s
>> > will lead to VMX regs save/load penalty. This patch set includes a
>> > patch to add a 32 bytes pre-checking to minimize the penalty.
>> >
>> > It did the similar with glibc commit dec4a7105e (powerpc: Improve memc=
mp=20
>> > performance for POWER8). Thanks Cyril Bur's information.
>> > This patch set also updates memcmp selftest case to make it compiled a=
nd
>> > incorporate large size comparison case.
>>=20
>> I'm seeing a few crashes with this applied, I haven't had time to look
>> into what is happening yet, sorry.
>>=20
>=20
> The bug is due to memcmp() invokes a C function enter_vmx_ops() who will =
load=20
> some PIC value based on r2.
>=20
> memcmp() doesn't use r2 and if the memcmp() is invoked from kernel
> itself, everything is fine. But if memcmp() is invoked from modules[test_=
user_copy],=20
> r2 will be required to be setup correctly. Otherwise the enter_vmx_ops() =
will refer=20
> to an incorrect/unexisting data location based on wrong r2 value.
>=20
> Following patch will fix this issue:
> ------------
> diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> index 5eba49744a5a..24d093fa89bb 100644
> --- a/arch/powerpc/lib/memcmp_64.S
> +++ b/arch/powerpc/lib/memcmp_64.S
> @@ -102,7 +102,7 @@
>   * 2) src/dst has different offset to the 8 bytes boundary. The handlers
>   * are named like .Ldiffoffset_xxxx
>   */
> -_GLOBAL(memcmp)
> +_GLOBAL_TOC(memcmp)
>         cmpdi   cr1,r5,0
>=20
>         /* Use the short loop if the src/dst addresses are not
> ----------
>=20
> It means the memcmp() fun entry will have additional 2 instructions. Is t=
here
> any way to save these 2 instructions when the memcmp() is actually invoke=
d
> from kernel itself?

That will be the case. We will end up entering the function via the=20
local entry point skipping the first two instructions. The Global entry=20
point is only used for cross-module calls.

- Naveen

=

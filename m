Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybkJt4cX0zDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 21:29:34 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAEATRR3015253
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 05:29:31 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e7upu1hj4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 05:29:30 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 10:29:27 -0000
Date: Tue, 14 Nov 2017 15:59:21 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/3] powerpc/modules: Don't try to restore r2 after a
 sibling call
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
In-Reply-To: <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
>=20
> When attempting to load a livepatch module, I got the following error:
>=20
>   module_64: patch_module: Expect noop after relocate, got 3c820000
>=20
> The error was triggered by the following code in
> unregister_netdevice_queue():
>=20
>   14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
>                          14c: R_PPC64_REL24      net_set_todo
>   150:   00 00 82 3c     addis   r4,r2,0
>=20
> GCC didn't insert a nop after the branch to net_set_todo() because it's
> a sibling call, so it never returns.  The nop isn't needed after the
> branch in that case.
>=20
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/module_64.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index 39b01fd..9e5391f 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -489,6 +489,10 @@ static int restore_r2(u32 *instruction, struct modul=
e *me)
>  	if (is_early_mcount_callsite(instruction - 1))
>  		return 1;
>=20
> +	/* Sibling calls don't return, so they don't need to restore r2 */
> +	if (instruction[-1] =3D=3D PPC_INST_BRANCH)
> +		return 1;
> +

This looks quite fragile, unless we know for sure that gcc will _always_
emit this instruction form for sibling calls with relocations.

As an alternative, does it make sense to do the following check instead?
	if ((instr_is_branch_iform(insn) || instr_is_branch_bform(insn))
		&& !(insn & 0x1))


- Naveen

=

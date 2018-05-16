Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m5Bj6xzQzF1gK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 17:08:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4G73tLr142034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 03:08:43 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j0fukgknr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 03:08:42 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 16 May 2018 08:08:41 +0100
Date: Wed, 16 May 2018 12:38:35 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC] powerpc/emulate_step: Fix kernel crash when VSX is not
 present
To: mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Cc: anton@samba.org, cyrilbur@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, matthew.brown.dev@gmail.com,
 paulus@samba.org, sandipan@linux.vnet.ibm.com
References: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1526454049.ztv236j5bs.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Adding Mikey]

Ravi Bangoria wrote:
> emulate_step() is not checking runtime VSX feature flag before
> emulating an instruction. This can cause kernel oops when kernel
> is compiled with CONFIG_VSX=3Dy but running on machine where VSX is
> not supported or disabled. Ex, while running emulate_step tests on
> P6 machine:
>=20
>   ...
>   emulate_step_test: lvx            : PASS
>   emulate_step_test: stvx           : PASS
>   Oops: Exception in kernel mode, sig: 4 [#1]
>   NIP [c000000000095c24] .load_vsrn+0x28/0x54
>   LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
>   Call Trace:
>   [c0000000494c3770] [40fe240c7ae147ae] 0x40fe240c7ae147ae (unreliable)
>   [c0000000494c37f0] [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
>   [c0000000494c3900] [c000000000094f6c] .emulate_step+0x25c/0x5bc
>   [c0000000494c39b0] [c000000000ec90dc] .test_lxvd2x_stxvd2x+0x64/0x154
>   [c0000000494c3b90] [c000000000ec9204] .test_emulate_step+0x38/0x4c
>   [c0000000494c3c00] [c00000000000de2c] .do_one_initcall+0x5c/0x2c0
>   [c0000000494c3cd0] [c000000000eb4bf8] .kernel_init_freeable+0x314/0x4cc
>   [c0000000494c3db0] [c00000000000e1e4] .kernel_init+0x24/0x160
>   [c0000000494c3e30] [c00000000000bc24] .ret_from_kernel_thread+0x58/0xb4
>=20
> With fix:
>   ...
>   emulate_step_test: stvx           : PASS
>   emulate_step_test: lxvd2x         : FAIL
>   emulate_step_test: stxvd2x        : FAIL

Those tests should also be updated to skip testing these instructions if=20
!CPU_FTR_VSX.

>=20
> Fixes: https://github.com/linuxppc/linux/issues/148
>=20
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
> Note: VSX was first introduced on P6. But there are many VSX instructions
>       which were introduced in later versions. So ideally, analyse_instr(=
)
>       should check for ISA version along with opcode.

Yes, this patch should be useful for when VSX is not present. For=20
specific instructions, we should add a cpu feature check.

- Naveen

=

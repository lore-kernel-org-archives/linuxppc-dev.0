Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hwmH3pMSzF2Cn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 13:38:18 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4B3ZSA0121923
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:38:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hw036ea8r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:38:15 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Fri, 11 May 2018 04:38:14 +0100
Subject: Re: [PATCH] powerpc: Fix emulate_step() on POWER6
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180511013539.12239-1-mikey@neuling.org>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Fri, 11 May 2018 09:08:09 +0530
MIME-Version: 1.0
In-Reply-To: <20180511013539.12239-1-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <c0cb8d08-9999-bca7-2bfe-a020a44f2a40@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/11/2018 07:05 AM, Michael Neuling wrote:
> emulate_step() will fail on POWER6 currently with:
>
>   emulate_step_test: lfdx           : PASS
>   emulate_step_test: stfdx          : PASS
>   emulate_step_test: lvx            : PASS
>   emulate_step_test: stvx           : PASS
>   Oops: Exception in kernel mode, sig: 4 [#1]
>   BE SMP NR_CPUS=2048 NUMA pSeries
>   Modules linked in:
>   CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc4-gcc5x-g036db8b #1
>   NIP:  c000000000095c24 LR: c000000000094bdc CTR: c00000000008f4a0
>   REGS: c0000000494c34f0 TRAP: 0700   Not tainted  (4.17.0-rc4-gcc5x-g036db8b)
>   MSR:  8000000000089032 <SF,EE,ME,IR,DR,RI>  CR: 48004224  XER: 20000009
>   CFAR: c000000000094bd0 SOFTE: 0
>   GPR00: c000000000094bdc c0000000494c3770 c000000001238400 0000000000000027
>   GPR04: c0000000494c3870 0000000000000008 8000000000009032 8000000000809032
>   GPR08: 0000000000000070 800000000280b032 c0000000494c0000 0000000000000000
>   GPR12: 0000000044000428 c000000007fff300 c00000000000e1c0 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 bfffffffffffffff c0000000494c3870 0000000000000027
>   GPR24: c0000000494c3860 0000000000000000 c000000000da0538 c0000000494c3b90
>   GPR28: 0000000000000000 c0000000494c3970 c0000000494c3a20 0000000000000008
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
>
> The below fixes this by gating the VSX tests on CPU_FTR_VSX.

Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks,
Ravi

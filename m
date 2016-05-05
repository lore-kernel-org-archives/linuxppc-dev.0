Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0tpj2wBVzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 22:03:25 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r0tph3ghmz9t3s
 for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2016 22:03:24 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 5 May 2016 17:33:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4EABF125805B
 for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2016 17:35:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45C3HPU45744194
 for <linuxppc-dev@ozlabs.org>; Thu, 5 May 2016 17:33:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45C3ErU023345
 for <linuxppc-dev@ozlabs.org>; Thu, 5 May 2016 17:33:16 +0530
Date: Thu, 5 May 2016 17:32:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/9] FP/VEC/VSX switching optimisations
Message-ID: <20160505120139.GN7880@naverao1-tp.in.ibm.com>
References: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/29 05:53PM, Cyril Bur wrote:
> Cover-letter for V1 of the series is at
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-November/136350.html
> 
> Cover-letter for V2 of the series is at
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/138054.html
> 
> Changes in V3:
> Addressed review comments from Michael Neuling
>  - Made commit message in 4/9 better reflect the patch
>  - Removed overuse of #ifdef blocks and redundant condition in 5/9
>  - Split 6/8 in two to better prepare for 7,8,9
>  - Removed #ifdefs in 6/9
> 
> Changes in V4:
>  - Addressed non ABI compliant ASM macros in 1/9
>  - Fixed build breakage due to changing #ifdefs in V3 (6/9)
>  - Reordered some conditions in if statements
> 
> Changes in V5:
>  - Enhanced basic-asm.h to provide ABI independent macro as pointed out by
>    Naveen Rao.
>    - Tested for both BE and LE builds. Had to disable -flto from the
>      selftests/powerpc Makefile as it didn't play well with the custom ASM.
>  - Added some extra debugging output to the vmx_signal testcase
>  - Fixed comments in testing code
>  - Updated VSX test code to use GCC Altivec macros
> 
> Changes in V6:
>  - Removed recursive definition of CFLAGS in math/Makefile
>  - Corrected the use of the word param in favour of doubleword
>  - Reordered some code in basic-asm.h and neatened some comments

This series is resulting in a kernel crash with one of the perf tests.  
To reproduce, build perf and run the test for breakpoint overflow signal 
handler.

# ./perf test -v 17
17: Test breakpoint overflow signal handler                  :
--- start ---
test child forked, pid 3753
failed opening event 0
failed opening event 0
cpu 0xd: Vector: 600 (Alignment) at [c0000000edd738c0]
    pc: c00000000000a818: save_fpu+0xa8/0x2ac
    lr: c00000000001568c: __giveup_fpu+0x2c/0x90
    sp: c0000000edd73b40
   msr: 800000000280b033
   dar: c0000000edc436e0
 dsisr: 42000000
  current = 0xc0000000edc42c00
  paca    = 0xc000000007e82700	 softe: 0	 irq_happened: 0x01
    pid   = 3753, comm = perf
Linux version 4.6.0-rc3-nnr+ (root@rhel71le) (gcc version 4.8.3 20140911 (Red Hat 4.8.3-8) (GCC) ) #93 SMP Wed May 4 22:01:06 IST 2016
enter ? for help
[link register   ] c00000000001568c __giveup_fpu+0x2c/0x90
[c0000000edd73b40] 0000000000000000 (unreliable)
[c0000000edd73b70] c000000000015730 giveup_fpu+0x40/0xa0
[c0000000edd73ba0] c000000000015810 flush_fp_to_thread+0x80/0x90
[c0000000edd73bd0] c000000000026b3c setup_sigcontext.constprop.3+0xbc/0x1f0
[c0000000edd73c30] c0000000000274c4 handle_rt_signal64+0x3b4/0x7c0
[c0000000edd73d10] c000000000017ee0 do_signal+0x150/0x2b0
[c0000000edd73e00] c000000000018220 do_notify_resume+0xd0/0x110
[c0000000edd73e30] c000000000009844 ret_from_except_lite+0x70/0x74
--- Exception: 900 (Decrementer) at 00000000100b3c88
SP (3fffd08cfb20) is in userspace
d:mon> ls save_fpu
save_fpu: c00000000000a770

With v4.5, the test would fail, but not cause what looks to be an 
alignment exception.


- Naveen

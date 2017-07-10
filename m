Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5VYJ6NvNzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:09:08 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A38WPx011553
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Jul 2017 23:09:06 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjvs2a9ca-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 23:09:06 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 13:09:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A390ZR18808964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:09:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A38p9L006604
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:08:52 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 33/38] powerpc: Deliver SEGV signal on pkey violation
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Date: Mon, 10 Jul 2017 08:38:53 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4cbcc16c-7597-7aa1-ddea-b6bef25df11b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2017 02:52 AM, Ram Pai wrote:
> The value of the AMR register at the time of exception
> is made available in gp_regs[PT_AMR] of the siginfo.
> 
> The value of the pkey, whose protection got violated,
> is made available in si_pkey field of the siginfo structure.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/ptrace.h |    3 ++-
>  arch/powerpc/kernel/signal_32.c        |    5 +++++
>  arch/powerpc/kernel/signal_64.c        |    4 ++++
>  arch/powerpc/kernel/traps.c            |   14 ++++++++++++++
>  4 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 8036b38..7ec2428 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -108,8 +108,9 @@ struct pt_regs {
>  #define PT_DAR	41
>  #define PT_DSISR 42
>  #define PT_RESULT 43
> -#define PT_DSCR 44
>  #define PT_REGS_COUNT 44
> +#define PT_DSCR 44
> +#define PT_AMR	45

Why PT_DSCR was moved down ? This change is redundant here.

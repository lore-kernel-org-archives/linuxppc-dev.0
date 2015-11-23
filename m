Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 009561A029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 17:23:18 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 11:53:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 96E123940049
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:53:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAN6NA3s3146122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:53:11 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAN6NA74032165
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:53:10 +0530
Message-ID: <5652B0CE.40704@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 11:53:10 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2015 11:34 AM, Rashmica Gupta wrote:
> Most architectures use NR_syscalls as the #define for the number of syscalls.
> 
> We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
> 
> __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
> NR_syscalls must be defined and __NR_syscalls does not, replace __NR_syscalls
> with NR_syscalls.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
>  arch/powerpc/include/asm/unistd.h        | 3 +--
>  arch/powerpc/include/asm/vdso_datapage.h | 2 +-
>  arch/powerpc/kernel/systbl_chk.c         | 2 +-
>  arch/powerpc/kernel/systbl_chk.sh        | 2 +-
>  arch/powerpc/kernel/vdso.c               | 2 +-
>  arch/powerpc/kernel/vdso32/datapage.S    | 2 +-
>  arch/powerpc/kernel/vdso64/datapage.S    | 2 +-
>  arch/powerpc/platforms/cell/spufs/run.c  | 2 +-
>  8 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
> index 6d8f8023ac27..05bf34296144 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -12,10 +12,9 @@
>  #include <uapi/asm/unistd.h>
>  
>  
> -#define __NR_syscalls		378
> +#define NR_syscalls		378

This does not apply any more because of Michael's recent mlock2() system
call enablement commit. Please do rebase and resend.

- Anshuman

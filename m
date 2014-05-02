Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEC6514011B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 15:39:25 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 2 May 2014 11:09:22 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9A4A03940048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 11:09:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s425dIMF50724978
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 May 2014 11:09:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s425dIiN003700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 May 2014 11:09:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is
 enabled
In-Reply-To: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
References: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
Date: Fri, 02 May 2014 11:09:17 +0530
Message-ID: <87wqe4age2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Ram Pai <linuxram@us.ibm.com>,
 anton@samba.org, tony@ozlabs.au.ibm.com, hartb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

>     powerpc: crtsaveres.o needed only when -Os flag is enabled
>     
>     Currently on powerpc arch, out-of-tree module fails to build without
>     crtsaveres.o, even when the module has no dependency on the symbols
>     provided by the file; when built without the -Os flag.
>     
>     BTW: '-Os' flag is enabled when CONFIG_CC_OPTIMIZE_FOR_SIZE is
>     configured.
>     
>     This patch fixes that problem.
>     
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 4c0cedf..cf12f38 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -157,7 +157,10 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
>  
>  CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
>  
> +ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> +endif
> +
>  
>  # No AltiVec or VSX instructions when building kernel
>  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
>

So if we enable CONFIG_CC_OPTIMIZE_FOR_SIZE can we build out-of-tree
module with this patch ? 

-aneesh

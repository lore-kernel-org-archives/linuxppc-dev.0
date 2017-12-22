Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3Bjs1H07zF083
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 02:09:04 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBMF8KMn083205
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 10:09:02 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f12cgqe04-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 10:09:01 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 22 Dec 2017 08:09:00 -0700
References: <20171220145206.12234-1-npiggin@gmail.com>
 <20171220145206.12234-5-npiggin@gmail.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 4/8] powerpc/64s: put io_sync bit into r14
In-reply-to: <20171220145206.12234-5-npiggin@gmail.com>
Date: Fri, 22 Dec 2017 13:08:54 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a7ya6bqx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello Nicholas,

Just a small comment about syntax. I'm afraid I can't comment much about
the substance of the patch.

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index b9ebc3085fb7..182bb9304c79 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -40,16 +40,9 @@
>  #endif
>
>  #if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
> -#define CLEAR_IO_SYNC	(get_paca()->io_sync = 0)
> -#define SYNC_IO		do {						\
> -				if (unlikely(get_paca()->io_sync)) {	\
> -					mb();				\
> -					get_paca()->io_sync = 0;	\
> -				}					\
> -			} while (0)
> +#define CLEAR_IO_SYNC	do { r14_clear_bits(R14_BIT_IO_SYNC); } while(0)

Is there a reason for the do { } while(0) idiom here? If
r14_clear_bits() is an inline function, isn't it a single statement
already?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

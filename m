Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tsSZ02NHHzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2017 17:57:27 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v026sBcr035407
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jan 2017 01:57:25 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27q38vdahy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 01:57:25 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Mon, 2 Jan 2017 06:57:23 -0000
Date: Mon, 2 Jan 2017 07:57:13 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Peter Zijlstra <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
Message-Id: <20170102065713.GB4779@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 30, 2016 at 06:56:31PM +0300, Dmitry Safonov wrote:
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),
> 
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
> ---
...

> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 6bca916a5ba0..c53e8e2a51ac 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -89,10 +89,9 @@ extern void execve_tail(void);
>   * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
>   */
> 
> -#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
>  #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
>  					(1UL << 30) : (1UL << 41))
> -#define TASK_SIZE		TASK_SIZE_OF(current)
> +#define TASK_SIZE		(current->mm->context.asce_limit)
>  #define TASK_MAX_SIZE		(1UL << 53)
> 
>  #define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:42))

FWIW, for the s390 part:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

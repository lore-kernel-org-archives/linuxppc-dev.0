Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA6021A0B73
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 07:36:10 +1000 (EST)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9B4E1400B7
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2014 07:36:09 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 Aug 2014 17:36:06 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 345E938C804A
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2014 17:36:04 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7RLa47610092900
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2014 21:36:04 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7RLa2uZ032648
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2014 17:36:04 -0400
Date: Wed, 27 Aug 2014 14:35:59 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 3/3] powerpc, ptrace: Enable support for miscellaneous
 registers
Message-ID: <20140827213559.GB11489@us.ibm.com>
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1400858138-3939-4-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400858138-3939-4-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, davej@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| This patch enables get and set of miscellaneous registers through ptrace
| PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing new powerpc
| specific register set REGSET_MISC support corresponding to the new ELF
| core note NT_PPC_MISC added previously in this regard.
| 
| Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
| ---
|  arch/powerpc/kernel/ptrace.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
|  1 file changed, 81 insertions(+)
| 
| diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
| index 17642ef..63b883a 100644
| --- a/arch/powerpc/kernel/ptrace.c
| +++ b/arch/powerpc/kernel/ptrace.c
| @@ -1149,6 +1149,76 @@ static int tm_cvmx_set(struct task_struct *target, const struct user_regset *reg
|  #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
|  
|  /*
| + * Miscellaneous Registers
| + *
| + * struct {
| + * 	unsigned long dscr;
| + *	unsigned long ppr;
| + * 	unsigned long tar;
| + * };
| + */
| +static int misc_get(struct task_struct *target, const struct user_regset *regset,
| +		   unsigned int pos, unsigned int count,
| +		   void *kbuf, void __user *ubuf)
| +{
| +	int ret;
| +
| +	/* DSCR register */
| +	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
| +					&target->thread.dscr, 0,
| +					sizeof(unsigned long));
| +
| +	BUILD_BUG_ON(offsetof(struct thread_struct, dscr) + sizeof(unsigned long) +
| +				sizeof(unsigned long) != offsetof(struct thread_struct, ppr));


I see these in  arch/powerpc/include/asm/processor.h

#ifdef CONFIG_PPC64
        unsigned long   dscr;
        int             dscr_inherit;
        unsigned long   ppr;    /* used to save/restore SMT priority */
#endif

where there is an 'int' between ppr and dscr. So, should one of
the above sizeof(unsigned long) be changed to sizeof(int) ?

Also, since we use offsetof(struct thread_struct, field) heavily, a
macro local to the file, may simplify the code.

#define	TSO(f)	(offsetof(struct thread_struct, f))

| +
| +	/* PPR register */
| +	if (!ret)
| +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
| +					  &target->thread.ppr, sizeof(unsigned long),
| +					  2 * sizeof(unsigned long));
| +
| +	BUILD_BUG_ON(offsetof(struct thread_struct, ppr) + sizeof(unsigned long)
| +						!= offsetof(struct thread_struct, tar));
| +	/* TAR register */
| +	if (!ret)
| +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
| +					  &target->thread.tar, 2 * sizeof(unsigned long),
| +					  3 * sizeof(unsigned long));
| +	return ret;
| +}
| +
| +static int misc_set(struct task_struct *target, const struct user_regset *regset,
| +		   unsigned int pos, unsigned int count,
| +		   const void *kbuf, const void __user *ubuf)
| +{
| +	int ret;
| +
| +	/* DSCR register */
| +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
| +					&target->thread.dscr, 0,
| +					sizeof(unsigned long));
| +
| +	BUILD_BUG_ON(offsetof(struct thread_struct, dscr) + sizeof(unsigned long) +
| +			sizeof(unsigned long) != offsetof(struct thread_struct, ppr));
| +
| +	/* PPR register */
| +	if (!ret)
| +		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
| +						&target->thread.ppr, sizeof(unsigned long),
| +						2 * sizeof(unsigned long));
| +
| +	BUILD_BUG_ON(offsetof(struct thread_struct, ppr) + sizeof(unsigned long)
| +						!= offsetof(struct thread_struct, tar));
| +
| +	/* TAR register */
| +	if (!ret)
| +		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
| +						&target->thread.tar, 2 * sizeof(unsigned long),
| +						3 * sizeof(unsigned long));
| +	return ret;
| +}
| +
| +/*
|   * These are our native regset flavors.
|   */
|  enum powerpc_regset {
| @@ -1169,6 +1239,7 @@ enum powerpc_regset {
|  	REGSET_TM_CFPR,		/* TM checkpointed FPR */
|  	REGSET_TM_CVMX,		/* TM checkpointed VMX */
|  #endif
| +	REGSET_MISC		/* Miscellaneous */
|  };
|  
|  static const struct user_regset native_regsets[] = {
| @@ -1225,6 +1296,11 @@ static const struct user_regset native_regsets[] = {
|  		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
|  	},
|  #endif
| +	[REGSET_MISC] = {
| +		.core_note_type = NT_PPC_MISC, .n = 3,
| +		.size = sizeof(u64), .align = sizeof(u64),
| +		.get = misc_get, .set = misc_set
| +	},
|  };
|  
|  static const struct user_regset_view user_ppc_native_view = {
| @@ -1566,6 +1642,11 @@ static const struct user_regset compat_regsets[] = {
|  		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
|  	},
|  #endif
| +	[REGSET_MISC] = {
| +		.core_note_type = NT_PPC_MISC, .n = 3,
| +		.size = sizeof(u64), .align = sizeof(u64),
| +		.get = misc_get, .set = misc_set
| +	},

Since the .n = 3 is used more than once, how about a macro for the
number of misc registers ?

|  };
|  
|  static const struct user_regset_view user_ppc_compat_view = {
| -- 
| 1.7.11.7
| 
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev

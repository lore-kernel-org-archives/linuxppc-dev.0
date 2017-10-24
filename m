Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLkdQ55hrzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 17:58:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O6s8QU080468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:58:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dt0na08jx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:58:47 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Oct 2017 07:58:45 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 09/25] powerpc: ability to create execute-disabled pkeys
In-Reply-To: <20171018051547.GD5617@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-18-git-send-email-linuxram@us.ibm.com>
 <20171018144256.72bdd785@firefly.ozlabs.ibm.com>
 <20171018051547.GD5617@ram.oc3035372033.ibm.com>
Date: Tue, 24 Oct 2017 12:28:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp3lvxpg.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> On Wed, Oct 18, 2017 at 02:42:56PM +1100, Balbir Singh wrote:
>> On Fri,  8 Sep 2017 15:44:57 -0700
>> Ram Pai <linuxram@us.ibm.com> wrote:
>> 
>> > powerpc has hardware support to disable execute on a pkey.
>> > This patch enables the ability to create execute-disabled
>> > keys.
>> > 
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> > ---
>> >  arch/powerpc/include/uapi/asm/mman.h |    6 ++++++
>> >  arch/powerpc/mm/pkeys.c              |   16 ++++++++++++++++
>> >  2 files changed, 22 insertions(+), 0 deletions(-)
>> > 
>> > diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
>> > index ab45cc2..f272b09 100644
>> > --- a/arch/powerpc/include/uapi/asm/mman.h
>> > +++ b/arch/powerpc/include/uapi/asm/mman.h
>> > @@ -45,4 +45,10 @@
>> >  #define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB   HugeTLB Page */
>> >  #define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB  HugeTLB Page */
>> >  
>> > +/* override any generic PKEY Permission defines */
>> > +#define PKEY_DISABLE_EXECUTE   0x4
>> > +#undef PKEY_ACCESS_MASK
>> > +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
>> > +				PKEY_DISABLE_WRITE  |\
>> > +				PKEY_DISABLE_EXECUTE)
>> >  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
>> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
>> > index cc5be6a..2282864 100644
>> > --- a/arch/powerpc/mm/pkeys.c
>> > +++ b/arch/powerpc/mm/pkeys.c
>> > @@ -24,6 +24,14 @@ void __init pkey_initialize(void)
>> >  {
>> >  	int os_reserved, i;
>> >  
>> > +	/*
>> > +	 * we define PKEY_DISABLE_EXECUTE in addition to the arch-neutral
>> > +	 * generic defines for PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.
>> > +	 * Ensure that the bits a distinct.
>> > +	 */
>> > +	BUILD_BUG_ON(PKEY_DISABLE_EXECUTE &
>> > +		     (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
>> 
>> Will these values every change? It's good to have I guess.
>> 
>> > +
>> >  	/* disable the pkey system till everything
>> >  	 * is in place. A patch further down the
>> >  	 * line will enable it.
>> > @@ -120,10 +128,18 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>> >  		unsigned long init_val)
>> >  {
>> >  	u64 new_amr_bits = 0x0ul;
>> > +	u64 new_iamr_bits = 0x0ul;
>> >  
>> >  	if (!is_pkey_enabled(pkey))
>> >  		return -EINVAL;
>> >  
>> > +	if ((init_val & PKEY_DISABLE_EXECUTE)) {
>> > +		if (!pkey_execute_disable_support)
>> > +			return -EINVAL;
>> > +		new_iamr_bits |= IAMR_EX_BIT;
>> > +	}
>> > +	init_iamr(pkey, new_iamr_bits);
>> > +
>> 
>> Where do we check the reserved keys?
>
> The main gate keeper against spurious keys are the system calls.
> sys_pkey_mprotect(), sys_pkey_free() and sys_pkey_modify() are the one
> that will check against reserved and unallocated keys.  Once it has
> passed the check, all other internal functions trust the key values
> provided to them. I can put in additional checks but that will
> unnecessarily chew a few cpu cycles.
>
> Agree?
>
> BTW: you raise a good point though, I may have missed guarding against
> unallocated or reserved keys in sys_pkey_modify(). That was a power
> specific system call that I have introduced to change the permissions on
> a key.

Why do you need a power specific syscall? We should ideally not require
anything powerpc specific in the application to use memory keys. If it
is for exectue only key, the programming model should remain same as the
other keys.

NOTE: I am not able to find patch that add sys_pkey_modify()

-aneesh

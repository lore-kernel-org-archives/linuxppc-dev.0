Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 735CA2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:21:58 +1100 (EST)
Message-ID: <52E7D918.5020704@windriver.com>
Date: Tue, 28 Jan 2014 11:21:44 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>	
 <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>	
 <20140123003838.GA10182@windriver.com> <1390878783.3872.63.camel@pasglop>
In-Reply-To: <1390878783.3872.63.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-01-27 10:13 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-01-22 at 19:38 -0500, Paul Gortmaker wrote:
> 
>> Thanks, it was a great help as it uncovered a few issues in fringe arch
>> that I didn't have toolchains for, and I've fixed all of those up.
>>
>> I've noticed that powerpc has been un-buildable for a while now; I have
>> used this hack patch locally so I could run the ppc defconfigs to check
>> that I didn't break anything.  Maybe useful for linux-next in the
>> interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)
> 
> Can you and/or Aneesh submit that as a proper patch (with S-O-B
> etc...) ?

I'd updated toolchains and didn't realize it was still broken.  Patch sent.

http://patchwork.ozlabs.org/patch/314749/

Paul.
--

> 
> Thanks !
> 
> Cheers,
> Ben.
> 
>> Paul.
>> --
>>
>> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
>> index d27960c89a71..d0f070a2b395 100644
>> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
>> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
>> @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  			    pmd_t *pmdp);
>>  
>>  #define pmd_move_must_withdraw pmd_move_must_withdraw
>> -typedef struct spinlock spinlock_t;
>> -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
>> -					 spinlock_t *old_pmd_ptl)
>> +struct spinlock;
>> +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>> +					 struct spinlock *old_pmd_ptl)
>>  {
>>  	/*
>>  	 * Archs like ppc64 use pgtable to store per pmd
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHwSj08fNzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 04:11:31 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JH5o70127233
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 13:11:27 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dpykxsxku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 13:11:26 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 11:11:26 -0600
Date: Thu, 19 Oct 2017 10:11:17 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 01/25] powerpc: initial pkey plumbing
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-10-git-send-email-linuxram@us.ibm.com>
 <87lgk7kbu3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgk7kbu3.fsf@concordia.ellerman.id.au>
Message-Id: <20171019171117.GX5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 03:20:36PM +1100, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 9fc3c0b..a4cd210 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -864,6 +864,22 @@ config SECCOMP
> >  
> >  	  If unsure, say Y. Only embedded should say N here.
> >  
> > +config PPC64_MEMORY_PROTECTION_KEYS
> 
> That's pretty wordy, can we make it CONFIG_PPC_MEM_KEYS ?
> 
> I think you're a sufficient vim wizard to search and replace all
> usages at once,

I take that as a compliment for now ;)

> if not I can do it before I apply the series.

Will change it...just that I was trying to keep it similar to what intel
has X86_INTEL_MEMORY_PROTECTION_KEYS

> 
> > +	prompt "PowerPC Memory Protection Keys"
> > +	def_bool y
> > +	# Note: only available in 64-bit mode
> 
> We don't need the note, that's exactly what the next line says:
> > +	depends on PPC64
> 
> But shouldn't it be BOOK3S_64 ?
> 
> I don't think it works on BookE does it?
> 
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> > +	select ARCH_HAS_PKEYS
> > +	---help---
> 
> I prefer just "help".

ok.

> 
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 3095925..7badf29 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -141,5 +141,10 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> 	/*

  ....snip...

>          * Disable the pkey system till everything is in place. A patch
>          * further down the line will enable it.
> 	 */
> 
> I'm going to stop commenting on every badly formatted comment :)

did not realize I had acquired a habit for badly formatted
comments. :-( Sorry for causing the pain. Will fix it.


RP

Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYBnV54DCzDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 02:41:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HGctub145350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 12:41:47 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cdac6hxgm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 12:41:46 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 17 Aug 2017 12:41:46 -0400
Date: Thu, 17 Aug 2017 09:41:40 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 09/25] powerpc: store and restore the pkey state across
 context switches
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-10-git-send-email-linuxram@us.ibm.com>
 <874ltfkv64.fsf@linux.vnet.ibm.com>
 <87fucyd34k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fucyd34k.fsf@concordia.ellerman.id.au>
Message-Id: <20170817164140.GE5505@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 04:34:19PM +1000, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > Ram Pai <linuxram@us.ibm.com> writes:
> >> --- a/arch/powerpc/kernel/process.c
> >> +++ b/arch/powerpc/kernel/process.c
> >> @@ -42,6 +42,7 @@
> >>  #include <linux/hw_breakpoint.h>
> >>  #include <linux/uaccess.h>
> >>  #include <linux/elf-randomize.h>
> >> +#include <linux/pkeys.h>
> >>
> >>  #include <asm/pgtable.h>
> >>  #include <asm/io.h>
> >> @@ -1096,6 +1097,13 @@ static inline void save_sprs(struct thread_struct *t)
> >>  		t->tar = mfspr(SPRN_TAR);
> >>  	}
> >>  #endif
> >> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> >> +	if (arch_pkeys_enabled()) {
> >> +		t->amr = mfspr(SPRN_AMR);
> >> +		t->iamr = mfspr(SPRN_IAMR);
> >> +		t->uamor = mfspr(SPRN_UAMOR);
> >> +	}
> >> +#endif
> >>  }
> >
> > Is it worth having a flag in thread_struct saying whether it has every
> > called pkey_alloc and only do the mfsprs if it did?

Yes. This will further optimize the code; a great thing!

> 
> Yes, in fact there's a programming note in the UAMOR section of the arch
> that says exactly that.
> 
> On the write side you have to be a bit more careful. You have to make
> sure you set the UAMOR to 0 when you're switching from a process that
> has used keys to one that isn't.

Currently we save and restore AMR/IAMR/UAMOR if the OS has enabled pkeys.
This means the UAMOR will get restored to 0 if the application has not
used any keys.

But if we do optimize the code further; as suggested by Thiago, we will
have to be careful with initializing UAMOR while switching back task
that has not used the keys yet.

RP

> 
> cheers

-- 
Ram Pai

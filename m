Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtNx81GqlzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 02:18:03 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EGEX1O128939
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 12:18:01 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cyv5k3e2k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 12:18:01 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 12:18:00 -0400
Date: Thu, 14 Sep 2017 09:17:54 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 01/25] powerpc: initial pkey plumbing
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-10-git-send-email-linuxram@us.ibm.com>
 <20170914133205.5542e70b@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914133205.5542e70b@firefly.ozlabs.ibm.com>
Message-Id: <20170914161754.GC5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 01:32:05PM +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:49 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Basic  plumbing  to   initialize  the   pkey  system.
> > Nothing is enabled yet. A later patch will enable it
> > ones all the infrastructure is in place.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/Kconfig                   |   16 +++++++++++
> >  arch/powerpc/include/asm/mmu_context.h |    5 +++
> >  arch/powerpc/include/asm/pkeys.h       |   45 ++++++++++++++++++++++++++++++++
> >  arch/powerpc/kernel/setup_64.c         |    4 +++
> >  arch/powerpc/mm/Makefile               |    1 +
> >  arch/powerpc/mm/hash_utils_64.c        |    1 +
> >  arch/powerpc/mm/pkeys.c                |   33 +++++++++++++++++++++++
> >  7 files changed, 105 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/include/asm/pkeys.h
> >  create mode 100644 arch/powerpc/mm/pkeys.c
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 9fc3c0b..a4cd210 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -864,6 +864,22 @@ config SECCOMP
> >  
> >  	  If unsure, say Y. Only embedded should say N here.
> >  
> > +config PPC64_MEMORY_PROTECTION_KEYS
> > +	prompt "PowerPC Memory Protection Keys"
> > +	def_bool y
> > +	# Note: only available in 64-bit mode
> > +	depends on PPC64
> 
> This is not sufficient right, you need PPC_BOOK3S_64
> for compile time at-least?

Ok. Not thought too deep about this. Thanks for the input.


> 
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> > +
.....
> > +void __init pkey_initialize(void)
> > +{
> > +	/* disable the pkey system till everything
> > +	 * is in place. A patch further down the
> > +	 * line will enable it.
> > +	 */
> 
> Comment style is broken
> 

checkpatch.pl does not complain.  So is it really a broken
comment style, or is it checkpatch.pl needs to be fixed?


RP

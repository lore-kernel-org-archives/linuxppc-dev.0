Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcJRL4h1gzDrJK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 04:06:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7MI5qFD141052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 14:06:51 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cgr5pcu26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 14:06:51 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 22 Aug 2017 12:06:50 -0600
Date: Tue, 22 Aug 2017 11:06:37 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 35/62] powerpc: Deliver SEGV signal on pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-36-git-send-email-linuxram@us.ibm.com>
 <87d17rnzll.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d17rnzll.fsf@xmission.com>
Message-Id: <20170822180637.GA17106@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 19, 2017 at 02:09:58PM -0500, Eric W. Biederman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index d4e545d..fe1e7c7 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/debug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> > +#include <linux/pkeys.h>
> >  #include <linux/stddef.h>
> >  #include <linux/unistd.h>
> >  #include <linux/ptrace.h>
> > @@ -247,6 +248,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
> >  	info->si_addr = (void __user *)regs->nip;
> >  }
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
> > +{
> > +	if (si_code != SEGV_PKUERR)
> > +		return;
> 
> Given that SEGV_PKUERR is a signal specific si_code this test is
> insufficient to detect an pkey error.  You also need to check
> that signr == SIGSEGV

true. will make it a more precise check.

Thanks
RP

Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHw4V45FdzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 03:54:02 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JGn5bH056875
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:53:59 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dpyrmgh9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:53:59 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 10:53:58 -0600
Date: Thu, 19 Oct 2017 09:53:50 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
 <20171019102752.7d9075ec@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019102752.7d9075ec@MiWiFi-R3-srv>
Message-Id: <20171019165350.GU5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:27:52AM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:08 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Handle Data and  Instruction exceptions caused by memory
> > protection-key.
> > 
> > The CPU will detect the key fault if the HPTE is already
> > programmed with the key.
> > 
> > However if the HPTE is not  hashed, a key fault will not
> > be detected by the  hardware. The   software will detect
> > pkey violation in such a case.
> 
> 
> This bit is not clear.
> 
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/mm/fault.c |   37 ++++++++++++++++++++++++++++++++-----
> >  1 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 4797d08..a16bc43 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -145,6 +145,23 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
> >  	return __bad_area(regs, address, SEGV_MAPERR);
> >  }
> >  
> > +static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
> > +					int si_code)
> > +{
> > +	int sig = SIGBUS;
> > +	int code = BUS_OBJERR;
> > +
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	if (si_code & DSISR_KEYFAULT) {
> > +		sig = SIGSEGV;
> > +		code = SEGV_PKUERR;
> > +	}
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> > +	_exception(sig, regs, code, address);
> > +	return 0;
> > +}
> > +
> >  static int do_sigbus(struct pt_regs *regs, unsigned long address,
> >  		     unsigned int fault)
> >  {
> > @@ -391,11 +408,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >  		return 0;
> >  
> >  	if (unlikely(page_fault_is_bad(error_code))) {
> > -		if (is_user) {
> > -			_exception(SIGBUS, regs, BUS_OBJERR, address);
> > -			return 0;
> > -		}
> > -		return SIGBUS;
> > +		if (!is_user)
> > +			return SIGBUS;
> > +		return bad_page_fault_exception(regs, address, error_code);
> >  	}
> >  
> >  	/* Additional sanity check(s) */
> > @@ -492,6 +507,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >  	if (unlikely(access_error(is_write, is_exec, vma)))
> >  		return bad_area(regs, address);
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> > +			is_exec, 0))
> > +		return __bad_area(regs, address, SEGV_PKUERR);
> 
> 
> Hmm.. this is for the missing entry in the HPT and software detecting the
> fault you mentioned above? Why do we need this case?

I thought I had put in a comment motivating the reason. Seems to have
disappeared. Will add it back.  But here is the reason....

hardware enforces key-exception only after the key is programmed into
the HPTE. However there is a window where the key is programmed into the
PTE and waiting for a page fault so that it can propagate key to the
HPTE. It is that window, during which we have to guard for key
violation. The above check closes that small window of vulnerability.
	
RP

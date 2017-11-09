Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY02w6YBVzDrKD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 10:38:00 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA9NZFuw004456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 18:37:58 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e4wqdr9g7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 18:37:57 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 9 Nov 2017 16:37:56 -0700
Date: Thu, 9 Nov 2017 15:37:46 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org,
 ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org,
 dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 44/51] selftest/vm: powerpc implementation for generic
 abstraction
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-45-git-send-email-linuxram@us.ibm.com>
 <20171109184714.xs523k4cvmqghew3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109184714.xs523k4cvmqghew3@gmail.com>
Message-Id: <20171109233745.GD5546@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 09, 2017 at 04:47:15PM -0200, Breno Leitao wrote:
> Hi Ram,
> 
> On Mon, Nov 06, 2017 at 12:57:36AM -0800, Ram Pai wrote:
> > @@ -206,12 +209,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
> >  
> >  	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
> >  	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
> > -	fpregset = uctxt->uc_mcontext.fpregs;
> > -	fpregs = (void *)fpregset;
> 
> Since you removed all references for fpregset now, you probably want to
> remove the declaration of the variable above.

fpregs is still needed.

> 
> > @@ -219,20 +224,21 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
> >  	 * state.  We just assume that it is here.
> >  	 */
> >  	fpregs += 0x70;
> > -#endif
> > -	pkey_reg_offset = pkey_reg_xstate_offset();
> 
> With this code, you removed all the reference for variable
> pkey_reg_offset, thus, its declaration could be removed also.

yes. will fix it.

> 
> > -	*(u64 *)pkey_reg_ptr = 0x00000000;
> > +	dprintf1("si_pkey from siginfo: %lx\n", si_pkey);
> > +#if defined(__i386__) || defined(__x86_64__) /* arch */
> > +	dprintf1("signal pkey_reg from xsave: %016lx\n", *pkey_reg_ptr);
> > +	*(u64 *)pkey_reg_ptr &= reset_bits(si_pkey, PKEY_DISABLE_ACCESS);
> > +#elif __powerpc64__
> 
> Since the variable pkey_reg_ptr is only used for Intel code (inside
> #ifdefs), you probably want to #ifdef the variable declaration also,
> avoid triggering "unused variable" warning on non-Intel machines.

yes. Actually it will trigger the warning on intel machines. Fixed it.

Thanks Breno!
RP

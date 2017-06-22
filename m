Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtw5R4WnFzDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 07:41:47 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MLccwV116950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 17:41:44 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8k1hf25t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 17:41:44 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 22 Jun 2017 15:41:43 -0600
Date: Thu, 22 Jun 2017 14:41:31 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
 <622d7abf-3d99-8897-5afb-ef8c4f950fc0@linux.vnet.ibm.com>
 <1497609181.2897.100.camel@kernel.crashing.org>
 <20170616191537.GB17588@ram.oc3035372033.ibm.com>
 <1497653684.2897.104.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497653684.2897.104.camel@kernel.crashing.org>
Message-Id: <20170622214131.GO17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 17, 2017 at 08:54:44AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2017-06-16 at 12:15 -0700, Ram Pai wrote:
> > gp_regs size is not changed, nor is the layout. A unused field in
> > the gp_regs is used to fill in the AMR contents. Old binaries will not
> > be knowing about this unused field, and hence should not break.
> > 
> > New binaries can leverage this already existing but newly defined
> > field; to read the contents of AMR.
> > 
> > Is it still a concern?
> 
> Calls to sys_swapcontext with a made-up context will end up with a crap
> AMR if done by code who didn't know about that register.

Turns out x86 does not have this problem, because x86 does not implement
sys_swapcontext.  However; unlike x86, powerpc lets signal handler
program the AMR(x86 PKRU equivalent), which can persist even after the
signal handler returns to the kernel through sys_sigreturn.

So I am inclined to deviate from the x86 protection-key semantics.

On x86 the persistent way for the signal handler
to change the key register(PKRU) is through a field in the siginfo structure.

And on powerpc  the persistent way for the signal handler to change the
key register(AMR) will be to directly program the AMR register.

This should resolve your concern on powerpc, since there is no way
a crap AMR value will change the real AMR register, because the powerpc
kernel will not be letting it happen. Acceptable?

RP

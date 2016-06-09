Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQ5RQ5vztzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 10:15:14 +1000 (AEST)
Message-ID: <1465431308.22191.101.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, LinuxPPC-dev
 <linuxppc-dev@lists.ozlabs.org>, Becky Bruce <beckyb@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Wed, 08 Jun 2016 19:15:08 -0500
In-Reply-To: <b2980a9d-4795-ae1b-16dd-ba244d559a31@c-s.fr>
References: <b2980a9d-4795-ae1b-16dd-ba244d559a31@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC] Implementing HUGEPAGE on MPC 8xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 09:03 +0200, Christophe Leroy wrote:
> In see in the current ppc kernel that for PPC32, SYS_SUPPORTS_HUGETLBFS 
> is selected only if we have PHYS_64BIT.
> What is the reason for only implementing HUGETLBFS with 64 bits phys 
> addresses ?

That's not for PPC32 in general -- it's for 32-bit FSL Book E.  The reason for
the limitation is that there are separate TLB miss handlers depending on
whether PHYS_64BIT is enabled, and we didn't want to have to implement hugetlb
support in both of them unless there was actual demand for it.

>  From your point of view, what would be the best approach to extend 
> support of HUGE PAGES to PPC_8xx ?
> Would the good starting point be to implement a hugepagetlb-8xx.c from 
> hugepagetlb-book3e.c ?

Yes.

-Scott

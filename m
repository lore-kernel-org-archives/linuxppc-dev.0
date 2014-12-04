Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D53B11A0C38
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 20:35:54 +1100 (AEDT)
Message-ID: <1417685753.31400.1.camel@concordia>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 04 Dec 2014 20:35:53 +1100
In-Reply-To: <547D7FF2.3010901@linux.vnet.ibm.com>
References: <20141128223838.B21E51401B1@ozlabs.org>
 <547D7FF2.3010901@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-02 at 14:31 +0530, Mahesh Jagannath Salgaonkar wrote:
> On 11/29/2014 04:08 AM, Michael Ellerman wrote:
> > On Tue, 2014-23-09 at 03:53:54 UTC, Mahesh Salgaonkar wrote:
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> The flush_tlb hook in cpu_spec was introduced as a generic function hook
> >> to invalidate TLBs. But the current implementation of flush_tlb hook
> >> takes IS (invalidation selector) as an argument which is architecture
> >> dependent. Hence, It is not right to have a generic routine where caller
> >> has to pass non-generic argument.
> >>
> >> This patch fixes this and makes flush_tlb hook as high level API.
> >>
> >> The old code used to call flush_tlb hook with IS=0 (single page) resulting
> >> partial invalidation of TLBs which is not right. This fix now makes
> >> sure that whole TLB is invalidated to be able to successfully recover from
> >> TLB and ERAT errors.
> > 
> > Which old code? You mean the MCE code I think. That's a bug fix, so it should
> > be a separate patch.
> 
> Yes. MCE code. Since this patch re-factors the code that takes IS as
> direct argument, having a separate fix patch does not make any sense and
> would get overwritten by this patch anyway.

That's irrelevant.

The fix will go to stable, the refactor will not.

Please do the MCE fix as a separate, preceeding patch.

cheers

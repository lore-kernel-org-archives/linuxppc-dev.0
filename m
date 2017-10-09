Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9jll5553zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:48:03 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99Ej6X5062637
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 10:48:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg3jdgbvd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 10:48:01 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 15:47:59 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99EltVJ23855296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 14:47:56 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99Elwq7025479
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:47:59 +1100
Date: Mon, 9 Oct 2017 20:17:51 +0530
From: "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Segher Boessenkool'" <segher@kernel.crashing.org>,
 "'Sandipan Das'" <sandipan@linux.vnet.ibm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
Subject: Re: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
References: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008D92D@AcuExch.aculab.com>
 <20171009142053.GA4406@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD008D9DE@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD008D9DE@AcuExch.aculab.com>
Message-Id: <20171009144751.wkox4viisyycv2oj@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/09 02:43PM, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 09 October 2017 15:21
> > On Mon, Oct 09, 2017 at 01:49:26PM +0000, David Laight wrote:
> > > From: Sandipan Das
> > > > Sent: 09 October 2017 12:07
> > > > According to the GCC documentation, the behaviour of __builtin_clz()
> > > > and __builtin_clzl() is undefined if the value of the input argument
> > > > is zero. Without handling this special case, these builtins have been
> > > > used for emulating the following instructions:
> > > >   * Count Leading Zeros Word (cntlzw[.])
> > > >   * Count Leading Zeros Doubleword (cntlzd[.])
> > > >
> > > > This fixes the emulated behaviour of these instructions by adding an
> > > > additional check for this special case.
> > >
> > > Presumably the result is undefined because the underlying cpu
> > > instruction is used - and it's return value is implementation defined.
> > 
> > It is undefined because the result is undefined, and the compiler
> > optimises based on that.  The return value of the builtin is undefined,
> > not implementation defined.
> > 
> > The patch is correct.
> 
> But the code you are emulating might be relying on the (un)defined value
> the cpu instruction gives for zero input rather than the input width.
> 
> Or, put another way, if the return value for a clz instruction with zero
> argument is undefined (as it is on x86 - intel and amd may differ) then the
> emulation can return any value since the code can't care.
> So the conditional is not needed.

This is about the behavior of the gcc builtin being undefined, rather 
than the actual cpu instruction itself.


- Naveen

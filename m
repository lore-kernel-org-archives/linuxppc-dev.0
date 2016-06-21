Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYds35Gy5zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 17:00:07 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L6xiAH003456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 03:00:05 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23pygntfs8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 03:00:04 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 17:00:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3897D2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 17:00:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L700p446268624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 17:00:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L6xxfB026159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 17:00:00 +1000
Date: Tue, 21 Jun 2016 12:28:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Matt Evans <matt@ozlabs.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, Paul Mackerras <paulus@samba.org>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
References: <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <3rWKtT2tSrz9t2G@ozlabs.org>
 <20160619173642.GB8886@naverao1-tp.localdomain>
 <1466465899.437.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466465899.437.0.camel@ellerman.id.au>
Message-Id: <20160621065847.GD8886@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/21 09:38AM, Michael Ellerman wrote:
> On Sun, 2016-06-19 at 23:06 +0530, Naveen N. Rao wrote:
> > On 2016/06/17 10:53PM, Michael Ellerman wrote:
> > > On Tue, 2016-07-06 at 13:32:23 UTC, "Naveen N. Rao" wrote:
> > > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > > new file mode 100644
> > > > index 0000000..954ff53
> > > > --- /dev/null
> > > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > > @@ -0,0 +1,956 @@
> > > ...
> 
> > > > +
> > > > +static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> > > > +{
> > > > +	int *p = area;
> > > > +
> > > > +	/* Fill whole space with trap instructions */
> > > > +	while (p < (int *)((char *)area + size))
> > > > +		*p++ = BREAKPOINT_INSTRUCTION;
> > > > +}
> > > 
> > > This breaks the build for some configs, presumably you're missing a header:
> > > 
> > >   arch/powerpc/net/bpf_jit_comp64.c:30:10: error: 'BREAKPOINT_INSTRUCTION' undeclared (first use in this function)
> > > 
> > > http://kisskb.ellerman.id.au/kisskb/buildresult/12720611/
> > 
> > Oops. Yes, I should have caught that. I need to add:
> > 
> > #include <asm/kprobes.h>
> > 
> > in bpf_jit_comp64.c
> > 
> > Can you please check if it resolves the build error?
> 
> Can you? :D

:)
Sorry, I should have explained myself better. I did actually try your 
config and I was able to reproduce the build error. After the above 
#include, that error went away, but I saw some vdso related errors. I 
thought I was doing something wrong and needed a different setup for 
that particular kernel config, which is why I requested your help in the 
matter. I just didn't do a good job of putting across that message...

Note to self: randconfig builds *and* more time drafting emails :)

Do you want me to respin the patches?


Thanks,
Naveen

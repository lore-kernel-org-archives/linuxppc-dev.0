Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXh623YGWzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 03:38:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5JHY7xm017743
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 13:37:59 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mcxy6v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 13:37:58 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 03:37:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3C8812BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 03:37:53 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5JHbr0h7012794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 03:37:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5JHbqh9030106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 03:37:52 +1000
Date: Sun, 19 Jun 2016 23:06:42 +0530
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3rWKtT2tSrz9t2G@ozlabs.org>
Message-Id: <20160619173642.GB8886@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/17 10:53PM, Michael Ellerman wrote:
> On Tue, 2016-07-06 at 13:32:23 UTC, "Naveen N. Rao" wrote:
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > new file mode 100644
> > index 0000000..954ff53
> > --- /dev/null
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -0,0 +1,956 @@
> ...
> > +
> > +static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> > +{
> > +	int *p = area;
> > +
> > +	/* Fill whole space with trap instructions */
> > +	while (p < (int *)((char *)area + size))
> > +		*p++ = BREAKPOINT_INSTRUCTION;
> > +}
> 
> This breaks the build for some configs, presumably you're missing a header:
> 
>   arch/powerpc/net/bpf_jit_comp64.c:30:10: error: 'BREAKPOINT_INSTRUCTION' undeclared (first use in this function)
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/12720611/

Oops. Yes, I should have caught that. I need to add:

#include <asm/kprobes.h>

in bpf_jit_comp64.c

Can you please check if it resolves the build error?

Regards,
Naveen

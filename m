Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNn8964GfzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 04:58:17 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FHnZHp145230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 12:58:14 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mswswg1m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 12:58:14 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 23:28:11 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B84B5E0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:29:41 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FHw80Z35389600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:28:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FHw7Tf003118
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:28:08 +0530
Date: Wed, 15 Feb 2017 23:28:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: fix handling of function offsets
 on ABIv2
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170216001733.98d247f7ee293172c238b1f2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216001733.98d247f7ee293172c238b1f2@kernel.org>
Message-Id: <20170215175805.GF3169@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/16 12:17AM, Masami Hiramatsu wrote:
> On Tue, 14 Feb 2017 14:08:01 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > commit 239aeba76409 ("perf powerpc: Fix kprobe and kretprobe handling
> > with kallsyms on ppc64le") changed how we use the offset field in struct
> > kprobe on ABIv2. perf now offsets from the GEP (Global entry point) if an
> > offset is specified and otherwise chooses the LEP (Local entry point).
> > 
> > Fix the same in kernel for kprobe API users. We do this by extending
> > kprobe_lookup_name() to accept an additional parameter to indicate the
> > offset specified with the kprobe registration. If offset is 0, we return
> > the local function entry and return the global entry point otherwise.
> > 

<snip>

> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 83ad7e440417..9bc433575d98 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -63,7 +63,7 @@
> >   * so this must be overridable.
> >   */
> >  #ifndef kprobe_lookup_name
> > -#define kprobe_lookup_name(name, addr) \
> > +#define kprobe_lookup_name(name, addr, offset) \
> >  	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
> >  #endif
> 
> Hmm, it smells no good coding... I would like to use __weak function
> instead of this "#ifndef" trick.

Can't say I wasn't tempted. KPROBES_ON_FTRACE makes this worse. I will 
clean this up.

Thanks!
- Naveen

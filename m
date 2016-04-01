Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbyFm0pHPzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:25:47 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 20:25:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 290233578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:25:42 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31APXeH62259358
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:25:42 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31AP80c029574
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 21:25:09 +1100
Date: Fri, 1 Apr 2016 15:54:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, Matt Evans <matt@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 0/6] eBPF JIT for PPC64
Message-ID: <20160401102422.GE17907@naverao1-tp.ibm.com>
References: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1459504222.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/01 03:28PM, Naveen N Rao wrote:
> Implement extended BPF JIT for ppc64. We retain the classic BPF JIT for
> ppc32 and move ppc64 BE/LE to use the new JIT. Classic BPF filters will
> be converted to extended BPF (see convert_filter()) and JIT'ed with the
> new compiler.
> 
> Most of the existing macros are retained and fixed/enhanced where
> appropriate. Patches 1-4 are geared towards this.
> 
> Patch 5 breaks out the classic BPF JIT specifics into a separate
> bpf_jit32.h header file, while retaining all the generic instruction
> macros in bpf_jit.h. Most of these macros can potentially be generalized
> and moved to more common code (tagged with a TODO in patch 6).
> 
> Patch 6 implements eBPF JIT for ppc64.

As a comparison, here are the test results with the BPF test suite 
kernel module:

With the classic BPF JIT:
test_bpf: Summary: 291 PASSED, 0 FAILED, [85/283 JIT'ed]

and with the extended BPF JIT:
test_bpf: Summary: 291 PASSED, 0 FAILED, [234/283 JIT'ed]

As noted in patch 6, there are still a few more instructions to be 
JIT'ed.


- Naveen

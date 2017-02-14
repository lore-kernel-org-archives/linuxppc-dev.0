Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwrR6twhzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:41:43 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8UR41015379
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:41:41 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kwv49q2t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:41:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 01:41:40 -0700
Date: Tue, 14 Feb 2017 14:11:34 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: fix handling of function offsets
 on ABIv2
Reply-To: ananth@linux.vnet.ibm.com
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170214084134.GG29806@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2017 at 02:08:01PM +0530, Naveen N. Rao wrote:
> commit 239aeba76409 ("perf powerpc: Fix kprobe and kretprobe handling
> with kallsyms on ppc64le") changed how we use the offset field in struct
> kprobe on ABIv2. perf now offsets from the GEP (Global entry point) if an
> offset is specified and otherwise chooses the LEP (Local entry point).
> 
> Fix the same in kernel for kprobe API users. We do this by extending
> kprobe_lookup_name() to accept an additional parameter to indicate the
> offset specified with the kprobe registration. If offset is 0, we return
> the local function entry and return the global entry point otherwise.
> 
> With:
> 	# cd /sys/kernel/debug/tracing/
> 	# echo "p _do_fork" >> kprobe_events
> 	# echo "p _do_fork+0x10" >> kprobe_events
> 
> before this patch:
> 	# cat ../kprobes/list
> 	c0000000000d0748  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d0758  k  _do_fork+0x18    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> and after:
> 	# cat ../kprobes/list
> 	c0000000000d04c8  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d04d0  k  _do_fork+0x10    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>

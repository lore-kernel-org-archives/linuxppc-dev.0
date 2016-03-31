Return-Path: <prvs=3898f00e9f=ast@fb.com>
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbXDf53SDzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 04:53:22 +1100 (AEDT)
Subject: Re: [PATCH 4/4] samples/bpf: Enable powerpc support
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <28a3811d03f6e8f7dca989a4ade536bf9aa8c7ce.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
CC: "David S . Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FD63F4.2010500@fb.com>
Date: Thu, 31 Mar 2016 10:52:52 -0700
MIME-Version: 1.0
In-Reply-To: <28a3811d03f6e8f7dca989a4ade536bf9aa8c7ce.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> Add the necessary definitions for building bpf samples on ppc.
>
> Since ppc doesn't store function return address on the stack, modify how
> PT_REGS_RET() and PT_REGS_FP() work.
>
> Also, introduce PT_REGS_IP() to access the instruction pointer. I have
> fixed this to work with x86_64 and arm64, but not s390.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
...
> +
> +#ifdef __powerpc__
> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)		{ (ip) = (ctx)->link; }
> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)	BPF_KPROBE_READ_RET_IP(ip, ctx)
> +#else
> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)						\
> +		bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx))
> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)					\
> +		bpf_probe_read(&(ip), sizeof(ip),				\
> +				(void *)(PT_REGS_FP(ctx) + sizeof(ip)))

makes sense, but please use ({ }) gcc extension instead of {} and
open call to make sure that macro body is scoped.

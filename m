Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qc3yV37mQzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 01:42:58 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 2 Apr 2016 00:42:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F8F92CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 01:42:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31EgfOk51708064
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Apr 2016 01:42:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31EgGjp023946
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Apr 2016 01:42:17 +1100
Date: Fri, 1 Apr 2016 20:11:31 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@fb.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 4/4] samples/bpf: Enable powerpc support
Message-ID: <20160401144131.GG17907@naverao1-tp.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <28a3811d03f6e8f7dca989a4ade536bf9aa8c7ce.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD63F4.2010500@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56FD63F4.2010500@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/31 10:52AM, Alexei Starovoitov wrote:
> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
> ...
> >+
> >+#ifdef __powerpc__
> >+#define BPF_KPROBE_READ_RET_IP(ip, ctx)		{ (ip) = (ctx)->link; }
> >+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)	BPF_KPROBE_READ_RET_IP(ip, ctx)
> >+#else
> >+#define BPF_KPROBE_READ_RET_IP(ip, ctx)						\
> >+		bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx))
> >+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)					\
> >+		bpf_probe_read(&(ip), sizeof(ip),				\
> >+				(void *)(PT_REGS_FP(ctx) + sizeof(ip)))
> 
> makes sense, but please use ({ }) gcc extension instead of {} and
> open call to make sure that macro body is scoped.

To be sure I understand this right, do you mean something like this?

+
+#ifdef __powerpc__
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = (ctx)->link; })
+#define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
+#else
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({                              \
+               bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)     ({                              \
+               bpf_probe_read(&(ip), sizeof(ip),                               \
+                               (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+#endif
+


Thanks,
Naveen

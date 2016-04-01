Return-Path: <prvs=3899432171=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qc8JW1VlgzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 04:58:50 +1100 (AEDT)
Subject: Re: [PATCH 4/4] samples/bpf: Enable powerpc support
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <28a3811d03f6e8f7dca989a4ade536bf9aa8c7ce.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD63F4.2010500@fb.com> <20160401144131.GG17907@naverao1-tp.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Daniel
 Borkmann <daniel@iogearbox.net>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FEB6CA.6060607@fb.com>
Date: Fri, 1 Apr 2016 10:58:34 -0700
MIME-Version: 1.0
In-Reply-To: <20160401144131.GG17907@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/1/16 7:41 AM, Naveen N. Rao wrote:
> On 2016/03/31 10:52AM, Alexei Starovoitov wrote:
>> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
>> ...
>>> +
>>> +#ifdef __powerpc__
>>> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)		{ (ip) = (ctx)->link; }
>>> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)	BPF_KPROBE_READ_RET_IP(ip, ctx)
>>> +#else
>>> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)						\
>>> +		bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx))
>>> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)					\
>>> +		bpf_probe_read(&(ip), sizeof(ip),				\
>>> +				(void *)(PT_REGS_FP(ctx) + sizeof(ip)))
>>
>> makes sense, but please use ({ }) gcc extension instead of {} and
>> open call to make sure that macro body is scoped.
>
> To be sure I understand this right, do you mean something like this?
>
> +
> +#ifdef __powerpc__
> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = (ctx)->link; })
> +#define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
> +#else
> +#define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({                              \
> +               bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
> +#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)     ({                              \
> +               bpf_probe_read(&(ip), sizeof(ip),                               \
> +                               (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
> +#endif

yes. Thanks!

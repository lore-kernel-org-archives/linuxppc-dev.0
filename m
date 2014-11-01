Return-Path: <dborkman@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74FA41A0057
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 05:31:53 +1100 (AEDT)
Message-ID: <54552709.7000409@redhat.com>
Date: Sat, 01 Nov 2014 19:31:37 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
References: <CAOJe8K31iB9+7c1BnS=6DdriU08WUisM7sYgj8nOBo4Fg=XUBg@mail.gmail.com>
 <20141101.133957.1365371956675094081.davem@davemloft.net>
 <CAOJe8K2FzuPTZ5pch8_UK7X==+=k8RKLnfz0mZb2hca19aU4pg@mail.gmail.com>
 <20141101.140035.13626854970331774.davem@davemloft.net>
In-Reply-To: <20141101.140035.13626854970331774.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: matt@ozlabs.org, kda@linux-powerpc.org, linuxppc-dev@ozlabs.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01/2014 07:00 PM, David Miller wrote:
> From: Denis Kirjanov <kda@linux-powerpc.org>
> Date: Sat, 1 Nov 2014 21:49:27 +0400
>
>> David, you need a feedback from other guys to apply this patch, right?
>>
>> Alexei wanted some output before/after the patch.
>> Michael Ellerman wanted the explanation what a BPF_ANC | SKF_AD_PKTTYPE means.

The BPF_ANC | SKF_AD_PKTTYPE case means that this is an ancillary
operation aka BPF extension which loads the value of skb->pkt_type
into the accumulator.

A similar transformation, that is, from BPF into eBPF insns can be
found in convert_bpf_extensions() in the SKF_AD_PKTTYPE case, or
commit 709f6c58d4dc ("sparc: bpf_jit: add SKF_AD_PKTTYPE support
to JIT") that recently enabled the same in sparc.

>> So I'm waiting  the ack/nack from them...
>
> I don't really think performance metrics are necessary just for adding
> SKF_AD_PKTTYPE support, that's sort of an over the top requirement
> if you ask me.

Right, lib/test_bpf.c actually brings the quoted output w/ numbers
for free. I think the important point was that the 'After:' case
with ``echo 1 > /proc/sys/net/core/bpf_jit_enable'' runs through for
that test case, which has been shown here.

> It's pretty obvious that we should support as many operations as
> possible to each JIT, because all of program has to do is use that
> unsupported opcode and then we have none of that program being JIT'd.

Return-Path: <dborkman@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 782051A0057
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 05:40:52 +1100 (AEDT)
Message-ID: <54552926.1020504@redhat.com>
Date: Sat, 01 Nov 2014 19:40:38 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Denis Kirjanov <kirjanov@gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
 <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
 <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
In-Reply-To: <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Matt Evans <matt@ozlabs.org>, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@ozlabs.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2014 07:09 AM, Denis Kirjanov wrote:
> On 10/30/14, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Oct 29, 2014 at 11:12 PM, Denis Kirjanov <kda@linux-powerpc.org>
>> wrote:
>>> Add BPF extension SKF_AD_PKTTYPE to ppc JIT to load
>>> skb->pkt_type field.
>>>
>>> Before:
>>> [   88.262622] test_bpf: #11 LD_IND_NET 86 97 99 PASS
>>> [   88.265740] test_bpf: #12 LD_PKTTYPE 109 107 PASS
>>>
>>> After:
>>> [   80.605964] test_bpf: #11 LD_IND_NET 44 40 39 PASS
>>> [   80.607370] test_bpf: #12 LD_PKTTYPE 9 9 PASS
>>
>> if you'd only quoted #12, it would all make sense ;)
>> but #11 test is not using PKTTYPE. So your patch shouldn't
>> make a difference. Are these numbers with JIT on and off?
>
> Right.

Ok.

Please mention this in future log messages, as it was not quite
clear that "before" was actually with JIT off, and "after" was
with JIT on.

One could have read it that actually both cases were with JIT on,
and thus the inconsistent result for LD_IND_NET is a bit confusing
since you've quoted it here as well.

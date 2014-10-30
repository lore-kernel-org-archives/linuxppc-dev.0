Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12FA71A0171
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 07:32:48 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
Date: Thu, 30 Oct 2014 13:32:44 -0700
Message-ID: <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Matt Evans <matt@ozlabs.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2014 at 11:12 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Add BPF extension SKF_AD_PKTTYPE to ppc JIT to load
> skb->pkt_type field.
>
> Before:
> [   88.262622] test_bpf: #11 LD_IND_NET 86 97 99 PASS
> [   88.265740] test_bpf: #12 LD_PKTTYPE 109 107 PASS
>
> After:
> [   80.605964] test_bpf: #11 LD_IND_NET 44 40 39 PASS
> [   80.607370] test_bpf: #12 LD_PKTTYPE 9 9 PASS

if you'd only quoted #12, it would all make sense ;)
but #11 test is not using PKTTYPE. So your patch shouldn't
make a difference. Are these numbers with JIT on and off?

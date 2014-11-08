Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5061E1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Nov 2014 04:59:59 +1100 (AEDT)
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com
 [IPv6:2607:f8b0:400d:c04::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3C19140082
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2014 04:59:58 +1100 (AEDT)
Received: by mail-qg0-f45.google.com with SMTP id z107so3827439qgd.18
 for <linuxppc-dev@ozlabs.org>; Sat, 08 Nov 2014 09:59:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415253755-4001-1-git-send-email-kda@linux-powerpc.org>
References: <1415253755-4001-1-git-send-email-kda@linux-powerpc.org>
Date: Sat, 8 Nov 2014 09:59:55 -0800
Message-ID: <CAADnVQJZxVvzPFKG1E0jQkpv3GB4iJejyPknb-PnkcKfP4Nf1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: add SKF_AD_HATYPE instruction
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Daniel Borkmann <dborkman@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 5, 2014 at 10:02 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Add BPF extension SKF_AD_HATYPE to ppc JIT to check
> the hw type of the interface
>
> JIT off:
> [   69.106783] test_bpf: #20 LD_HATYPE 48 48 PASS
> JIT on:
> [   64.721757] test_bpf: #20 LD_HATYPE 7 6 PASS
>
> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
> CC: Daniel Borkmann<dborkman@redhat.com>
> CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d110e28..8bf4fc2 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -412,6 +412,22 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>                         PPC_ANDI(r_A, r_A, PKT_TYPE_MAX);
>                         PPC_SRWI(r_A, r_A, 5);
>                         break;
> +               case BPF_ANC | SKF_AD_HATYPE:
> +                       BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
> +                       PPC_LD_OFFS(r_scratch1, r_skb, offsetof(struct sk_buff,
> +                                                               dev));
> +                       PPC_CMPDI(r_scratch1, 0);
> +                       if (ctx->pc_ret0 != -1) {
> +                               PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
> +                       } else {
> +                               /* Exit, returning 0; first pass hits here. */
> +                               PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);

please use canonical formatting ctx->idx * 4 + 12

> +                               PPC_LI(r_ret, 0);
> +                               PPC_JMP(exit_addr);
> +                       }
> +                       PPC_LHZ_OFFS(r_A, r_scratch1,
> +                                    offsetof(struct net_device, type));

the whole thing looks like copy paste from 'case ifindex'.
Would be nice to handle them together to reduce
duplicated code, sine only last load is different.

Also in commit log please do _both_ runs with JIT on.
You should see a difference before/after applying this patch.

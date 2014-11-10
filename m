Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF1F21A0179
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 05:26:45 +1100 (AEDT)
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2ACBE14011B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 05:26:45 +1100 (AEDT)
Received: by mail-qg0-f50.google.com with SMTP id a108so5801833qge.23
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 10:26:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415599183-3883-1-git-send-email-kda@linux-powerpc.org>
References: <1415599183-3883-1-git-send-email-kda@linux-powerpc.org>
Date: Mon, 10 Nov 2014 10:26:41 -0800
Message-ID: <CAADnVQ+rSDi9rwfXzp-N12tc=+WdvP50WLJCRTJqo+z8nz53jw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] PPC: bpf_jit_comp: add SKF_AD_HATYPE
 instruction
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

On Sun, Nov 9, 2014 at 9:59 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Add BPF extension SKF_AD_HATYPE to ppc JIT to check
> the hw type of the interface
>
> Before:
> [   57.723666] test_bpf: #20 LD_HATYPE
> [   57.723675] BPF filter opcode 0020 (@0) unsupported
> [   57.724168] 48 48 PASS
>
> After:
> [  103.053184] test_bpf: #20 LD_HATYPE 7 6 PASS
>
> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
> CC: Daniel Borkmann<dborkman@redhat.com>
> CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>
> v2: address Alexei's comments
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d110e28..d3fa80d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -361,6 +361,11 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>                                                             protocol));
>                         break;
>                 case BPF_ANC | SKF_AD_IFINDEX:
> +               case BPF_ANC | SKF_AD_HATYPE:
> +                       BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
> +                                               ifindex) != 4);
> +                       BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
> +                                               type) != 2);
>                         PPC_LD_OFFS(r_scratch1, r_skb, offsetof(struct sk_buff,
>                                                                 dev));
>                         PPC_CMPDI(r_scratch1, 0);
> @@ -368,14 +373,18 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
>                                 PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
>                         } else {
>                                 /* Exit, returning 0; first pass hits here. */
> -                               PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
> +                               PPC_BCC_SHORT(COND_NE, ctx->idx * 4 + 12);
>                                 PPC_LI(r_ret, 0);
>                                 PPC_JMP(exit_addr);
>                         }
> -                       BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
> -                                                 ifindex) != 4);
> -                       PPC_LWZ_OFFS(r_A, r_scratch1,
> +                       if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
> +                               PPC_LWZ_OFFS(r_A, r_scratch1,
>                                      offsetof(struct net_device, ifindex));
> +                       } else {
> +                               PPC_LHZ_OFFS(r_A, r_scratch1,
> +                                    offsetof(struct net_device, type));

formatting is a bit off here, but that's minor.
Acked-by: Alexei Starovoitov <ast@plumgrid.com>

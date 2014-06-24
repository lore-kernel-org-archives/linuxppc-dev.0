Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0E891A083D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 01:29:59 +1000 (EST)
Received: by mail-qg0-f50.google.com with SMTP id j5so409780qga.23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 08:29:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
References: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
Date: Tue, 24 Jun 2014 08:29:46 -0700
Message-ID: <CAADnVQJPoy_z-WoqEXnSvTZ-ussCRawn9L5eBfo6S_gxY2MMwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: bpf: Use correct mask while accessing the
 VLAN tag
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 2:59 AM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Use the proper mask which is 0xefff

sob is missing.

also please expand the commit message a bit, otherwise it's too cryptic for
folks who don't know bpf details.

> ---
>  arch/powerpc/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 6dcdade..af0ed4d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -393,7 +393,7 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
>                         PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
>                                                           vlan_tci));
>                         if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
> -                               PPC_ANDI(r_A, r_A, VLAN_VID_MASK);
> +                               PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
>                         else
>                                 PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
>                         break;
> --
> 2.0.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

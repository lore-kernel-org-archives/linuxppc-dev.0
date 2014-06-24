Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F8C01A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 00:23:07 +1000 (EST)
Received: by mail-lb0-f173.google.com with SMTP id s7so551755lbd.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 07:23:03 -0700 (PDT)
Message-ID: <53A989CA.9030405@cogentembedded.com>
Date: Tue, 24 Jun 2014 18:23:06 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: bpf: Fix the broken LD_VLAN_TAG_PRESENT test
References: <1403603969-24436-1-git-send-email-kda@linux-powerpc.org>
 <1403603969-24436-2-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1403603969-24436-2-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 06/24/2014 01:59 PM, Denis Kirjanov wrote:

> We have to return the boolean here if the tag presents
> or not, not jusr ORing the TCI with the mask which results to:

> [  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
> [  709.412245] ret 4096 != 1
> [  709.412332] ret 4096 != 1
> [  709.412333] FAIL (2 times)

    You need to sign off on the patch, else it won't be applied.

> ---
>   arch/powerpc/net/bpf_jit_comp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index af0ed4d..a3d8f58 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -394,8 +394,10 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
>   							  vlan_tci));
>   			if (code == (BPF_ANC | SKF_AD_VLAN_TAG))
>   				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
> -			else
> +			else {

    All arms of the *if* statement should have {} if one branch has {}.

>   				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
> +				PPC_SRWI(r_A, r_A, 12);
> +			}
>   			break;
>   		case BPF_ANC | SKF_AD_QUEUE:
>   			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,

WBR, Sergei

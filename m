Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75725C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F086420823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z66m6nLXzF3LR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 22:29:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iogearbox.net
 (client-ip=213.133.104.62; helo=www62.your-server.de;
 envelope-from=daniel@iogearbox.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iogearbox.net
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z64J2X26zDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 22:26:56 +1100 (AEDT)
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1gOhhX-0008DQ-7g; Mon, 19 Nov 2018 12:26:47 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
 by sslproxy06.your-server.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daniel@iogearbox.net>)
 id 1gOhhX-0005qG-1e; Mon, 19 Nov 2018 12:26:47 +0100
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling
 from VLAN_TCI
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 netdev@vger.kernel.org
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
Date: Mon, 19 Nov 2018 12:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25134/Mon Nov 19 07:16:12 2018)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/10/2018 07:58 PM, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Why you have empty commit messages for non-trivial changes like this in
4 out of 6 of your patches ...

How was it tested on the JITs you were changing? Did you test on both,
big and little endian machines?

> ---
>  net/core/filter.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e521c5ebc7d1..c151b906df53 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -296,22 +296,21 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
>  		break;
>  
>  	case SKF_AD_VLAN_TAG:
> -	case SKF_AD_VLAN_TAG_PRESENT:
>  		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
>  
>  		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
>  		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
>  				      offsetof(struct sk_buff, vlan_tci));
> -		if (skb_field == SKF_AD_VLAN_TAG) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			/* dst_reg >>= 12 */
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
> -			/* dst_reg &= 1 */
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
> +		break;
> +	case SKF_AD_VLAN_TAG_PRESENT:
> +		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
>  			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
> -		}
>  		break;
>  	}
>  
> @@ -6140,19 +6139,22 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  		break;
>  
>  	case offsetof(struct __sk_buff, vlan_present):
> +		*target_size = 1;
> +		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
> +				      PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
> +			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> +		break;
> +
>  	case offsetof(struct __sk_buff, vlan_tci):
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
> -
>  		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  				      bpf_target_off(struct sk_buff, vlan_tci, 2,
>  						     target_size));
> -		if (si->off == offsetof(struct __sk_buff, vlan_tci)) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, 12);
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> -		}
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
>  		break;
>  
>  	case offsetof(struct __sk_buff, cb[0]) ...
> 


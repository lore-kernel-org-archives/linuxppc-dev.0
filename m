Return-Path: <bhutchings@solarflare.com>
Received: from exchange.solarflare.com (exchange.solarflare.com
	[216.237.3.220]) by ozlabs.org (Postfix) with ESMTP id C7058B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 12:10:46 +1000 (EST)
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
From: Ben Hutchings <bhutchings@solarflare.com>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4E04288F.4090201@ozlabs.org>
References: <4E04288F.4090201@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Jun 2011 02:58:34 +0100
Message-ID: <1308967114.3093.1379.camel@localhost>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-24 at 16:02 +1000, Matt Evans wrote:
[...]
> +		case BPF_S_ALU_ADD_K: /* A += K; */
> +			if (!K)
> +				break;
> +			if (K < 32768)
> +				PPC_ADDI(r_A, r_A, K);
> +			else
> +				PPC_ADDI(r_A, r_A, IMM_L(K));
> +				PPC_ADDIS(r_A, r_A, IMM_HA(K));
> +			break;

Missing braces.

> +		case BPF_S_ALU_SUB_X: /* A -= X; */
> +			ctx->seen |= SEEN_XREG;
> +			PPC_SUB(r_A, r_A, r_X);
> +			break;
> +		case BPF_S_ALU_SUB_K: /* A -= K */
> +			if (!K)
> +				break;
> +			if (K < 32768)
> +				PPC_ADDI(r_A, r_A, -K);
> +			else
> +				PPC_ADDI(r_A, r_A, IMM_L(-K));
> +				PPC_ADDIS(r_A, r_A, IMM_HA(-K));
> +			break;
[...]

Here as well.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

Return-Path: <matt@ozlabs.org>
Message-ID: <4E1A967E.50908@ozlabs.org>
Date: Mon, 11 Jul 2011 16:21:50 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
References: <4E04288F.4090201@ozlabs.org>
	<1308967114.3093.1379.camel@localhost>
In-Reply-To: <1308967114.3093.1379.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/06/11 11:58, Ben Hutchings wrote:
> On Fri, 2011-06-24 at 16:02 +1000, Matt Evans wrote:
> [...]
>> +		case BPF_S_ALU_ADD_K: /* A += K; */
>> +			if (!K)
>> +				break;
>> +			if (K < 32768)
>> +				PPC_ADDI(r_A, r_A, K);
>> +			else
>> +				PPC_ADDI(r_A, r_A, IMM_L(K));
>> +				PPC_ADDIS(r_A, r_A, IMM_HA(K));
>> +			break;
> 
> Missing braces.
> 
>> +		case BPF_S_ALU_SUB_X: /* A -= X; */
>> +			ctx->seen |= SEEN_XREG;
>> +			PPC_SUB(r_A, r_A, r_X);
>> +			break;
>> +		case BPF_S_ALU_SUB_K: /* A -= K */
>> +			if (!K)
>> +				break;
>> +			if (K < 32768)
>> +				PPC_ADDI(r_A, r_A, -K);
>> +			else
>> +				PPC_ADDI(r_A, r_A, IMM_L(-K));
>> +				PPC_ADDIS(r_A, r_A, IMM_HA(-K));
>> +			break;
> [...]
> 
> Here as well.

Thanks, Ben -- oops! :)  Really, just the ADDISes need to be conditional, too.


Cheers,


Matt

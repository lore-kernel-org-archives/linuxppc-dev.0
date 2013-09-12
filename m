Return-Path: <matt@ozlabs.org>
Subject: Re: [PATCH] ppc: bpf_jit: support MOD operation
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <1378154750.3978.43.camel@pasglop>
Date: Thu, 12 Sep 2013 02:18:37 +0100
Message-Id: <C1FCF580-0B28-43FA-913B-9790BB76AAB7@ozlabs.org>
References: <1377643792-10327-1-git-send-email-murzin.v@gmail.com>
 <20130902174842.GA1866@hp530> <1378154750.3978.43.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, Vladimir Murzin <murzin.v@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, dborkman@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, Vladimir,


*dusts off very thick PPC cobwebs*  Sorry for the delay as I'm =
travelling, didn't get to this until now.

On 02/09/2013, at 9:45 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2013-09-02 at 19:48 +0200, Vladimir Murzin wrote:
>> Ping
>>=20
>> On Wed, Aug 28, 2013 at 02:49:52AM +0400, Vladimir Murzin wrote:
>>> commit b6069a9570 (filter: add MOD operation) added generic
>>> support for modulus operation in BPF.
>>>=20
> Sorry, nobody got a chance to review that yet. Unfortunately Matt
> doesn't work for us anymore and none of us has experience with the
> BPF code, so somebody (possibly me) will need to spend a bit of time
> figuring it out before verifying that is correct.
>=20
> Do you have a test case/suite by any chance ?
>=20
> Ben.
>=20
>>> This patch brings JIT support for PPC64
>>>=20
>>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>>> ---
>>> arch/powerpc/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
>>> 1 file changed, 22 insertions(+)
>>>=20
>>> diff --git a/arch/powerpc/net/bpf_jit_comp.c =
b/arch/powerpc/net/bpf_jit_comp.c
>>> index bf56e33..96f24dc 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>>> @@ -193,6 +193,28 @@ static int bpf_jit_build_body(struct sk_filter =
*fp, u32 *image,
>>> 				PPC_MUL(r_A, r_A, r_scratch1);
>>> 			}
>>> 			break;
>>> +		case BPF_S_ALU_MOD_X: /* A %=3D X; */
>>> +			ctx->seen |=3D SEEN_XREG;
>>> +			PPC_CMPWI(r_X, 0);
>>> +			if (ctx->pc_ret0 !=3D -1) {
>>> +				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
>>> +			} else {
>>> +				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
>>> +				PPC_LI(r_ret, 0);
>>> +				PPC_JMP(exit_addr);
>>> +			}
>>> +			PPC_DIVWU(r_scratch1, r_A, r_X);
>>> +			PPC_MUL(r_scratch1, r_X, r_scratch1);
>>> +			PPC_SUB(r_A, r_A, r_scratch1);
>>> +			break;

Without having compiled & tested this, it looks fine to me (especially =
with the corrected DIVWU opcode in the other patch, oops...).

>>> +		case BPF_S_ALU_MOD_K: /* A %=3D K; */
>>> +#define r_scratch2 (r_scratch1 + 1)
>>> +			PPC_LI32(r_scratch2, K);
>>> +			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
>>> +			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
>>> +			PPC_SUB(r_A, r_A, r_scratch1);
>>> +#undef r_scratch2
>>> +			break;

If you need another scratch register, it should really be defined in =
bpf_jit.h instead.

Once you define r_scratch2 in there,

Acked-by: Matt Evans <matt@ozlabs.org>


Thanks!


Matt




>>> 		case BPF_S_ALU_DIV_X: /* A /=3D X; */
>>> 			ctx->seen |=3D SEEN_XREG;
>>> 			PPC_CMPWI(r_X, 0);
>>> --=20
>>> 1.8.1.5
>>>=20
>=20

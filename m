Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com
 [IPv6:2a00:1450:4010:c04::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C29E22C0368
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 12:56:49 +1000 (EST)
Received: by mail-lb0-f182.google.com with SMTP id c11so364312lbj.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 19:56:44 -0700 (PDT)
Date: Thu, 12 Sep 2013 04:56:22 +0200
From: Vladimir Murzin <murzin.v@gmail.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH] ppc: bpf_jit: support MOD operation
Message-ID: <20130912025618.GB1869@hp530>
References: <1377643792-10327-1-git-send-email-murzin.v@gmail.com>
 <20130902174842.GA1866@hp530> <1378154750.3978.43.camel@pasglop>
 <C1FCF580-0B28-43FA-913B-9790BB76AAB7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <C1FCF580-0B28-43FA-913B-9790BB76AAB7@ozlabs.org>
Cc: dborkman@redhat.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 12, 2013 at 02:18:37AM +0100, Matt Evans wrote:
> Hi Ben, Vladimir,
> 
> 
> *dusts off very thick PPC cobwebs*  Sorry for the delay as I'm travelling, didn't get to this until now.
> 
> On 02/09/2013, at 9:45 PM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2013-09-02 at 19:48 +0200, Vladimir Murzin wrote:
> >> Ping
> >> 
> >> On Wed, Aug 28, 2013 at 02:49:52AM +0400, Vladimir Murzin wrote:
> >>> commit b6069a9570 (filter: add MOD operation) added generic
> >>> support for modulus operation in BPF.
> >>> 
> > Sorry, nobody got a chance to review that yet. Unfortunately Matt
> > doesn't work for us anymore and none of us has experience with the
> > BPF code, so somebody (possibly me) will need to spend a bit of time
> > figuring it out before verifying that is correct.
> > 
> > Do you have a test case/suite by any chance ?
> > 
> > Ben.
> > 
> >>> This patch brings JIT support for PPC64
> >>> 
> >>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> >>> ---
> >>> arch/powerpc/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
> >>> 1 file changed, 22 insertions(+)
> >>> 
> >>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> >>> index bf56e33..96f24dc 100644
> >>> --- a/arch/powerpc/net/bpf_jit_comp.c
> >>> +++ b/arch/powerpc/net/bpf_jit_comp.c
> >>> @@ -193,6 +193,28 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
> >>> 				PPC_MUL(r_A, r_A, r_scratch1);
> >>> 			}
> >>> 			break;
> >>> +		case BPF_S_ALU_MOD_X: /* A %= X; */
> >>> +			ctx->seen |= SEEN_XREG;
> >>> +			PPC_CMPWI(r_X, 0);
> >>> +			if (ctx->pc_ret0 != -1) {
> >>> +				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
> >>> +			} else {
> >>> +				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
> >>> +				PPC_LI(r_ret, 0);
> >>> +				PPC_JMP(exit_addr);
> >>> +			}
> >>> +			PPC_DIVWU(r_scratch1, r_A, r_X);
> >>> +			PPC_MUL(r_scratch1, r_X, r_scratch1);
> >>> +			PPC_SUB(r_A, r_A, r_scratch1);
> >>> +			break;
> 
> Without having compiled & tested this, it looks fine to me (especially with the corrected DIVWU opcode in the other patch, oops...).
> 
> >>> +		case BPF_S_ALU_MOD_K: /* A %= K; */
> >>> +#define r_scratch2 (r_scratch1 + 1)
> >>> +			PPC_LI32(r_scratch2, K);
> >>> +			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
> >>> +			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
> >>> +			PPC_SUB(r_A, r_A, r_scratch1);
> >>> +#undef r_scratch2
> >>> +			break;
> 
> If you need another scratch register, it should really be defined in bpf_jit.h instead.
> 
> Once you define r_scratch2 in there,
> 
> Acked-by: Matt Evans <matt@ozlabs.org>
> 
> 
> Thanks!
> 
> 
> Matt
> 

Thanks!

Vladimir

> 
> 
> 
> >>> 		case BPF_S_ALU_DIV_X: /* A /= X; */
> >>> 			ctx->seen |= SEEN_XREG;
> >>> 			PPC_CMPWI(r_X, 0);
> >>> -- 
> >>> 1.8.1.5
> >>> 
> > 
> 

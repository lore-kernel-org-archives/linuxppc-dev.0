Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 455F12C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 06:46:04 +1000 (EST)
Message-ID: <1378154750.3978.43.camel@pasglop>
Subject: Re: [PATCH] ppc: bpf_jit: support MOD operation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Date: Tue, 03 Sep 2013 06:45:50 +1000
In-Reply-To: <20130902174842.GA1866@hp530>
References: <1377643792-10327-1-git-send-email-murzin.v@gmail.com>
 <20130902174842.GA1866@hp530>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, dborkman@redhat.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-02 at 19:48 +0200, Vladimir Murzin wrote:
> Ping
> 
> On Wed, Aug 28, 2013 at 02:49:52AM +0400, Vladimir Murzin wrote:
> > commit b6069a9570 (filter: add MOD operation) added generic
> > support for modulus operation in BPF.
> >
Sorry, nobody got a chance to review that yet. Unfortunately Matt
doesn't work for us anymore and none of us has experience with the
BPF code, so somebody (possibly me) will need to spend a bit of time
figuring it out before verifying that is correct.

Do you have a test case/suite by any chance ?

Ben.

> > This patch brings JIT support for PPC64
> > 
> > Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> > ---
> >  arch/powerpc/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index bf56e33..96f24dc 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -193,6 +193,28 @@ static int bpf_jit_build_body(struct sk_filter *fp, u32 *image,
> >  				PPC_MUL(r_A, r_A, r_scratch1);
> >  			}
> >  			break;
> > +		case BPF_S_ALU_MOD_X: /* A %= X; */
> > +			ctx->seen |= SEEN_XREG;
> > +			PPC_CMPWI(r_X, 0);
> > +			if (ctx->pc_ret0 != -1) {
> > +				PPC_BCC(COND_EQ, addrs[ctx->pc_ret0]);
> > +			} else {
> > +				PPC_BCC_SHORT(COND_NE, (ctx->idx*4)+12);
> > +				PPC_LI(r_ret, 0);
> > +				PPC_JMP(exit_addr);
> > +			}
> > +			PPC_DIVWU(r_scratch1, r_A, r_X);
> > +			PPC_MUL(r_scratch1, r_X, r_scratch1);
> > +			PPC_SUB(r_A, r_A, r_scratch1);
> > +			break;
> > +		case BPF_S_ALU_MOD_K: /* A %= K; */
> > +#define r_scratch2 (r_scratch1 + 1)
> > +			PPC_LI32(r_scratch2, K);
> > +			PPC_DIVWU(r_scratch1, r_A, r_scratch2);
> > +			PPC_MUL(r_scratch1, r_scratch2, r_scratch1);
> > +			PPC_SUB(r_A, r_A, r_scratch1);
> > +#undef r_scratch2
> > +			break;
> >  		case BPF_S_ALU_DIV_X: /* A /= X; */
> >  			ctx->seen |= SEEN_XREG;
> >  			PPC_CMPWI(r_X, 0);
> > -- 
> > 1.8.1.5
> > 

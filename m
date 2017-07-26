Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail1v.puc.rediris.es
 (ci-l1mail1v-out05a.puc.rediris.es [IPv6:2001:720:418:ca02::15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHS1M679CzDqmg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 17:49:26 +1000 (AEST)
Date: Wed, 26 Jul 2017 09:49:15 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
Message-ID: <20170726074915.jtjgtv2rw2bsl7al@lt-gp.iram.es>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
 <1500970085.2611.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500970085.2611.3.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 06:08:05PM +1000, Balbir Singh wrote:
> On Tue, 2017-07-25 at 13:33 +1000, Matt Brown wrote:
> > This adds emulation for the prtyw and prtyd instructions.
> > Tested for logical correctness against the prtyw and prtyd instructions
> > on ppc64le.
> > 
> > Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> > ---
> > v3:
> > 	- optimised using the Giles-Miller method of side-ways addition
> > v2:
> > 	- fixed opcodes
> > 	- fixed bitshifting and typecast errors
> > 	- merged do_prtyw and do_prtyd into single function
> > ---
> >  arch/powerpc/lib/sstep.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index 6a79618..0bcf631 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -655,6 +655,25 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
> >  	regs->gpr[ra] = perm;
> >  }
> >  #endif /* __powerpc64__ */
> > +/*
> > + * The size parameter adjusts the equivalent prty instruction.
> > + * prtyw = 32, prtyd = 64
> > + */
> > +static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
> > +				int size, int ra)
> > +{
> > +	unsigned long long res = v;
> > +
> > +	res = (0x0001000100010001 & res) + (0x0001000100010001 & (res >> 8));
> > +	res = (0x0000000700000007 & res) + (0x0000000700000007 & (res >> 16));
> > +	if (size == 32) {		/* prtyw */
> > +		regs->gpr[ra] = (0x0000000100000001 & res);
> > +		return;
> > +	}
> > +
> > +	res = (0x000000000000000f & res) + (0x000000000000000f & (res >> 32));
> > +	regs->gpr[ra] = res & 1;	/*prtyd */
> 
> Looks good, you can also xor instead of adding, but the masks would need
> to change in that case.

Actually, I'd prefer to use xor for this case, since you hardly ever
need any mask, except at the end. Most masks are only needed because of
carry propagation, which the xor completely avoid.

In other words:

	unsigned long long res = v ^ (v >> 8);
	res ^= res >> 16; 
	if (size == 32) {
		regs->gpr[ra] = res & 0x0000000100000001;
		return;
	}
	res ^= res >> 32;
	regs-> gpr[ra] = res & 1;

should work, but I've not even compiled it.

	Gabriel

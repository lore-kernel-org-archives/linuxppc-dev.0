Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c8PF2ftzzF2V4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 19:05:21 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i29-v6so12649621pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 02:05:21 -0700 (PDT)
Date: Thu, 3 May 2018 17:05:15 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/11] KVM: PPC: fix incorrect element_size for stxsiwx
 in analyse_instr
Message-ID: <20180503090515.GF6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-5-git-send-email-wei.guo.simon@gmail.com>
 <20180503055047.GE6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503055047.GE6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:50:47PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:37PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > stwsiwx will place contents of word element 1 of VSR into word
> > storage of EA. So the element size of stwsiwx should be 4.
> > 
> > This patch correct the size from 8 to 4.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  arch/powerpc/lib/sstep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index 34d68f1..151d484 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -2178,7 +2178,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >  		case 140:	/* stxsiwx */
> >  			op->reg = rd | ((instr & 1) << 5);
> >  			op->type = MKOP(STORE_VSX, 0, 4);
> > -			op->element_size = 8;
> > +			op->element_size = 4;
> 
> I made the element_size be 8 deliberately because this way, with
> size=4 but element_size=8, the code will naturally choose the correct
> word (the least-significant word of the left half) of the register to
> store into memory.  With this change you then need the special case in
> a later patch for stxsiwx, which you shouldn't need if you don't make
> this change.
> 
> Paul.

Thanks for point out. I will update accordingly.

Thanks,
- Simon

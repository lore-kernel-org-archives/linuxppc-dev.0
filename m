Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es [130.206.18.9])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5506D1A0DD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 21:41:41 +1100 (AEDT)
Date: Fri, 30 Jan 2015 11:41:26 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
Message-ID: <20150130104126.GB29904@visitor2.iram.es>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 <1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
 <1422578995.10544.138.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>
 <20150130084945.GA27784@visitor2.iram.es>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916DA3@EXCHANGE.collogia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F916DA3@EXCHANGE.collogia.de>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2015 at 09:39:41AM +0000, Markus Stockhausen wrote:
> > Von: Gabriel Paubert [paubert@iram.es]
> > Gesendet: Freitag, 30. Januar 2015 09:49
> > An: Markus Stockhausen
> > Cc: Scott Wood; linuxppc-dev@lists.ozlabs.org; Herbert Xu
> > Betreff: Re: AW: SPE & Interrupt context (was how to make use of SPE instructions)
> >
> > > ...
> > > - I must already save several non-volatile registers. Putting the 64 bit values
> > > into them would require me to save their contents with evstdd instead of
> > > stw. Of course stack alignment to 8 bytes required. So only a few alignment
> > > instructions needed additionally during initialization.
> > 
> > On most PPC ABI the stack is guaranteed to be aligned to a 16 byte
> > boundary. In some it may be only 8, but I can't remember any 4 byte
> > only alignment.
> > 
> > I checked my 32 bit kernel images with:
> > 
> > objdump -d vmlinux |awk '/stwu.*r1,/{print $6,$7}'|sort -u
> > 
> > and the stack seems to always be 16 byte aligned.
> > For 64 bit, use stdu instead of stwu.
> > 
> > I've also found a few stwux/stdux which are hopefully known
> > to be harmless.
> >
> > Gabriel
> 
> A helpful annotation. But now I'm unsure about function usage. SPE seems to be
> 32bit only and I would use their evxxx instructions. Do you think the following
> sequence will be the right way? 
> 
> _GLOBAL(ppc_spe_sha256_transform)
>   stwu            r1,-128(r1);    /* create stack frame           */
>   stw             r24,8(r1);      /* save normal registers        */
>   stw             r25,12(r1);                                       
>   evstdw          r14,16(r1);     /* We must save non volatile    */
>   evstdw          r15,24(r1);    /* registers. Take the chance   */
>   evstdw          r16,32(r12);    /* and save the SPE part too    */ \
>   ...
>   lwz             r24,8(r1);      /* restore normal registers     */ \
>   lwz             r25,12(r1);
>   evldw           r14,16(r12);     /* restore non-v. + SPE registers      */
>   evldw           r15,24(r12);
>   evldw           r16,32(r12);
>   addi            r1,r1,128;      /* cleanup stack frame          */
> 

Yes. But there is also probably a status/control register somewhere that
you might need to save restore, unless it is never used and/or affected by the
instructions you use.

> Or must I use the kernel provided defines with PPC_STLU r1,-INT_FRAME_SIZE(r1) 
> plus SAVE_GPR/SAVE_EVR/REST_GPR/REST_EVR?
> 

>From what I understand INT_FRAME_SIZE is for interrupt entry code. This
is not the case of your code which is a standard function except for
the fact that it clobbers the upper 32 bits of some registers by using
SPE instructions. Therore INT_FRAME_SIZE is overkill. I also believe that
you can save the registers as you suggest, no need to split it into
the high and low part.

By the way, I wonder where the SAVE_EVR/REST_EVR macros are used. I only
see the definitions, no use in a 3.18 source tree.

    Gabriel

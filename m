Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcTqk2tXhzDvtw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 15:09:22 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so9515167pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Dec 2016 20:09:22 -0800 (PST)
Date: Mon, 12 Dec 2016 14:09:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: pseudo-NMI/SMP watchdog
Message-ID: <20161212140904.7a3fe955@roar.ozlabs.ibm.com>
In-Reply-To: <5f861916-f96a-484b-4d34-5253285086bd@gmail.com>
References: <20161209155252.31381-1-npiggin@gmail.com>
 <5f861916-f96a-484b-4d34-5253285086bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 10 Dec 2016 23:24:59 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> > @@ -1295,7 +1295,7 @@ masked_##_H##interrupt:					\
> >  	lis	r10,0x7fff;				\
> >  	ori	r10,r10,0xffff;				\
> >  	mtspr	SPRN_DEC,r10;				\
> > -	b	2f;					\
> > +	b	masked_decrementer_##_H##interrupt;	\
> >  1:	cmpwi	r10,PACA_IRQ_DBELL;			\
> >  	beq	2f;					\
> >  	cmpwi	r10,PACA_IRQ_HMI;			\
> > @@ -1312,6 +1312,16 @@ masked_##_H##interrupt:					\
> >  	##_H##rfid;					\
> >  	b	.
> >  
> > +#define MASKED_NMI(_H)					\
> > +masked_decrementer_##_H##interrupt:			\
> > +	std	r12,PACA_EXGEN+EX_R12(r13);		\
> > +	GET_SCRATCH0(r10);				\
> > +	std	r10,PACA_EXGEN+EX_R13(r13);		\
> > +	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
> > +  
> 
> This bit a little confusing, we are already handling an exception
> do a masked_##_H##interrupt check and we redo the exception prolog?

The soft mask test is done halfway thought EXCEPTION_PROLOG_1, so I think
we have to finish that then continue with PROLOG_PSERIES_1 to get into
"common" code.

That's the main tricky part of the code, so I'll have to go back and
step through the asm and comment better, but it looked about right when
I wrote it (famous last words).

Thanks,
Nick

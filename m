Return-Path: <SRS0=AY7V=64=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4445C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 12:18:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BF3206A5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 12:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BF3206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49N9Yn2LTPzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 22:18:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49N9Tf3V18zDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 22:15:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49N9Td0sKyz9sV9;
 Thu, 14 May 2020 22:15:01 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v8 28/30] powerpc: Support prefixed instructions in
 alignment handler
Date: Thu, 14 May 2020 22:15:00 +1000
Message-ID: <1772537.83GeNkKoO8@townsend>
In-Reply-To: <0bfb8015-44e4-7693-e32e-39b46a87dd3a@csgroup.eu>
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-29-jniethe5@gmail.com>
 <0bfb8015-44e4-7693-e32e-39b46a87dd3a@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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
Cc: christophe.leroy@c-s.fr, Jordan Niethe <jniethe5@gmail.com>,
 npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thursday, 14 May 2020 4:14:12 PM AEST Christophe Leroy wrote:
> Le 06/05/2020 =E0 05:40, Jordan Niethe a =E9crit :
> > If a prefixed instruction results in an alignment exception, the
> > SRR1_PREFIXED bit is set. The handler attempts to emulate the
> > responsible instruction and then increment the NIP past it. Use
> > SRR1_PREFIXED to determine by how much the NIP should be incremented.
> >=20
> > Prefixed instructions are not permitted to cross 64-byte boundaries. If
> > they do the alignment interrupt is invoked with SRR1 BOUNDARY bit set.
> > If this occurs send a SIGBUS to the offending process if in user mode.
> > If in kernel mode call bad_page_fault().
>=20
> Shouldn't this patch go before patch 23 ?

Is there a particular reason you think it needs to go before patch 23? Neit=
her=20
seem particularly related to one another and it seems logical to me at leas=
t=20
that you would introduce prefix support to the datatype prior to using them.

=2D Alistair
=20
> Christophe
>=20
> > Reviewed-by: Alistair Popple <alistair@popple.id.au>
> > Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> > ---
> > v2: - Move __get_user_instr() and __get_user_instr_inatomic() to this
> > commit (previously in "powerpc sstep: Prepare to support prefixed
> > instructions").
> >=20
> >      - Rename sufx to suffix
> >      - Use a macro for calculating instruction length
> >=20
> > v3: Move __get_user_{instr(), instr_inatomic()} up with the other
> > get_user definitions and remove nested if.
> > v4: Rolled into "Add prefixed instructions to instruction data type"
> > v5: Only one definition of inst_length()
> > ---
> >=20
> >   arch/powerpc/kernel/traps.c | 19 ++++++++++++++++++-
> >   1 file changed, 18 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 493a3fa0ac1a..105242cc2f28 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -583,6 +583,8 @@ static inline int check_io_access(struct pt_regs
> > *regs)
> >=20
> >   #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
> >   #define REASON_PRIVILEGED	ESR_PPR
> >   #define REASON_TRAP		ESR_PTR
> >=20
> > +#define REASON_PREFIXED		0
> > +#define REASON_BOUNDARY		0
> >=20
> >   /* single-step stuff */
> >   #define single_stepping(regs)	(current->thread.debug.dbcr0 & DBCR0_IC)
> >=20
> > @@ -597,12 +599,16 @@ static inline int check_io_access(struct pt_regs
> > *regs)>=20
> >   #define REASON_ILLEGAL		SRR1_PROGILL
> >   #define REASON_PRIVILEGED	SRR1_PROGPRIV
> >   #define REASON_TRAP		SRR1_PROGTRAP
> >=20
> > +#define REASON_PREFIXED		SRR1_PREFIXED
> > +#define REASON_BOUNDARY		SRR1_BOUNDARY
> >=20
> >   #define single_stepping(regs)	((regs)->msr & MSR_SE)
> >   #define clear_single_step(regs)	((regs)->msr &=3D ~MSR_SE)
> >   #define clear_br_trace(regs)	((regs)->msr &=3D ~MSR_BE)
> >   #endif
> >=20
> > +#define inst_length(reason)	(((reason) & REASON_PREFIXED) ? 8 : 4)
> > +
> >=20
> >   #if defined(CONFIG_E500)
> >   int machine_check_e500mc(struct pt_regs *regs)
> >   {
> >=20
> > @@ -1593,11 +1599,20 @@ void alignment_exception(struct pt_regs *regs)
> >=20
> >   {
> >  =20
> >   	enum ctx_state prev_state =3D exception_enter();
> >   	int sig, code, fixed =3D 0;
> >=20
> > +	unsigned long  reason;
> >=20
> >   	/* We restore the interrupt state now */
> >   	if (!arch_irq_disabled_regs(regs))
> >   =09
> >   		local_irq_enable();
> >=20
> > +	reason =3D get_reason(regs);
> > +
> > +	if (reason & REASON_BOUNDARY) {
> > +		sig =3D SIGBUS;
> > +		code =3D BUS_ADRALN;
> > +		goto bad;
> > +	}
> > +
> >=20
> >   	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
> >   =09
> >   		goto bail;
> >=20
> > @@ -1606,7 +1621,8 @@ void alignment_exception(struct pt_regs *regs)
> >=20
> >   		fixed =3D fix_alignment(regs);
> >   =09
> >   	if (fixed =3D=3D 1) {
> >=20
> > -		regs->nip +=3D 4;	/* skip over emulated instruction */
> > +		/* skip over emulated instruction */
> > +		regs->nip +=3D inst_length(reason);
> >=20
> >   		emulate_single_step(regs);
> >   		goto bail;
> >   =09
> >   	}
> >=20
> > @@ -1619,6 +1635,7 @@ void alignment_exception(struct pt_regs *regs)
> >=20
> >   		sig =3D SIGBUS;
> >   		code =3D BUS_ADRALN;
> >   =09
> >   	}
> >=20
> > +bad:
> >   	if (user_mode(regs))
> >   =09
> >   		_exception(sig, regs, code, regs->dar);
> >   =09
> >   	else





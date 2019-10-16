Return-Path: <SRS0=QKeg=YJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26DC4360C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 07:51:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BE32082C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 07:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BE32082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46tPcY3jMrzDqnR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 18:51:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46tPZ5150lzDqdd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2019 18:49:00 +1100 (AEDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iKe31-0007jH-2v; Wed, 16 Oct 2019 09:48:43 +0200
Date: Wed, 16 Oct 2019 09:48:43 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 03/34] powerpc: Use CONFIG_PREEMPTION
Message-ID: <20191016074842.6acrlzbmgb5bx4pm@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-4-bigeasy@linutronix.de>
 <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2019-10-16 06:57:48 [+0200], Christophe Leroy wrote:
>=20
>=20
> Le 15/10/2019 =C3=A0 21:17, Sebastian Andrzej Siewior a =C3=A9crit=C2=A0:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >=20
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_R=
T.
> > Both PREEMPT and PREEMPT_RT require the same functionality which today
> > depends on CONFIG_PREEMPT.
> >=20
> > Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
> > output in __die().
>=20
> powerpc doesn't select ARCH_SUPPORTS_RT, so this change is useless as
> CONFIG_PREEMPT_RT cannot be selected.

No it is not. It makes it possible for PowerPC to select it one day and
I have patches for it today. Also, if other ARCH copies code from
PowerPC it will copy the correct thing (as in distinguish between the
flavour PREEMPT and the functionality PREEMPTION).

> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 82f43535e6867..23d2f20be4f2e 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -252,14 +252,19 @@ NOKPROBE_SYMBOL(oops_end);
> >   static int __die(const char *str, struct pt_regs *regs, long err)
> >   {
> > +	const char *pr =3D "";
> > +
>=20
> Please follow the same approach as already existing. Don't add a local var
> for that.

I would leave it to the maintainer to comment on that and decide which
one they want. My eyes find it more readable and the compiles does not
create more code.

> >   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
> > +	if (IS_ENABLED(CONFIG_PREEMPTION))
> > +		pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
> > +
>=20
> drop
>=20
> >   	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s%s%s %s\n",
>=20
> Add one %s
>=20
> >   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
> >   	       PAGE_SIZE / 1024,
> >   	       early_radix_enabled() ? " MMU=3DRadix" : "",
> >   	       early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ? " MMU=3DHash" : "=
",
> > -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
>=20
> Replace by: 	IS_ENABLED(CONFIG_PREEMPTION) ? " PREEMPT" : ""
>=20
> > +	       pr,
>=20
> add something like: IS_ENABLED(CONFIG_PREEMPT_RT) ? "_RT" : ""

this on the other hand will create more code which is not strictly
required.

> >   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
> >   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS))=
 : "",
> >   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> >=20
>=20
> Christophe

Sebastian

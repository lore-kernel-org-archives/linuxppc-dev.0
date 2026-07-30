Return-Path: <linuxppc-dev+bounces-25072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72737C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:39:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fgT1FXXz2yDs;
	Thu, 30 Jul 2026 16:39:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785393557;
	cv=none; b=U/oNYMgEmgeBouDPJtLrz5pgAjUuKNy24vh+C0Dw38hVtiUcWHdvGY0McieIUgHGSFDUzr5roiR6y8evkR1LdiYdR0nRl1ahO1h3whwLKSSkaLSePiGAzUxSUa4UPiyIChvORUKu9f5D2Vc4XiVDKzaDpxlOJSZTU3q3DN9v2wSQmPUq9L/NXxLYsxHHDmJ5JokQ00UzlpsbBN20P0gX9rdaLvh4hYgjn7P4ZqNjRaNXPyqrWkTpc+29kNGrr0XfcKnpQHLMVNsk5q6mWMIQdU3D82cZknODQg5Qf6cEdy2wAjbZSSAQruISC3vvZJffZ9NF+U2dQpaLGrMDZyymlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785393557; c=relaxed/relaxed;
	bh=v8Ab0rqKkisiC1FuGdQjdY7HUVMn6t7PyOtF9gib960=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA8RY19OQGm7xI40F4luIcKo+EXJzABwek1FCYnAzT/0PvhIeVVOb/UQFDZpZjC/7AIZ3t7dlUsT8WDqM1BWZaguYyeYKpqUI5weCSxKP3dtSejGbbltUuTLz6sS3ftpCvcnxkyhys8Zp2DdR8FEevdt3qZ0TiAzc1Qf5sxZ4JLfdwHmP5u9PpVzQOwyUw2QyIz1idDfrKyErYbTmMJRAFMoIvoDLYjsqOXySi5hiycHUkAJxsOZzmc3pUJXZHO+dvseok1KY+Y6DMB+8z1bF+HxC9HdL+2i7GJ/n6Jx0SaZhqkiew7XSlIk1UhITq+m5lhy+7HmnNgiS3tCEbXo5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fgS3QQGz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:39:16 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 8C8D7709934A; Thu, 30 Jul 2026 08:39:13 +0200 (CEST)
Date: Thu, 30 Jul 2026 08:39:13 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/sstep: =?utf-8?Q?D?=
 =?utf-8?Q?on=E2=80=99t_define_variables_we_won=E2=80=99t?= be using
Message-ID: <amrxka_ZBaclQtZL@desktop>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
 <20260729204958.755143-3-linkmauve@linkmauve.fr>
 <c48b748a-67d9-4fd4-b516-c54d2cf70704@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c48b748a-67d9-4fd4-b516-c54d2cf70704@kernel.org>
Jabber-ID: linkmauve@linkmauve.fr

On Thu, Jul 30, 2026 at 08:24:36AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 29/07/2026 à 22:49, Link Mauve a écrit :
> > It seems this function has only compiled without warnings on PPC64, not
> > on PowerPC, so before this commit it would fail with:
> > ```
> > ../arch/powerpc/lib/sstep.c: In function 'analyse_instr':
> > ../arch/powerpc/lib/sstep.c:1350:28: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
> >   1350 |         unsigned int word, suffix;
> >        |                            ^~~~~~
> > ../arch/powerpc/lib/sstep.c:1346:38: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
> >   1346 |         unsigned int opcode, ra, rb, rc, rd, spr, u;
> >        |                                      ^~
> > cc1: all warnings being treated as errors
> > ```
> > 
> 
> I'm surprised we still have this issue. I remember seeing it reported
> several times allthough I've not been able to spot when.
> 
> By the way on my side it happens only when I do a W=1 build.

Oh indeed, I was using W=1 all along, thanks for spotting that!

> 
> Same as previous patch, I'd prefer using CONFIG_PPC64 instead of
> __powerpc64__

Will do in v2.

> 
> > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > ---
> >   arch/powerpc/lib/sstep.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index 597a0d841fe8..c866e4337f94 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -1342,16 +1342,20 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >   {
> >   #ifdef __powerpc64__
> >   	unsigned int suffixopcode, prefixtype, prefix_r;
> > +	unsigned int rc;
> > +	unsigned int suffix;
> 
> A single line would be enough:

Will do in v2.

> 
> 	unsigned int rc, suffix;
> 
> >   #endif
> > -	unsigned int opcode, ra, rb, rc, rd, spr, u;
> > +	unsigned int opcode, ra, rb, rd, spr, u;
> >   	unsigned long int imm;
> >   	unsigned long int val, val2;
> >   	unsigned int mb, me, sh;
> > -	unsigned int word, suffix;
> > +	unsigned int word;
> >   	long ival;
> >   	word = ppc_inst_val(instr);
> > +#ifdef __powerpc64__
> >   	suffix = ppc_inst_suffix(instr);
> > +#endif
> >   	op->type = COMPUTE;
> > @@ -1469,7 +1473,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >   	rd = (word >> 21) & 0x1f;
> >   	ra = (word >> 16) & 0x1f;
> >   	rb = (word >> 11) & 0x1f;
> > +#ifdef __powerpc64__
> >   	rc = (word >> 6) & 0x1f;
> > +#endif
> >   	switch (opcode) {
> >   #ifdef __powerpc64__
> 

-- 
Link Mauve


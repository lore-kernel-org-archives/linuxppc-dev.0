Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3175606A89D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPNVH0AX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRbl2rT0z2xqJ;
	Wed, 18 Nov 2026 01:16:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794924963;
	cv=none; b=aHC1IyMPxAHsLZPEx3jMAZs8v1K87vNYr5V3C7TqgYJ/3jEvrDJ4OK5u40Paw9B6UbbKTR9a13Bn/44xVEXf8E+y1xzcgSrVC1hHWdFhhvijg6yaolmKSxqdwZtJKNdRD3L2gdhbj86ZkFNoqdDZXtxkolhmfsNJk7LnsWFs7LuTtPlKB6wSWGg8BJVDby3T2T/7SHhYeJkA7BFHod23Z2362tVnGpfQlPkjll2AAe7xcniZl8Va/YBadaW65yA/CO4Pifp62FHTDi47iA8y2bhh+B55pfUIWmAUX21UQ+OsgpUk1du3gILjl3hjiaz9CEZg1qYOpHi7QwqR79d5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794924963; c=relaxed/relaxed;
	bh=aeDxw0dSGGlnGghiVGMTuuktj73iHEfNfkBG2eV9bYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB4Sd+tqT31YtNxIWx60TftpsyIfo3jHPblZGcBoXVF5bYhUEUAWC8Rw3k9JV978V7nlFPUvKS/OejJmqgXUSNlPoTGxrZRjrrVYqBowcJ0X+pbMYRfu8Nr888cG1dtJdH0/8jZqZO3jegPdBtZxUS1vNOe/Cjw4ZX9PP+h2YbXONRRO9D88WNvCCAsrgY/gRAszaPBily25oJ364T3CMEYTn2KDu88rrrMpXQacycpFKtPXzMd8F9JT6RZBv6QztmRhzxWw574MHUvDm2R5bmEECodVL3mOI4lH9c1R0NFw1bG8puLWqRBoRQNW1Py27nnWED2vZX8MSYa8/vqhYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPNVH0AX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPNVH0AX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRbk426Lz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:16:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 87D6761178;
	Tue, 17 Nov 2026 14:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EA61F000C5;
	Tue, 17 Nov 2026 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924960;
	bh=aeDxw0dSGGlnGghiVGMTuuktj73iHEfNfkBG2eV9bYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPNVH0AXpNFa0FHwdRr6Z7/4yi5gjZRgwUrjrosl+dKdjTIuQg8SU4HEEHC2gyMOX
	 yENh+gcRkrWW+s4t2i7YuO3yqtgPtES/VilTxpkAyhqaTjBuw9XwLFN6greIaGdFm4
	 eM51fX/Ohbr+Z3ZgEyLA5AUMH9ccjukPUPSOC/rw9pdMH7TgsLalCLKE++WXAbPpNJ
	 X5SEvuZxWXxjyT6V4ZzxRpd3Sk6lPR1PFIAVEk5Ddo/oMbbiO0UdJKBruAQMgguiIB
	 zcmjsC7jTfLIYciA/tWXFzhphB8cK712SNihWdpWjePgRx9zMqC7GzyFbnFGjlKrRS
	 fuBnc5E31Y4EQ==
Date: Tue, 17 Nov 2026 16:15:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from
 the modules area on book3s/32
Message-ID: <avxhmaXa7lsQ86EA@kernel.org>
References: <cover.1794572365.git.ritesh.list@gmail.com>
 <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com>
 <avltdwzlh07VZSFC@kernel.org>
 <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org>
 <avsn7Kn4a8wbB2QH@kernel.org>
 <zev77i3i.ritesh.list@gmail.com>
 <eb634d1f-cb08-44a8-88c9-e3b559c399a3@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb634d1f-cb08-44a8-88c9-e3b559c399a3@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:04:49PM +0100, Christophe Leroy (CS GROUP) wrote:
> Le 17/11/2026 à 13:33, Ritesh Harjani a écrit :
> > Mike Rapoport <rppt@kernel.org> writes:
> > 
> > > > > > Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
> > > > > Right, I missed that on book3s/32 does vmalloc is not executable and its
> > > > > protection can't be changed.
> > > > > 
> > > > > Could it be that 8xx also need a special treatment for kprobes?
> > > > 
> > > > Yes indeed, not for the same reasons but because 8xx ITLB-miss handler
> > > > doesn't expect any instruction TLB miss on kernel addresses other than the
> > > > ones from the module area:
> > > > 
> > > > Commit 4afb0be7ccda ("powerpc/8xx: Avoid testing for kernel space in ITLB
> > > > Miss.")
> > > > Commit 16a71c045186 ("powerpc/8xx: Preallocate execmem page tables")
> > > > Commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in ITLB
> > > > misses")
> > 
> > Right. I looked at the above series which added all of this support [1].
> > So looks like 603 might also have this related problem (other than the
> > per segment N bit issue), since it's iTLB miss handler only walks the
> > task's PGDIR, unlike it's dTLB handler which falls back to reloading the
> > missing kernel PGD entry from swapper_pg_dir. So what I meant to say is
> > that, similar to 8xx, a new PGD entry created in the kernel's vmalloc
> > area for an insn page does not get copied over after the task is
> > created (/PGDIR allocated), on 603 as well.
> > But since MODLUES_VADDR is defined for both BOOK3S/32 and 8xx, so I guess it
> > gets covered by the same change anyways.
> > 
> > > > So at the end as MODULES_VADDR/MODULES_END only exist on book3s/32 and 8xx I
> > > > think when they exist they should be used as follows:
> > > > 
> > > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > > > index b617b69452cd..856f4609c488 100644
> > > > --- a/arch/powerpc/mm/mem.c
> > > > +++ b/arch/powerpc/mm/mem.c
> > > > @@ -428,8 +428,13 @@ struct execmem_info __init *execmem_arch_setup(void)
> > > >   				.fallback_end	= fallback_end,
> > > >   			},
> > > >   			[EXECMEM_KPROBES] = {
> > > > +#ifdef MODULES_VADDR
> > > > +				.start	= MODULES_VADDR,
> > > > +				.end	= MODULES_END,
> > > > +#else
> > > >   				.start	= VMALLOC_START,
> > > >   				.end	= VMALLOC_END,
> > > > +#endif
> > > 
> > > We already have #ifdef MODULES_VADDR a few lines above, I think the
> > > assignment of kprobes_start and kprobes_end could go there instead of if
> > > (IS_ENABLED(CONFIG_PPC_BOOK3S_32)).
> > > 
> > 
> > Right. So let me use the following diff then?
> > 
> > Please let me know if this diff looks good to you? If yes, then I can
> > send a v3.
> 
> My preference would go to something similar to 'start' and 'end', no init at
> declaration, kprobes_start and kprobes_end set to VMALLOC_START/VMALLOC_END
> inside the #else

I agree, it's more consistent this way.
 
> > Also - it will be good to know if patch-1 and patch-3 looks ok too,
> > before I spin a next revision?

Both make sense to me, feel free to add my

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


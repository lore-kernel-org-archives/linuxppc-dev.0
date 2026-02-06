Return-Path: <linuxppc-dev+bounces-16694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640BEE20B9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:12:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f70yq3cjtz2xqk;
	Sat, 07 Feb 2026 04:12:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770397971;
	cv=none; b=C49LUzrYLX0fXOR6xClwRKkW5QV5KlU86LJjJNVwWgg1sIBMdtpxf0x9WwfZz7bkUO+kD9yq5EulGf1i/6ON51sMqy4HAmObPd5GZyw008vVp384yIcDmxLyaEvJjbX6OjuLSCglbfQDLEAOTJ5jVR/zznXwYKvXbQ661+aHZTYAIWoWqZJ6FHbQf6d0X8ly2C9MIu1w6yp0e5Lv+2NL/94gBfUO0lZPonhVVRJVu0/jcOKQOnT0WIysBof5eBh8Ij8NaC6A1HWc7XSaLc5NMemSM6KPK9DSi45jb45O7XrIw0fokficyE7YN3on3fcc2F6PZ7nIKY55BsFni1Ha9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770397971; c=relaxed/relaxed;
	bh=t8ZnY4n2/jlef09Nr4Oq3A5dqrIGBbSlZfyNPxj7ahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WavLULepqxoXN2yBH0Yr00MAMGFxTDH8Ubwwf76isiHQPF9/6uJife1qkWqnVezj+eKoiQw92n6DikhbstJ0tFVdUquTmu4GSatGerqGc9wrpXhGSH+JAF/YjyhH3GgkJ5kH7zITiikA6eKaxcPu2HWBC0u1MwlAT16jkfp9r8TYbFT7qdzz/onwny7tOmzbFck3T+e27RNJN23amIdYGPSawyKMHyU8kkR4y5YmXEyhhIpYRFLpNtsNK5JFcFH9arSchE+pCwobWhHxlkdF9/PhmhEq3336tPGgYW0w/+DnrhMatXnrcNoSvDKShMkhBNGzGpNwN+svd01c8AKx2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CMP7LNGl; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CMP7LNGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f70yp0s36z2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 04:12:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D3D5F60010;
	Fri,  6 Feb 2026 17:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF7C116C6;
	Fri,  6 Feb 2026 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770397967;
	bh=f51fr0RwPbgcilaL5p8ILUT8dwBt1G9K1Ep4iTQCoSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMP7LNGlV4Z5pl65Rd7unzogYBQIDSiH0zCtfTSI/EDUAvkpSMrd4HnjKZU17g/CD
	 BZXra/le1xACKpyF9UI9qrbi98RA1m2+XnuqbCNSbZXoiR7HHqcDRQ4sqLwoGcWIFt
	 Q0gGqwzFR96kUU/DPD+4x32K3EsCiCXwubYEJFJR671ERQ2Ep2XKeGvPhGyLcWKjSv
	 fw7+ENfiFAwGhG3sv9DyBKyBpOyMbc9ayAtcqhr+o75aqwj4Q4grNrv/gDBhW/g8Cd
	 JbLHFv4Zl7PQ8Ml8t4YQFXh/glEDKdROiw6yzoC0OnYLcSsCEqQjmFDxwsLqcxA46k
	 0vV8F35qk4E1A==
Date: Fri, 6 Feb 2026 18:12:37 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <aYYhBe9hZsIW8LXP@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
 <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>
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
In-Reply-To: <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>

On Tue, Feb 03, 2026 at 01:55:05PM +0100, Thomas Weißschuh wrote:
> On 2026-01-30 18:06:20+0100, Petr Pavlu wrote:
> > On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > > Normally the .ko module files depend on a fully built vmlinux to be
> > > available for modpost validation and BTF generation. With
> > > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > > to build a merkle tree. This introduces a dependency cycle which is
> > > impossible to satisfy. Work around this by building the modules during
> > > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > > but before the final module hashes are
> > 
> > I wonder if this dependency cycle could be resolved by utilizing the
> > split into vmlinux.unstripped and vmlinux that occurred last year.
> > 
> > The idea is to create the following ordering: vmlinux.unstripped ->
> > modules -> vmlinux, and to patch in .module_hashes only when building
> > the final vmlinux.
> > 
> > This would require the following:
> > * Split scripts/Makefile.vmlinux into two Makefiles, one that builds the
> >   current vmlinux.unstripped and the second one that builds the final
> >   vmlinux from it.
> > * Modify the top Makefile to recognize vmlinux.unstripped and update the
> >   BTF generation rule 'modules: vmlinux' to
> >   'modules: vmlinux.unstripped'.
> > * Add the 'vmlinux: modules' ordering in the top Makefile for
> >   CONFIG_MODULE_HASHES=y.
> > * Remove the patching of vmlinux.unstripped in scripts/link-vmlinux.sh
> >   and instead move it into scripts/Makefile.vmlinux when running objcopy
> >   to produce the final vmlinux.
> > 
> > I think this approach has two main advantages:
> > * CONFIG_MODULE_HASHES can be made orthogonal to
> >   CONFIG_DEBUG_INFO_BTF_MODULES.
> > * All dependencies are expressed at the Makefile level instead of having
> >   scripts/link-vmlinux.sh invoke 'make -f Makefile modules'.
> > 
> > Below is a rough prototype that applies on top of this series. It is a
> > bit verbose due to the splitting of part of scripts/Makefile.vmlinux
> > into scripts/Makefile.vmlinux_unstripped.
> 
> That looks like a feasible alternative. Before adopting it, I'd like to
> hear the preference of the kbuild folks.

After the first run-through, the proposed alternative sounds good.
Unfortunately, I ran out of time for this week.  I can give a more
founded reply in a few days.

Kind regards,
Nicolas



> > diff --git a/Makefile b/Makefile
> > index 841772a5a260..19a3beb82fa7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1259,7 +1259,7 @@ vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
> >  vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
> >  	@:
> >  
> > -PHONY += vmlinux
> > +PHONY += vmlinux.unstripped vmlinux
> >  # LDFLAGS_vmlinux in the top Makefile defines linker flags for the top vmlinux,
> >  # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
> >  # unrelated; the decompressors just happen to have the same base name,
> > @@ -1270,9 +1270,11 @@ PHONY += vmlinux
> >  #   https://savannah.gnu.org/bugs/?61463
> >  # For Make > 4.4, the following simple code will work:
> >  #  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > -vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > -vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> > -vmlinux: vmlinux.o $(KBUILD_LDS) modpost
> > +vmlinux.unstripped: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > +vmlinux.unstripped: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> > +vmlinux.unstripped: vmlinux.o $(KBUILD_LDS) modpost
> > +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_unstripped
> > +vmlinux: vmlinux.unstripped
> >  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
> 
> Maybe we could keep them together in a single Makefile,
> and instead have different targets in it.
> 
> (...)
> 
> > @@ -98,70 +44,15 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
> >  # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
> >  # it is necessary to remove the PT_LOAD flag from the segment.
> >  quiet_cmd_strip_relocs = OBJCOPY $@
> > -      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> > -                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
> > +      cmd_script_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> > +                          $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) \
> > +                                     $(remove-symbols) \
> > +                                     $(patch-module-hashes) $@
> 
> cmd_script_relocs -> cmd_strip_relocs
> 
> (...)

-- 
Nicolas


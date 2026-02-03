Return-Path: <linuxppc-dev+bounces-16551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBD1E87823
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 12:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f53Nw1BhSz30Sv;
	Tue, 03 Feb 2026 23:55:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770123312;
	cv=none; b=gIvNjHGOTVmmqZYf6UnWUzwTzti8CCQUSv/9K+p0DqWMGfS2qEnjXvdHg7jKnU0HZL7NMAJ6SRfSERopMvOjTkAyifdfSlEQ/19mKIBaGNPLm3zPTBQutp5UAz1oT6mz1U469vb1ZlVHa4i9JNX1KWR1nOsztvtXVVv0nr8u7i/DvFHGMvf58HldnViA7YuAHPMqmgWZCswX28O51DlZultEUrzYQKlZ5LzfhK5wOmShkkUh7KlWZIE6ZaR5EYBKXAb3nvdCUZ0QpOrc3sqHaJ1okeQDbMdbDTEeBXbkwi7TdLUwLSstP9GG05zlkC04bY+UZniybLYx3nyV3/hlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770123312; c=relaxed/relaxed;
	bh=E93W2ZAWN8xztkgJntTMF6qnkjimr9jSfXNob207+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+kjcCN5jUmY8vg81VJKWM78MHZiWmC7LcitPIjJgGHkfpRblGfRr8Zh21JSLkUqPEwRPxXL9+Gc4naS+IXCHqNc7QoY+5vDTvTOwIWZtW3UbkwQQtTf0mTI5lp3oKyl3l0vQ2ktH6a8BaZckEAgpwQ8tMQ7Lz2B2EunwJPuTI3/tUo+qJ63qHZNyloAp0srVDE1iF8FfNEudapby58QTU/k/4s9a8Kr6RewLrQjzbjvueVYeCxA9e50ias5ukQubHWDft8e28b2RTwI0tPGme0FB7RQsVJTHZIKNfXkTbp4AQXZaafLUqqLkLdOoonQj9ouwAKs1IavJo7PjI5J4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=h3fezYnN; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=h3fezYnN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f53Nt3WmHz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 23:55:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770123305;
	bh=8c+Pqi8S29ccrlKn7/Q5mxLVtC9FrsWFxplmCU6dgEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3fezYnNYnXEKvq604yd2NerVugru+NdBANWM+DWnwaWb5ItwAC0VUZhIl5YUjCms
	 ygiVLrxrPvbovp2BJqy+bNMcWSa/VW1lTBYim8VFtMaE6qk2X2Xo1Ey0C4zQ14Aokc
	 Wog6ncF8YdRMXZU8PXR10lrOsiZ6bohkkWQdQQIY=
Date: Tue, 3 Feb 2026 13:55:05 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>

On 2026-01-30 18:06:20+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > Normally the .ko module files depend on a fully built vmlinux to be
> > available for modpost validation and BTF generation. With
> > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > to build a merkle tree. This introduces a dependency cycle which is
> > impossible to satisfy. Work around this by building the modules during
> > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > but before the final module hashes are
> 
> I wonder if this dependency cycle could be resolved by utilizing the
> split into vmlinux.unstripped and vmlinux that occurred last year.
> 
> The idea is to create the following ordering: vmlinux.unstripped ->
> modules -> vmlinux, and to patch in .module_hashes only when building
> the final vmlinux.
> 
> This would require the following:
> * Split scripts/Makefile.vmlinux into two Makefiles, one that builds the
>   current vmlinux.unstripped and the second one that builds the final
>   vmlinux from it.
> * Modify the top Makefile to recognize vmlinux.unstripped and update the
>   BTF generation rule 'modules: vmlinux' to
>   'modules: vmlinux.unstripped'.
> * Add the 'vmlinux: modules' ordering in the top Makefile for
>   CONFIG_MODULE_HASHES=y.
> * Remove the patching of vmlinux.unstripped in scripts/link-vmlinux.sh
>   and instead move it into scripts/Makefile.vmlinux when running objcopy
>   to produce the final vmlinux.
> 
> I think this approach has two main advantages:
> * CONFIG_MODULE_HASHES can be made orthogonal to
>   CONFIG_DEBUG_INFO_BTF_MODULES.
> * All dependencies are expressed at the Makefile level instead of having
>   scripts/link-vmlinux.sh invoke 'make -f Makefile modules'.
> 
> Below is a rough prototype that applies on top of this series. It is a
> bit verbose due to the splitting of part of scripts/Makefile.vmlinux
> into scripts/Makefile.vmlinux_unstripped.

That looks like a feasible alternative. Before adopting it, I'd like to
hear the preference of the kbuild folks.

> diff --git a/Makefile b/Makefile
> index 841772a5a260..19a3beb82fa7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1259,7 +1259,7 @@ vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
>  vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
>  	@:
>  
> -PHONY += vmlinux
> +PHONY += vmlinux.unstripped vmlinux
>  # LDFLAGS_vmlinux in the top Makefile defines linker flags for the top vmlinux,
>  # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
>  # unrelated; the decompressors just happen to have the same base name,
> @@ -1270,9 +1270,11 @@ PHONY += vmlinux
>  #   https://savannah.gnu.org/bugs/?61463
>  # For Make > 4.4, the following simple code will work:
>  #  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> -vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> -vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> -vmlinux: vmlinux.o $(KBUILD_LDS) modpost
> +vmlinux.unstripped: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> +vmlinux.unstripped: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> +vmlinux.unstripped: vmlinux.o $(KBUILD_LDS) modpost
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_unstripped
> +vmlinux: vmlinux.unstripped
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux

Maybe we could keep them together in a single Makefile,
and instead have different targets in it.

(...)

> @@ -98,70 +44,15 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
>  # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
>  # it is necessary to remove the PT_LOAD flag from the segment.
>  quiet_cmd_strip_relocs = OBJCOPY $@
> -      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> -                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
> +      cmd_script_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> +                          $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) \
> +                                     $(remove-symbols) \
> +                                     $(patch-module-hashes) $@

cmd_script_relocs -> cmd_strip_relocs

(...)


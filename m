Return-Path: <linuxppc-dev+bounces-17982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED201EB105F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 21:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVnHx1mCcz2xQB;
	Wed, 11 Mar 2026 08:36:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773178573;
	cv=none; b=aIM8IhnAd6ivUKwSAwPVMxtBqM7ACRxawYXColIUDCiicw1DvYylcxm4316htZnAWdE3uudCnQdWZA6xM572SDMw+n+0MGHZrV/rQRpjDmmNvIvRZGxsxk44nFNuX0cpjWfhJyT7z9DEaQ6jfPbZw638lynY8FOoJInpPqnp3I5f9hRVHVhdeM7Qs8Y+MO9zjUxdE0YOKDOmRaPagIrfbNXwqFYfWI0V7H3i4qPnl0zem/T4Bc8XLmk2ytLJrhrhQDv2qxxLRG1Gamq/UXFGyP+653oHsZh0kdbiX2XBfQfopRHjsYN01o7ATBUrF3o9q1qjeGhDKTQVrMvtfH426A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773178573; c=relaxed/relaxed;
	bh=1XZnaA0ahK98csDIg3Z9JryfyR9t4r5XlH2CXzZDt1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOb986GCOj6dhgsnQGHEBlXl6vijQySUuUszvWXqm/pf/VxF7PTzdJGJ8fkigOISKi8kwypCJuibqdzlKW/1FKN95vqEfhJ80Zomf+jnMz43lueXUdjJo7IHgsShfCyPFG1IkRn2UwBxgWvOm/yKCXnSN8BnUSrzXFsA62UN0vJKDQNaEZttSboSj5gXGNJyMtnLX9AybovmaVTLsJ4wW2XCaxUTOLUGLd2PT37BFoHhvtBnQZaoRupaezEfGRu+VZyDuBx3muFcvYqo26zGqLoHOQ3shRnqs7JgFF1QpXDuVIPRGbgsfISS0aTx8DzJCjTAy7GPOSgnXBHvvdxBGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rFsrzVKi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rFsrzVKi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVnHw14cMz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:36:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EBDA16012A;
	Tue, 10 Mar 2026 21:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47922C19423;
	Tue, 10 Mar 2026 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773178569;
	bh=Xg4CGBK3u8/ArgMip1X0dYT6v82ryRISxkCSzREkPSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFsrzVKiD8VQjeGuN+nEd00lZPd0I4jL+qZRfGtN3x1gIsiu+MJ8jFnr83Y+560yY
	 SpEl2asG9qxhQgwS/T+7OdXOjJP4Uie/qk7vLBGXJ0YEdOMD+VtIK3iVBP5xb5t+sR
	 AWlWnw+zk3tSDoW3EImfYu5Du8Uy4F2++O1V2FGVqKKSjV9YKUWJsj37oEu5TaaYv0
	 h0LIbjKFNgwn0zf9efYj16MNz7kz27oGqtw+c1YEGZVjJ1TxHDJwF3v+Gs1h4mihps
	 jFoLf8wbuiKkjVBnQqE0JrNES33AIWTX6ZkcyETw1CBNFaoCmmu6oY8B5yjWBz8zag
	 9wnK1qInBajjw==
Date: Tue, 10 Mar 2026 14:36:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
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
Subject: Re: [PATCH v4 06/17] kbuild: add stamp file for vmlinux BTF data
Message-ID: <20260310213606.GD120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:50PM +0100, Thomas Weiﬂschuh wrote:
> The upcoming module hashes functionality will build the modules in
> between the generation of the BTF data and the final link of vmlinux.
> Having a dependency from the modules on vmlinux would make this
> impossible as it would mean having a cyclic dependency.
> Break this cyclic dependency by introducing a new target.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.modfinal | 4 ++--
>  scripts/link-vmlinux.sh   | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 149e12ff5700..adfef1e002a9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -56,8 +56,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>  	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>  
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/.tmp_vmlinux_btf.stamp) FORCE
> +	+$(call if_changed_except,ld_ko_o,$(objtree)/.tmp_vmlinux_btf.stamp)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 4ab44c73da4d..8c98f8645a5c 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -111,6 +111,7 @@ vmlinux_link()
>  gen_btf()
>  {
>  	local btf_data=${1}.btf.o
> +	local btf_stamp=.tmp_vmlinux_btf.stamp
>  
>  	info BTF "${btf_data}"
>  	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> @@ -131,6 +132,11 @@ gen_btf()
>  	fi
>  	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
>  
> +	info STAMP $btf_stamp
> +	if ! cmp --silent $btf_data $btf_stamp; then
> +		cp $btf_data $btf_stamp
> +	fi

A "stamp file" is traditionally an empty file that is written when some
build step has completed.  The above code is instead copying the entire
.tmp_vmlinux1.btf.o file (megabytes in size) to .tmp_vmlinux_btf.stamp.

So, it's not clear to me why the stamp file is needed at all, versus
depending directly on .tmp_vmlinux1.btf.o.

I guess 'make' doesn't know about the dependencies of
.tmp_vmlinux1.btf.o.  But the same is true of the stamp file, right?  So
either way, how would 'make' know to finish rebuilding the file before
starting to execute the "Re-generate module BTFs" rule?

Also, passing the long option '--silent' to 'cmp' creates a dependency
on the GNU implementation of 'cmp', which isn't documented as a kernel
build dependency.  Probably better to use the short option '-s'.

Also, the stamp file isn't being deleted by 'make clean'.  It looks like
it would need to be added to cleanup() in link-vmlinux.sh.

- Eric


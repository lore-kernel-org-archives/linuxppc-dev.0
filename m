Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E4606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYrZDzw1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZWrw3MFLz2xwP;
	Thu, 26 Nov 2026 07:45:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795639504;
	cv=none; b=mozMuLbvp8tWmFy7wfv7gs1V+vN0/OhJv25Gk/H64yIEMoV7DpcfinCQ6JkQt1tFgORLlhLj81K4dzu6a99RdeH2vvx1oE8m+ggsRmsGyY9OnCJwF4nCqehHGX8dX8rEs9TVgvCNguHlAJxX3hSS4JqIvT3BNj9Tv1AHRNktzvaFuqP8DZDGSFns8St8vH32/2P0XvhIRXsiKjO7FwSpGOMOhroesaxsCWwVDfPSwUUfuXOa4SQ9wqH2OiS42qhsSoVC3x+Yk6MUQIXeL7nZvQ9qNLSvF70VX/LwpCf/QqaJsT8HbZ5U3zLKWrCMeUHvTcxJfFoFwTvLRgvCEKvf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795639504; c=relaxed/relaxed;
	bh=Vue2jOZ1khdcISxHu/EhJAQ6nZxM803LHVIcey8TaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHtCdzi1LFGadjvAqXvqa+2DLwQXL1r0VbDp+kRRfjDnZOeC9XgNh/pqq9Oszn+2FeAzHOBP8VR1sMP9ZIYRA9Z3WSzSl94P4kNgrUdt8l2/+vR6AlGL2Nba0a7x17pUi8nbf2crUS5akYo/yYfhRRuvE0ltIgnvB2Ka3lBlB7RYu3X6ElqOQ2jPrefDE6CSjp48sCQ1jhoM8+S2xvrzB7VSldCmNqSJZv/jWdaHflUi1R3ZbPRHMuxEkAiEsrPzcciGVCIj3b2a5wvzVrNgRE5RUCGRXlFqzrWn0ssJFWLFvrFzSQ+v9EBcRT4OsZA/5RX4oWDKbvqcVY+jE5WFvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYrZDzw1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYrZDzw1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZWrv167gz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 07:45:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 585F745F10;
	Wed, 25 Nov 2026 20:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1378C1F000C4;
	Wed, 25 Nov 2026 20:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639500;
	bh=Vue2jOZ1khdcISxHu/EhJAQ6nZxM803LHVIcey8TaJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYrZDzw1Svtl+8sgjl/5MB/bZPKRYGIMwLvJqrXPnugEnMpS6IXVW7+dzSyrvpQPO
	 v/Z9C1MP5cUpVKkUyskgLguAbOQgjv59VTajMNrZhuzG/Xl3i0S+dom7fbXp9IUCoc
	 D6Ndq0/F/WFVZ4JfQKt1DATQuimFZvqDRZrwUJ/f9VMUUu8Ll09nYuVEny+arLXqiX
	 2CrXIKHXfciXgbIKRkrw6gFoRz2Cv86tnyjKNRBlPypARNcrxW9uq5bNRM/pTuH2YG
	 MQcihpy0KgjOClaEfOCn0tSuNcfqWHLLBpw0FxpfGwGT9+U2scEgnh1De+70ab+wFP
	 vUdm1DhIgCEjg==
Date: Wed, 25 Nov 2026 13:44:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Jeevitha Palanisamy <jeevitha@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Usama Arif <usama.arif@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] powerpc: Add support for 128-bit cmpxchg
Message-ID: <20261125204453.GC3625068@ax162>
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
 <20261125174035.1412724-2-nysal@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125174035.1412724-2-nysal@linux.ibm.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 11:10:22PM +0530, Nysal Jan K.A. wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3b6cd655606..79cda056dfc4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -15,6 +15,9 @@ config CC_HAS_PCREL
>  	# do pcrel yet.
>  	def_bool PPC64 && CC_IS_GCC && $(cc-option, -mcpu=power10 -mpcrel)
>  
> +config CC_HAS_PTI_MODE_VAR_ATTR
> +	def_bool $(success,echo 'void foo(void) { unsigned __int128 u128 __attribute__((__mode__(PTI))); }' | $(CC) -x c - -c -o /dev/null)

Please use '$(CC) $(CLANG_FLAGS)' so that this works if clang adds
support for this, which will depend on the target information in
CLANG_FLAGS.

Also, consider following the recently added guidance to
scripts/Kconfig.toolchain and add some information about when this check
can go away:

  https://git.kernel.org/kbuild/c/c285fe817a92f9c747931134f468d2aefeae6bce

It would probably be something like

  # gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106895 - first fixed in 17.0.0, backported in 16.2.0, 15.4.0, and 14.5.0
  # clang: not supported - <bug link like Nick requested>

-- 
Cheers,
Nathan


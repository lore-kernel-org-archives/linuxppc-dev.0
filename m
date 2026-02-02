Return-Path: <linuxppc-dev+bounces-16525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B63E7DF19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4Zv21mMXz30M6;
	Tue, 03 Feb 2026 05:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770057070;
	cv=none; b=S6T5svrCKbVTgk1eLhs52sVUR1tqtJ8JOJPTBE4/SxP3rywmmVVLPwy/mgtr1RckfuThSOrEIV/cR5wGvKvUOXPyuOClnK+tP1hiGJECoyNawOegpDLRB2vCRZ8AmnldfHgNyagPK1iKA1wR9Bz3WvHLJUkN1Ni7jJFK7y80fMR/W9UFGQ96VMajR6RqbRXidVAB11dE4QuFMrbMTgz26uVuSMbS/xc9h+pIRh4J1zMSeYkvEpPtI/h+X2XCy+6ROXV1To8scp7xUmI5SWhyCXUEaGABc36OhKaI2xlvhIBSBNZKBz4eKPp0x2abF4OvxDYhaBMb/ZJIDC9YtLDmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770057070; c=relaxed/relaxed;
	bh=oNx+hCAL4E/Pc6Jo2HhfsXkPxHB/scQLsLlFTn0IoHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/jMlgZF+h0MIEREdiTDuuT8RcYGrBBXxlRtLLqzRkGHn7LoN2tx5+zZd9VJ/5zg1ItTikPw+BRBAt88hW9as4MjEGcJpKooUSOh/zPaarbZCOI/nMh+GvtA+xNWSNbTthfEv3rD2zMyLf5TF2snFy+UhgwVzIGK4M0ncM+nvv+GtK6AYBsdLP0kqLOygJRIxj+J/ZRRKK3W8PzqRG/cmObLPNwUZQesTJuN3fvpBgB6PKubmSOCBf5fY5O0rFdIgUoccEFQ95Rcv6hiJpXRgxV/1xcHrPL914tQEUVquanV5MCiw9yjeXhI8JzILCgDr9yuRwJ8Ixvj+0w5faoq2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jQdWElel; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jQdWElel;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4Ztv22tZz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 05:31:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7887860010;
	Mon,  2 Feb 2026 18:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3BC116C6;
	Mon,  2 Feb 2026 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770057059;
	bh=ba2/NLTkOhnfOM6fqK9CoYWWEtF7emjNfwqBUh4yBbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQdWElelgsDi9Lay4j/hwJ03E13C+lgoT6EceyxP+5cYY6I6m7jHMoK+qOMfJiv86
	 yQ3WpDDf9fgEhNukaSob3J6pFaTB/P4DCFJjyfM4Qjn/hK2D2RuxK//YXd1Is1nThp
	 MMNKlgqT+Agvdn6PA3w3ZXA54il9ecGPcwQbfeIQVC1mCBJEN7XENg1MdrliWyx+hh
	 BKgNv5CkNux1m/VqvUXQanwkHaGSibh10BbGrK26dHOS6DSO2GQpycuZCHpDaFERCb
	 c/7E10hAvVtHrmBU33vel+eacqEbofbWdplYFbOlibC/SQaxmPqR8fKJZItMGwz9/Y
	 /D38Ipq7pYTIQ==
Date: Mon, 2 Feb 2026 10:30:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
	linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
	atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
	christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
	da.gomez@kernel.org, da.gomez@samsung.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	f.gruenbichler@proxmox.com, jmorris@namei.org, kpcyrd@archlinux.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
	mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
	nathan@kernel.org, naveen@kernel.org,
	nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
	npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
	petr.pavlu@suse.com, roberto.sassu@huawei.com,
	samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
	zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Message-ID: <20260202183055.GB2036@quark>
References: <20260201201218.GA15755@quark>
 <20260131073636.65494-1-mcaju95@gmail.com>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2316630.1769965788@warthog.procyon.org.uk>
 <2339369.1770024079@warthog.procyon.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2339369.1770024079@warthog.procyon.org.uk>

On Mon, Feb 02, 2026 at 09:21:19AM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > With that being the case, why is there still effort being put into
> > adding more features to module signing?  I would think efforts should be
> > focused on hash-based module authentication, i.e. this patchset.
> 
> Because it's not just signing of modules

Module signing is indeed about the signing of modules.

> and it's not just modules built with the kernel.

Could you give more details on this use case and why it needs
signatures, as opposed to e.g. loading an additional Merkle tree root
into the kernel to add to the set of allowed modules?

> Also a hash table just of module hashes built into the core
> kernel image will increase the size of the kernel by around a third of a meg
> (on Fedora 43 and assuming SHA512) with uncompressible data.

This patchset already optimizes it to use Merkle tree proofs instead.
While I'm a bit skeptical of the complexity myself (and distros
shouldn't be shipping such an excessively large number of modules in the
first place), if it's indeed needed it's already been solved.  It's
still much simpler than the PKCS#7 signature mess.

- Eric


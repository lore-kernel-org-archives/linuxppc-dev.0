Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCE606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqeWePhs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLYlP0kBZz2xKx;
	Fri, 06 Nov 2026 20:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793957328;
	cv=none; b=nuH5ZQ4/GkXQUwV9GSUMCz9u+XhbwI+ATZwphFpHmdNa35dm+8o/skBSAtQtp8jC97/STsBS0XuzzdJOEPxyQtDKMtHZoAP42SGejVoYmWAHhH3UjFX0U0uXWpuCCWTHV11nZADyH5sTi5rcnQ5oLczSNIiAI07FBYndfeZNG8kcY+3YLh+MhVktmQXS+pBnFJKjCir0tHbSj5UL3wVeKq4RjWPMItrkkqrJJ/Vlu3jyh/wXmdI+19LA9vTtsQqH9E8hC3C8QyYIIVXBhlmGCcXO3old/0D0aO3UV/W2raITGlddjY7+lEbLrjFR5zcwqHWvs9i9S3M1aywsbHuY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793957328; c=relaxed/relaxed;
	bh=VC16RfQ/Ch74ykYoajUZJ+R1KFdW7fHzBmB94MytVlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Onr2UWFuD/8HebF3l9rXNnl67tUlZULr/veGPL8op/KZhFvCPIZUZmucslV7rp0TQfa89jQGNkCFBCrktH9imRPL+ehl8PkEsOGoLuXSPTQXTo3S/J8l1jy7bO/fQoOeysZLWIUPUTer54gaXoddAeyBZB/oTAMpBHzs0jkhbddZ4WnvOY4tIr8ytpjjRjg8Wa12XA7ds814LkzYUqNd7wHemNp7EuYRLA/HRlk1xVNyHo7joW/K3EQzifSvHTm6+GoGwhhTYPtcs8yU1E29GgBNansCMEYEOfy7yq5Unr2kbXe/CEpFPzwX4Sl3jNYyShq7tMFkNIoqxk+Ae13kJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqeWePhs; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqeWePhs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLYlN1YGkz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:28:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9853D60621;
	Fri,  6 Nov 2026 09:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C551F0089F;
	Fri,  6 Nov 2026 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957324;
	bh=VC16RfQ/Ch74ykYoajUZJ+R1KFdW7fHzBmB94MytVlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqeWePhskc8HNNCmYcdAWgvx59rFaItJGQOF/OyXIt/sCZd7S07yg+8aS/fnB0zNp
	 VZWmUIjL5yONrrC/I3jiwH2+dnKikXHjGeTuLUGr0j0eRPY5SO/KWrCGOFcgNA3ZZL
	 HdLccbtIl2+rB52+gfXthzuEXvhI4yjsjlV4x4GCkb7bizD6hCKSxpyMWCje9+/s6U
	 4d4hYcIqy+tap693g+yX6oZ4XvZL7fnGPKzTviF5CpGIRYQ1kG01IAXQpkl7+VYCF1
	 E9JusScvtWLyNrSjSK8j0HDA6lphKi+qTFh2GDRYyMedmYzEVbuuhiiS7jnOcasf3z
	 PDOC78hNF61Zw==
From: Christian Brauner <brauner@kernel.org>
To: me@bobcopeland.com,
	Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	geert@linux-m68k.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] omfs: remove the filesystem
Date: Fri,  6 Nov 2026 10:28:33 +0100
Message-ID: <20261106-vortrag-exotisch-pelzmantel-66235662f81f@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105044046.52180-1-dennylin0707@gmail.com>
References: <20261105044046.52180-1-dennylin0707@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org; h=from:subject:message-id; bh=i3zpqEJ74dna9za+0x2JJjtzgM6lB6eRNkY0jcS+yfg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9nXv4bfPNlUcWTPn4uXNLgONU2auKFum3j/m/yNjO3 u7/4QGPcEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEkjYzMkw6HKYfmszBsTjg nQ9D0/sLfp1fF166+WGPjq32xIUV3GcZfrMKhXHuzlJ3P5KXsnvXZd3mx77RJ1add2gs+WygyOB fzwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 04:40:45 +0000, Hungyu Lin wrote:
> OMFS supports the on-disk format used by the long-discontinued Rio Karma
> music player and ReplayTV DVR. While reviewing a fix for incorrect block
> mapping on writes starting beyond EOF, Matthew suggested removing the
> filesystem instead of continuing to maintain it.
> 
> Existing OMFS media can still be accessed using an older kernel with OMFS
> support.
> 
> [...]

I agree. It's great to see that we are are able to shed a whole bunch of
legacy tech.

---

Applied to the vfs-7.5.omfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.omfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.omfs

[1/1] omfs: remove the filesystem
      https://git.kernel.org/vfs/vfs/c/b4d257187fe7


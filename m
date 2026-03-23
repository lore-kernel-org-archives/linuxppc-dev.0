Return-Path: <linuxppc-dev+bounces-18625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DFAEC01DC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:44:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffWYP1hM5z2ySc;
	Mon, 23 Mar 2026 22:44:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774266281;
	cv=none; b=Ry1g7BU7yYdJg+MKfrC+1EUvj/GRBMLyYHNKPDE0wpxS+YPrjTciDzSlLfnAcGXCVyPurAEQVA76eFyF9zdHMa/jHT0NAA/uHP3FikpyMYWhlZCiplY/IKfyQ8Y92m2PUbofuLzbgQYqtQGawlu8U3qgvdgkLNJDPrJ6b80r7kJ5/SmBkRMpuoXKCfuM6vKhvGc13I4vrTMSl86nEqcSJhKUqwFbzZtBakBJUP/3aT3Wn2Lde42tvVu/pPFzrt5TK6OYUbabD2D9Kgnl4nFP9WLH72I0E0qkb89Qb8PPhUj5aYqMAY6F66Nd/pdWzOzKMpSB7hGB2DxwETkGh93kog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774266281; c=relaxed/relaxed;
	bh=HxnppuImLMBgT4VBsGkDuaPUxODcTjjrpyoPcgMsU1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzNDQp+E4aOQFF8Lb0owz1FQ4TlvPHULTyzuzFsEEu1U4UON5fc02tKcI6OFMdAGRq/O0ayjBeUQVm1YLQJf8H60Pa6nOcqpV9fvC9BVk8DmSH4UIVZvZ6HqG8Slw0HlBdCkNcLallVxmsLVu1yJAmy90fncOQGbxOPe98weUz8Fs1coyycWoU9YuyoyAFeAT50OW8h6vUbOr9xQRIipdM2OjI0zHc2y0PMTOu8HR8vkMve95fecqMn+9zcpNT6ZIMyw7RzGU2agdvPpp4rdmmrpNgfHzjskgnMxtWEZeW8LDrOBc1pLkQ6M1H447cBohuy3qICxEFdkT9gLaZVQjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gR/RCY7x; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gR/RCY7x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffWYM5sbZz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 22:44:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 96CD36013A;
	Mon, 23 Mar 2026 11:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622CAC4CEF7;
	Mon, 23 Mar 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774266276;
	bh=aXd296Lm46/RWsbI4I1OOM2FgVG5HdKEPdtKxCcKiSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gR/RCY7xEISChh9Lrf9qGuhPEZS19LykvA5um6hJZDCEVVMpMFmEesD49v4VS0VeX
	 7tvtxyMDQ8xUKY4iIhm3sU/C9WMRUdj6Z81Mw6hUi1GQnRCuXsZFys+7kWnJiM8LcH
	 8qIODBP67hQ9u9z4blHsBR/iyNhx3ikj0My0HbCKCwAfCv1CzXTou3L+pTZAo5icZX
	 O7F1SyOoy3ailgv1X6DwqsvZtE5mFHC/I3tpfFNVdXE7iSSWu4p62HgxDdHbQH+JxZ
	 xHniVseYGTA81Swnq7Ya3s5cLs7Yq1ml1dSxfQYULHCaMrleKub1aY5HyQ6V3LTinA
	 /L+uZAmg1tcww==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: fix architecture-specific compat_ftruncate64 implementations
Date: Mon, 23 Mar 2026 12:44:08 +0100
Message-ID: <20260323-pocht-abberufen-825ffe02281f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070205.2939118-1-hch@lst.de>
References: <20260323070205.2939118-1-hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=brauner@kernel.org; h=from:subject:message-id; bh=aXd296Lm46/RWsbI4I1OOM2FgVG5HdKEPdtKxCcKiSg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQeVJ/Ny96b4PNJrzr+9NOiA/8+bLx4YW3lMTVfacWzS 0yOhLLad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwDmGf1plEULnTrzd+kq7 uMavcddW/zt2IduMvmY9VrKaK9Qs58Lw3/Gk5+XnL/zeeZz4yxfF98j+tsyNy3aT8znSj9yckRz wkh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 08:01:43 +0100, Christoph Hellwig wrote:
> this series fixes a really old bug found by code inspection, where the
> architecture-specific 32-bit compat ftruncate64 implementations enforce
> the non-LFS file size limit unless opened with O_LARGEFILE.
> 
> Diffstat:
>  arch/arm64/kernel/sys32.c       |    2 +-
>  arch/mips/kernel/linux32.c      |    2 +-
>  arch/parisc/kernel/sys_parisc.c |    4 ++--
>  arch/powerpc/kernel/sys_ppc32.c |    2 +-
>  arch/sparc/kernel/sys_sparc32.c |    2 +-
>  arch/x86/kernel/sys_ia32.c      |    3 ++-
>  fs/internal.h                   |    3 +--
>  fs/open.c                       |   40 +++++++++++++++++++---------------------
>  include/linux/syscalls.h        |   16 +++-------------
>  io_uring/truncate.c             |    2 +-
>  10 files changed, 32 insertions(+), 44 deletions(-)
> 
> [...]

VFS CI: https://github.com/linux-fsdevel/vfs/actions/runs/23425735066

  x86_64 (gcc, debian, ovl-fstests)  pass
  x86_64 (gcc, debian, selftests)    pass
  x86_64 (gcc, debian, xfstests)     pass
  x86_64 (gcc, fedora, ovl-fstests)  pass
  x86_64 (gcc, fedora, selftests)    pass
  x86_64 (gcc, fedora, xfstests)     pass

---

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/3] fs: fix archiecture-specific compat_ftruncate64
      https://git.kernel.org/vfs/vfs/c/e43dce8a0bc0
[2/3] fs: pass on FTRUNCATE_* flags to do_truncate
      https://git.kernel.org/vfs/vfs/c/0924f6b80d4a
[3/3] fs: remove do_sys_truncate
      https://git.kernel.org/vfs/vfs/c/e8767a3134ca


Return-Path: <linuxppc-dev+bounces-26553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DFAC624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:43:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbtP61hh7z2xfj;
	Fri, 04 Sep 2026 20:43:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788518634;
	cv=none; b=Us8ya8adeN5wYNhQl7fP8vKiJA5er58hrkKgAzwl4moeHpap5M0dgXZHH99HMbBW41CXckwrR/2hDv+FmAj24zGDV/M73/enB8T5loqoLhDE/3FSEfueKP99Hgb2QrtyfonUaZHQ6S1Whhh60gC7Ru9LeB9GHfXfiRD7jlPl7bxZ/u+74GdQqh96RrBslDuSWjtedzINwZLwtMq3mBJFlThx71BKsip/G29QP4yPAsLnmhkvM8DEG0lP2HL6xk4BAozQQPc2ngYPffx2g9W45qZNPafBpk0Q72KA456CmAim4FyRwCzc0ir0Zrmm7yAfPT24RvSFnD9JlNbv/uctKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788518634; c=relaxed/relaxed;
	bh=VW/CLvXtR4yi53YJ7B+rM0JAvXpIe3UjCxJyIRDFpr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vu6dvdp1xz9wsm4WfgQf6bTyWtMWt2ELN49J3AdI/RhlQAHhY7mmTTZDsF+0rH29++x0uo9py2cSQMU+TdSN7sI31TSQvjTmKZfLDcACddZku6grBKO9nCG4A8fzt0/l3hhZS6qD5yu1nKZFjjIf1grlSeFB773ACWJcHk1rkJdxw7pUwUWkLq5ZiD4DY0T0i3w568uPgE7c2Rfn1SFHlBIgv5Rdo9MS8M1sS+S2grO+V/QqNrYXzVFIm29PUz82YXdlZdX/n1vhvL/QcqQABHdCqW5dk6Pj0SRmD6Funic1qjLYY7ff0F+RpS4PR1NG3ZUbLzHrNBPN/nvmHS91Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVjYeIbd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVjYeIbd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbtP467kdz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:43:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC6D4600CB;
	Fri,  4 Sep 2026 10:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10011F00A3D;
	Fri,  4 Sep 2026 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518629;
	bh=VW/CLvXtR4yi53YJ7B+rM0JAvXpIe3UjCxJyIRDFpr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CVjYeIbd00dffOAYPugbkKN2MbArT5cImYadB4j+59apFTYJ6qNsx+HJXhXSHjxWd
	 PDU+/10sgnpMiO+5G+/JkISHJeO5wyEx1bjM/hX2VhwGl6LIlR3fGnc8THVTpArie1
	 0Xk7ms3jKC3xlsqJhXRbTzeRZjLy4Abb2Suyos0H7Aj2bak0q/nUotJea62OlTfBij
	 QyM6wsxZkGpPgAGrubvnOsTcq+ZBX3tEAp72W8R7GuA7Lqbhu8bwvKXzqb7k6qJm9l
	 sLBakyO/blUmymUISaV/2lYDlsveRZLBbJM96xbjGN9yZpw4lKEzujXCapOwqYUlvZ
	 ZIMVI+2+bSC4Q==
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jakub Kicinski <kuba@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
 Hisam Mehboob <hisamshar@gmail.com>, 
 =?utf-8?q?Martin_Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, 
 Amir Goldstein <amir73il@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 David Howells <dhowells@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Theodore Ts'o <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Andrew Lunn <andrew@lunn.ch>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Andrei Vagin <avagin@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
 Bhavik Sachdev <b.sachdev1904@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, 
 Malaya Kumar Rout <malayarout91@gmail.com>, linux-doc@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20260904082954.48738-1-enelsonmoore@gmail.com>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-Id: <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>
Date: Fri, 04 Sep 2026 12:43:09 +0200
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SEZe5HnLJEPtViVtmgtwkTJszcnx/wvXNNnLPrgibYw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWnB77S5lMyEl9+dJ/HLX590J4N+XsPtmUsuNHyGhN
 Q1OTHcedZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykeiojwxoB52CpkN9BCyZ2
 2izo/OY7bYapT739fJPZbu0Sp8xilzP8Lyt/d+TkVQWPP+sS1xyavfuujX3Dr4edtfbn2XY16J4
 9ygYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 04 Sep 2026 01:29:19 -0700, Ethan Nelson-Moore wrote:
> bfs: remove the filesystem

I agree.

---

Applied to the vfs-7.4.bfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.bfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.bfs

[1/1] bfs: remove the filesystem
      https://git.kernel.org/vfs/vfs/c/e36781a626b2



Return-Path: <linuxppc-dev+bounces-26122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6122AC61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 16:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVV006stXz308f;
	Thu, 27 Aug 2026 02:06:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787760416;
	cv=none; b=C94b5JPliD8bOQNjkzPuqla8uiILcyF0l3pjEdD2B7JjnTaELbIiOjqCaLL7hmrgzEwi84qmjjhHkLRc6VWww3d2MGtbacRmxaUIz5rGnkO0zbJz0w4J7VuBp+RnpN/v8XxRhp5kj7RhwiFnz5WISXdymcOjTUgBsn7WonkA7iMYyeAd2csHcjrpOHcTeIqCTxcSpJ++CQiTaJ3p5qvNn7+wQZ1meCFiplzF7ZTRK4uTxIm7gSIZTd6MImuVCVxj3oIZZHlCyvoCb/s8yRHWcO8tRPLXYTgwTO9NFNJ/n+mRA6kcFD+6hAjfY1GCEs++l54kTHtWxlimy9nA4LO6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787760416; c=relaxed/relaxed;
	bh=cmJCLhannwpQfe0H8AhecB4RfP76TbhEicx9QpJ/hJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5GVV/MIYljWE8BFUx3F1RdibXGRXCkmndwE3LAwtrp/xIqCISuwUnjGKDKeyjei11Tk/nb/x0dU+FcRUPiZroJ4/RBNa2m228W6UtXK7t+SEsqihSN3MY4EB1zPD172edJx+l8DVOt32IqEqtzZi+Hkc+wgBtzaI2w+wdFMwjI1FDbqCq6CFdPuBb9yRvJc2SzuCg9F+49lRedM5aw8n3hxWZ7HO6j+LlrCGRRyLDE4kIwMZiidSzS7ZgMjKBV0xhkCtux5LGFrKksNZu9tPUlyk/0XSoK0J+8fP4LiPw5YS6nb1+jrg8gWayXi0n3IFOFKm2by+uJnO/jMjaGFsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgnOTYOn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgnOTYOn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVV0010Vhz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 02:06:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E9F2A438CE;
	Wed, 26 Aug 2026 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192B1F000E9;
	Wed, 26 Aug 2026 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760413;
	bh=cmJCLhannwpQfe0H8AhecB4RfP76TbhEicx9QpJ/hJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XgnOTYOnVRzH0wZzLVRnQR05xwQjWrrl7AVdNnViIQ4Bcyw/EPxZmS4FinZ70OsWY
	 NI+H1W/ghgVhv+9tjU/qcry166sRrHtZkaCW+UlpLBnVQ9SHnm06izP3gjYaDqI94Z
	 EWnE5w1MOosmHr5SwiFYZNNuJWlbDdHMIjbvnM49ihiBoyuxgr7I0yd4RPDerv3xi8
	 WwFtIZw5piEN/tTVQJpaSXNx6u6g0do/u4YPtzlQ/TpNVAlq17aUNDbfKlLQyDVKx1
	 QMU6IIYc96dtY/44sPJtZpWLeY1J176+tOKx+Uhglz3h5Tc/OSbh08iP+PJAPMTp00
	 8Yps6dr390Osg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 26 Aug 2026 18:06:41 +0200
Subject: [PATCH 2/2] coredump: stop unsharing the file descriptor table
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
Message-Id: <20260826-work-spufs-coredump-v1-2-579e72a7ab66@kernel.org>
References: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
In-Reply-To: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
To: linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K84TbfxfceCW8PndmuLZov84ig4iyficrU4Ck6RdOao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT18wvf21CYzVAq/4Ndf77FU/EJZkmX07z5U1Rnd//95
 xASP/1VRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETuBjP8j7/41PjNiR/Frurs
 CzhO/9/V9aSg15/f/2bdrLU317tf+c7wz4x3AXuNAZvI2n6HIMaZ/zJKDCqnq/EwxRxdfvVP0mZ
 PJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We currently unshare the file descriptor table before we write the
coredump. The only code that ever looked at the file descriptor table
was the cell spufs coredump support. It walked all file descriptors to
find the spufs contexts it would have to dump as extra elf notes.

Now that we killed spufs coredumping stop doing that and update the
comments referencing spufs as they ave become stale.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c | 4 ++--
 fs/coredump.c   | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 06d0df105382..db32bb40a867 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2029,7 +2029,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	{
 		size_t sz = info.size;
 
-		/* For cell spufs and x86 xstate */
+		/* For x86 xstate */
 		sz += elf_coredump_extra_notes_size();
 
 		phdr4note = kmalloc_obj(*phdr4note);
@@ -2093,7 +2093,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
-	/* For cell spufs and x86 xstate */
+	/* For x86 xstate */
 	if (elf_coredump_extra_notes_write(cprm))
 		goto end_coredump;
 
diff --git a/fs/coredump.c b/fs/coredump.c
index ac3cd74808c6..a49f2fd6be28 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1118,11 +1118,6 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (cn->mask & COREDUMP_REJECT)
 		return;
 
-	/* get us an unshared descriptor table; almost always a no-op */
-	/* The cell spufs coredump code reads the file descriptor tables */
-	if (unshare_files())
-		return;
-
 	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
 		return;
 

-- 
2.53.0



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E392606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hj+qJx5a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNcyG12wrz2xRm;
	Tue, 10 Nov 2026 05:00:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794247222;
	cv=none; b=KHdO8CkdfbiIvA12m4qSCX6dQKQSLez/uALS5aV7g30xJPEpMKU/9bLolQhunS0yKpi5BzFR0QcbvOUuPLmfc8szo8xSbVpygWe9431FouyGlEVuDNhDivcBIiRYsQ4fuUCdu2uXKCzOF1MoSyeBru5e4Q293dSievjvZEcBZj4Na7ZwrdUuOeC5sDaC7sCG+4LZdfAkqM7cmkx9QSeOI83Ct8cLHrkFKYqad3n2qlLVUBoG8syeIrhcvcIG+8ISxKR2jtJmB2NTi7Q6bUjIZgZNwH9dB8GXvULK/ZoiT4eUlEmCYeVyLBMTIb+93RAS2PG0+Cd4PcNfeCR7W3HwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794247222; c=relaxed/relaxed;
	bh=3xK7L4/JaYx0EL19I/D7/R7R2oh/67eUA0pLpz/4Vyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S/9EAVpDdConnqbxpZl+4fbg41ukIONmgZmE/JsiHISOn4yTNDkKtKV72WftjgtT4T/Neq8UhqFr74dh7FEZ8SSt2PjGhVgYOPTLTm3RgzUlTkJXCiwn0cJivpZBmlnE3cXDmRIRECRaSzoh9IZBFa2RgbNMesoCuCSb8L8UDziRJFgj2gHLSJ7Fv33jM/kOZ7ei7d5VbZnSfLWENEOLNPKL7zr8ACEEl4y1Q2Upz95ojglqld0sH15ZxnSs1nWKenQD6WLtGA+mzQ7eEntTG78LSBBBHeKOsmKwOAQ3dplcRmOdBnXAZNs8PhKVMY8/fELVd3xnM8P8eE/7eIYzLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hj+qJx5a; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hj+qJx5a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNcyF0Nt9z2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 05:00:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AF5060A95;
	Mon,  9 Nov 2026 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376BB1F0089F;
	Mon,  9 Nov 2026 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794247218;
	bh=3xK7L4/JaYx0EL19I/D7/R7R2oh/67eUA0pLpz/4Vyg=;
	h=From:Date:Subject:To:Cc;
	b=Hj+qJx5aYVz8wK7JQmQamBE+WqPvz9takatG7seQvX/+mEnAjhg5HqjTgUO9AgK1p
	 7JQccuZtWODOtPoz0vz5gKnYz3cLFdcB6eWIIcHQmjWUFFxq0t1m90MpHowj4bdhAd
	 ZYrqYFD70FTKY3KcwFLPH//jbT98bTNV+7hZD2jbtduxZcFpnLUKbtgKG+X2ot0LDw
	 skhG2yTcYv5/2l22SKOPOUFyeWchNU4zu2SZJoGyPtTDjPBkBcgT3X01HPzT6uRdQH
	 j9pZWXIJopS1wbHocqT4MJs1YLXq6zdZf9NEgRVUqytdkt0bi8CKVo5Jd2B4+4V70k
	 77LvMITkLKnSw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 09 Nov 2026 13:00:12 -0500
Subject: [PATCH] powerpc/smp: Handle of_property_count_u32_elems() error in
 parse_thread_groups()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBBA0auUWTuQFCnGq4gLk0x0RJMw09ZC6
 d0bdfng81dQEiaFc7eC0MzKJTfYQwfhcct3Qo7N0Jt+sNY4rOVDUgPqu2IL4oswlCmPSCLojyf
 vUooDOQNtUYUSL7/95fq3Tv5JYfw+Ydt2RwA6oYAAAAA=
X-Change-ID: 20261109-powerpc-smp-handle-count-err-b48b9ffd6e90
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255; i=nathan@kernel.org;
 h=from:subject:message-id; bh=57alKDJGvf9NrPNQP0TZ4PGabY5w76Ut3KmDPbLom1M=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmfuHRzNF12rtI6FLD2qMrtB3cCrwkJL511bZZJz8qQt
 3rTIjSKO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE3oUx/E/TmHWsXZ5dp8Y6
 ceG8v27fjN8+3RA1J8js9YYiw9MHt8xiZNh5WVpB4Kltw8T7ScptjjeqTp79siaO69qGabfb3r9
 e1cEOAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
conversions"), there is a warning on boot for several PowerPC
configurations in QEMU:

  WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1b0, CPU#0: swapper/0/1
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc1-00262-g0af298e62e5c #1 PREEMPT(lazy)
  NIP [c0000000006074e4] ___kmalloc_large_node+0x174/0x1b0
  LR [c00000000060782c] __kmalloc_large_node_noprof+0x3c/0x150
  Call Trace:
  ...
  [c00000000369fb60] [c000000000614ff0] __kmalloc_noprof+0x490/0x690
  [c00000000369fbe0] [c000000000051308] _kzalloc_noprof.constprop.0+0x1c/0x74
  [c00000000369fc00] [c00000000200b450] init_thread_group_cache_map+0xc0/0x2c4
  ...

In this case, of_property_count_u32_elems() returns -EINVAL because
there is no "ibm,thread-groups" property. When kcalloc() was used to
allocate thread_group_array, the multiplication overflow check in
_kmalloc_array_noprof() caught that a really large allocation was
requested (as -EINVAL was converted to size_t) and returned NULL.
kzalloc_objs() has no such check, so the large allocation check in
__kmalloc_large_noprof() triggers the visible warning above.

Check if of_property_count_u32_elems() has returned an error and bail
out if so, clearing up the warning.

Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7a25eaa59e62..58824f5f4c80 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -824,6 +824,8 @@ static int parse_thread_groups(struct device_node *dn,
 	int i = 0;
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
+	if (count < 0)
+		return count;
 	thread_group_array = kzalloc_objs(u32, count);
 	if (!thread_group_array)
 		return -ENOMEM;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261109-powerpc-smp-handle-count-err-b48b9ffd6e90

Best regards,
--  
Cheers,
Nathan



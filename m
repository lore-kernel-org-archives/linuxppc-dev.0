Return-Path: <linuxppc-dev+bounces-25760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86241C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:48:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcwn44k4z3cFf;
	Wed, 12 Aug 2026 15:48:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513705;
	cv=none; b=jVxqCSbtxWNy26Ntsg2rB1gASCxlNjmihzWAn5Pu5ikUAyUYv3Gne0NkT81l08QeTP3utrVxj+Sej6zwnC7pY4y9OqlaVV8AI1Jpcq8ofAZUuSXLbVsFzlKLkXCBkQZ6JuLuQLPsAmMDRliRGxcZbuwCcnEoFP8x29Yp3UyLpOYJq9AFD1W5can/rYbbuK2KLzPIBWWfhVBscOTnlxXnm2LoJCDBKWp6kWWa+4bkxmNJQl+MK3xS1aOtb4dvohy3dxDmVs2/IWCYUW292EtrGcZ37SdCA43S3HVeTZgTPlRRyL7ASr7ZHMDQND1x538MSyQAjkJPhZvKn5XBMoWSag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513705; c=relaxed/relaxed;
	bh=w4EZMZvGFABCZodvsaOH6b9FL6j9vWU4MwO/1OVlhXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VafrRCiFmLe4o5fz3toAa8W8TDYDrL+AacFMKL8koh355qDYvvYpMfM6z/OjmP27KzBPR5VpchlLkk7ZPqn4IqBIVJ4Fb2xgVthOe8+3bvSFrJLMT4DCLEImRC8R6BTFlkfY34jf02Iy99AfSL4AdxmeCIoGs56bXVtQV7Eg/8/DQcCG8LGsMZfkXA8D/N/VEwQM+/9uNq/SLhZyaYmEEWh3zuo3bL78+z3eLcHNMBvJZZmf4OS5YpR3oxvcIuD2LENHFOL8l7BQHx9AbAwReMX7bGPbcyA6CE5c1yL1b+ASQBRvJgIxhHiblFZ4k/ExggkNFE/2vdTVnwnLQIUwtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PK/ni+Jw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PK/ni+Jw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcwm3NhKz3br7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F9A443F98;
	Wed, 12 Aug 2026 05:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03750C2BCFD;
	Wed, 12 Aug 2026 05:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513697;
	bh=P8daGFXWAmT1kD9/TcyCB6sNC9wXVqWP4xIwWe1Kobs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PK/ni+JwFqGivweerGHX6F4PMlqf3oBwDQmF7GkRhM5mPFxYuN0m7NoyMrRN+xD3b
	 65VLPmCE9dyjpO6DVWHL5Za8QFFdtsL28heJfGcT4K+f1syGB5FkfLWvu7hoKkxEXZ
	 JiQFow7UiTF7fYKfBNm7/K/iv2Pl6s7F1AsU0eyUXoaKVdOc6QSogDUABAqaFH7fL/
	 YCu3AM1Iwuk3XTM7vxhy6mtJb8C0C2k7a0wBIa3tSVaqb+OjR+FBgB9DPvBpvs5Jku
	 d9ksx8ZGZZeoWPftGznuaiO0daOtiCtSPvwHk6onHvkb8q13tLXiC7HEGSLLSJo5nT
	 dg/jjYhsBs2kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89C5CFEB;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 13:48:11 +0800
Subject: [PATCH 5/5] powerpc/spufs: fix mmap_lock/state_mutex lock
 inversion
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
Message-Id: <20260812-spufs-fixes-v1-5-449e201d9f64@outlook.com>
References: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
In-Reply-To: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=A766Kj+SIMmBxr8tNi5fB2Rg8hveBn1dANRK8rQSu+Q=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpO+XRRIc3NC47r6O/m+7zeYs7WdU9Dvn4P3qri+
 LeuWVgrnL2jlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJrLvNSPD33kyX19tsint
 9nylHb89ZypfYZi844bdeh4Za60eWpUzMPwVmLbNn+3dlKPr07u38NVPm3Io7+zN6v5E45incsZ
 Ofq0cAKRLSIU=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

spufs_ps_fault() is called by the VM with mmap_lock held for read and
takes ctx->state_mutex via spu_acquire(). When ctx->state is
SPU_STATE_SAVED it drops mmap_lock, waits in spufs_wait() for the
context to become runnable, and then re-takes mmap_lock. spufs_wait()
returns with state_mutex re-acquired, and spu_release() only runs after
the branch, so mmap_read_lock() is called while state_mutex is held.
Every other spufs fault path takes the locks in the opposite order:
spufs_mem_mmap_fault() and spufs_ps_fault() are entered with mmap_lock
already held and only then take state_mutex.

Three threads sharing an mm can close the cycle: one holds state_mutex
and blocks in mmap_read_lock(), another holds mmap_lock for read and
blocks in spu_acquire(), and a queued writer in mmap_write_lock()
prevents the first down_read() from succeeding. This can result in a
deadlock, and since spusched_tick() takes the same state_mutex, one
wedged context also stalls SPU scheduling for every other context on
the node.

Fix by calling spu_release() before re-taking mmap_lock and jumping to
the existing refault path, which drops the reference taken earlier in
the function and returns VM_FAULT_NOPAGE as before.

Fixes: 33bfd7a73861 ("[POWERPC] spufs: block fault handlers in spu_acquire_runnable")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by inspection; I have no Cell/PS3 hardware, so this is
compile-tested only.
---
 arch/powerpc/platforms/cell/spufs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 07b1755ddc3d..d479c956506d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -349,7 +349,10 @@ static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 		spu_context_nospu_trace(spufs_ps_fault__sleep, ctx);
 		err = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
 		spu_context_trace(spufs_ps_fault__wake, ctx, ctx->spu);
+		if (!err)
+			spu_release(ctx);
 		mmap_read_lock(current->mm);
+		goto refault;
 	} else {
 		area = ctx->spu->problem_phys + ps_offs;
 		ret = vmf_insert_pfn(vmf->vma, vmf->address,

-- 
2.51.2



